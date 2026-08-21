---自动生成代码----start----
local PassTaskItemView = BaseClass( 'PassTaskItemView' , BaseView )
local M = PassTaskItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.txtDes = self:AddBaseCom( GameUIText ,'txtDes')
  self.imgProgress = self:AddBaseCom( GameUIImage ,'imgProgress')
  self.txtRatio = self:AddBaseCom( GameUIText ,'txtRatio')
  self.itemPfb =   self._binder:GetValue('itemPfb')  
  self.rectButton =   self._binder:GetValue('rectButton')  
  self.rectReceive =   self._binder:GetValue('rectReceive')  
  self.rectGoto =   self._binder:GetValue('rectGoto')  
  self.rectComplete =   self._binder:GetValue('rectComplete')  
  self.alphaTask =   self._binder:GetValue('alphaTask')  


end

return PassTaskItemView
---自动生成代码----end----