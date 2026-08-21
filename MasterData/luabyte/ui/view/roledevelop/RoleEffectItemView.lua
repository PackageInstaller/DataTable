---自动生成代码----start----
local RoleEffectItemView = BaseClass( 'RoleEffectItemView' , BaseView )
local M = RoleEffectItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.icon = self:AddBaseCom( GameUIImage ,'icon')
  self.nameText = self:AddBaseCom( GameUIText ,'nameText')
  self.number = self:AddBaseCom( GameUIText ,'number')
  self.upNumber = self:AddBaseCom( GameUIText ,'upNumber')
  self.state =   self._binder:GetValue('state')  


end

return RoleEffectItemView
---自动生成代码----end----