-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4201505 = oo.class(SkillBase)
function Skill4201505:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 加buff时
function Skill4201505:OnAddBuff(caster, target, data)
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	local count31 = SkillApi:BuffCount(self, caster, target,2,3,3002)
	if SkillJudger:Greater(self, caster, self.card, true,count31,0) then
	else
		return
	end
	self:AddBuffCount(SkillEffect[4201505], caster, target, data, 4201505,1,10)
end
