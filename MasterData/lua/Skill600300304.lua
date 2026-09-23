-- 倾覆剑光
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill600300304 = oo.class(SkillBase)
function Skill600300304:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill600300304:DoSkill(caster, target, data)
	-- 12005
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12005], caster, target, data, 0.2,5)
end
-- 入场时
function Skill600300304:OnBorn(caster, target, data)
	-- 4600306
	self:AddBuff(SkillEffect[4600306], caster, self.card, data, 6111)
end
-- 行动结束
function Skill600300304:OnActionOver(caster, target, data)
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
	-- 8424
	local count24 = SkillApi:BuffCount(self, caster, target,3,3,6111)
	-- 8107
	if SkillJudger:Greater(self, caster, self.card, true,count24,0) then
	else
		return
	end
	-- 4600305
	self:Cure(SkillEffect[4600305], caster, self.card, data, 2,0.5)
	-- 92017
	self:DelBufferForce(SkillEffect[92017], caster, self.card, data, 6111,2)
	-- 4600307
	self:ShowTips(SkillEffect[4600307], caster, self.card, data, 2,"恒长",true,4600307)
	-- 8131
	if SkillJudger:OwnerPercentHp(self, caster, target, true,0.1) then
	else
		return
	end
	-- 4600308
	self:AddBuff(SkillEffect[4600308], caster, self.card, data, 4600308)
end
