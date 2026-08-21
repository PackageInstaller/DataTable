---自动生成代码----start----
local RoleProfileStoryItemView = BaseClass( 'RoleProfileStoryItemView' , BaseView )
local M = RoleProfileStoryItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.UlockText = self:AddBaseCom( GameUIText ,'UlockText')
  self.Name1 = self:AddBaseCom( GameUIText ,'Name1')
  self.Name2 = self:AddBaseCom( GameUIText ,'Name2')
  self.tfRedPoint =   self._binder:GetValue('tfRedPoint')  
  self.UIState =   self._binder:GetValue('UIState')  
  self.imgNum1 = self:AddBaseCom( GameUIImage ,'imgNum1')
  self.imgNum2 = self:AddBaseCom( GameUIImage ,'imgNum2')
  self.btn = self:AddBaseCom( GameUIImage ,'btn')


end

return RoleProfileStoryItemView
---自动生成代码----end----