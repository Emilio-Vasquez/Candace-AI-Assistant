USE candace_assistant;

SET SQL_SAFE_UPDATES = 0;

-- Wipe any existing grades for these courses for Alex
DELETE ag
FROM assignment_grades ag
JOIN assignments a   ON ag.assignment_id = a.assignment_id
JOIN classes cl      ON a.class_id       = cl.class_id
JOIN courses c       ON cl.course_id     = c.course_id
WHERE ag.student_id = 1000001
  AND c.course_name IN (
    'CST 161 - Computer Programming Fundamentals',
    'ENG 101 - English Composition I',
    'PSY 101 - General Psychology',
    'MAT 171 - Unified Calculus I',
    'CST 162 - Computer Algorithms',
    'MAT 172 - Unified Calculus II',
    'ENG 102 - English Composition II',
    'PHY 111 - Mechanics',
    'PHYL 111 - Mechanics Lab'
  );

-- =====================================================
-- CST 161 - Computer Programming Fundamentals (1004)
-- Last two: Project 2 + Final Exam -> submitted, no score yet
-- =====================================================
INSERT INTO assignment_grades (student_id, assignment_id, score, submitted_at, status)
SELECT
  1000001 AS student_id,
  a.assignment_id,
  CASE a.assignment_name
    WHEN 'Getting Started: Canvas & zyBooks Setup'           THEN 18   -- /20
    WHEN 'Lab 1: Intro to Python & Ethics Reflection'        THEN 36   -- /40
    WHEN 'Homework 1: Variables & Expressions'               THEN 37   -- /40
    WHEN 'Homework 2: Decision Structures'                   THEN 35   -- /40
    WHEN 'Semester Exam I: Chapters 1–3'                     THEN 86   -- /100
    WHEN 'Homework 3: Loops'                                 THEN 46   -- /50
    WHEN 'Project 1: Lists & Dictionaries Mini-Project'      THEN 91   -- /100
    WHEN 'Quiz: Number Systems'                              THEN 26   -- /30
    WHEN 'Semester Exam II: Loops, Data Structures & Number Systems' THEN 94  -- /120
    WHEN 'Homework 4: Files, Strings & Exceptions'           THEN 55   -- /60
    -- Last two -> no score yet
    WHEN 'Project 2: Final Programming Project'              THEN NULL
    WHEN 'Final Exam: Comprehensive'                         THEN NULL
    ELSE a.points
  END AS score,
  a.due_at AS submitted_at,
  CASE
    WHEN a.assignment_name IN ('Project 2: Final Programming Project',
                               'Final Exam: Comprehensive')
      THEN 'submitted'        -- turned in, not graded
    ELSE 'graded'
  END AS status
FROM assignments a
JOIN classes cl  ON a.class_id   = cl.class_id
JOIN courses c   ON cl.course_id = c.course_id
WHERE c.course_name = 'CST 161 - Computer Programming Fundamentals';

-- =====================================================
-- ENG 101 - English Composition I (class_id = 1001)
-- Last two: Final Critical Analysis Essay + Final Exam
-- =====================================================
INSERT INTO assignment_grades (student_id, assignment_id, score, submitted_at, status)
SELECT
  1000001 AS student_id,
  a.assignment_id,
  CASE a.assignment_name
    WHEN 'Diagnostic Writing'                     THEN 15   -- /20
    WHEN 'Draft: Reflection/Narration Essay'      THEN 25   -- /30
    WHEN 'Final Reflection/Narrative Essay'       THEN 63   -- /100
    WHEN 'Draft: Comparison/Contrast Essay'       THEN 30   -- /40
    WHEN 'Final Comparison/Contrast Essay'        THEN 72   -- /100
    WHEN 'Draft: Research Essay'                  THEN 32   -- /40
    WHEN 'Citation Quiz (MLA Format)'             THEN 12   -- /20
    WHEN 'Final Research Essay'                   THEN 75   -- /120
    WHEN 'Draft: Critical Analysis Essay'         THEN 35   -- /40
    -- Last two -> no score yet
    WHEN 'Final Critical Analysis Essay'          THEN NULL
    WHEN 'Final Exam'                             THEN NULL
    ELSE a.points
  END AS score,
  a.due_at AS submitted_at,
  CASE
    WHEN a.assignment_name IN ('Final Critical Analysis Essay',
                               'Final Exam')
      THEN 'submitted'
    ELSE 'graded'
  END AS status
FROM assignments a
JOIN classes cl  ON a.class_id   = cl.class_id
JOIN courses c   ON cl.course_id = c.course_id
WHERE c.course_name = 'ENG 101 - English Composition I';

