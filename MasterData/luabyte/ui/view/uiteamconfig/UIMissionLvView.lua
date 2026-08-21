---自动生成代码----start----
local UIMissionLvView = BaseClass( 'UIMissionLvView' , BaseView )
local M = UIMissionLvView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.btnMask = self:AddBaseCom( GameUIImage ,'btnMask')
  self.toggleNoTips = self:AddBaseCom( UIToggle ,'toggleNoTips')
  self.tfTips =   self._binder:GetValue('tfTips')  
  self.toggle =   self._binder:GetValue('toggle')  
  self.btnDevelop = self:AddBaseCom( GameUIImage ,'btnDevelop')


end

return UIMissionLvView
---自动生成代码----end----