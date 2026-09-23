-- 钓鱼佬
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill912101301 = oo.class(SkillBase)
function Skill912101301:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动开始
function Skill912101301:OnActionBegin(caster, target, data)
	-- 912102411
	if SkillJudger:HasBuff(self, caster, target, true,3,912102410) then
	else
		return
	end
	-- 912101301
	self:AddBuff(SkillEffect[912101301], caster, self.card, data, 912101301)
	-- 912101302
	self:AddBuff(SkillEffect[912101302], caster, self.card, data, 912101302)
end
