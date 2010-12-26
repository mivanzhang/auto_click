

require 'Win32API'

require "auto_click/input_structure"

module AutoClick
  
  @@gcp = Win32API.new("user32", "GetCursorPos",'P','V')
  @@scp = Win32API.new("user32", 'SetCursorPos', 'II', 'V')
  @@si = Win32API.new("user32", 'SendInput','IPI', 'I')
  
  @@rightdown = InputStructure.mouse_input(0,0,0,0x0008)
  @@rightup = InputStructure.mouse_input(0,0,0,0x0010)  
  @@leftdown = InputStructure.mouse_input(0,0,0,0x0002)
  @@leftup = InputStructure.mouse_input(0,0,0,0x0004)


  def send_input(inputs)
    n = inputs.size
    ptr = inputs.collect {|i| i.to_s}.join
    @@si.call(n, ptr, inputs[0].size)
  end

  def mouse_move(x,y)
    @@scp.call(x,y)
  end
  
  def right_click
    send_input( [@@rightdown, @@rightup] )
  end
  
  def left_click
    send_input( [@@leftdown, @@leftup] )
  end
  
  def cursor_position
    point = " " * 8
    @@gcp.call(point)
    point.unpack('LL')  
  end
  
  def mouse_scroll(d) 
    scroll = InputStructure.mouse_input(0,0,d*120,0x0800)
    send_input( [scroll])
  end


end


include AutoClick  # This line allow auto include when the user require the gem

  








