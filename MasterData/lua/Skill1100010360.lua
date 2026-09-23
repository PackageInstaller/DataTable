-- 山脉角色攻击时附带最大血量转化成攻击力的伤害，开局全体防御下降每有一个山脉角色下降12%防御
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1100010360 = oo.class(SkillBase)
function Skill1100010360:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill1100010360:OnBefourHurt(caster, target, data)
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
	-- 1100010362
	self:LimitDamage(SkillEffect[1100010362], caster, target, data, 0.06,((dqzdnaijiu)*0.000015))
end
-- 入场时
function Skill1100010360:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 1100010360
	self:AddBuff(SkillEffect[1100010360], caster, caster, data, 1100010360)
end
