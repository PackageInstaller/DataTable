-- 蜘蛛大人被动技能2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill914200601 = oo.class(SkillBase)
function Skill914200601:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill914200601:OnBefourHurt(caster, target, data)
	-- 914200610
	self:tFunc_914200610_914200601(caster, target, data)
	self:tFunc_914200610_914200602(caster, target, data)
	self:tFunc_914200610_914200603(caster, target, data)
	self:tFunc_914200610_914200604(caster, target, data)
	self:tFunc_914200610_914200605(caster, target, data)
	self:tFunc_914200610_914200606(caster, target, data)
	self:tFunc_914200610_914200607(caster, target, data)
	self:tFunc_914200610_914200608(caster, target, data)
	self:tFunc_914200610_914200609(caster, target, data)
end
-- 入场时
function Skill914200601:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 914200611
	self:CallOwnerSkill(SkillEffect[914200611], caster, self.card, data, 914200401)
end
-- 行动结束2
function Skill914200601:OnActionOver2(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8072
	if SkillJudger:TargetIsTeammate(self, caster, target, true) then
	else
		return
	end
	-- 8261
	if SkillJudger:IsCallSkill(self, caster, target, true) then
	else
		return
	end
	-- 8487
	local count87 = SkillApi:GetBeDamage(self, caster, target,2)
	-- 8201
	if SkillJudger:IsSingle(self, caster, target, true) then
	else
		return
	end
	-- 5700009
	self:AddHp(SkillEffect[5700009], caster, self.card, data, -count87,1)
end
function Skill914200601:tFunc_914200610_914200605(caster, target, data)
	-- 8237
	if SkillJudger:IsCasterMech(self, caster, self.card, true,5) then
	else
		return
	end
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 9724
	local count813 = SkillApi:ClassCount(self, caster, target,4,5)
	-- 914200605
	self:AddTempAttr(SkillEffect[914200605], caster, self.card, data, "bedamage2",math.max((0.1*(count813-1)),0))
end
function Skill914200601:tFunc_914200610_914200601(caster, target, data)
	-- 8229
	if SkillJudger:IsCasterMech(self, caster, self.card, true,1) then
	else
		return
	end
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 9720
	local count809 = SkillApi:ClassCount(self, caster, target,4,1)
	-- 914200601
	self:AddTempAttr(SkillEffect[914200601], caster, self.card, data, "bedamage2",math.max((0.1*(count809-1)),0))
end
function Skill914200601:tFunc_914200610_914200602(caster, target, data)
	-- 8231
	if SkillJudger:IsCasterMech(self, caster, self.card, true,2) then
	else
		return
	end
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 9721
	local count810 = SkillApi:ClassCount(self, caster, target,4,2)
	-- 914200602
	self:AddTempAttr(SkillEffect[914200602], caster, self.card, data, "bedamage2",math.max((0.1*(count810-1)),0))
end
function Skill914200601:tFunc_914200610_914200604(caster, target, data)
	-- 8235
	if SkillJudger:IsCasterMech(self, caster, self.card, true,4) then
	else
		return
	end
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 9723
	local count812 = SkillApi:ClassCount(self, caster, target,4,4)
	-- 914200604
	self:AddTempAttr(SkillEffect[914200604], caster, self.card, data, "bedamage2",math.max((0.1*(count812-1)),0))
end
function Skill914200601:tFunc_914200610_914200608(caster, target, data)
	-- 8277
	if SkillJudger:IsCasterMech(self, caster, self.card, true,9) then
	else
		return
	end
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 9765
	local count9765 = SkillApi:ClassCount(self, caster, target,4,9)
	-- 914200608
	self:AddTempAttr(SkillEffect[914200608], caster, self.card, data, "bedamage2",math.max((0.1*(count9765-1)),0))
end
function Skill914200601:tFunc_914200610_914200603(caster, target, data)
	-- 8233
	if SkillJudger:IsCasterMech(self, caster, self.card, true,3) then
	else
		return
	end
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 9722
	local count811 = SkillApi:ClassCount(self, caster, target,4,3)
	-- 914200603
	self:AddTempAttr(SkillEffect[914200603], caster, self.card, data, "bedamage2",math.max((0.1*(count811-1)),0))
end
function Skill914200601:tFunc_914200610_914200609(caster, target, data)
	-- 8279
	if SkillJudger:IsCasterMech(self, caster, self.card, true,10) then
	else
		return
	end
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 9766
	local count9766 = SkillApi:ClassCount(self, caster, target,4,10)
	-- 914200609
	self:AddTempAttr(SkillEffect[914200609], caster, self.card, data, "bedamage2",math.max((0.1*(count9766-1)),0))
end
function Skill914200601:tFunc_914200610_914200607(caster, target, data)
	-- 8241
	if SkillJudger:IsCasterMech(self, caster, self.card, true,7) then
	else
		return
	end
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 9726
	local count815 = SkillApi:ClassCount(self, caster, target,4,7)
	-- 914200607
	self:AddTempAttr(SkillEffect[914200607], caster, self.card, data, "bedamage2",math.max((0.1*(count815-1)),0))
end
function Skill914200601:tFunc_914200610_914200606(caster, target, data)
	-- 8239
	if SkillJudger:IsCasterMech(self, caster, self.card, true,6) then
	else
		return
	end
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 9725
	local count814 = SkillApi:ClassCount(self, caster, target,4,6)
	-- 914200606
	self:AddTempAttr(SkillEffect[914200606], caster, self.card, data, "bedamage2",math.max((0.1*(count814-1)),0))
end
