module NikePlus
  class Run
    attr_accessor :id, :workoutType, :startTime, :distance, :duration,
        :syncTime, :calories, :name, :description
        
    def initialize(run)
      run.each_element_with_text do |e|
        send("#{e.name}=", e.text)
      end
      
      %W{workoutType id}.each do |e|
        send("#{e}=", run.attributes[e])
      end
    end

    def distance=(s)
      @distance = s.to_f
    end

    def duration=(s)
      @duration = s.to_i
    end

    def minutes
      @duration/60000
    end

    def seconds
      @duration % 60000 / 1000
    end

    def miles
      "%.2f" % (@distance * 0.621371192)
    end
  end
end