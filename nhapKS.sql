USE HotelReservationDB;
GO

-- Dữ liệu mẫu cho bảng 1: HOTEL
INSERT INTO HOTEL (HotelName, Address, StarRating, Phone, Email, Description) VALUES
(N'Grand Saigon Hotel', N'Đường Đồng Khởi, Quận 1, TP. Hồ Chí Minh', 5.0, '02838275888', 'contact@grandsaigon.com', N'Khách sạn 5 sao sang trọng tại trung tâm Sài Gòn.'),
(N'Hanoi Elegance', N'Phố Hàng Bè, Quận Hoàn Kiếm, Hà Nội', 4.5, '02439396868', 'info@hanoielegance.vn', N'Khách sạn boutique cổ điển gần Hồ Hoàn Kiếm.'),
(N'Da Nang Beach Resort', N'Đường Võ Nguyên Giáp, Quận Ngũ Hành Sơn, Đà Nẵng', 4.0, '02363969798', 'res@danangbeach.com', N'Khu nghỉ dưỡng mặt biển với hồ bơi vô cực.'),
(N'Imperial Hue', N'Đường Hùng Vương, TP. Huế', 4.0, '02343897799', 'booking@imperialhue.com', N'Khách sạn mang kiến trúc cung đình triều Nguyễn.');
GO

-- Dữ liệu mẫu cho bảng 2: CUSTOMER
INSERT INTO CUSTOMER (FullName, Email, Phone, IdentifyNumber) VALUES
(N'Trần Văn An', 'an.tran@example.com', '0901112233', '001123456789'),
(N'Nguyễn Thị Bình', 'binh.nguyen@example.com', '0918887766', '002987654321'),
(N'Lê Hoàng Cường', 'cuong.le@example.com', '0975554433', '003112233445'),
(N'Phạm Thị Dung', 'dung.pham@example.com', '0983332211', '004678901234');
GO

-- Dữ liệu mẫu cho bảng 3: ROOM_TYPE (ĐÃ BỎ CỘT Area)
INSERT INTO ROOM_TYPE (RoomTypeID, Hotel_ID, TYPE_NAME, Description, Capacity, BasePrice) VALUES
-- Hotel 1 (Grand Saigon Hotel)
(1, 1, N'Deluxe King', N'Phòng Deluxe có giường King size, hướng phố.', 2, 2500000.00),
(2, 1, N'Suite President', N'Phòng Suite Tổng thống, tầm nhìn toàn cảnh.', 4, 15000000.00),
(3, 1, N'Standard Twin', N'Phòng tiêu chuẩn có 2 giường đơn.', 2, 1800000.00);

-- Hotel 2 (Hanoi Elegance)
INSERT INTO ROOM_TYPE (RoomTypeID, Hotel_ID, TYPE_NAME, Description, Capacity, BasePrice) VALUES
(1, 2, N'Boutique King', N'Phòng có phong cách cổ điển, giường King.', 2, 1500000.00),
(2, 2, N'Family Room', N'Phòng gia đình với 1 giường đôi và 2 giường đơn.', 4, 2800000.00);
GO

-- Dữ liệu mẫu cho bảng 4: ROOM
-- Hotel 1
INSERT INTO ROOM (Hotel_ID, RoomTypeID, RoomNumber, STATUS) VALUES
(1, 1, '101', 'Available'), -- Deluxe King - RoomID 1
(1, 1, '102', 'Occupied'),  -- Deluxe King - RoomID 2
(1, 2, '201', 'Available'), -- Suite President - RoomID 3
(1, 3, '305', 'Available'); -- Standard Twin - RoomID 4

-- Hotel 2
INSERT INTO ROOM (Hotel_ID, RoomTypeID, RoomNumber, STATUS) VALUES
(2, 1, '401', 'Available'), -- Boutique King - RoomID 5
(2, 1, '402', 'Occupied'),  -- Boutique King - RoomID 6
(2, 2, '503', 'Available'); -- Family Room - RoomID 7
GO

-- Dữ liệu mẫu cho bảng 5: TIME_PERIOD
-- Hotel 1 (Grand Saigon Hotel)
INSERT INTO TIME_PERIOD (Hotel_ID, PeriodName, StartDate, EndDate, PriceMultiplier) VALUES
(1, N'Mùa Cao Điểm Lễ', '2025-12-20', '2026-01-05', 1.25), -- TimePeriodID 1
(1, N'Mùa Thấp Điểm', '2026-06-01', '2026-08-31', 0.80);    -- TimePeriodID 2

