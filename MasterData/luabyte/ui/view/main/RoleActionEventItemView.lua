---自动生成代码----start----
local RoleActionEventItemView = BaseClass( 'RoleActionEventItemView' , BaseView )
local M = RoleActionEventItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.titleTf = self:AddBaseCom( GameUIText ,'titleTf')
  self.contentTf = self:AddBaseCom( GameUIText ,'contentTf')
  self.go = self:AddBaseCom( UINewButton ,'go')
  self.state =   self._binder:GetValue('state')  
  self.playBtn = self:AddBaseCom( GameUIImage ,'playBtn')


end

return RoleActionEventItemView
---自动生成代码----end----