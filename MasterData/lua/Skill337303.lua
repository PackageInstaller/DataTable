-- 剑脊2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill337303 = oo.class(SkillBase)
function Skill337303:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合开始时
function Skill337303:OnRoundBegin(caster, target, data)
	-- 9715
	local count804 = SkillApi:ClassCount(self, caster, target,1,3)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 337303
	if self:Rand(3500+1000*count804) then
		self:AddNp(SkillEffect[337303], caster, self.card, data, 20)
	end
end
