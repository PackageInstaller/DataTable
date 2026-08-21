---自动生成代码----start----
local UIGiftItemView = BaseClass( 'UIGiftItemView' , BaseView )
local M = UIGiftItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.labName = self:AddBaseCom( GameUIText ,'labName')
  self.imgIcon = self:AddBaseCom( GameUIImage ,'imgIcon')
  self.stateSelect =   self._binder:GetValue('stateSelect')  
  self.stateQuality =   self._binder:GetValue('stateQuality')  
  self.tfMask =   self._binder:GetValue('tfMask')  
  self.redPoint =   self._binder:GetValue('redPoint')  


end

return UIGiftItemView
---自动生成代码----end----