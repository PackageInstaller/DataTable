-- 剑脊2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill337301 = oo.class(SkillBase)
function Skill337301:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合开始时
function Skill337301:OnRoundBegin(caster, target, data)
	-- 9715
	local count804 = SkillApi:ClassCount(self, caster, target,1,3)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 337301
	if self:Rand(2500+1000*count804) then
		self:AddNp(SkillEffect[337301], caster, self.card, data, 20)
	end
end
