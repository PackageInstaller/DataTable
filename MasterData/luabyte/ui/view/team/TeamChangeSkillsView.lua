---自动生成代码----start----
local TeamChangeSkillsView = BaseClass( 'TeamChangeSkillsView' , BaseView )
local M = TeamChangeSkillsView 
--desc

function M:__init(go)
--require

--declare
  local trans = go.transform 
  self.skillList =   self._binder:GetValue('skillList')  
  self.confirm =   self._binder:GetValue('confirm')  
  self.mask =   self._binder:GetValue('mask')  
end
return TeamChangeSkillsView
---自动生成代码----end----