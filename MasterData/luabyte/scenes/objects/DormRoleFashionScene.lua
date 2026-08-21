---自动生成代码----start----
local DormRoleFashionScene = BaseClass( 'DormRoleFashionScene' , BaseView )
local M = DormRoleFashionScene 
--desc

function M:__init(go)
  local trans = go.transform 
  self.showGirlRoot =   self._binder:GetValue('showGirlRoot')  
  self.CameraNode =   self._binder:GetValue('CameraNode')  
  self.factionScene =   self._binder:GetValue('factionScene')  


end

return DormRoleFashionScene
---自动生成代码----end----