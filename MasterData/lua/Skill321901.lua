-- 怪力钳制
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill321901 = oo.class(SkillBase)
function Skill321901:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击结束
function Skill321901:OnAttackOver(caster, target, data)
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
	-- 8412
	local count12 = SkillApi:BuffCount(self, caster, target,2,1,2)
	-- 8187
	if SkillJudger:Greater(self, caster, target, true,count12,0) then
	else
		return
	end
	-- 8214
	if SkillJudger:IsTypeOf(self, caster, target, true,2) then
	else
		return
	end
	-- 321901
	self:HitAddBuff(SkillEffect[321901], caster, target, data, 2000,5707)
	-- 92008
	self:DelBufferGroup(SkillEffect[92008], caster, target, data, 2,3)
end
