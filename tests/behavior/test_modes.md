# Mode Behavior Test Cases

These test cases verify the mode switching and behavior for English Ssam.

## Mode Switching Tests

### M-01: Switch to Check Mode

**Input:** `/english-ssam check`

**Expected:**
- Shows "Mode Changed" message
- Mode set to "check"
- Subsequent prompts show corrections then execute immediately

---

### M-02: Switch to Confirm Mode

**Input:** `/english-ssam confirm`

**Expected:**
- Shows "Mode Changed" message
- Mode set to "confirm"
- Subsequent prompts wait for Y/N/E response

---

### M-03: Switch to Auto Mode

**Input:** `/english-ssam auto`

**Expected:**
- Shows "Mode Changed" message
- Mode set to "auto"
- Subsequent prompts show corrections and auto-proceed

---

### M-04: Switch to Silent Mode

**Input:** `/english-ssam silent`

**Expected:**
- Shows "Mode Changed" message
- Mode set to "silent"
- Subsequent prompts execute without showing corrections

---

### M-05: Show Status

**Input:** `/english-ssam status`

**Expected:**
- Shows current ON/OFF state
- Shows current mode
- Lists available modes

---

## Check Mode Behavior Tests

### M-06: Check Mode with Errors

**Precondition:** Mode is "check"

**Input:** "I want make function"

**Expected:**
- Shows correction table
- Proceeds immediately with task
- No confirmation prompt

---

### M-07: Check Mode without Errors

**Precondition:** Mode is "check"

**Input:** "Please create a function"

**Expected:**
- Shows "English is perfect" message
- Proceeds immediately with task

---

## Confirm Mode Behavior Tests

### M-08: Confirm Mode - User Accepts (Y)

**Precondition:** Mode is "confirm"

**Input:** "I want make function"
**Follow-up:** "Y"

**Expected:**
1. Shows correction with Y/N/E options
2. Waits for response
3. On "Y": Uses corrected version, proceeds with task

---

### M-09: Confirm Mode - User Rejects (N)

**Precondition:** Mode is "confirm"

**Input:** "I want make function"
**Follow-up:** "N"

**Expected:**
1. Shows correction with Y/N/E options
2. Waits for response
3. On "N": Uses original version as-is, proceeds with task

---

### M-10: Confirm Mode - User Edits (E)

**Precondition:** Mode is "confirm"

**Input:** "I want make function"
**Follow-up:** "E"

**Expected:**
1. Shows correction with Y/N/E options
2. Waits for response
3. On "E": Asks user to type their edited version
4. Uses user's edited version, proceeds with task

---

### M-11: Confirm Mode - Korean Response (예)

**Precondition:** Mode is "confirm"

**Input:** "I want make function"
**Follow-up:** "예"

**Expected:**
- Recognizes Korean "예" as "yes"
- Uses corrected version, proceeds with task

---

### M-12: Confirm Mode - No Errors

**Precondition:** Mode is "confirm"

**Input:** "Please create a function"

**Expected:**
- Shows "English is perfect" message
- Proceeds immediately (no confirmation needed)

---

## Auto Mode Behavior Tests

### M-13: Auto Mode with Errors

**Precondition:** Mode is "auto"

**Input:** "I want make function"

**Expected:**
- Shows correction briefly
- Shows "auto-proceeding" indicator
- Proceeds with corrected version

---

### M-14: Auto Mode without Errors

**Precondition:** Mode is "auto"

**Input:** "Please create a function"

**Expected:**
- Shows "English is perfect" message
- Proceeds immediately

---

## Silent Mode Behavior Tests

### M-15: Silent Mode with Errors

**Precondition:** Mode is "silent"

**Input:** "I want make function"

**Expected:**
- No correction display shown
- Internally uses corrected version
- Executes task directly

---

### M-16: Silent Mode without Errors

**Precondition:** Mode is "silent"

**Input:** "Please create a function"

**Expected:**
- No correction display shown
- Executes task directly

---

## State Persistence Tests

### M-17: Mode Persists Across Messages

**Setup:**
1. `/english-ssam confirm`
2. Send message "fix bug"
3. Respond "Y"
4. Send another message "add feature"

**Expected:**
- Second message still uses confirm mode
- Mode persists until explicitly changed

---

### M-18: Mode Resets on Toggle Off

**Setup:**
1. `/english-ssam confirm`
2. `/english-ssam` (toggle off)
3. `/english-ssam` (toggle on)

**Expected:**
- After re-enabling, mode resets to "check" (default)

---

## Edge Cases

### M-19: Invalid Mode Name

**Input:** `/english-ssam invalid`

**Expected:**
- Shows error: "Unknown mode"
- Lists available modes
- State unchanged

---

### M-20: Uppercase Mode Name

**Input:** `/english-ssam CONFIRM`

**Expected:**
- Should work (case-insensitive)
- Sets mode to "confirm"
