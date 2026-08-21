---自动生成代码----start----
local UICoreItemView = BaseClass( 'UICoreItemView' , BaseView )
local M = UICoreItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.UIState =   self._binder:GetValue('UIState')  
  self.imgIcon = self:AddBaseCom( GameUIImage ,'imgIcon')
  self.imgNum = self:AddBaseCom( GameUIImage ,'imgNum')
  self.tfSelect = self:AddBaseCom( GameUIImage ,'tfSelect')
  self.btn = self:AddBaseCom( GameUIImage ,'btn')


end

return UICoreItemView
---自动生成代码----end----