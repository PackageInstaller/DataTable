-- 光影疾驰
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill401900203 = oo.class(SkillBase)
function Skill401900203:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill401900203:DoSkill(caster, target, data)
	-- 4204
	self.order = self.order + 1
	self:AddBuff(SkillEffect[4204], caster, target, data, 4204)
end
-- 行动开始
function Skill401900203:OnActionBegin(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8200
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	-- 401900201
	self:AddNp(SkillEffect[401900201], caster, self.card, data, 10)
end
