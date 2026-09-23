-- 暴虐被动技能2（反击伤害效果）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill980110701 = oo.class(SkillBase)
function Skill980110701:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill980110701:OnBefourHurt(caster, target, data)
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
	-- 8244
	if SkillJudger:IsBeatBack(self, caster, target, true) then
	else
		return
	end
	-- 980110701
	self:AddTempAttr(SkillEffect[980110701], caster, self.card, data, "bedamage",0.5)
end
-- 加buff时
function Skill980110701:OnAddBuff(caster, target, data, buffer)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 980110706
	if SkillJudger:IsCtrlBuffType(buffer or self, caster, target, true,3) then
	else
		return
	end
	-- 980110702
	self:AddBuffCount(SkillEffect[980110702], caster, self.card, data, 980110702,1,6)
end
-- 行动结束2
function Skill980110701:OnActionOver2(caster, target, data)
	-- 980110705
	local count980110702 = SkillApi:GetCount(self, caster, target,3,980110702)
	-- 980110704
	if SkillJudger:GreaterEqual(self, caster, target, true,count980110702,6) then
	else
		return
	end
	-- 980110703
	self:AddBuffCount(SkillEffect[980110703], caster, self.card, data, 980110702,-6,6)
	-- 980100720
	self:AddBuff(SkillEffect[980100720], caster, self.card, data, 980100720,1)
	-- 980100723
	self:AlterBufferByGroup(SkillEffect[980100723], caster, self.card, data, 2,1)
	-- 980100721
	self:AddProgress(SkillEffect[980100721], caster, self.card, data, 1020)
end
