---自动生成代码----start----
local FreeChooseItemView = BaseClass( 'FreeChooseItemView' , BaseView )
local M = FreeChooseItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.item =   self._binder:GetValue('item')  
  self.selectBtn =   self._binder:GetValue('selectBtn')  
  self.useNum = self:AddBaseCom( GameUIText ,'useNum')
  self.downBtn =   self._binder:GetValue('downBtn')  
  self.numObj =   self._binder:GetValue('numObj')  
  self.clickBg =   self._binder:GetValue('clickBg')  
  self.txtItemCount = self:AddBaseCom( GameUIText ,'txtItemCount')


end

return FreeChooseItemView
---自动生成代码----end----