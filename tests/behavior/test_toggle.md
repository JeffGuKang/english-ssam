# Toggle Behavior Test Cases

These test cases verify the `/english-ssam` toggle command behavior.

## Test Cases

### T-01: First Activation

**Input:** `/english-ssam` (first time in conversation)

**Expected:**
- Shows activation message with emoji header
- Contains "English Ssam Activated!"
- Shows "What I'll Do" section
- Shows "Correction Format" example
- Shows "Special Focus for Korean Speakers" section
- Ends with "English Ssam is now active!"

**Pass Criteria:** All expected elements present

---

### T-02: Toggle OFF

**Precondition:** English Ssam is currently ON

**Input:** `/english-ssam`

**Expected:**
- Shows deactivation message
- Contains "English Ssam Deactivated"
- Contains "English tutor mode is now OFF"
- Shows how to turn it back on

**Pass Criteria:** State changes from ON to OFF

---

### T-03: Toggle ON After OFF

**Precondition:** English Ssam was turned OFF

**Input:** `/english-ssam`

**Expected:**
- Shows activation message again
- State returns to ON

**Pass Criteria:** State changes from OFF to ON

---

### T-04: Multiple Toggles

**Input:** Toggle 4 times in sequence

**Expected:**
1. First toggle: ON (Activated)
2. Second toggle: OFF (Deactivated)
3. Third toggle: ON (Activated)
4. Fourth toggle: OFF (Deactivated)

**Pass Criteria:** Consistent alternating behavior

---

### T-05: State Persistence in Conversation

**Precondition:** English Ssam is ON

**Input:** User sends normal message "fix the bug"

**Expected:**
- AI provides English correction before executing task
- Shows correction table if errors found

**Pass Criteria:** English check appears before task execution

---

### T-06: No Check When OFF

**Precondition:** English Ssam is OFF

**Input:** User sends message with errors "I have many computer"

**Expected:**
- AI responds normally without English correction
- No correction table shown

**Pass Criteria:** No English check when disabled
