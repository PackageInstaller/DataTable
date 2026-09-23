-- 浮游
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill9024 = oo.class(SkillBase)
function Skill9024:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill9024:OnBefourHurt(caster, target, data)
	-- 9024
	self:tFunc_9024_902401(caster, target, data)
	self:tFunc_9024_902402(caster, target, data)
end
function Skill9024:tFunc_9024_902401(caster, target, data)
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
	-- 8134
	if SkillJudger:OwnerPercentHp(self, caster, target, true,0.4) then
	else
		return
	end
	-- 902401
	self:AddTempAttr(SkillEffect[902401], caster, caster, data, "damage",0.6)
end
function Skill9024:tFunc_9024_902402(caster, target, data)
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
	-- 8144
	if SkillJudger:OwnerPercentHp(self, caster, target, false,0.4) then
	else
		return
	end
	-- 902402
	self:AddTempAttr(SkillEffect[902402], caster, caster, data, "damage",-0.6)
end
