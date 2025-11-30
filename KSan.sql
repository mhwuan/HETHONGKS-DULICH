USE master; 
GO


IF EXISTS (SELECT name FROM sys.databases WHERE name = N'HotelReservationDB')
BEGIN
    ALTER DATABASE HotelReservationDB SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE HotelReservationDB;
END
GO 

CREATE DATABASE HotelReservationDB;
GO

USE HotelReservationDB;
GO


-- Bảng 1: HOTEL
CREATE TABLE HOTEL (
    Hotel_ID      INT             IDENTITY(1, 1) PRIMARY KEY,
    HotelName     NVARCHAR(100)   NOT NULL,
    Address       NVARCHAR(255),
    StarRating    DECIMAL(2,1)    CHECK (StarRating >= 1 AND StarRating <= 5),
    Phone         VARCHAR(20),
    Email         VARCHAR(100),
    Description   NVARCHAR(MAX)
);

-- Bảng 2: CUSTOMER
CREATE TABLE CUSTOMER (
    CustomerID      INT             IDENTITY(1, 1) PRIMARY KEY,
    FullName        NVARCHAR(100)   NOT NULL,
    Email           VARCHAR(100)    UNIQUE,
    Phone           VARCHAR(20),
    IdentifyNumber  VARCHAR(50)     UNIQUE
);

-- Bảng 3: ROOM_TYPE 
CREATE TABLE ROOM_TYPE (
    RoomTypeID      INT             NOT NULL,
    Hotel_ID        INT             NOT NULL,
    TYPE_NAME       NVARCHAR(100)   NOT NULL,
    Description     NVARCHAR(MAX),
    Capacity        INT             NOT NULL,
    BasePrice       DECIMAL(10, 2)  NOT NULL,

    PRIMARY KEY (RoomTypeID, Hotel_ID),
    FOREIGN KEY (Hotel_ID) REFERENCES HOTEL(Hotel_ID)
);

-- Bảng 4: ROOM 
CREATE TABLE ROOM (
    RoomID      INT             IDENTITY(1, 1) PRIMARY KEY, 
    Hotel_ID    INT             NOT NULL,
    RoomTypeID  INT             NOT NULL,
    RoomNumber  VARCHAR(10)     NOT NULL,
    STATUS      NVARCHAR(50)    NOT NULL DEFAULT 'Available',
    
    -- Khóa ngoại vẫn tham chiếu Khóa ghép của ROOM_TYPE
    FOREIGN KEY (RoomTypeID, Hotel_ID) REFERENCES ROOM_TYPE(RoomTypeID, Hotel_ID),
    -- Ràng buộc duy nhất RoomNumber trong phạm vi Hotel
    CONSTRAINT UQ_Room_Number UNIQUE (Hotel_ID, RoomNumber)
);

-- Bảng 5: TIME_PERIOD
CREATE TABLE TIME_PERIOD (
    TimePeriodID    INT             IDENTITY(1, 1) PRIMARY KEY,
    Hotel_ID        INT             NOT NULL,
    PeriodName      NVARCHAR(100)   NOT NULL,
    StartDate       DATE            NOT NULL,
    EndDate         DATE            NOT NULL,
    PriceMultiplier DECIMAL(4, 2)   NOT NULL DEFAULT 1.00,
    
    FOREIGN KEY (Hotel_ID) REFERENCES HOTEL(Hotel_ID),
    CONSTRAINT CHK_TimePeriod_Dates CHECK (EndDate >= StartDate),
    CONSTRAINT CHK_PriceMultiplier CHECK (PriceMultiplier > 0)
);

-- Bảng 6: BOOKING
CREATE TABLE BOOKING (
    BookingID       INT             IDENTITY(1, 1),
    CustomerID      INT             NOT NULL,
    TimePeriodID    INT,
    BookingDate     DATE            NOT NULL DEFAULT GETDATE(),
    Check_In_Date   DATETIME        NOT NULL,
    Check_Out_Date  DATETIME        NOT NULL,
    NumberOfGuests  INT             NOT NULL DEFAULT 1,
    TotalAmount     DECIMAL(12, 2)  NOT NULL DEFAULT 0,
    STATUS          NVARCHAR(50)    NOT NULL DEFAULT 'Pending',
    
    PRIMARY KEY (BookingID, CustomerID),
    FOREIGN KEY (CustomerID) REFERENCES CUSTOMER(CustomerID),
    FOREIGN KEY (TimePeriodID) REFERENCES TIME_PERIOD(TimePeriodID),
    CONSTRAINT CHK_Booking_Dates CHECK (Check_Out_Date > Check_In_Date),
    CONSTRAINT CHK_NumberOfGuests CHECK (NumberOfGuests > 0)
);

-- Bảng 7: REVIEW
CREATE TABLE REVIEW (
    ReviewID        INT             IDENTITY(1, 1),
    BookingID       INT             NOT NULL,
    CustomerID      INT             NOT NULL,
    Rating          DECIMAL(3, 1)   NOT NULL CHECK (Rating >= 1 AND Rating <= 5),
    Comment         NVARCHAR(MAX),
    ReviewDate      DATE            NOT NULL DEFAULT GETDATE(),
    
    PRIMARY KEY (ReviewID, BookingID, CustomerID),
    FOREIGN KEY (BookingID, CustomerID) REFERENCES BOOKING(BookingID, CustomerID)
);

-- Bảng 8: BOOKING_ROOM 
CREATE TABLE BOOKING_ROOM (
    BookingID   INT             NOT NULL,
    CustomerID  INT             NOT NULL,
    RoomID      INT             NOT NULL, 
    RoomPrice   DECIMAL(10, 2)  NOT NULL,
    
    PRIMARY KEY (BookingID, CustomerID, RoomID),
    FOREIGN KEY (BookingID, CustomerID) REFERENCES BOOKING(BookingID, CustomerID),
    FOREIGN KEY (RoomID) REFERENCES ROOM(RoomID) -- Tham chiếu Khóa chính đơn mới
);

-- Bảng 9: PAYMENT
CREATE TABLE PAYMENT (
    PaymentID       INT             IDENTITY(1, 1) PRIMARY KEY,
    BookingID       INT             NOT NULL,
    CustomerID      INT             NOT NULL,
    Payment_Date    DATETIME        NOT NULL DEFAULT GETDATE(),
    Payment_Method  NVARCHAR(50)    NOT NULL,
    Amount          DECIMAL(12, 2)  NOT NULL,
    Payment_Status  NVARCHAR(50)    NOT NULL DEFAULT 'Pending',
    TransactionID   VARCHAR(100),
    
    FOREIGN KEY (BookingID, CustomerID) REFERENCES BOOKING(BookingID, CustomerID),
    CONSTRAINT CHK_Payment_Amount CHECK (Amount >= 0)
);
GO



