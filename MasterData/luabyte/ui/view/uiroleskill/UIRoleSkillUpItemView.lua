---自动生成代码----start----
local UIRoleSkillUpItemView = BaseClass( 'UIRoleSkillUpItemView' , BaseView )
local M = UIRoleSkillUpItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.imgIcon = self:AddBaseCom( GameUIImage ,'imgIcon')
  self.labDesc = self:AddBaseCom( GameUIText ,'labDesc')
  self.labValue1 = self:AddBaseCom( GameUIText ,'labValue1')
  self.labValue2 = self:AddBaseCom( GameUIText ,'labValue2')
  self.labName = self:AddBaseCom( GameUIText ,'labName')


end

return UIRoleSkillUpItemView
---自动生成代码----end----