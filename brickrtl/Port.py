from Common import *

# Port is actually a ports array
class Port:
    def __init__(
        self,
        exist_type: ExistType, 
        module_instance_name: str,
        port_name: str,
        port_direction: Direction = Direction.IN,
        port_width: int = 1,
        port_repeat: int = 1
    ):
        self.exist_type = exist_type
        self.module_instance_name = module_instance_name
        self.name = port_name
        self.direction = port_direction
        self.width = port_width
        self.repeat = port_repeat
        # default not connected
        self.get_connected = False
        
    # let function `addport` return the port created just now，then can use `@` to assign width and repeat  
    def __matmul__(self, width_and_repeat: tuple):
        # 
        if len(width_and_repeat) != 2:
            raise ValueError("parameter `width_and_repeat` must have length 2")
        else:
            for ele in width_and_repeat:
                if type(ele) != int:
                    raise ValueError("value in parameter `width_and_repeat` must have type int")
            self.width = width_and_repeat[0]
            self.repeat = width_and_repeat[1]
    
    
    # only output port that belongs to an instance module can use this function
    def connect_to(
        self, 
        batch_connect: True, # let all repeat ports connect to the same port, default true
        target_port: list['Port']
    ):
        pass  
    
    # only input port that belongs to an instance module can use this function
    def get_connected(
        self
    ):
        pass         
    
    # generate in module 
    def generate_disp(self):
        direction_prestr = "input" if self.direction is Direction.IN else "output"
        port_str_list = []
        for i in range(self.repeat):
            port_str = direction_prestr + " logic " + self.name + str(i) + " [" + str(self.real_width) + "]"
            port_str_list.append(port_str)
        return port_str_list
    