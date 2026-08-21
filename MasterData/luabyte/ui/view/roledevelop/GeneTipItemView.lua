---自动生成代码----start----
local GeneTipItemView = BaseClass( 'GeneTipItemView' , BaseView )
local M = GeneTipItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.Title = self:AddBaseCom( GameUIText ,'Title')
  self.AttrText1 =   self:AddValue('UI.Ctrl.RoleDevelop.AttrTextCtrl','UI.View.RoleDevelop.AttrTextView','AttrText1')  
  self.AttrText2 =   self:AddValue('UI.Ctrl.RoleDevelop.AttrTextCtrl','UI.View.RoleDevelop.AttrTextView','AttrText2')  
  self.AttrText3 =   self:AddValue('UI.Ctrl.RoleDevelop.AttrTextCtrl','UI.View.RoleDevelop.AttrTextView','AttrText3')  
  self.AttrText4 =   self:AddValue('UI.Ctrl.RoleDevelop.AttrTextCtrl','UI.View.RoleDevelop.AttrTextView','AttrText4')  


end

return GeneTipItemView
---自动生成代码----end----