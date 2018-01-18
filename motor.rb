class Motor
  attr_reader :stall_current
  attr_reader :stall_torque
  attr_reader :free_speed
  attr_reader :max_power

  def current(speed: nil, torque: nil)
    unless speed.nil?
      return @stall_current * (@free_speed - speed) / @free_speed
    end

    unless torque.nil?
      return @stall_current * torque / @stall_torque
    end
  end

  def speed(current: nil, torque: nil)
    unless current.nil?
      return @free_speed * (@stall_current - current) / @stall_current
    end

    unless torque.nil?
      return @free_speed * (@stall_torque - torque) / @stall_torque
    end
  end

  def torque(speed: nil, current: nil)
    unless speed.nil?
      return @stall_torque * (@free_speed - speed) / @free_speed
    end

    unless current.nil?
      return @stall_torque * current / @stall_current
    end
  end
end

class CIM < Motor
  def initialize
    @stall_current = 131
    @stall_torque = 2.41
    @free_speed = 5330
    @max_power = 337
  end
end
