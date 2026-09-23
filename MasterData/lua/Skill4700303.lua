-- 水能
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4700303 = oo.class(SkillBase)
function Skill4700303:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击结束
function Skill4700303:OnAttackOver(caster, target, data)
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
	-- 4700303
	self:AddBuff(SkillEffect[4700303], caster, self.card, data, 6503)
	-- 4700306
	self:ShowTips(SkillEffect[4700306], caster, self.card, data, 2,"水能",true,4700306)
end
-- 行动开始
function Skill4700303:OnActionBegin(caster, target, data)
	-- 4700343
	self:tFunc_4700343_4700313(caster, target, data)
	self:tFunc_4700343_4700323(caster, target, data)
	self:tFunc_4700343_4700333(caster, target, data)
end
-- 行动结束
function Skill4700303:OnActionOver(caster, target, data)
	-- 4700383
	self:tFunc_4700383_4700353(caster, target, data)
	self:tFunc_4700383_4700363(caster, target, data)
	self:tFunc_4700383_4700373(caster, target, data)
end
-- 伤害前
function Skill4700303:OnBefourHurt(caster, target, data)
	-- 4700393
	self:tFunc_4700393_4700368(caster, target, data)
	self:tFunc_4700393_4700378(caster, target, data)
	self:tFunc_4700393_4700388(caster, target, data)
end
function Skill4700303:tFunc_4700383_4700363(caster, target, data)
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
	-- 4700363
	if self:Rand(4000) then
		self:CallOwnerSkill(SkillEffect[4700363], caster, target, data, 700300100+count701)
	end
end
function Skill4700303:tFunc_4700383_4700353(caster, target, data)
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
	-- 4700353
	if self:Rand(4000) then
		self:CallOwnerSkill(SkillEffect[4700353], caster, target, data, 700300100+count701)
	end
end
function Skill4700303:tFunc_4700343_4700333(caster, target, data)
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
	-- 4700333
	self:OwnerAddBuff(SkillEffect[4700333], caster, caster, data, 4700313)
end
function Skill4700303:tFunc_4700383_4700373(caster, target, data)
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
	-- 4700373
	if self:Rand(4000) then
		self:CallOwnerSkill(SkillEffect[4700373], caster, target, data, 700300100+count701)
	end
end
function Skill4700303:tFunc_4700393_4700388(caster, target, data)
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
	-- 4700388
	self:AddTempAttr(SkillEffect[4700388], caster, target, data, "bedamage",0.18)
end
function Skill4700303:tFunc_4700393_4700368(caster, target, data)
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
	-- 4700368
	self:AddTempAttr(SkillEffect[4700368], caster, target, data, "bedamage",0.9)
end
function Skill4700303:tFunc_4700343_4700313(caster, target, data)
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
	-- 4700313
	self:OwnerAddBuff(SkillEffect[4700313], caster, caster, data, 4700313)
end
function Skill4700303:tFunc_4700343_4700323(caster, target, data)
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
	-- 4700323
	self:OwnerAddBuff(SkillEffect[4700323], caster, caster, data, 4700313)
end
function Skill4700303:tFunc_4700393_4700378(caster, target, data)
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
	-- 4700378
	self:AddTempAttr(SkillEffect[4700378], caster, target, data, "bedamage",0.36)
end
