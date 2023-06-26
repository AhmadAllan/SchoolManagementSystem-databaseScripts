 -- Create admin table
CREATE TABLE admin (
    admin_id INT AUTO_INCREMENT NOT NULL,
    password VARCHAR(45) NOT NULL,
    user_name VARCHAR(45) NOT NULL UNIQUE,
    name VARCHAR(256) NOT NULL,
    email VARCHAR(45) NOT NULL,
    phone_number INT NOT NULL,
    PRIMARY KEY (admin_id)
);

-- Create teacher table
CREATE TABLE teacher (
    teacher_id INT AUTO_INCREMENT NOT NULL,
    password VARCHAR(45) NOT NULL,
    user_name VARCHAR(45) NOT NULL UNIQUE,
    name VARCHAR(256) NOT NULL,
    email VARCHAR(45) NOT NULL,
    phone_number INT NOT NULL,
    PRIMARY KEY (teacher_id)
);

-- Create parent table
CREATE TABLE parent (
    parent_id INT AUTO_INCREMENT NOT NULL,
    password VARCHAR(45) NOT NULL,
    user_name VARCHAR(45) NOT NULL UNIQUE,
    name VARCHAR(256) NOT NULL,
    email VARCHAR(45) NOT NULL,
    phone_number INT NOT NULL,
    PRIMARY KEY (parent_id)
);

-- Create student table
CREATE TABLE student (
    student_id INT AUTO_INCREMENT NOT NULL,
    password VARCHAR(45) NOT NULL,
    user_name VARCHAR(45) NOT NULL UNIQUE,
    name VARCHAR(256) NOT NULL,
    email VARCHAR(45) NOT NULL,
    grade INT NOT NULL,
    classroom VARCHAR(45) NOT NULL,
    fk_parent_id INT NOT NULL,
    status VARCHAR(45) NOT NULL,
    PRIMARY KEY (student_id),
    FOREIGN KEY (fk_parent_id) REFERENCES parent (parent_id)
);

-- Create classroom table
CREATE TABLE classroom (
    classroom_id INT AUTO_INCREMENT NOT NULL,
    grade INT NOT NULL,
    capacity INT NOT NULL,
    location VARCHAR(45) NOT NULL,
    fk_supervisor_id INT NOT NULL,
    PRIMARY KEY (classroom_id),
    FOREIGN KEY (fk_supervisor_id) REFERENCES teacher (teacher_id)
);

-- Create material table
CREATE TABLE material (
    material_id INT AUTO_INCREMENT NOT NULL,
    material_name VARCHAR(45) NOT NULL,
    grade INT NOT NULL,
    PRIMARY KEY (material_id)
);

-- Create t_m_c table
CREATE TABLE t_m_c (
    fk_teacher_id INT NOT NULL,
    fk_classroom_id INT NOT NULL,
    fk_material_id INT NOT NULL,
    FOREIGN KEY (fk_teacher_id) REFERENCES teacher (teacher_id),
    FOREIGN KEY (fk_classroom_id) REFERENCES classroom (classroom_id),
    FOREIGN KEY (fk_material_id) REFERENCES material (material_id)
);

-- Create mark table
CREATE TABLE mark (
    mark_id INT AUTO_INCREMENT NOT NULL,
    fk_material_id INT NOT NULL,
    fk_student_id INT NOT NULL,
    report INT NOT NULL,
    midterm INT NOT NULL,
    final INT NOT NULL,
    PRIMARY KEY (mark_id),
    FOREIGN KEY (fk_material_id) REFERENCES material (material_id),
    FOREIGN KEY (fk_student_id) REFERENCES student (student_id)
);

-- Create schedule table
CREATE TABLE schedule (
    schedule_id INT AUTO_INCREMENT NOT NULL,
    fk_classroom_id INT,
    publicity INT NOT NULL,
    event_date DATE,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    PRIMARY KEY (schedule_id),
    FOREIGN KEY (fk_classroom_id) REFERENCES classroom (classroom_id)
);

-- Create announcement table
CREATE TABLE announcement (
    announcement_id INT AUTO_INCREMENT NOT NULL,
    title VARCHAR(45) NOT NULL,
    content VARCHAR(256) NOT NULL,
    date_posted DATE NOT NULL,
    sender_id INT NOT NULL,
    PRIMARY KEY (announcement_id),
    FOREIGN KEY (sender_id) REFERENCES admin (admin_id)
);

-- Create messages table
CREATE TABLE messages (
    message_id INT AUTO_INCREMENT NOT NULL,
    sender_admin_id INT NOT NULL,
    sender_teacher_id INT NOT NULL,
    sender_student_id INT NOT NULL,
    sender_parent_id INT NOT NULL,
    receiver_admin_id INT NOT NULL,
    receiver_teacher_id INT NOT NULL,
    receiver_student_id INT NOT NULL,
    receiver_parent_id INT NOT NULL,
    message_content VARCHAR(256) NOT NULL,
    date_sent DATE NOT NULL,
    PRIMARY KEY (message_id),
    FOREIGN KEY (sender_admin_id) REFERENCES admin (admin_id),
    FOREIGN KEY (sender_teacher_id) REFERENCES teacher (teacher_id),
    FOREIGN KEY (sender_student_id) REFERENCES student (student_id),
    FOREIGN KEY (sender_parent_id) REFERENCES parent (parent_id),
    FOREIGN KEY (receiver_admin_id) REFERENCES admin (admin_id),
    FOREIGN KEY (receiver_teacher_id) REFERENCES teacher (teacher_id),
    FOREIGN KEY (receiver_student_id) REFERENCES student (student_id),
    FOREIGN KEY (receiver_parent_id) REFERENCES parent (parent_id)
);


