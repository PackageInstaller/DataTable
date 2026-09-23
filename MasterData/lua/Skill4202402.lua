-- 断章
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4202402 = oo.class(SkillBase)
function Skill4202402:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill4202402:OnActionOver(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8219
	if SkillJudger:IsUltimate(self, caster, target, true) then
	else
		return
	end
	-- 4202402
	self:AddProgress(SkillEffect[4202402], caster, self.card, data, 100)
	-- 4202412
	self:OwnerAddBuffCount(SkillEffect[4202412], caster, self.card, data, 4202402,1,5)
	-- 4202414
	self:OwnerAddBuffCount(SkillEffect[4202414], caster, self.card, data, 4202404,1,5)
end
