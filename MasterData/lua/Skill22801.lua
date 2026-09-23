-- 再起I级
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill22801 = oo.class(SkillBase)
function Skill22801:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill22801:OnBorn(caster, target, data)
	-- 4600806
	self:AddBuff(SkillEffect[4600806], caster, self.card, data, 6111)
end
-- 行动结束
function Skill22801:OnActionOver(caster, target, data)
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
	-- 4600801
	self:Cure(SkillEffect[4600801], caster, self.card, data, 2,0.10)
	-- 92017
	self:DelBufferForce(SkillEffect[92017], caster, self.card, data, 6111,2)
	-- 4600807
	self:ShowTips(SkillEffect[4600807], caster, self.card, data, 2,"意志力",true,4600807)
end
-- 回合开始处理完成后
function Skill22801:OnAfterRoundBegin(caster, target, data)
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
	-- 4600801
	self:Cure(SkillEffect[4600801], caster, self.card, data, 2,0.10)
	-- 92017
	self:DelBufferForce(SkillEffect[92017], caster, self.card, data, 6111,2)
	-- 4600807
	self:ShowTips(SkillEffect[4600807], caster, self.card, data, 2,"意志力",true,4600807)
end
