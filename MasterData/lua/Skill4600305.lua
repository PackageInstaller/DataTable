-- 恒长
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4600305 = oo.class(SkillBase)
function Skill4600305:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 驱散buff时
function Skill4600305:OnDelBuff(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4600322
	self:AddBuffCount(SkillEffect[4600322], caster, self.card, data, 4600312,1,5)
end
-- 伤害前
function Skill4600305:OnBefourHurt(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8415
	local count15 = SkillApi:BuffCount(self, caster, target,1,2,2)
	-- 8855
	if SkillJudger:Less(self, caster, target, true,count15,1) then
	else
		return
	end
	-- 4600324
	self:AddTempAttr(SkillEffect[4600324], caster, self.card, data, "damage",0.1)
end
-- 回合开始时
function Skill4600305:OnRoundBegin(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4600312
	self:DelBuffQuality(SkillEffect[4600312], caster, self.card, data, 2,2)
end
