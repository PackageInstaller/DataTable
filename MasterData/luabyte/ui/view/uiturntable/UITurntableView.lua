---自动生成代码----start----
local UITurntableView = BaseClass( 'UITurntableView' , BaseView )
local M = UITurntableView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.Panel =   self._binder:GetValue('Panel')  
  self.btnReward = self:AddBaseCom( UIButton ,'btnReward')
  self.btnTask = self:AddBaseCom( UIButton ,'btnTask')
  self.Item1 =   self:AddValue('UI.Ctrl.UITurntable.UITweentableItemCtrl','UI.View.UITurntable.UITweentableItemView','Item1')  
  self.Item2 =   self:AddValue('UI.Ctrl.UITurntable.UITweentableItemCtrl','UI.View.UITurntable.UITweentableItemView','Item2')  
  self.Item3 =   self:AddValue('UI.Ctrl.UITurntable.UITweentableItemCtrl','UI.View.UITurntable.UITweentableItemView','Item3')  
  self.Item4 =   self:AddValue('UI.Ctrl.UITurntable.UITweentableItemCtrl','UI.View.UITurntable.UITweentableItemView','Item4')  
  self.Item5 =   self:AddValue('UI.Ctrl.UITurntable.UITweentableItemCtrl','UI.View.UITurntable.UITweentableItemView','Item5')  
  self.Item6 =   self:AddValue('UI.Ctrl.UITurntable.UITweentableItemCtrl','UI.View.UITurntable.UITweentableItemView','Item6')  
  self.Item7 =   self:AddValue('UI.Ctrl.UITurntable.UITweentableItemCtrl','UI.View.UITurntable.UITweentableItemView','Item7')  
  self.Item8 =   self:AddValue('UI.Ctrl.UITurntable.UITweentableItemCtrl','UI.View.UITurntable.UITweentableItemView','Item8')  
  self.Item9 =   self:AddValue('UI.Ctrl.UITurntable.UITweentableItemCtrl','UI.View.UITurntable.UITweentableItemView','Item9')  
  self.Item10 =   self:AddValue('UI.Ctrl.UITurntable.UITweentableItemCtrl','UI.View.UITurntable.UITweentableItemView','Item10')  
  self.Item11 =   self:AddValue('UI.Ctrl.UITurntable.UITweentableItemCtrl','UI.View.UITurntable.UITweentableItemView','Item11')  
  self.Item12 =   self:AddValue('UI.Ctrl.UITurntable.UITweentableItemCtrl','UI.View.UITurntable.UITweentableItemView','Item12')  
  self.Item13 =   self:AddValue('UI.Ctrl.UITurntable.UITweentableItemCtrl','UI.View.UITurntable.UITweentableItemView','Item13')  
  self.Item14 =   self:AddValue('UI.Ctrl.UITurntable.UITweentableItemCtrl','UI.View.UITurntable.UITweentableItemView','Item14')  
  self.Item15 =   self:AddValue('UI.Ctrl.UITurntable.UITweentableItemCtrl','UI.View.UITurntable.UITweentableItemView','Item15')  
  self.Item16 =   self:AddValue('UI.Ctrl.UITurntable.UITweentableItemCtrl','UI.View.UITurntable.UITweentableItemView','Item16')  
  self.labNum = self:AddBaseCom( GameUIText ,'labNum')
  self.btnThrow = self:AddBaseCom( UIButton ,'btnThrow')


end

return UITurntableView
---自动生成代码----end----