-- 夏炙4
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill338205 = oo.class(SkillBase)
function Skill338205:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合开始时
function Skill338205:OnRoundBegin(caster, target, data)
	-- 8580
	local count101 = SkillApi:BuffCount(self, caster, target,1,2,2)
	-- 8954
	if SkillJudger:Greater(self, caster, self.card, true,count101,0) then
	else
		return
	end
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 338205
	self:AddBuffCount(SkillEffect[338205], caster, self.card, data, 338205,math.min(count101,3),3)
	-- 338215
	self:DelBuffQuality(SkillEffect[338215], caster, self.card, data, 2,3)
end
