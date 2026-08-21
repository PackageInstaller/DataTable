---自动生成代码----start----
local UIActivityItemView = BaseClass( 'UIActivityItemView' , BaseView )
local M = UIActivityItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.labName = self:AddBaseCom( GameUIText ,'labName')
  self.uiState =   self._binder:GetValue('uiState')  
  self.redPoint =   self._binder:GetValue('redPoint')  
  self.playerAudio =   self._binder:GetValue('playerAudio')  


end

return UIActivityItemView
---自动生成代码----end----