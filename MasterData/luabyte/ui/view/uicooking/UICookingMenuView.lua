---自动生成代码----start----
local UICookingMenuView = BaseClass( 'UICookingMenuView' , BaseView )
local M = UICookingMenuView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.labName = self:AddBaseCom( GameUIText ,'labName')
  self.imgIcon = self:AddBaseCom( GameUIImage ,'imgIcon')
  self.labEatNum = self:AddBaseCom( GameUIText ,'labEatNum')
  self.Bg1 =   self:AddValue('UI.Ctrl.UICooking.UICookClassCtrl','UI.View.UICooking.UICookClassView','Bg1')  
  self.Bg2 =   self:AddValue('UI.Ctrl.UICooking.UICookClassCtrl','UI.View.UICooking.UICookClassView','Bg2')  
  self.Bg3 =   self:AddValue('UI.Ctrl.UICooking.UICookClassCtrl','UI.View.UICooking.UICookClassView','Bg3')  
  self.Bg4 =   self:AddValue('UI.Ctrl.UICooking.UICookClassCtrl','UI.View.UICooking.UICookClassView','Bg4')  


end

return UICookingMenuView
---自动生成代码----end----