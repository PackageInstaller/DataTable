---自动生成代码----start----
local UITurnTaskItemView = BaseClass( 'UITurnTaskItemView' , BaseView )
local M = UITurnTaskItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.OtakuFoodScrollbar =   self._binder:GetValue('OtakuFoodScrollbar')  
  self.labName = self:AddBaseCom( GameUIText ,'labName')
  self.labNum = self:AddBaseCom( GameUIText ,'labNum')
  self.btn = self:AddBaseCom( UINewButton ,'btn')
  self.ItemPfbUI =   self._binder:GetValue('ItemPfbUI')  
  self.btnState =   self._binder:GetValue('btnState')  


end

return UITurnTaskItemView
---自动生成代码----end----