# Setup workspace from scratch
setup:
    sudo apt install -y colcon
    git submodule update --init --remote
    just install-agent
    just build

# Build ROS2 packages
build:
    bash -c "source /opt/ros/jazzy/setup.bash && colcon build --symlink-install --base-paths src"

# Install Micro-XRCE-DDS-Agent
install-agent:
    cd agents/micro-xrce-dds-agent && mkdir -p build && cd build && cmake .. && make -j$(nproc) && sudo make install && sudo ldconfig

# Run Micro-XRCE-DDS-Agent
run-agent:
    MicroXRCEAgent udp4 -p 8888

# Run offboard control
run-offboard:
    bash -c "source /opt/ros/jazzy/setup.bash && source install/setup.bash && ros2 launch px4_offboard offboard_position_control.launch.py"

# Clean build artifacts
clean:
    rm -rf build install log
