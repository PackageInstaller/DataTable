-- 恒长
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4600302 = oo.class(SkillBase)
function Skill4600302:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 驱散buff时
function Skill4600302:OnDelBuff(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4600321
	self:AddBuffCount(SkillEffect[4600321], caster, self.card, data, 4600311,1,5)
end
-- 伤害前
function Skill4600302:OnBefourHurt(caster, target, data)
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
	-- 4600323
	self:AddTempAttr(SkillEffect[4600323], caster, self.card, data, "damage",0.05)
end
-- 回合开始时
function Skill4600302:OnRoundBegin(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4600311
	self:DelBuffQuality(SkillEffect[4600311], caster, self.card, data, 2,1)
end
