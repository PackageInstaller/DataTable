-- 高卡萨斯1
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill502500101 = oo.class(SkillBase)
function Skill502500101:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill502500101:DoSkill(caster, target, data)
	-- 11002
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[11002], caster, target, data, 0.5,2)
end
-- 伤害前
function Skill502500101:OnBefourHurt(caster, target, data)
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
	-- 8444
	local count44 = SkillApi:BuffCount(self, caster, target,2,4,3)
	-- 8125
	if SkillJudger:Greater(self, caster, self.card, true,count44,0) then
	else
		return
	end
	-- 8200
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	-- 502500101
	self:AddTempAttr(SkillEffect[502500101], caster, self.card, data, "damage",0.5)
end
