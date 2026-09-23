-- 稽查者加强被动
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill907800602 = oo.class(SkillBase)
function Skill907800602:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击结束
function Skill907800602:OnAttackOver(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8419
	local count19 = SkillApi:GetAttr(self, caster, target,3,"xp")
	-- 8824
	if SkillJudger:Greater(self, caster, self.card, true,count19,3) then
	else
		return
	end
	-- 907800604
	self:AddProgress(SkillEffect[907800604], caster, self.card, data, 1000)
end
