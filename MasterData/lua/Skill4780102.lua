-- 洛贝拉
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4780102 = oo.class(SkillBase)
function Skill4780102:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束2
function Skill4780102:OnActionOver2(caster, target, data)
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
	-- 603300301
	self:OwnerAddBuffCount(SkillEffect[603300301], caster, self.card, data, 603300301,1,3)
	-- 9731
	if SkillJudger:IsTypeOf(self, caster, target, true,4) then
	else
		return
	end
	-- 603300305
	self:OwnerAddBuffCount(SkillEffect[603300305], caster, self.card, data, 603300301,1,3)
end
-- 伤害后
function Skill4780102:OnAfterHurt(caster, target, data)
	-- 4603342
	self:tFunc_4603342_4603312(caster, target, data)
	self:tFunc_4603342_4603315(caster, target, data)
end
function Skill4780102:tFunc_4603342_4603315(caster, target, data)
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
function Skill4780102:tFunc_4603342_4603312(caster, target, data)
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