-- =====================================================
-- PSY 101 - General Psychology (class_id = 1002)
-- Last two: Quiz 12 + Final Exam / Research Paper
-- =====================================================
INSERT INTO assignment_grades (student_id, assignment_id, score, submitted_at, status)
SELECT
  1000001 AS student_id,
  a.assignment_id,
  CASE a.assignment_name
    WHEN 'Quiz 1: What is Psychology?'                     THEN 18  -- /20
    WHEN 'Quiz 2: Biology and Psychology'                  THEN 17  -- /20
    WHEN 'Quiz 3: Sensation and Perception'                THEN 19  -- /20
    WHEN 'Quiz 4: Consciousness'                           THEN 16  -- /20
    WHEN 'Quiz 5: Learning'                                THEN 18  -- /20
    WHEN 'Information Literacy Project / Midterm'          THEN 54  -- /60
    WHEN 'Quiz 6: Memory'                                  THEN 17  -- /20
    WHEN 'Quiz 7: Thinking, Language, and Intelligence'    THEN 18  -- /20
    WHEN 'Quiz 8: Motivation and Emotion'                  THEN 19  -- /20
    WHEN 'Evaluation Exam / Applied Paper'                 THEN 87  -- /100
    WHEN 'Quiz 9: The Voyage Through the Life Span'        THEN 18  -- /20
    WHEN 'Quiz 10: Personality'                            THEN 17  -- /20
    WHEN 'Quiz 11: Psychological Disorders'                THEN 16  -- /20
    -- Last two -> no score yet
    WHEN 'Quiz 12: Social Psychology'                      THEN NULL
    WHEN 'Final Exam / Research Paper'                     THEN NULL
    ELSE a.points
  END AS score,
  a.due_at AS submitted_at,
  CASE
    WHEN a.assignment_name IN ('Quiz 12: Social Psychology',
                               'Final Exam / Research Paper')
      THEN 'submitted'
    ELSE 'graded'
  END AS status
FROM assignments a
JOIN classes cl  ON a.class_id   = cl.class_id
JOIN courses c   ON cl.course_id = c.course_id
WHERE c.course_name = 'PSY 101 - General Psychology';

-- =====================================================
-- MAT 171 - Unified Calculus I (class_id = 1003)
-- Last two: Homework 4 + Final Exam Comprehensive
-- =====================================================
INSERT INTO assignment_grades (student_id, assignment_id, score, submitted_at, status)
SELECT
  1000001 AS student_id,
  a.assignment_id,
  CASE a.assignment_name
    WHEN 'Diagnostic Skills Quiz (Precalculus Review)'                   THEN 17  -- /20
    WHEN 'Homework 1: Limits & Continuity (Sections 1.1–1.4)'            THEN 36  -- /40
    WHEN 'Quiz 1: Limits & Continuity'                                   THEN 26  -- /30
    WHEN 'Unit Test I: Limits & Their Properties'                        THEN 88  -- /100
    WHEN 'Homework 2: Basic Differentiation Rules (Sections 2.1–2.3)'    THEN 44  -- /50
    WHEN 'Unit Test II: Differentiation'                                 THEN 96  -- /120
    WHEN 'Homework 3: Applications of Derivatives (Sections 3.1–3.7)'    THEN 52  -- /60
    WHEN 'Unit Test III: Applications of Differentiation'                THEN 90  -- /120
    -- Last two -> no score yet
    WHEN 'Homework 4: Integration & FTC'                                 THEN NULL
    WHEN 'Final Exam: Comprehensive Calculus I'                          THEN NULL
    ELSE a.points
  END AS score,
  a.due_at AS submitted_at,
  CASE
    WHEN a.assignment_name IN ('Homework 4: Integration & FTC',
                               'Final Exam: Comprehensive Calculus I')
      THEN 'submitted'
    ELSE 'graded'
  END AS status
FROM assignments a
JOIN classes cl  ON a.class_id   = cl.class_id
JOIN courses c   ON cl.course_id = c.course_id
WHERE c.course_name = 'MAT 171 - Unified Calculus I';

