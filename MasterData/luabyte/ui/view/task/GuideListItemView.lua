---自动生成代码----start----
local GuideListItemView = BaseClass( 'GuideListItemView' , BaseView )
local M = GuideListItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.awardScrollView = self:AddBaseCom( CircularScrollView ,'awardScrollView')
  self.txtDes = self:AddBaseCom( GameUIText ,'txtDes')
  self.txtPropertion = self:AddBaseCom( GameUIText ,'txtPropertion')
  self.imgProgress = self:AddBaseCom( GameUIImage ,'imgProgress')
  self.rectGoto =   self._binder:GetValue('rectGoto')  
  self.rectReceive =   self._binder:GetValue('rectReceive')  
  self.rectComplete =   self._binder:GetValue('rectComplete')  
  self.rectNormal =   self._binder:GetValue('rectNormal')  
  self.rectClickArea =   self._binder:GetValue('rectClickArea')  
  self.rectTask =   self._binder:GetValue('rectTask')  


end

return GuideListItemView
---自动生成代码----end----