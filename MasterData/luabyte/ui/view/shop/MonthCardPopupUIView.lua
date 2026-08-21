---自动生成代码----start----
local MonthCardPopupUIView = BaseClass( 'MonthCardPopupUIView' , BaseView )
local M = MonthCardPopupUIView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.imgIcon = self:AddBaseCom( GameUIImage ,'imgIcon')
  self.txtDays = self:AddBaseCom( GameUIText ,'txtDays')
  self.txtDes = self:AddBaseCom( GameUIText ,'txtDes')
  self.txtCost = self:AddBaseCom( GameUIText ,'txtCost')
  self.scrollItems = self:AddBaseCom( CircularScrollView ,'scrollItems')
  self.rectBuy =   self._binder:GetValue('rectBuy')  
  self.rectClose =   self._binder:GetValue('rectClose')  
  self.rectTips =   self._binder:GetValue('rectTips')  
  self.rectDays =   self._binder:GetValue('rectDays')  


end

return MonthCardPopupUIView
---自动生成代码----end----