---自动生成代码----start----
local SignItemView = BaseClass( 'SignItemView' , BaseView )
local M = SignItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.dayText = self:AddBaseCom( GameUIText ,'dayText')
  self.icon = self:AddBaseCom( GameUIImage ,'icon')
  self.valueText = self:AddBaseCom( GameUIText ,'valueText')
  self.recived =   self._binder:GetValue('recived')  
  self.animator =   self._binder:GetValue('animator')  
  self.uiState =   self._binder:GetValue('uiState')  


end

return SignItemView
---自动生成代码----end----