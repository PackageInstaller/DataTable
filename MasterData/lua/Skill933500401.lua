-- 本体机制
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill933500401 = oo.class(SkillBase)
function Skill933500401:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill933500401:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 6201
	self:AddBuff(SkillEffect[6201], caster, self.card, data, 6113)
end
-- 攻击开始
function Skill933500401:OnAttackBegin(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8476
	local count76 = SkillApi:LiveCount(self, caster, target,3)
	-- 8801
	if SkillJudger:Equal(self, caster, target, true,count76,1) then
	else
		return
	end
	-- 933500401
	self:DelBufferForce(SkillEffect[933500401], caster, self.card, data, 6113)
end
