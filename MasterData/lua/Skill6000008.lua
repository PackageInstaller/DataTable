-- 连锁阵线第二期buff1（中长轴）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill6000008 = oo.class(SkillBase)
function Skill6000008:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill6000008:OnBefourHurt(caster, target, data)
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
	-- 8261
	if SkillJudger:IsCallSkill(self, caster, target, true) then
	else
		return
	end
	-- 60000070
	self:AddTempAttr(SkillEffect[60000070], caster, self.card, data, "damage2",0.2)
end
-- 行动结束
function Skill6000008:OnActionOver(caster, target, data)
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
	-- 8261
	if SkillJudger:IsCallSkill(self, caster, target, true) then
	else
		return
	end
	-- 60000071
	self:AddBuffCount(SkillEffect[60000071], caster, self.card, data, 60000071,1,100)
end
-- 行动结束2
function Skill6000008:OnActionOver2(caster, target, data)
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
	-- 8261
	if SkillJudger:IsCallSkill(self, caster, target, true) then
	else
		return
	end
	-- 8219
	if SkillJudger:IsUltimate(self, caster, target, true) then
	else
		return
	end
	-- 60000072
	self:AddBuffCount(SkillEffect[60000072], caster, self.card, data, 60000071,30,100)
end
