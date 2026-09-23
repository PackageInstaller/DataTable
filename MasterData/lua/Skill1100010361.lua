-- 山脉角色攻击时附带最大血量转化成攻击力的伤害，开局防御每有一个山脉角色提高10%防御
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1100010361 = oo.class(SkillBase)
function Skill1100010361:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill1100010361:OnBefourHurt(caster, target, data)
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
	-- 9713
	local count802 = SkillApi:ClassCount(self, caster, target,1,1)
	-- 1100010363
	local dqzdnaijiu = SkillApi:GetAttr(self, caster, target,3,"maxhp")
	-- 8229
	if SkillJudger:IsCasterMech(self, caster, self.card, true,1) then
	else
		return
	end
	-- 1100010364
	self:LimitDamage(SkillEffect[1100010364], caster, target, data, 0.06,((dqzdnaijiu)*0.00002))
end
-- 入场时
function Skill1100010361:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 1100010361
	self:AddBuff(SkillEffect[1100010361], caster, caster, data, 1100010361)
end
