---自动生成代码----start----
local PageApplyView = BaseClass( 'PageApplyView' , BaseView )
local M = PageApplyView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.scrollView =   self._binder:GetValue('scrollView')  
  self.nullTip =   self._binder:GetValue('nullTip')  
  self.applyNumText = self:AddBaseCom( GameUIText ,'applyNumText')
  self.applyMaxText = self:AddBaseCom( GameUIText ,'applyMaxText')
  self.friendNumText = self:AddBaseCom( GameUIText ,'friendNumText')
  self.friendMaxText = self:AddBaseCom( GameUIText ,'friendMaxText')
  self.negletBtn =   self._binder:GetValue('negletBtn')  
  self.confirmBtn =   self._binder:GetValue('confirmBtn')  


end

return PageApplyView
---自动生成代码----end----