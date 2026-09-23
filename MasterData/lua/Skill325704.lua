-- 致命猎枪
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill325704 = oo.class(SkillBase)
function Skill325704:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill325704:OnActionOver(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8219
	if SkillJudger:IsUltimate(self, caster, target, true) then
	else
		return
	end
	-- 8438
	local count38 = SkillApi:BuffCount(self, caster, target,2,3,3009)
	-- 8121
	if SkillJudger:Greater(self, caster, self.card, true,count38,0) then
	else
		return
	end
	-- 325704
	self:AddBuff(SkillEffect[325704], caster, self.card, data, 325704)
end
