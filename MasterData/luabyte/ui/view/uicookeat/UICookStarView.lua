---自动生成代码----start----
local UICookStarView = BaseClass( 'UICookStarView' , BaseView )
local M = UICookStarView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.btnMask =   self._binder:GetValue('btnMask')  
  self.labDesc = self:AddBaseCom( GameUIText ,'labDesc')
  self.labName = self:AddBaseCom( GameUIText ,'labName')
  self.imgIcon = self:AddBaseCom( GameUIImage ,'imgIcon')
  self.tfStar =   self._binder:GetValue('tfStar')  


end

return UICookStarView
---自动生成代码----end----