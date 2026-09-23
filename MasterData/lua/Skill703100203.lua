-- 扳机三连
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill703100203 = oo.class(SkillBase)
function Skill703100203:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill703100203:DoSkill(caster, target, data)
	-- 12004
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12004], caster, target, data, 0.25,4)
end
-- 伤害后
function Skill703100203:OnAfterHurt(caster, target, data)
	-- 703100222
	self:tFunc_703100222_703100202(caster, target, data)
	self:tFunc_703100222_703100212(caster, target, data)
end
function Skill703100203:tFunc_703100222_703100202(caster, target, data)
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
	-- 703100202
	if self:Rand(4000) then
		self:AlterBufferByID(SkillEffect[703100202], caster, target, data, 1003,1)
	end
end
function Skill703100203:tFunc_703100222_703100212(caster, target, data)
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
	-- 703100212
	if self:Rand(4000) then
		self:AlterBufferByID(SkillEffect[703100212], caster, target, data, 1051,1)
	end
end
