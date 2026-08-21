---自动生成代码----start----
local UIDanceAchieveItemView = BaseClass( 'UIDanceAchieveItemView' , BaseView )
local M = UIDanceAchieveItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.icon = self:AddBaseCom( GameUIImage ,'icon')
  self.name = self:AddBaseCom( GameUIText ,'name')
  self.desc = self:AddBaseCom( GameUIText ,'desc')
  self.UIDanceItemCtrl1 =   self:AddValue('UI.Ctrl.UIMasquerade.UIDanceItemCtrl','UI.View.UIMasquerade.UIDanceItemView','UIDanceItemCtrl1')  
  self.UIDanceItemCtrl2 =   self:AddValue('UI.Ctrl.UIMasquerade.UIDanceItemCtrl','UI.View.UIMasquerade.UIDanceItemView','UIDanceItemCtrl2')  
  self.rewardBtn =   self._binder:GetValue('rewardBtn')  
  self.state0 =   self._binder:GetValue('state0')  
  self.state1 =   self._binder:GetValue('state1')  
  self.state2 =   self._binder:GetValue('state2')  
  self.num = self:AddBaseCom( GameUIText ,'num')
  self.day = self:AddBaseCom( GameUIText ,'day')
  self.tfRedPoint =   self._binder:GetValue('tfRedPoint')  


end

return UIDanceAchieveItemView
---自动生成代码----end----