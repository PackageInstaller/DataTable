-- 喀喀荷弹
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill100400103 = oo.class(SkillBase)
function Skill100400103:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill100400103:DoSkill(caster, target, data)
	-- 11001
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[11001], caster, target, data, 1,1)
end
-- 行动结束
function Skill100400103:OnActionOver(caster, target, data)
	-- 8166
	if SkillJudger:CasterIsOwnSummon(self, caster, target, true) then
	else
		return
	end
	-- 8202
	if SkillJudger:IsNormal(self, caster, target, true) then
	else
		return
	end
	-- 802700101
	self:AddBuff(SkillEffect[802700101], caster, self.card, data, 4604,2)
	-- 802700102
	self:AddBuff(SkillEffect[802700102], caster, self.card, data, 4904,2)
end
