-- 神秘金字塔技能5
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill934100501 = oo.class(SkillBase)
function Skill934100501:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill934100501:DoSkill(caster, target, data)
	-- 12003
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12003], caster, target, data, 0.333,3)
	-- 11003
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[11003], caster, target, data, 0.333,3)
end
-- 攻击结束
function Skill934100501:OnAttackOver(caster, target, data)
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
	-- 8200
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	-- 503001301
	self:ClosingBuffByID(SkillEffect[503001301], caster, target, data, 1,1003)
	-- 503001302
	self:ClosingBuffByID(SkillEffect[503001302], caster, target, data, 1,1051)
	-- 503001303
	self:ClosingBuffByID(SkillEffect[503001303], caster, target, data, 5,1001)
	-- 503001304
	self:ClosingBuffByID(SkillEffect[503001304], caster, target, data, 1,1002)
end
