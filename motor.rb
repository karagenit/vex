class Motor
  attr_reader :stall_current
  attr_reader :stall_torque
  attr_reader :free_speed
  attr_reader :max_power
  attr_reader :quantity

  def initialize
    @quantity = 1
  end

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

  ##
  # Sets the # of motors being used.
  #
  # Note: because this may be called in initialize, we rely on
  # the @quantity value to default to one (and not be nil) - this
  # is set in the super initialize in Motor.
  #
  def quantity=(qty)
    @stall_current *= qty / @quantity
    @stall_torque *= qty / @quantity
    @max_power *= qty / @quantity
  end
end

class CIM < Motor
  def initialize(qty = 1)
    super()
    @stall_current = 131
    @stall_torque = 2.41
    @free_speed = 5330
    @max_power = 337
    quantity = qty
  end
end
