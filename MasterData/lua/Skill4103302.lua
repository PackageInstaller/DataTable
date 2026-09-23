-- 天丛云·山脉
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4103302 = oo.class(SkillBase)
function Skill4103302:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合开始时
function Skill4103302:OnRoundBegin(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8985
	local count985 = SkillApi:BuffCount(self, caster, target,3,4,103300102)
	-- 4103302
	if SkillJudger:Greater(self, caster, target, true,count985,0) then
	else
		return
	end
	-- 8986
	local count986 = SkillApi:BuffCount(self, caster, target,3,4,103300202)
	-- 4103303
	if SkillJudger:Greater(self, caster, target, true,count986,0) then
	else
		return
	end
	-- 8987
	local count987 = SkillApi:BuffCount(self, caster, target,3,4,103300302)
	-- 4103304
	if SkillJudger:Greater(self, caster, target, true,count987,0) then
	else
		return
	end
	-- 4103301
	self:AddBuff(SkillEffect[4103301], caster, self.card, data, 4103311)
end