-- =====================================================
-- CST 162 - Computer Algorithms
-- Last two: Project 2 + Final Exam -> submitted, no score yet
-- =====================================================
INSERT INTO assignment_grades (student_id, assignment_id, score, submitted_at, status)
SELECT
  1000001 AS student_id,
  a.assignment_id,
  CASE a.assignment_name
    WHEN 'Getting Started: Java & IDE Setup'                      THEN 19   -- /20
    WHEN 'Lab 1: Intro to Java & Simple Programs'                 THEN 35   -- /40
    WHEN 'Homework 1: Variables, Input/Output & Decisions'        THEN 36   -- /40
    WHEN 'Homework 2: Loops & Nested Loops'                       THEN 34   -- /40
    WHEN 'Semester Exam I: Chapters 1–4'                          THEN 89   -- /100
    WHEN 'Project 1: Classes & Objects Mini-Project'              THEN 92   -- /100
    WHEN 'Homework 3: Arrays & Array Algorithms'                  THEN 47   -- /50
    WHEN 'Semester Exam II: Arrays & Methods'                     THEN 96   -- /120
    WHEN 'Homework 4: File I/O & Exception Handling'              THEN 54   -- /60
    WHEN 'Quiz: Inheritance & Polymorphism'                       THEN 27   -- /30
    -- Last two -> no score yet
    WHEN 'Project 2: Object-Oriented Design Project'              THEN NULL
    WHEN 'Final Exam: Comprehensive Java & Algorithms'            THEN NULL
    ELSE a.points
  END AS score,
  a.due_at AS submitted_at,
  CASE
    WHEN a.assignment_name IN ('Project 2: Object-Oriented Design Project',
                               'Final Exam: Comprehensive Java & Algorithms')
      THEN 'submitted'        -- turned in, not graded
    ELSE 'graded'
  END AS status
FROM assignments a
JOIN classes cl  ON a.class_id   = cl.class_id
JOIN courses c   ON cl.course_id = c.course_id
WHERE c.course_name = 'CST 162 - Computer Algorithms';

-- =====================================================
-- MAT 172 - Unified Calculus II
-- Last two: Homework 4 + Final Exam -> submitted, no score yet
-- =====================================================
INSERT INTO assignment_grades (student_id, assignment_id, score, submitted_at, status)
SELECT
  1000001 AS student_id,
  a.assignment_id,
  CASE a.assignment_name
    WHEN 'Diagnostic Quiz: Calc I Review'                         THEN 16   -- /20
    WHEN 'Homework 1: Techniques of Integration'                  THEN 35   -- /40
    WHEN 'Quiz 1: Integration Applications'                       THEN 26   -- /30
    WHEN 'Unit Test I: Techniques of Integration'                 THEN 87   -- /100
    WHEN 'Homework 2: Applications of Integration'                THEN 36   -- /40
    WHEN 'Quiz 2: Area, Volume & Arc Length'                      THEN 27   -- /30
    WHEN 'Unit Test II: Applications of Integration'              THEN 92   -- /120
    WHEN 'Homework 3: Sequences & Series'                         THEN 43   -- /50
    WHEN 'Unit Test III: Infinite Series'                         THEN 90   -- /120
    -- Last two -> no score yet
    WHEN 'Homework 4: Parametric & Polar Curves'                  THEN NULL
    WHEN 'Final Exam: Comprehensive Calculus II'                  THEN NULL
    ELSE a.points
  END AS score,
  a.due_at AS submitted_at,
  CASE
    WHEN a.assignment_name IN ('Homework 4: Parametric & Polar Curves',
                               'Final Exam: Comprehensive Calculus II')
      THEN 'submitted'
    ELSE 'graded'
  END AS status
FROM assignments a
JOIN classes cl  ON a.class_id   = cl.class_id
JOIN courses c   ON cl.course_id = c.course_id
WHERE c.course_name = 'MAT 172 - Unified Calculus II';

-- =====================================================
-- ENG 102 - English Composition II
-- Last two: Final Research Essay + Final Exam -> submitted, no score yet
-- =====================================================
INSERT INTO assignment_grades (student_id, assignment_id, score, submitted_at, status)
SELECT
  1000001 AS student_id,
  a.assignment_id,
  CASE a.assignment_name
    WHEN 'Diagnostic Writing: Literary Analysis'                   THEN 16   -- /20
    WHEN 'Response Paper 1: The Story of an Hour & Araby'         THEN 25   -- /30
    WHEN 'Response Paper 2: Chopin''s The Awakening'              THEN 34   -- /40
    WHEN 'Response Paper 3: A Rose for Emily'                     THEN 32   -- /40
    WHEN 'Literary Terms Quiz'                                    THEN 17   -- /20
    WHEN 'Response Paper 4: Hurston & Baldwin Stories'            THEN 34   -- /40
    WHEN 'Midterm Exam: Fiction & Literary Terms'                 THEN 86   -- /100
    WHEN 'Research Essay Draft: Drama or Poetry'                  THEN 32   -- /40
    WHEN 'Annotated Bibliography: Research Essay'                 THEN 27   -- /30
    -- Last two -> no score yet
    WHEN 'Final Research Essay: Literary Argument'                THEN NULL
    WHEN 'Final Exam: Poetry, Drama & Fiction'                    THEN NULL
    ELSE a.points
  END AS score,
  a.due_at AS submitted_at,
  CASE
    WHEN a.assignment_name IN ('Final Research Essay: Literary Argument',
                               'Final Exam: Poetry, Drama & Fiction')
      THEN 'submitted'
    ELSE 'graded'
  END AS status
