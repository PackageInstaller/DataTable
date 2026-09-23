-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4201503 = oo.class(SkillBase)
function Skill4201503:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 加buff时
function Skill4201503:OnAddBuff(caster, target, data)
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
	self:AddBuffCount(SkillEffect[4201503], caster, target, data, 4201503,1,10)
end