-- Hotel 2 (Hanoi Elegance)
INSERT INTO TIME_PERIOD (Hotel_ID, PeriodName, StartDate, EndDate, PriceMultiplier) VALUES
(2, N'Cuối Tuần Lớn', '2025-11-20', '2025-11-23', 1.10);    -- TimePeriodID 3
GO

-- Dữ liệu mẫu cho bảng 6: BOOKING
-- Lấy TimePeriodID cho mùa cao điểm của Hotel 1
DECLARE @TimePeriodID_Hotel1_Peak INT = (SELECT TimePeriodID FROM TIME_PERIOD WHERE Hotel_ID = 1 AND PeriodName = N'Mùa Cao Điểm Lễ'); -- ID 1
-- Lấy TimePeriodID cho cuối tuần lớn của Hotel 2
DECLARE @TimePeriodID_Hotel2_Weekend INT = (SELECT TimePeriodID FROM TIME_PERIOD WHERE Hotel_ID = 2 AND PeriodName = N'Cuối Tuần Lớn'); -- ID 3

INSERT INTO BOOKING (CustomerID, TimePeriodID, BookingDate, Check_In_Date, Check_Out_Date, NumberOfGuests, TotalAmount, STATUS) VALUES
-- Booking 1: Khách hàng 1, Mùa Cao Điểm Hotel 1, Đã nhận phòng. Giá phòng: 2.500.000 * 1.25 = 3.125.000/đêm. (3 đêm) -> 9.375.000. Giả định TotalAmount là giá đúng: 9375000.00
(1, @TimePeriodID_Hotel1_Peak, '2025-11-01', '2025-12-21 14:00:00', '2025-12-24 12:00:00', 2, 9375000.00, 'Checked-In'), -- BookingID 1

-- Booking 2: Khách hàng 2, Không có TimePeriod đặc biệt, Đã hoàn thành. Giá phòng: 1.800.000/đêm. (3 đêm) -> 5.400.000
(2, NULL, '2025-10-15', '2025-11-05 15:00:00', '2025-11-08 12:00:00', 1, 5400000.00, 'Completed'), -- BookingID 2

-- Booking 3: Khách hàng 3, Cuối Tuần Lớn Hotel 2, Đã xác nhận (sắp tới). Giá phòng: 2.800.000 * 1.10 = 3.080.000/đêm. (2 đêm) -> 6.160.000
(3, @TimePeriodID_Hotel2_Weekend, '2025-11-10', '2025-11-21 14:00:00', '2025-11-23 12:00:00', 3, 6160000.00, 'Confirmed'), -- BookingID 3

-- Booking 4: Khách hàng 4, Không có TimePeriod đặc biệt, Đang chờ. Giá phòng: 1.800.000/đêm (2 đêm) -> 3.600.000
(4, NULL, '2025-11-14', '2026-01-10 14:00:00', '2026-01-12 12:00:00', 2, 3600000.00, 'Pending'); -- BookingID 4
GO

-- Dữ liệu mẫu cho bảng 7: REVIEW
-- Review cho Booking 2 (Khách hàng 2)
INSERT INTO REVIEW (BookingID, CustomerID, Rating, Comment, ReviewDate) VALUES
(2, 2, 4.5, N'Phòng sạch sẽ, vị trí thuận tiện. Dịch vụ tốt.', '2025-11-08'); -- ReviewID 1
GO

-- Dữ liệu mẫu cho bảng 8: BOOKING_ROOM


INSERT INTO BOOKING_ROOM (BookingID, RoomID, RoomPrice, CustomerID) VALUES
(1, 2, 3125000.00, 1), -- Booking 1 của Customer 1
(2, 4, 1800000.00, 2), -- Booking 2 của Customer 2
(3, 7, 3080000.00, 3); -- Booking 3 của Customer 3
GO


-- Dữ liệu mẫu cho bảng 9: PAYMENT
-- Payment 1 cho Booking 1 (9.375.000)
INSERT INTO PAYMENT (BookingID, CustomerID, Payment_Date, Payment_Method, Amount, Payment_Status, TransactionID) VALUES
(1, 1, '2025-11-01 10:30:00', N'Credit Card', 9375000.00, 'Completed', 'TXN_GSH12345'), -- PaymentID 1
-- Payment 2 cho Booking 2 (5.400.000)
(2, 2, '2025-10-15 11:00:00', N'Bank Transfer', 5400000.00, 'Completed', 'TXN_GSH67890'); -- PaymentID 2
GO