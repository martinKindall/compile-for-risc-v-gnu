#include "headers.h"

// --- Configuration Constants ---

// The base memory address of the framebuffer
#define FRAMEBUFFER_BASE ((volatile unsigned char *)0x401000)

// The dimensions of the framebuffer
#define FRAMEBUFFER_COLS 80
#define FRAMEBUFFER_ROWS 30

// --- Function Implementation ---

/**
 * @brief Outputs a single character to the memory-mapped framebuffer.
 *
 * This function maintains a static internal cursor position (row, col).
 * - It handles newline characters ('\n') by moving the cursor to the
 * beginning of the next row.
 * - If the cursor exceeds the column width, it wraps to the next row.
 * - If the cursor exceeds the total row count, it wraps back to the
 * first row (row 0).
 *
 * @param c The character to write to the framebuffer.
 */
void outchar(unsigned char c) {
    // Pointer to the volatile memory-mapped I/O device
    volatile unsigned char *framebuffer = FRAMEBUFFER_BASE;

    // Static variables to maintain cursor position across function calls
    static unsigned int s_cursor_col = 0;
    static unsigned int s_cursor_row = 0;

    // --- 1. Handle Character Input ---

    if (c == '\n') {
        // Newline character:
        // Reset column to 0 and advance to the next row
        s_cursor_col = 0;
        s_cursor_row++;
    } else {
        // All other characters:
        // Calculate the linear offset in the framebuffer
        unsigned int offset = (s_cursor_row * FRAMEBUFFER_COLS) + s_cursor_col;
        
        // Write the character to the memory-mapped device
        framebuffer[offset] = c;
        
        // Advance the column cursor
        s_cursor_col++;
    }

    // --- 2. Handle Column Wrap-around ---

    // If the column is now at or past the end of the line...
    if (s_cursor_col >= FRAMEBUFFER_COLS) {
        // ...reset column to 0 and advance to the next row
        s_cursor_col = 0;
        s_cursor_row++;
    }

    // --- 3. Handle Row Wrap-around (Screen Wrap) ---

    // If the row is now at or past the end of the screen...
    // (This catches wraps from both newlines and column wraps)
    if (s_cursor_row >= FRAMEBUFFER_ROWS) {
        // ...reset the row to 0 (back to the top)
        s_cursor_row = 0;
    }
}

void print(const unsigned char *msg) {
    while(*msg) {
        outchar(*msg);
	    msg++;
	}
}

void println(const unsigned char *msg) {
    print(msg);
    outchar('\n');
}
