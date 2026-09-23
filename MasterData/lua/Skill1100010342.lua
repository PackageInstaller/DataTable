-- 山脉攻击后，下个角色每段攻击100%附带防御转攻击的真实伤害效果，开局每有一个山脉角色提高10%防御力
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1100010342 = oo.class(SkillBase)
function Skill1100010342:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害后
function Skill1100010342:OnAfterHurt(caster, target, data)
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
	-- 1100010343
	self:OwnerAddBuffCount(SkillEffect[1100010343], caster, target, data, 1100010342,1,10)
end
-- 伤害前
function Skill1100010342:OnBefourHurt(caster, target, data)
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
	-- 1100010346
	self:OwnerAddBuffCount(SkillEffect[1100010346], caster, target, data, 1100010342,-1,10)
end
-- 入场时
function Skill1100010342:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 1100010361
	self:AddBuff(SkillEffect[1100010361], caster, caster, data, 1100010361)
end
