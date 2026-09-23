-- 不死之身
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill907000401 = oo.class(SkillBase)
function Skill907000401:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill907000401:DoSkill(caster, target, data)
	-- 12002
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12002], caster, target, data, 0.5,2)
end
-- 入场时
function Skill907000401:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 6201
	self:AddBuff(SkillEffect[6201], caster, self.card, data, 6113)
end
-- 攻击结束
function Skill907000401:OnAttackOver(caster, target, data)
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
	-- 6202
	self:DelBufferForce(SkillEffect[6202], caster, self.card, data, 6113)
	-- 6203
	self:AddHp(SkillEffect[6203], caster, self.card, data, -99999)
end
-- 行动结束
function Skill907000401:OnActionOver(caster, target, data)
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 6204
	self:ShowTips(SkillEffect[6204], caster, self.card, data, 1,"伤害免疫",true,6204)
end
