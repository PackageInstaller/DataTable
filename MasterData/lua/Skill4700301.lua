-- 水能
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4700301 = oo.class(SkillBase)
function Skill4700301:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击结束
function Skill4700301:OnAttackOver(caster, target, data)
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
	-- 4700301
	self:AddBuff(SkillEffect[4700301], caster, self.card, data, 6501)
	-- 4700306
	self:ShowTips(SkillEffect[4700306], caster, self.card, data, 2,"水能",true,4700306)
end
-- 行动开始
function Skill4700301:OnActionBegin(caster, target, data)
	-- 4700341
	self:tFunc_4700341_4700311(caster, target, data)
	self:tFunc_4700341_4700321(caster, target, data)
	self:tFunc_4700341_4700331(caster, target, data)
end
-- 行动结束
function Skill4700301:OnActionOver(caster, target, data)
	-- 4700381
	self:tFunc_4700381_4700351(caster, target, data)
	self:tFunc_4700381_4700361(caster, target, data)
	self:tFunc_4700381_4700371(caster, target, data)
end
-- 伤害前
function Skill4700301:OnBefourHurt(caster, target, data)
	-- 4700391
	self:tFunc_4700391_4700366(caster, target, data)
	self:tFunc_4700391_4700376(caster, target, data)
	self:tFunc_4700391_4700386(caster, target, data)
end
function Skill4700301:tFunc_4700381_4700351(caster, target, data)
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
	-- 4700351
	if self:Rand(2000) then
		self:CallOwnerSkill(SkillEffect[4700351], caster, target, data, 700300100+count701)
	end
end
function Skill4700301:tFunc_4700341_4700331(caster, target, data)
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
	-- 4700331
	self:OwnerAddBuff(SkillEffect[4700331], caster, caster, data, 4700311)
end
function Skill4700301:tFunc_4700341_4700321(caster, target, data)
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
	-- 4700321
	self:OwnerAddBuff(SkillEffect[4700321], caster, caster, data, 4700311)
end
function Skill4700301:tFunc_4700391_4700386(caster, target, data)
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
	-- 4700386
	self:AddTempAttr(SkillEffect[4700386], caster, target, data, "bedamage",0.06)
end
function Skill4700301:tFunc_4700391_4700376(caster, target, data)
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
	-- 4700376
	self:AddTempAttr(SkillEffect[4700376], caster, target, data, "bedamage",0.12)
end
function Skill4700301:tFunc_4700381_4700361(caster, target, data)
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
	-- 4700361
	if self:Rand(2000) then
		self:CallOwnerSkill(SkillEffect[4700361], caster, target, data, 700300100+count701)
	end
end
function Skill4700301:tFunc_4700381_4700371(caster, target, data)
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
	-- 4700371
	if self:Rand(2000) then
		self:CallOwnerSkill(SkillEffect[4700371], caster, target, data, 700300100+count701)
	end
end
function Skill4700301:tFunc_4700341_4700311(caster, target, data)
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
	-- 4700311
	self:OwnerAddBuff(SkillEffect[4700311], caster, caster, data, 4700311)
end
function Skill4700301:tFunc_4700391_4700366(caster, target, data)
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
	-- 4700366
	self:AddTempAttr(SkillEffect[4700366], caster, target, data, "bedamage",0.3)
end
