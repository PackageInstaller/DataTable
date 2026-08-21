---自动生成代码----start----
local RoleLifeSkillItemView = BaseClass( 'RoleLifeSkillItemView' , BaseView )
local M = RoleLifeSkillItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.txt_name = self:AddBaseCom( GameUIText ,'txt_name')
  self.node_stage1 =   self._binder:GetValue('node_stage1')  
  self.node_stage2 =   self._binder:GetValue('node_stage2')  
  self.node_stage3 =   self._binder:GetValue('node_stage3')  
  self.txt_desc = self:AddBaseCom( GameUIText ,'txt_desc')


end

return RoleLifeSkillItemView
---自动生成代码----end----