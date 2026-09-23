-- 水能
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4700302 = oo.class(SkillBase)
function Skill4700302:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击结束
function Skill4700302:OnAttackOver(caster, target, data)
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
	-- 4700302
	self:AddBuff(SkillEffect[4700302], caster, self.card, data, 6502)
	-- 4700306
	self:ShowTips(SkillEffect[4700306], caster, self.card, data, 2,"水能",true,4700306)
end
-- 行动开始
function Skill4700302:OnActionBegin(caster, target, data)
	-- 4700342
	self:tFunc_4700342_4700312(caster, target, data)
	self:tFunc_4700342_4700322(caster, target, data)
	self:tFunc_4700342_4700332(caster, target, data)
end
-- 行动结束
function Skill4700302:OnActionOver(caster, target, data)
	-- 4700382
	self:tFunc_4700382_4700352(caster, target, data)
	self:tFunc_4700382_4700362(caster, target, data)
	self:tFunc_4700382_4700372(caster, target, data)
end
-- 伤害前
function Skill4700302:OnBefourHurt(caster, target, data)
	-- 4700392
	self:tFunc_4700392_4700367(caster, target, data)
	self:tFunc_4700392_4700377(caster, target, data)
	self:tFunc_4700392_4700387(caster, target, data)
end
function Skill4700302:tFunc_4700392_4700367(caster, target, data)
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
	-- 4700367
	self:AddTempAttr(SkillEffect[4700367], caster, target, data, "bedamage",0.6)
end
function Skill4700302:tFunc_4700382_4700362(caster, target, data)
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
	-- 4700362
	if self:Rand(3000) then
		self:CallOwnerSkill(SkillEffect[4700362], caster, target, data, 700300100+count701)
	end
end
function Skill4700302:tFunc_4700382_4700352(caster, target, data)
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
	-- 4700352
	if self:Rand(3000) then
		self:CallOwnerSkill(SkillEffect[4700352], caster, target, data, 700300100+count701)
	end
end
function Skill4700302:tFunc_4700342_4700332(caster, target, data)
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
	-- 4700332
	self:OwnerAddBuff(SkillEffect[4700332], caster, caster, data, 4700312)
end
function Skill4700302:tFunc_4700382_4700372(caster, target, data)
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
	-- 4700372
	if self:Rand(3000) then
		self:CallOwnerSkill(SkillEffect[4700372], caster, target, data, 700300100+count701)
	end
end
function Skill4700302:tFunc_4700342_4700312(caster, target, data)
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
	-- 4700312
	self:OwnerAddBuff(SkillEffect[4700312], caster, caster, data, 4700312)
end
function Skill4700302:tFunc_4700392_4700387(caster, target, data)
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
	-- 4700387
	self:AddTempAttr(SkillEffect[4700387], caster, target, data, "bedamage",0.12)
end
function Skill4700302:tFunc_4700392_4700377(caster, target, data)
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
	-- 4700377
	self:AddTempAttr(SkillEffect[4700377], caster, target, data, "bedamage",0.24)
end
function Skill4700302:tFunc_4700342_4700322(caster, target, data)
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
	-- 4700322
	self:OwnerAddBuff(SkillEffect[4700322], caster, caster, data, 4700312)
end
