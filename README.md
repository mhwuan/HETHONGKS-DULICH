# 🏨 Hotel Booking Management System

> Một hệ thống quản lý và đặt phòng khách sạn toàn diện, hỗ trợ quản lý giá theo mùa vụ và xử lý logic đặt phòng thông minh.

[![Build Status](https://img.shields.io/badge/build-passing-brightgreen)]()
[![License](https://img.shields.io/badge/license-MIT-blue)]()
[![Version](https://img.shields.io/badge/version-1.0.0-orange)]()

## 📖 Giới thiệu tổng quan (Overview)

Dự án này là một ứng dụng web/phần mềm cho phép người dùng tìm kiếm và đặt phòng khách sạn, đồng thời cung cấp công cụ cho quản trị viên quản lý phòng ốc, loại phòng và thiết lập giá cả linh hoạt.

Điểm nổi bật của hệ thống là khả năng xử lý các nghiệp vụ phức tạp như: kiểm tra trùng lịch (availability check), tính toán giá theo mùa/ngày lễ và hệ thống đánh giá khách quan.

## 🚀 Tính năng chính (Features)

### 👤 Dành cho Khách hàng (User)
- Tìm kiếm thông minh:** Tìm phòng theo tên khách sạn, ngày nhận (Check-in) và ngày trả (Check-out).
- **Xem chi tiết:** Xem thông tin phòng, tiện ích và giá cả chi tiết.
- **Đặt phòng (Booking):** Nhập thông tin khách hàng và xác nhận đặt phòng.
- **Đánh giá (Review):** Gửi đánh giá và bình luận sau khi hoàn thành kỳ nghỉ.

### 🛠 Dành cho Quản trị viên (Admin)
- **Quản lý phòng:** Thêm/Sửa/Xóa phòng, loại phòng.
- **Quản lý giá:** Cấu hình giá thay đổi theo mùa, theo ngày đặc biệt.
- **Quản lý đơn đặt:** Xem danh sách booking, xử lý check-in/check-out.

### ⚙️ Logic xử lý & Backend (Core Logic)
- **Kiểm tra tính hợp lệ:** Thuật toán tự động phát hiện và ngăn chặn việc đặt trùng phòng trong cùng một khoảng thời gian.
- **Cơ chế hủy phòng:** (Đang phát triển) Xử lý hoàn tiền hoặc tính phí dựa trên chính sách hủy.
- **Tính toán chiết khấu:** Áp dụng mã giảm giá hoặc ưu đãi theo mùa.

## 💻 Công nghệ sử dụng (Tech Stack)

* **Frontend:** [Ví dụ: ReactJS / Thymeleaf / JSP / HTML5 & CSS3]
* **Backend:** [Ví dụ: Java Spring Boot / C# .NET / NodeJS / PHP Laravel]
* **Database:** [Ví dụ: MySQL / SQL Server / PostgreSQL]
* **Tools:** [Ví dụ: Maven, Postman, Git]

## 📂 Cấu trúc thư mục (Folder Structure)

```text
├── database/            # Chứa file script SQL (.sql)
├── docs/                # Tài liệu dự án (ERD, UseCase, Diagrams)
├── src/                 # Mã nguồn chính
│   ├── controllers/     # Xử lý luồng dữ liệu
│   ├── models/          # Cấu trúc dữ liệu (Entities)
│   ├── views/           # Giao diện người dùng
│   └── utils/           # Các hàm tiện ích (Check trùng lịch, tính ngày...)
├── assets/              # Hình ảnh, CSS, JS
├── README.md            # Tài liệu hướng dẫn này
└── ...
