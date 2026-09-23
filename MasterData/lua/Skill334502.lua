-- 缇尔锋2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill334502 = oo.class(SkillBase)
function Skill334502:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动开始
function Skill334502:OnActionBegin(caster, target, data)
	-- 8166
	if SkillJudger:CasterIsOwnSummon(self, caster, target, true) then
	else
		return
	end
	-- 334502
	self:AddBuffCount(SkillEffect[334502], caster, self.card, data, 334502,1,99)
end
-- 行动结束
function Skill334502:OnActionOver(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 334506
	self:AddSp(SkillEffect[334506], caster, self.card, data, 15)
end
-- 行动结束2
function Skill334502:OnActionOver2(caster, target, data)
	-- 8166
	if SkillJudger:CasterIsOwnSummon(self, caster, target, true) then
	else
		return
	end
	-- 334507
	self:AddSp(SkillEffect[334507], caster, caster, data, 15)
end
