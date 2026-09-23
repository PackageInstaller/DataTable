-- 凝霜
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill602800204 = oo.class(SkillBase)
function Skill602800204:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill602800204:DoSkill(caster, target, data)
	-- 11002
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[11002], caster, target, data, 0.5,2)
end
-- 回合结束时
function Skill602800204:OnRoundOver(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8670
	local count670 = SkillApi:GetCount(self, caster, target,3,602800206)
	-- 8879
	if SkillJudger:Less(self, caster, target, true,count670,8) then
	else
		return
	end
	-- 602800214
	self:CallOwnerSkill(SkillEffect[602800214], caster, self.card, data, 602800404)
end
