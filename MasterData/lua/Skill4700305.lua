-- 水能
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4700305 = oo.class(SkillBase)
function Skill4700305:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击结束
function Skill4700305:OnAttackOver(caster, target, data)
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
	-- 4700305
	self:AddBuff(SkillEffect[4700305], caster, self.card, data, 6505)
	-- 4700306
	self:ShowTips(SkillEffect[4700306], caster, self.card, data, 2,"水能",true,4700306)
end
-- 行动开始
function Skill4700305:OnActionBegin(caster, target, data)
	-- 4700345
	self:tFunc_4700345_4700315(caster, target, data)
	self:tFunc_4700345_4700325(caster, target, data)
	self:tFunc_4700345_4700335(caster, target, data)
end
-- 行动结束
function Skill4700305:OnActionOver(caster, target, data)
	-- 4700385
	self:tFunc_4700385_4700355(caster, target, data)
	self:tFunc_4700385_4700365(caster, target, data)
	self:tFunc_4700385_4700375(caster, target, data)
end
-- 伤害前
function Skill4700305:OnBefourHurt(caster, target, data)
	-- 4700395
	self:tFunc_4700395_4700370(caster, target, data)
	self:tFunc_4700395_4700380(caster, target, data)
	self:tFunc_4700395_4700390(caster, target, data)
end
function Skill4700305:tFunc_4700385_4700355(caster, target, data)
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
	-- 4700355
	if self:Rand(6000) then
		self:CallOwnerSkill(SkillEffect[4700355], caster, target, data, 700300100+count701)
	end
end
function Skill4700305:tFunc_4700395_4700380(caster, target, data)
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
	-- 4700380
	self:AddTempAttr(SkillEffect[4700380], caster, target, data, "bedamage",0.60)
end
function Skill4700305:tFunc_4700395_4700370(caster, target, data)
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
	-- 4700370
	self:AddTempAttr(SkillEffect[4700370], caster, target, data, "bedamage",1.5)
end
function Skill4700305:tFunc_4700345_4700315(caster, target, data)
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
	-- 4700315
	self:OwnerAddBuff(SkillEffect[4700315], caster, caster, data, 4700315)
end
function Skill4700305:tFunc_4700395_4700390(caster, target, data)
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
	-- 4700390
	self:AddTempAttr(SkillEffect[4700390], caster, target, data, "bedamage",0.30)
end
function Skill4700305:tFunc_4700345_4700335(caster, target, data)
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
	-- 4700335
	self:OwnerAddBuff(SkillEffect[4700335], caster, caster, data, 4700315)
end
function Skill4700305:tFunc_4700385_4700375(caster, target, data)
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
	-- 4700375
	if self:Rand(6000) then
		self:CallOwnerSkill(SkillEffect[4700375], caster, target, data, 700300100+count701)
	end
end
function Skill4700305:tFunc_4700345_4700325(caster, target, data)
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
	-- 4700325
	self:OwnerAddBuff(SkillEffect[4700325], caster, caster, data, 4700315)
end
function Skill4700305:tFunc_4700385_4700365(caster, target, data)
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
	-- 4700365
	if self:Rand(6000) then
		self:CallOwnerSkill(SkillEffect[4700365], caster, target, data, 700300100+count701)
	end
end