FROM assignments a
JOIN classes cl  ON a.class_id   = cl.class_id
JOIN courses c   ON cl.course_id = c.course_id
WHERE c.course_name = 'ENG 102 - English Composition II';

-- =====================================================
-- PHY 111 - Mechanics
-- Last two: Test 5 + Final Exam -> submitted, no score yet
-- =====================================================
INSERT INTO assignment_grades (student_id, assignment_id, score, submitted_at, status)
SELECT
  1000001 AS student_id,
  a.assignment_id,
  CASE a.assignment_name
    WHEN 'Homework 1: Units, Vectors & Motion'                    THEN 34   -- /40
    WHEN 'Test 1: Units, 1D & 2D Kinematics'                      THEN 84   -- /100
    WHEN 'Homework 2: Newton''s Laws & Friction'                  THEN 35   -- /40
    WHEN 'Test 2: Newton''s Laws & Circular Motion'               THEN 88   -- /100
    WHEN 'Homework 3: Work, Energy & Power'                       THEN 36   -- /40
    WHEN 'Test 3: Work & Energy'                                  THEN 90   -- /100
    WHEN 'Homework 4: Momentum & Collisions'                      THEN 35   -- /40
    WHEN 'Test 4: Momentum & Center of Mass'                      THEN 89   -- /100
    WHEN 'Homework 5: Rotation, Gravitation & Fluids'             THEN 34   -- /40
    -- Last two -> no score yet
    WHEN 'Test 5: Rotation, Gravitation & Fluids'                 THEN NULL -- e.g. /120
    WHEN 'Final Exam: Comprehensive Mechanics'                    THEN NULL
    ELSE a.points
  END AS score,
  a.due_at AS submitted_at,
  CASE
    WHEN a.assignment_name IN ('Test 5: Rotation, Gravitation & Fluids',
                               'Final Exam: Comprehensive Mechanics')
      THEN 'submitted'
    ELSE 'graded'
  END AS status
FROM assignments a
JOIN classes cl  ON a.class_id   = cl.class_id
JOIN courses c   ON cl.course_id = c.course_id
WHERE c.course_name = 'PHY 111 - Mechanics';

-- =====================================================
-- PHYL 111 - Mechanics Lab
-- Last two: Lab Practical + Final Lab Report -> submitted, no score yet
-- =====================================================
INSERT INTO assignment_grades (student_id, assignment_id, score, submitted_at, status)
SELECT
  1000001 AS student_id,
  a.assignment_id,
  CASE a.assignment_name
    WHEN 'Lab 1: Measurement & Uncertainty'                       THEN 22   -- /25
    WHEN 'Lab 2: One-Dimensional Kinematics'                      THEN 23   -- /25
    WHEN 'Lab 3: Projectile Motion'                               THEN 22   -- /25
    WHEN 'Lab 4: Newton''s Second Law'                            THEN 23   -- /25
    WHEN 'Lab 5: Work & Energy'                                   THEN 24   -- /25
    WHEN 'Lab 6: Momentum & Collisions'                           THEN 23   -- /25
    WHEN 'Lab 7: Rotational Dynamics'                             THEN 22   -- /25
    WHEN 'Lab 8: Fluids & Buoyancy'                               THEN 24   -- /25
    -- Last two -> no score yet
    WHEN 'Lab Practical Exam'                                     THEN NULL
    WHEN 'Final Lab Report: Experimental Portfolio'               THEN NULL
    ELSE a.points
  END AS score,
  a.due_at AS submitted_at,
  CASE
    WHEN a.assignment_name IN ('Lab Practical Exam',
                               'Final Lab Report: Experimental Portfolio')
      THEN 'submitted'
    ELSE 'graded'
  END AS status
FROM assignments a
JOIN classes cl  ON a.class_id   = cl.class_id
JOIN courses c   ON cl.course_id = c.course_id
WHERE c.course_name = 'PHYL 111 - Mechanics Lab';

SET SQL_SAFE_UPDATES = 1;
