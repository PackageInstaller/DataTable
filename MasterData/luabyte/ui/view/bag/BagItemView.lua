---自动生成代码----start----
local BagItemView = BaseClass( 'BagItemView' , BaseView )
local M = BagItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.item =   self._binder:GetValue('item')  
  self.node_alpha =   self._binder:GetValue('node_alpha')  
  self.node_mask =   self._binder:GetValue('node_mask')  
  self.tfTimer =   self._binder:GetValue('tfTimer')  
  self.tfTimer1 = self:AddBaseCom( GameUIImage ,'tfTimer1')
  self.tfTimer2 = self:AddBaseCom( GameUIImage ,'tfTimer2')


end

return BagItemView
---自动生成代码----end----