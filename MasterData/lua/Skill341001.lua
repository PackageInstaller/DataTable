-- 天丛云SP4
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill341001 = oo.class(SkillBase)
function Skill341001:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill341001:OnActionOver(caster, target, data)
	-- 8061
	if SkillJudger:CasterIsFriend(self, caster, target, true) then
	else
		return
	end
	-- 8229
	if SkillJudger:IsCasterMech(self, caster, self.card, true,1) then
	else
		return
	end
	-- 8267
	if SkillJudger:IsCtrlType(self, caster, target, true,13) then
	else
		return
	end
	-- 341001
	self:AddBuffCount(SkillEffect[341001], caster, caster, data, 341001,1,4)
end
-- 行动开始
function Skill341001:OnActionBegin(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8276
	if SkillJudger:IsTypeOf(self, caster, target, true,7) then
	else
		return
	end
	-- 8990
	local count990 = SkillApi:GetCount(self, caster, target,2,341001)
	-- 9730
	local count817 = SkillApi:GetAttr(self, caster, target,2,"defense")
	-- 341002
	self:AddTempAttrPercent(SkillEffect[341002], caster, self.card, data, "attack",(count990+1)*0.01*math.floor(count817/300))
end
