-- 神秘金字塔技能4
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill934100401 = oo.class(SkillBase)
function Skill934100401:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill934100401:DoSkill(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 934100401
	self.order = self.order + 1
	self:AddBuff(SkillEffect[934100401], caster, self.card, data, 934100401)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 934100402
	self.order = self.order + 1
	self:AddBuff(SkillEffect[934100402], caster, self.card, data, 934100402)
end
