-- 山脉攻击后，下个角色每段攻击100%附带防御转攻击的真实伤害效果
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1100010341 = oo.class(SkillBase)
function Skill1100010341:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害后
function Skill1100010341:OnAfterHurt(caster, target, data)
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
	-- 8229
	if SkillJudger:IsCasterMech(self, caster, self.card, true,1) then
	else
		return
	end
	-- 1100010342
	self:OwnerAddBuffCount(SkillEffect[1100010342], caster, target, data, 1100010341,1,10)
end
-- 伤害前
function Skill1100010341:OnBefourHurt(caster, target, data)
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
	-- 8230
	if SkillJudger:IsCasterMech(self, caster, self.card, false,1) then
	else
		return
	end
	-- 1100010345
	self:OwnerAddBuffCount(SkillEffect[1100010345], caster, target, data, 1100010341,-1,10)
end
