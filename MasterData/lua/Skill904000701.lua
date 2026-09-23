-- 风暴吐息
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill904000701 = oo.class(SkillBase)
function Skill904000701:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill904000701:OnActionOver(caster, target, data)
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
	-- 8418
	local count18 = SkillApi:GetAttr(self, caster, target,3,"sp")
	-- 8152
	if SkillJudger:Greater(self, caster, self.card, true,count18,60) then
	else
		return
	end
	-- 8419
	local count19 = SkillApi:GetAttr(self, caster, target,3,"xp")
	-- 8153
	if SkillJudger:Greater(self, caster, self.card, true,count19,2) then
	else
		return
	end
	-- 8573
	self:BeatBack(SkillEffect[8573], caster, target, data, 904000501)
	-- 84005
	self:AddXp(SkillEffect[84005], caster, self.card, data, -3)
end
