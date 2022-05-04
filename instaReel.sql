-- Create Database
CREATE DATABASE instagramReels;

-- Create users Table
CREATE TABLE users(
    uid INTEGER NOT NULL UNIQUE AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    userName VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    savedReels LONGBLOB NOT NULL,
    dob DATE,
    userProfileImg BLOB,
    PRIMARY KEY(uid)
);

-- make uid INDEX for better searching
CREATE INDEX user_index ON users (uid);

-- Create Reels Table
CREATE TABLE reels(
    rId INTEGER NOT NULL UNIQUE AUTO_INCREMENT,
    uid INTEGER NOT NULL,
    videoLink VARCHAR(255) NOT NULL,
    caption VARCHAR(255),
    PRIMARY KEY(rId),
    FOREIGN KEY(uid) REFERENCES users(uid),
    INDEX (rId,uid)
);

-- Create comments Table
CREATE TABLE comments(
    cid INTEGER NOT NULL UNIQUE AUTO_INCREMENT,
    rId INTEGER NOT NULL,
    uid INTEGER NOT NULL,
    commentDescription VARCHAR(255),
    PRIMARY KEY(cid),
    FOREIGN KEY(rId) REFERENCES reels(rId),
    FOREIGN KEY(uid) REFERENCES users(uid)
);

-- Create likes Table
CREATE TABLE likes(
    lid INTEGER NOT NULL UNIQUE AUTO_INCREMENT,
    rId INTEGER NOT NULL,
    uid INTEGER NOT NULL,
    PRIMARY KEY(lid),
    FOREIGN KEY(rId) REFERENCES reels(rId),
    FOREIGN KEY(uid) REFERENCES users(uid)
);

-- Create follow Table
CREATE TABLE follow(
    senderId INTEGER NOT NULL,
    receiverId INTEGER NOT NULL,
    isFollower BOOLEAN DEFAULT false
    FOREIGN KEY(senderId) REFERENCES users(uid),
    FOREIGN KEY(receiverId) REFERENCES users(uid)
);

-- Create notification Table
CREATE TABLE notification(
    userId INTEGER NOT NULL,
    reelsId INTEGER NOT NULL,
    notificationDescription VARCHAR(255) NOT NULL,
    FOREIGN KEY(reelsId) REFERENCES reels(rId),
    FOREIGN KEY(userId) REFERENCES users(uid)
);