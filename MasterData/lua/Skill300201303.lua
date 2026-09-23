-- 枪剑一体（OD）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill300201303 = oo.class(SkillBase)
function Skill300201303:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill300201303:DoSkill(caster, target, data)
	-- 11051
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[11051], caster, target, data, 0.125,4)
	-- 11052
	self.order = self.order + 1
	self:DamageLight(SkillEffect[11052], caster, target, data, 0.25,2)
end
-- 伤害前
function Skill300201303:OnBefourHurt(caster, target, data)
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
	-- 8481
	local count81 = SkillApi:BuffCount(self, caster, target,2,3,4300201)
	-- 8169
	if SkillJudger:Greater(self, caster, target, true,count81,0) then
	else
		return
	end
	-- 8200
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	-- 999999986
	self:AddTempAttr(SkillEffect[999999986], caster, self.card, data, "damage",1)
end