-- tables after this are created to fill the requirement but still need some work
-- Create attendance table
CREATE TABLE attendance (
    attendance_id INT AUTO_INCREMENT NOT NULL,
    fk_student_id INT NOT NULL,
    fk_classroom_id INT NOT NULL,
    date_submitted DATE NOT NULL,
    status VARCHAR(45) NOT NULL,
    PRIMARY KEY (attendance_id),
    FOREIGN KEY (fk_student_id) REFERENCES student (student_id),
    FOREIGN KEY (fk_classroom_id) REFERENCES classroom (classroom_id)
);

-- Create certification table
CREATE TABLE certification (
    certification_id INT AUTO_INCREMENT NOT NULL,
    fk_teacher_id INT NOT NULL,
    fk_student_id INT NOT NULL,
    certificate_name VARCHAR(45) NOT NULL,
    issue_date DATE NOT NULL,
    PRIMARY KEY (certification_id),
    FOREIGN KEY (fk_teacher_id) REFERENCES teacher (teacher_id),
    FOREIGN KEY (fk_student_id) REFERENCES student (student_id)
);

-- Create library table
CREATE TABLE library (
    library_id INT AUTO_INCREMENT NOT NULL,
    material_id INT NOT NULL,
    student_id INT NOT NULL,
    checkout_date DATE NOT NULL,
    due_date DATE NOT NULL,
    fine INT NOT NULL,
    PRIMARY KEY (library_id),
    FOREIGN KEY (material_id) REFERENCES material (material_id),
    FOREIGN KEY (student_id) REFERENCES student (student_id)
);

-- Create extracurricular_activities table
CREATE TABLE extracurricular_activities (
    activity_id INT AUTO_INCREMENT NOT NULL,
    activity_name VARCHAR(45) NOT NULL,
    description VARCHAR(256) NOT NULL,
    PRIMARY KEY (activity_id)
);

-- Create student_activities table
CREATE TABLE student_activities (
    fk_student_id INT NOT NULL,
    fk_activity_id INT NOT NULL,
    FOREIGN KEY (fk_student_id) REFERENCES student (student_id),
    FOREIGN KEY (fk_activity_id) REFERENCES extracurricular_activities (activity_id)
);

-- Create third_party_integration table
CREATE TABLE third_party_integration (
    integration_id INT AUTO_INCREMENT NOT NULL,
    integration_name VARCHAR(45) NOT NULL,
    PRIMARY KEY (integration_id)
);

-- Create gpa_calculator table
CREATE TABLE gpa_calculator (
    fk_student_id INT NOT NULL,
    gpa FLOAT NOT NULL,
    FOREIGN KEY (fk_student_id) REFERENCES student (student_id)
);

-- Create admission table
CREATE TABLE admission (
    admission_id INT AUTO_INCREMENT NOT NULL,
    fk_student_id INT NOT NULL,
    application_form VARCHAR(256) NOT NULL,
    payment_status VARCHAR(45) NOT NULL,
    admission_decision VARCHAR(45) NOT NULL,
    PRIMARY KEY (admission_id),
    FOREIGN KEY (fk_student_id) REFERENCES student (student_id)
);

-- Create data_protection table
CREATE TABLE data_protection (
    rule_id INT AUTO_INCREMENT NOT NULL,
    rule_name VARCHAR(45) NOT NULL,
    PRIMARY KEY (rule_id)
);

-- Create the calendar table to store activities and due dates
CREATE TABLE calendar (
    event_id INT AUTO_INCREMENT NOT NULL,
    event_name VARCHAR(45) NOT NULL,
    event_type VARCHAR(45) NOT NULL,
    event_date DATE NOT NULL,
    PRIMARY KEY (event_id)
);

-- Create the system_integration table for third-party LMS integration
CREATE TABLE system_integration (
    integration_id INT AUTO_INCREMENT NOT NULL,
    integration_name VARCHAR(45) NOT NULL,
    PRIMARY KEY (integration_id)
);

-- Create the authentication table for user authentication and authorization
CREATE TABLE authentication (
    user_id INT AUTO_INCREMENT NOT NULL,
    user_name VARCHAR(45) NOT NULL UNIQUE,
    password VARCHAR(45) NOT NULL,
    role VARCHAR(45) NOT NULL,
    PRIMARY KEY (user_id)
);

-- Update the table names and references in the above statements as per your database schema and naming conventions.

-- Add any additional constraints or modifications as per your requirements.

-- Finally, add any necessary indexes, triggers, or other database objects.

-- End of the script
