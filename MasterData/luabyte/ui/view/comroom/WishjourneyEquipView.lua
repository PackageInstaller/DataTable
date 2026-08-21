---自动生成代码----start----
local WishjourneyEquipView = BaseClass( 'WishjourneyEquipView' , BaseView )
local M = WishjourneyEquipView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.taskTitle = self:AddBaseCom( GameUIText ,'taskTitle')
  self.taskDesc = self:AddBaseCom( GameUIText ,'taskDesc')
  self.taskView = self:AddBaseCom( CircularScrollView ,'taskView')
  self.rewardView = self:AddBaseCom( CircularScrollView ,'rewardView')
  self.heroView = self:AddBaseCom( CircularScrollView ,'heroView')
  self.foodView = self:AddBaseCom( CircularScrollView ,'foodView')
  self.quickBtn =   self._binder:GetValue('quickBtn')  
  self.startBtn =   self._binder:GetValue('startBtn')  
  self.speedBtn =   self._binder:GetValue('speedBtn')  
  self.mask =   self._binder:GetValue('mask')  
  self.startNormal =   self._binder:GetValue('startNormal')  
  self.startLock =   self._binder:GetValue('startLock')  
  self.speedCost =   self:AddValue('UI.Ctrl.Common.ComItemSlipCtrl','UI.View.Common.ComItemSlipView','speedCost')  


end

return WishjourneyEquipView
---自动生成代码----end----