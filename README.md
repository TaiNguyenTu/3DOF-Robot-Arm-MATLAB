# 3-DOF Articulated Robot Arm – Kinematic Simulation in MATLAB

This project simulates the forward and inverse kinematics of a 3-degree-of-freedom articulated robotic arm using MATLAB. The system includes a user-friendly GUI built with `.fig` file and multiple functional `.m` scripts. The robot model is constructed using geometric primitives and visualized in 3D space.

## 🔧 Features
- Forward Kinematics: Compute end-effector position from joint angles.
- Inverse Kinematics: Compute joint angles from desired end-effector coordinates.
- Trajectory Planning: Generate smooth motion with velocity and acceleration control.
- Kalman Filter: Apply filtering to end-effector signals (optional).
- Animation: Real-time 3D visualization of robot movement.
- GUI: Comprehensive control panel for entering inputs, toggling features, and viewing output plots.

## 📂 Key Files
- `BTL_robot.fig`: Main GUI interface
- `Forward_Kinematic.m`, `Inverse_Kinematic.m`: Core kinematic calculations
- `plot_link1.m`, `plot_joint_velocity.m`, etc.: Plotting functions for robot animation
- `calculate_Trajectory.m`: Trajectory generation logic
- `kalman_filter.m`: Optional signal filtering
- `button_forward.m`, `button_inverse.m`: GUI interaction handlers

## 📷 GUI Preview

![GUI Screenshot](screenshots/gui_preview.png)

## 🛠 Requirements
- MATLAB R2021a+
- App Designer or GUIDE-compatible GUI environment
- Control System Toolbox (optional but helpful)

## 👨‍💻 Author
Nguyen Tu Tai  
📫 [tainguyentu.work@gmail.com](mailto:tainguyentu.work@gmail.com)  
🔗 [LinkedIn](https://www.linkedin.com/in/nguyentutai0502)

---

> *This project was developed as part of the Robotics course and demonstrates proficiency in robot kinematics, trajectory design, MATLAB scripting, and user interface design.*

