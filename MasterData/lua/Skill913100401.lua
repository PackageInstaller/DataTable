-- 人马机神防御形态4技能
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill913100401 = oo.class(SkillBase)
function Skill913100401:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill913100401:DoSkill(caster, target, data)
	-- 13016
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[13016], caster, target, data, 0.125,4)
	-- 13017
	self.order = self.order + 1
	self:DamageLight(SkillEffect[13017], caster, target, data, 0.125,4)
end
-- 攻击结束
function Skill913100401:OnAttackOver(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 913100801
	if self:Rand(5000) then
		self:BeatBack(SkillEffect[913100801], caster, self.card, data, nil,100)
	end
end
