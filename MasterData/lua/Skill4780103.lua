-- 洛贝拉
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4780103 = oo.class(SkillBase)
function Skill4780103:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束2
function Skill4780103:OnActionOver2(caster, target, data)
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
	-- 8219
	if SkillJudger:IsUltimate(self, caster, target, true) then
	else
		return
	end
	-- 603300302
	self:OwnerAddBuffCount(SkillEffect[603300302], caster, self.card, data, 603300301,1,4)
	-- 9731
	if SkillJudger:IsTypeOf(self, caster, target, true,4) then
	else
		return
	end
	-- 603300306
	self:OwnerAddBuffCount(SkillEffect[603300306], caster, self.card, data, 603300301,1,4)
end
-- 特殊入场时(复活，召唤，合体)
function Skill4780103:OnBornSpecial(caster, target, data)
	-- 8166
	if SkillJudger:CasterIsOwnSummon(self, caster, target, true) then
	else
		return
	end
	-- 4603302
	self:OwnerAddBuffCount(SkillEffect[4603302], caster, self.card, data, 603300301,1,4)
	-- 8166
	if SkillJudger:CasterIsOwnSummon(self, caster, target, true) then
	else
		return
	end
	-- 4603301
	self:AddOwnerEquipSkill(SkillEffect[4603301], caster, caster, data, nil)
end
-- 伤害后
function Skill4780103:OnAfterHurt(caster, target, data)
	-- 4603342
	self:tFunc_4603342_4603312(caster, target, data)
	self:tFunc_4603342_4603315(caster, target, data)
end
function Skill4780103:tFunc_4603342_4603315(caster, target, data)
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
	-- 8743
	local count743 = SkillApi:BuffCount(self, caster, target,3,4,338401)
	-- 8956
	if SkillJudger:Greater(self, caster, self.card, true,count743,0) then
	else
		return
	end
	-- 4603315
	self:LimitDamage(SkillEffect[4603315], caster, target, data, 0.04,1.6,1)
end
function Skill4780103:tFunc_4603342_4603312(caster, target, data)
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
	-- 8743
	local count743 = SkillApi:BuffCount(self, caster, target,3,4,338401)
	-- 8956
	if SkillJudger:Greater(self, caster, self.card, true,count743,0) then
	else
		return
	end
	-- 4603312
	self:LimitDamage(SkillEffect[4603312], caster, target, data, 0.04,1.6,1)
end
