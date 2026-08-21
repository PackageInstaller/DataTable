---自动生成代码----start----
local AirShip = BaseClass( 'AirShip' , BaseView )
local M = AirShip 
--desc

function M:__init(go)
--require

--declare
  local trans = go.transform 
  self.restaurant = UIUtil.FindComponent( trans , typeof(CS.UnityEngine.Transform) , "restaurant" )
  self.bedroom = UIUtil.FindComponent( trans , typeof(CS.UnityEngine.Transform) , "bedroom" )
  self.communicationRoom = UIUtil.FindComponent( trans , typeof(CS.UnityEngine.Transform) , "communicationRoom" )
  self.manufacturingRoom = UIUtil.FindComponent( trans , typeof(CS.UnityEngine.Transform) , "manufacturingRoom" )
  self.trainingRoom = UIUtil.FindComponent( trans , typeof(CS.UnityEngine.Transform) , "trainingRoom" )
  self.bridge = UIUtil.FindComponent( trans , typeof(CS.UnityEngine.Transform) , "bridge" )
  self.RestaurantPos = UIUtil.FindComponent( trans , typeof(CS.UnityEngine.Transform) , "vm/RestaurantPos" )
  self.BedroomPos = UIUtil.FindComponent( trans , typeof(CS.UnityEngine.Transform) , "vm/BedroomPos" )
  self.CommunicationRoomPos = UIUtil.FindComponent( trans , typeof(CS.UnityEngine.Transform) , "vm/CommunicationRoomPos" )
  self.ManufacturingRoomPos = UIUtil.FindComponent( trans , typeof(CS.UnityEngine.Transform) , "vm/ManufacturingRoomPos" )
  self.TrainingRoomPos = UIUtil.FindComponent( trans , typeof(CS.UnityEngine.Transform) , "vm/BridgePos" )
  self.BridgePos = UIUtil.FindComponent( trans , typeof(CS.UnityEngine.Transform) , "vm/BridgePos" )
  self.content = UIUtil.FindComponent( trans , typeof(CS.GameX.BaseCameraContent) , "CameraNode" )
end
return AirShip
---自动生成代码----end----