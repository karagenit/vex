module Motor
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
    def set_quantity(qty) #should be quantity=(), but then calling from child doesn't work?
      @stall_current *= qty / @quantity
      @stall_torque *= qty / @quantity
      @max_power *= qty / @quantity
      @quantity = qty
    end
  end

  class CIM < Motor
    def initialize(qty = 1)
      super()
      @stall_current = 131
      @stall_torque = 2.41
      @free_speed = 5330
      @max_power = 337
      set_quantity qty
    end
  end

  class MiniCIM < Motor
    def initialize(qty = 1)
      super()
      @stall_current = 89
      @stall_torque = 1.41
      @free_speed = 5840
      @max_power = 215
      set_quantity qty
    end
  end

  class Pro775 < Motor
    def initialize(qty = 1)
      super()
      @stall_current = 134
      @stall_torque = 0.71
      @free_speed = 18730
      @max_power = 347
      set_quantity qty
    end
  end
end
