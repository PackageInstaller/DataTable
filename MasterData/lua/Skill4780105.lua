-- 洛贝拉
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4780105 = oo.class(SkillBase)
function Skill4780105:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束2
function Skill4780105:OnActionOver2(caster, target, data)
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
	-- 603300303
	self:OwnerAddBuffCount(SkillEffect[603300303], caster, self.card, data, 603300301,1,5)
	-- 9731
	if SkillJudger:IsTypeOf(self, caster, target, true,4) then
	else
		return
	end
	-- 603300304
	self:OwnerAddBuffCount(SkillEffect[603300304], caster, self.card, data, 603300301,1,5)
end
-- 特殊入场时(复活，召唤，合体)
function Skill4780105:OnBornSpecial(caster, target, data)
	-- 8166
	if SkillJudger:CasterIsOwnSummon(self, caster, target, true) then
	else
		return
	end
	-- 4603303
	self:OwnerAddBuffCount(SkillEffect[4603303], caster, self.card, data, 603300301,1,5)
	-- 8166
	if SkillJudger:CasterIsOwnSummon(self, caster, target, true) then
	else
		return
	end
	-- 4603301
	self:AddOwnerEquipSkill(SkillEffect[4603301], caster, caster, data, nil)
end
-- 行动结束
function Skill4780105:OnActionOver(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8214
	if SkillJudger:IsTypeOf(self, caster, target, true,2) then
	else
		return
	end
	-- 4603304
	self:OwnerAddBuffCount(SkillEffect[4603304], caster, self.card, data, 603300301,1,5)
end
-- 伤害后
function Skill4780105:OnAfterHurt(caster, target, data)
	-- 4603343
	self:tFunc_4603343_4603313(caster, target, data)
	self:tFunc_4603343_4603316(caster, target, data)
end
function Skill4780105:tFunc_4603343_4603313(caster, target, data)
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
	-- 4603313
	self:LimitDamage(SkillEffect[4603313], caster, target, data, 0.05,2,1)
end
function Skill4780105:tFunc_4603343_4603316(caster, target, data)
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
	-- 4603316
	self:LimitDamage(SkillEffect[4603316], caster, target, data, 0.05,2,1)
end
