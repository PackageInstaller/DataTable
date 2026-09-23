-- 漆黑_Schwarz（剑）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill802410101 = oo.class(SkillBase)
function Skill802410101:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill802410101:DoSkill(caster, target, data)
	-- 11002
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[11002], caster, target, data, 0.5,2)
	-- 80003
	self.order = self.order + 1
	self:AddSp(SkillEffect[80003], caster, caster, data, 20)
end
-- 伤害后
function Skill802410101:OnAfterHurt(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8200
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	-- 802410201
	self:HitAddBuff(SkillEffect[802410201], caster, target, data, 3000,1003,2)
end
