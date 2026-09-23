-- 人马机神第二形态
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill913100802 = oo.class(SkillBase)
function Skill913100802:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill913100802:DoSkill(caster, target, data)
	-- 90011
	self.order = self.order + 1
	self:Transform(SkillEffect[90011], caster, target, data, {progress=1010})
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8200
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	-- 95001
	self.order = self.order + 1
	self:AlterBufferByGroup(SkillEffect[95001], caster, self.card, data, 1,1)
	-- 30013
	self.order = self.order + 1
	self:Cure(SkillEffect[30013], caster, self.card, data, 1,1)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 913110810
	self.order = self.order + 1
	self:AddBuff(SkillEffect[913110810], caster, self.card, data, 913110810)
	-- 913110808
	self.order = self.order + 1
	self:AddBuff(SkillEffect[913110808], caster, target, data, 913110808)
end
-- 战斗开始
function Skill913100802:OnStart(caster, target, data)
	-- 913100804
	self:SetInvincible(SkillEffect[913100804], caster, target, data, 2,2,999999999,30)
end
-- 行动结束
function Skill913100802:OnActionOver(caster, target, data)
	-- 913100805
	local angler100 = SkillApi:GetTurnCount(self, caster, self.card,nil)
	-- 913100807
	if SkillJudger:GreaterEqual(self, caster, target, true,angler100,20) then
	else
		return
	end
	-- 913100810
	self:AddHp(SkillEffect[913100810], caster, self.card, data, -1000000)
	-- 913100804
	self:SetInvincible(SkillEffect[913100804], caster, target, data, 2,2,999999999,30)
end
