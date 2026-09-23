-- 剑脊2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill337305 = oo.class(SkillBase)
function Skill337305:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合开始时
function Skill337305:OnRoundBegin(caster, target, data)
	-- 9715
	local count804 = SkillApi:ClassCount(self, caster, target,1,3)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 337305
	if self:Rand(4500+1000*count804) then
		self:AddNp(SkillEffect[337305], caster, self.card, data, 20)
	end
end
