-- 鸣刃4
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill335004 = oo.class(SkillBase)
function Skill335004:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动开始
function Skill335004:OnActionBegin(caster, target, data)
	-- 8166
	if SkillJudger:CasterIsOwnSummon(self, caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 335004
	self:OwnerAddBuff(SkillEffect[335004], caster, caster, data, 335004,1)
end
-- 行动结束2
function Skill335004:OnActionOver2(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 331206
	self:AddSp(SkillEffect[331206], caster, self.card, data, 15)
end
-- 行动结束
function Skill335004:OnActionOver(caster, target, data)
	-- 8166
	if SkillJudger:CasterIsOwnSummon(self, caster, target, true) then
	else
		return
	end
	-- 331207
	self:AddSp(SkillEffect[331207], caster, caster, data, 15)
end
