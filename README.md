# take_home_assignment

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


# ตอบคำถาม

## โครงสร้าง provider ที่ออกแบบ (มีกี่ตัว ทำหน้าที่บ้าง)
มี 2 ตัว
- TraderNotifier ทำหน้าที่ให้การโหลดข้อมูลที่ต้องมีการใช้งาน จาก assets/raw_data.json
- FilterNotifier ทำหน้าที่จัดการ filter ต้องมีการเลือกค่าไปใช้งาน (กรองข้อมูลที่ต้องการ) เช่น เลือก API ก็จะแสดงแค่อันที่มี API เป็นต้น


## เหตุผลที่เลือก state management pattern
เพื่อให้ง่ายต่อการจัดการจากหลายคนและมีผลกระทบจากการแก้ไขค่อนข้างน้อย

## หากมีข้อจำกัดด้านเวลาทำให้บางส่วนไม่สมบูรณ์ ให้ระบุไว้ด้วย
จะทำให้ส่วนที่ต้องใช้งานอันดีบแรกสุดใช้งานได้ก่อน จากนั้นจะไล่แก้ไขเพื่อให้ใช้งานได้ แต่ถ้าไม่ทัยจริงๆ จะทำการปิดไว้ก่อน เพื่อป้องกันการมีผู้เข้าไปใช้งาน