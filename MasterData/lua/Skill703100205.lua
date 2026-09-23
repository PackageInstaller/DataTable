-- 扳机三连
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill703100205 = oo.class(SkillBase)
function Skill703100205:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill703100205:DoSkill(caster, target, data)
	-- 12004
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12004], caster, target, data, 0.25,4)
end
-- 伤害后
function Skill703100205:OnAfterHurt(caster, target, data)
	-- 703100223
	self:tFunc_703100223_703100203(caster, target, data)
	self:tFunc_703100223_703100213(caster, target, data)
end
function Skill703100205:tFunc_703100223_703100213(caster, target, data)
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
	-- 703100213
	if self:Rand(5000) then
		self:AlterBufferByID(SkillEffect[703100213], caster, target, data, 1051,1)
	end
end
function Skill703100205:tFunc_703100223_703100203(caster, target, data)
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
	-- 703100203
	if self:Rand(5000) then
		self:AlterBufferByID(SkillEffect[703100203], caster, target, data, 1003,1)
	end
end
