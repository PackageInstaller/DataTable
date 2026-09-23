-- 吞噬者（怪）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4802202 = oo.class(SkillBase)
function Skill4802202:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合开始时
function Skill4802202:OnRoundBegin(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4802201
	self:CallSkillEx(SkillEffect[4802201], caster, target, data, 802200401)
end
-- 攻击结束
function Skill4802202:OnAttackOver(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 4802202
	self:DelBufferGroup(SkillEffect[4802202], caster, target, data, 2,2)
end
-- 伤害前
function Skill4802202:OnBefourHurt(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 4802305
	self:AddTempAttr(SkillEffect[4802305], caster, self.card, data, "damage",0.4)
end
