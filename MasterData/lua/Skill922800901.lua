-- 雾源觉醒
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill922800901 = oo.class(SkillBase)
function Skill922800901:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合开始时
function Skill922800901:OnRoundBegin(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8677
	local count677 = SkillApi:BuffCount(self, caster, target,3,4,922800801)
	-- 8889
	if SkillJudger:Greater(self, caster, self.card, true,count677,0) then
	else
		return
	end
	-- 922800901
	self:AddBuff(SkillEffect[922800901], caster, self.card, data, 922800901)
end
