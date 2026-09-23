-- 灭刃阵营角色攻击后，使敌方行动提前20%，使其攻击力下降10%，持续1回合，普攻行动后有概率使攻击力下降40%,持续2回合
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1100060020 = oo.class(SkillBase)
function Skill1100060020:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill1100060020:OnActionOver(caster, target, data)
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
	-- 1100060020
	self:AddProgress(SkillEffect[1100060020], caster, target, data, 200)
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
	-- 1100060023
	self:AddTempAttrPercent(SkillEffect[1100060023], caster, target, data, "attack",-0.1)
end
-- 行动结束2
function Skill1100060020:OnActionOver2(caster, target, data)
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
	-- 8202
	if SkillJudger:IsNormal(self, caster, target, true) then
	else
		return
	end
	-- 1100060011
	self:AddBuff(SkillEffect[1100060011], caster, self.card, data, 1100060011)
end
