module NikePlus
  class Run
    attr_accessor :id, :workoutType, :startTime, :distance, :duration,
        :syncTime, :calories, :name, :description
        
    def initialize(run)
      run.each_element_with_text do |e|
        send("#{e.name}=", e.text)
      end
    end
  end
end