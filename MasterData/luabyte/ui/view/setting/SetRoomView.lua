---自动生成代码----start----
local SetRoomView = BaseClass( 'SetRoomView' , BaseView )
local M = SetRoomView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.tg_cabinEnterAnim = self:AddBaseCom( UIToggle ,'tg_cabinEnterAnim')
  self.tg_cabinCameraTrackIn = self:AddBaseCom( UIToggle ,'tg_cabinCameraTrackIn')


end

return SetRoomView
---自动生成代码----end----