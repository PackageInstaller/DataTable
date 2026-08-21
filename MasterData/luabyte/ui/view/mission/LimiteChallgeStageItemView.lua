---自动生成代码----start----
local LimiteChallgeStageItemView = BaseClass( 'LimiteChallgeStageItemView' , BaseView )
local M = LimiteChallgeStageItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.state =   self._binder:GetValue('state')  
  self.line =   self._binder:GetValue('line')  
  self.label = self:AddBaseCom( GameUIText ,'label')
  self.starLabel = self:AddBaseCom( GameUIText ,'starLabel')
  self.starOn =   self._binder:GetValue('starOn')  
  self.starOff =   self._binder:GetValue('starOff')  


end

return LimiteChallgeStageItemView
---自动生成代码----end----