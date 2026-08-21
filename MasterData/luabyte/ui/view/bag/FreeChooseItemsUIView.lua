---自动生成代码----start----
local FreeChooseItemsUIView = BaseClass( 'FreeChooseItemsUIView' , BaseView )
local M = FreeChooseItemsUIView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.scrollview = self:AddBaseCom( CircularScrollView ,'scrollview')
  self.ok =   self._binder:GetValue('ok')  
  self.clean =   self._binder:GetValue('clean')  
  self.mask =   self._binder:GetValue('mask')  
  self.curNum = self:AddBaseCom( GameUIText ,'curNum')


end

return FreeChooseItemsUIView
---自动生成代码----end----