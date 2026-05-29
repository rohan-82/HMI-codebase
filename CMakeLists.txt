cmake_minimum_required(VERSION 3.16)

project(EV_HMI VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Quick)

qt_standard_project_setup()

qt_add_executable(EV_HMI
    main.cpp

    backend/VehicleData.cpp
    backend/TelemetrySimulator.cpp

    
)

target_include_directories(EV_HMI PRIVATE
    backend
)

qt_add_resources(EV_HMI "resources"
    PREFIX "/"
    FILES
        qml/main.qml
        qml/components/BatteryBar.qml
        qml/components/GearSelector.qml
        qml/components/Speedometer.qml
        qml/components/TelemetryCard.qml
)

target_link_libraries(EV_HMI PRIVATE
    Qt6::Quick
)