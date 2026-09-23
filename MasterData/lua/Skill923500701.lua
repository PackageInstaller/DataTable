-- 换色维达尔被动
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill923500701 = oo.class(SkillBase)
function Skill923500701:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击开始
function Skill923500701:OnAttackBegin(caster, target, data)
	-- 923600603
	self:tFunc_923600603_923600601(caster, target, data)
	self:tFunc_923600603_923600602(caster, target, data)
end
function Skill923500701:tFunc_923600603_923600601(caster, target, data)
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
	-- 8965
	if SkillJudger:IsCallSkill(self, caster, target, false) then
	else
		return
	end
	-- 923600604
	local count923600604 = SkillApi:GetAttr(self, caster, target,1,"hp")
	-- 923600601
	self:AddHp(SkillEffect[923600601], caster, caster, data, math.floor(-count923600604*0.2))
end
function Skill923500701:tFunc_923600603_923600602(caster, target, data)
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
	-- 8261
	if SkillJudger:IsCallSkill(self, caster, target, true) then
	else
		return
	end
	-- 923600604
	local count923600604 = SkillApi:GetAttr(self, caster, target,1,"hp")
	-- 923600602
	self:AddHp(SkillEffect[923600602], caster, caster, data, math.floor(-count923600604*0.02))
end
