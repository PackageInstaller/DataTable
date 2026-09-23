-- 袅韵4
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill202300406 = oo.class(SkillBase)
function Skill202300406:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill202300406:DoSkill(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4202303
	self.order = self.order + 1
	self:AddBuff(SkillEffect[4202303], caster, self.card, data, 4202301)
	-- 4202304
	self.order = self.order + 1
	self:AddBuff(SkillEffect[4202304], caster, self.card, data, 4202301)
end
