# English Correction Test Cases

These test cases verify that English Ssam correctly identifies and corrects common errors.

## Article Errors

### C-01: Missing "a" Article

**Input:** "I have computer"

**Expected Correction:** "I have **a** computer"

**Explanation:** Countable singular nouns need an article

---

### C-02: Missing "the" Article

**Input:** "Sun is bright today"

**Expected Correction:** "**The** sun is bright today"

**Explanation:** Unique nouns need "the"

---

### C-03: Wrong Article (a/an)

**Input:** "I need a apple"

**Expected Correction:** "I need **an** apple"

**Explanation:** Use "an" before vowel sounds

---

## Preposition Errors

### C-04: Wrong Preposition (at/in)

**Input:** "I'm good in coding"

**Expected Correction:** "I'm good **at** coding"

**Explanation:** "good at" is the correct collocation

---

### C-05: Wrong Preposition (on/at)

**Input:** "Let's meet at Monday"

**Expected Correction:** "Let's meet **on** Monday"

**Explanation:** Use "on" for days of the week

---

### C-06: Missing Preposition

**Input:** "I'm interested Python"

**Expected Correction:** "I'm interested **in** Python"

**Explanation:** "interested" requires "in"

---

## Plural Errors

### C-07: Missing Plural -s

**Input:** "I have many friend"

**Expected Correction:** "I have many friend**s**"

**Explanation:** "many" requires plural noun

---

### C-08: Missing Plural After Number

**Input:** "Three file were deleted"

**Expected Correction:** "Three file**s** were deleted"

**Explanation:** Numbers > 1 require plural

---

## Word Order Errors

### C-09: Adjective Position

**Input:** "The car red is fast"

**Expected Correction:** "The **red car** is fast"

**Explanation:** Adjectives come before nouns in English

---

### C-10: SOV to SVO

**Input:** "I the code reviewed"

**Expected Correction:** "I **reviewed the code**"

**Explanation:** English uses Subject-Verb-Object order

---

## Subject-Verb Agreement

### C-11: Third Person Singular

**Input:** "He write code every day"

**Expected Correction:** "He write**s** code every day"

**Explanation:** Third person singular needs -s

---

### C-12: Plural Subject

**Input:** "The developers writes tests"

**Expected Correction:** "The developers **write** tests"

**Explanation:** Plural subjects use base verb form

---

## Correct English (No Correction Needed)

### C-13: Perfect Sentence

**Input:** "Please review my pull request when you have time."

**Expected:** No correction needed message

**Pass Criteria:** Recognizes correct English

---

### C-14: Technical Terms

**Input:** "Run npm install to fetch dependencies."

**Expected:** No correction needed (technical terms are acceptable)

**Pass Criteria:** Doesn't incorrectly flag technical language

---

## Multiple Errors

### C-15: Combined Errors

**Input:** "I have many computer in desk"

**Expected Corrections:**
- "computer" → "computer**s**" (plural)
- "in desk" → "**on the** desk" (preposition + article)

**Pass Criteria:** All errors identified
