-- 水能
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4700304 = oo.class(SkillBase)
function Skill4700304:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击结束
function Skill4700304:OnAttackOver(caster, target, data)
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
	-- 8472
	local count72 = SkillApi:BuffCount(self, caster, target,3,4,650)
	-- 8164
	if SkillJudger:Less(self, caster, target, true,count72,5) then
	else
		return
	end
	-- 4700304
	self:AddBuff(SkillEffect[4700304], caster, self.card, data, 6504)
	-- 4700306
	self:ShowTips(SkillEffect[4700306], caster, self.card, data, 2,"水能",true,4700306)
end
-- 行动开始
function Skill4700304:OnActionBegin(caster, target, data)
	-- 4700344
	self:tFunc_4700344_4700314(caster, target, data)
	self:tFunc_4700344_4700324(caster, target, data)
	self:tFunc_4700344_4700334(caster, target, data)
end
-- 行动结束
function Skill4700304:OnActionOver(caster, target, data)
	-- 4700384
	self:tFunc_4700384_4700354(caster, target, data)
	self:tFunc_4700384_4700364(caster, target, data)
	self:tFunc_4700384_4700374(caster, target, data)
end
-- 伤害前
function Skill4700304:OnBefourHurt(caster, target, data)
	-- 4700394
	self:tFunc_4700394_4700369(caster, target, data)
	self:tFunc_4700394_4700379(caster, target, data)
	self:tFunc_4700394_4700389(caster, target, data)
end
function Skill4700304:tFunc_4700384_4700364(caster, target, data)
	-- 8263
	if SkillJudger:IsCasterSibling(self, caster, target, true,70050) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8701
	local count701 = SkillApi:SkillLevel(self, caster, target,3,7003001)
	-- 8062
	if SkillJudger:CasterIsTeammate(self, caster, target, true) then
	else
		return
	end
	-- 4700364
	if self:Rand(5000) then
		self:CallOwnerSkill(SkillEffect[4700364], caster, target, data, 700300100+count701)
	end
end
function Skill4700304:tFunc_4700394_4700379(caster, target, data)
	-- 8062
	if SkillJudger:CasterIsTeammate(self, caster, target, true) then
	else
		return
	end
	-- 8246
	if SkillJudger:IsTargetMech(self, caster, target, true,10) then
	else
		return
	end
	-- 8266
	if SkillJudger:IsLittleRange(self, caster, target, true) then
	else
		return
	end
	-- 4700379
	self:AddTempAttr(SkillEffect[4700379], caster, target, data, "bedamage",0.48)
end
function Skill4700304:tFunc_4700344_4700314(caster, target, data)
	-- 8262
	if SkillJudger:IsCasterSibling(self, caster, target, true,70010) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 4700314
	self:OwnerAddBuff(SkillEffect[4700314], caster, caster, data, 4700314)
end
function Skill4700304:tFunc_4700394_4700369(caster, target, data)
	-- 8062
	if SkillJudger:CasterIsTeammate(self, caster, target, true) then
	else
		return
	end
	-- 8246
	if SkillJudger:IsTargetMech(self, caster, target, true,10) then
	else
		return
	end
	-- 8265
	if SkillJudger:IsALLRange(self, caster, target, true) then
	else
		return
	end
	-- 4700369
	self:AddTempAttr(SkillEffect[4700369], caster, target, data, "bedamage",1.2)
end
function Skill4700304:tFunc_4700394_4700389(caster, target, data)
	-- 8062
	if SkillJudger:CasterIsTeammate(self, caster, target, true) then
	else
		return
	end
	-- 8246
	if SkillJudger:IsTargetMech(self, caster, target, true,10) then
	else
		return
	end
	-- 8269
	if SkillJudger:IsCtrlType(self, caster, target, true,14) then
	else
		return
	end
	-- 4700389
	self:AddTempAttr(SkillEffect[4700389], caster, target, data, "bedamage",0.24)
end
function Skill4700304:tFunc_4700384_4700354(caster, target, data)
	-- 8262
	if SkillJudger:IsCasterSibling(self, caster, target, true,70010) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8701
	local count701 = SkillApi:SkillLevel(self, caster, target,3,7003001)
	-- 8062
	if SkillJudger:CasterIsTeammate(self, caster, target, true) then
	else
		return
	end
	-- 4700354
	if self:Rand(5000) then
		self:CallOwnerSkill(SkillEffect[4700354], caster, target, data, 700300100+count701)
	end
end
function Skill4700304:tFunc_4700344_4700334(caster, target, data)
	-- 8264
	if SkillJudger:IsCasterSibling(self, caster, target, true,70051) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 4700334
	self:OwnerAddBuff(SkillEffect[4700334], caster, caster, data, 4700314)
end
function Skill4700304:tFunc_4700384_4700374(caster, target, data)
	-- 8264
	if SkillJudger:IsCasterSibling(self, caster, target, true,70051) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8701
	local count701 = SkillApi:SkillLevel(self, caster, target,3,7003001)
	-- 8062
	if SkillJudger:CasterIsTeammate(self, caster, target, true) then
	else
		return
	end
	-- 4700374
	if self:Rand(5000) then
		self:CallOwnerSkill(SkillEffect[4700374], caster, target, data, 700300100+count701)
	end
end
function Skill4700304:tFunc_4700344_4700324(caster, target, data)
	-- 8263
	if SkillJudger:IsCasterSibling(self, caster, target, true,70050) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 4700324
	self:OwnerAddBuff(SkillEffect[4700324], caster, caster, data, 4700314)
end
