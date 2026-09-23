-- 原蜻震击
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill911400101 = oo.class(SkillBase)
function Skill911400101:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill911400101:DoSkill(caster, target, data)
	-- 11002
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[11002], caster, target, data, 0.5,2)
end
-- 伤害前
function Skill911400101:OnBefourHurt(caster, target, data)
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
	-- 8086
	if SkillJudger:CasterPercentHp(self, caster, target, false,0.5) then
	else
		return
	end
	-- 911400101
	self:AddTempAttr(SkillEffect[911400101], caster, self.card, data, "damage",0.5)
end
-- 攻击结束
function Skill911400101:OnAttackOver(caster, target, data)
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
	-- 911400102
	self:DelBufferGroup(SkillEffect[911400102], caster, target, data, 2,1)
end
