// ****************** ECE319K_Lab1.s ***************
// Your solution to Lab 1 in assembly code
// Author: Melinda Dai
// Spring 2026
        .data
// Last Modified: 01/25/2026
        .align 2
// Declare global variables here if needed
// with the .space assembly directive

        .text
        .thumb
        .align 2
        .global EID
EID:    .string "MMD3728" // replace ZZZ123 with your EID here

        .global Phase
        .align 2
Phase:  .long 10 
// Phase= 0 will display your objective and some of the test cases, 
// Phase= 1 to 5 will run one test case (the ones you have been given)
// Phase= 6 to 7 will run one test case (the inputs you have not been given)
// Phase=10 will run the grader (all cases 1 to 7)
        .global Lab1
// Input: R0 points to the list
// Return: R0 as specified in Lab 1 assignment and terminal window
// According to AAPCS, you must save/restore R4-R7
// If your function calls another function, you must save/restore LR
Lab1: PUSH {R4-R7,LR}
       // your solution goes here
        MOV R4, R0      // R4 = pointer to list (current entry)
        MOVS R5, #0     // R5 = index 0

        Entries:
        LDR R6, [R4]    // R6 = eidPtr 
        CMP R6, #0
        BEQ NotFound    // if eidPtr == 0, not found

        LDR  R7, =EID   // R7 = pointer to your EID string
        // Compare R6 (list eid) and R7 (my EID)

        CompareChars:
        LDRB R0, [R6]   // ch1 = *eidPtr
        LDRB R1, [R7]   // ch2 = *EID
        CMP R0, R1
        BNE NextEntry   // not equal, mismatch

        CMP R0, #0
        BEQ Done        // both equal AND null terminator, match

        ADDS R6, #1     // eidPtr++
        ADDS R7, #1     // EID++
        B CompareChars

        NextEntry:
        ADDS R5, #1     // index++
        ADDS R4, #8     // ptr += 8 (skip score)
        B Entries

        Done:
        MOV R0, R5      // return index in R0
        POP {R4-R7, PC}

        NotFound:
        MOVS R0, #0
        SUBS R0, R0, #1         // R0 = -1

      POP  {R4-R7,PC} // return


        .align 2
        .global myClass
myClass: .long pAB123  // pointer to EID
         .long 95      // Score
         .long pXYZ1   // pointer to EID
         .long 96      // Score
         .long pAB5549 // pointer to EID
         .long 94      // Score
         .long 0       // null pointer means end of list
         .long 0
pAB123:  .string "AB123"
pXYZ1:   .string "XYZ1"
pAB5549: .string "AB5549"
        .end
