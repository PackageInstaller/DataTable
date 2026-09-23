-- 盈能抢修
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4304803 = oo.class(SkillBase)
function Skill4304803:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill4304803:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4304802
	self:OwnerAddBuffCount(SkillEffect[4304802], caster, self.card, data, 304800101,2,8)
end
-- 攻击结束
function Skill4304803:OnAttackOver(caster, target, data)
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
	-- 4304812
	if self:Rand(7000) then
		self:OwnerAddBuffCount(SkillEffect[4304812], caster, self.card, data, 304800101,1,8)
	end
end
-- 行动结束
function Skill4304803:OnActionOver(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8420
	local count20 = SkillApi:GetAttr(self, caster, target,3,"hp")
	-- 8106
	if SkillJudger:Less(self, caster, self.card, true,count20,2) then
	else
		return
	end
	-- 8684
	local count684 = SkillApi:GetCount(self, caster, target,3,304800101)
	-- 8897
	if SkillJudger:Greater(self, caster, target, true,count684,4) then
	else
		return
	end
	-- 4304826
	self:Cure(SkillEffect[4304826], caster, self.card, data, 2,0.5)
	-- 92017
	self:DelBufferForce(SkillEffect[92017], caster, self.card, data, 6111,2)
	-- 8131
	if SkillJudger:OwnerPercentHp(self, caster, target, true,0.1) then
	else
		return
	end
	-- 4600308
	self:AddBuff(SkillEffect[4600308], caster, self.card, data, 4600308)
	-- 4304828
	self:OwnerAddBuffCount(SkillEffect[4304828], caster, self.card, data, 304800101,-5,8)
end
-- 行动结束2
function Skill4304803:OnActionOver2(caster, target, data)
	-- 8684
	local count684 = SkillApi:GetCount(self, caster, target,3,304800101)
	-- 8897
	if SkillJudger:Greater(self, caster, target, true,count684,4) then
	else
		return
	end
	-- 8424
	local count24 = SkillApi:BuffCount(self, caster, target,3,3,6111)
	-- 8898
	if SkillJudger:Less(self, caster, self.card, true,count24,1) then
	else
		return
	end
	-- 4304827
	self:AddBuff(SkillEffect[4304827], caster, self.card, data, 6111)
end
