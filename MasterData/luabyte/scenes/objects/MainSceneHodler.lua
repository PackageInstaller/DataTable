---自动生成代码----start----
local MainSceneHodler = BaseClass( 'MainSceneHodler' , BaseView )
local M = MainSceneHodler 
--desc

function M:__init(go)
  local trans = go.transform 
  self.mainsceneObjs =   self._binder:GetValue('mainsceneObjs')  
  self.shopObjs =   self._binder:GetValue('shopObjs')  
  self.developHolder =   self:AddValue('','Scenes.Objects.RoleDevelopScene','developHolder')  
  self.CameraNode =   self._binder:GetValue('CameraNode')  
  self.developObjs =   self._binder:GetValue('developObjs')  
  self.lotteryObjs =   self._binder:GetValue('lotteryObjs')  
  self.lotteryHolder =   self:AddValue('','Scenes.Objects.ChoukaHolder','lotteryHolder')  
  self.otakuObjs =   self._binder:GetValue('otakuObjs')  
  self.luckdrawHolder =   self:AddValue('','Scene.Objects.LuckDrawholder','luckdrawHolder')  
  self.luckdrawObjs =   self._binder:GetValue('luckdrawObjs')  


end

return MainSceneHodler
---自动生成代码----end----