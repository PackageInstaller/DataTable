---自动生成代码----start----
local MonthlySignView = BaseClass( 'MonthlySignView' , BaseView )
local M = MonthlySignView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.ItemPfbView =   self:AddValue('','UI.View.Common.ItemPfbView','ItemPfbView')  
  self.btnShop =   self._binder:GetValue('btnShop')  
  self.labMonth = self:AddBaseCom( GameUIText ,'labMonth')
  self.labDay = self:AddBaseCom( GameUIText ,'labDay')
  self.grid = self:AddBaseCom( CircularScrollView ,'grid')


end

return MonthlySignView
---自动生成代码----end----