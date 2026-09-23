-- 锋芒毕露
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4300103 = oo.class(SkillBase)
function Skill4300103:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill4300103:OnBefourHurt(caster, target, data)
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
	-- 8406
	local count6 = SkillApi:PercentHp(self, caster, target,2)
	-- 4300103
	self:AddTempAttr(SkillEffect[4300103], caster, self.card, data, "damage",math.min((1-count6)*0.4,0.4))
	-- 4300106
	self:ShowTips(SkillEffect[4300106], caster, self.card, data, 2,"锋芒毕露",true,4300106)
end
