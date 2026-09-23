-- 超级重伤
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill326203 = oo.class(SkillBase)
function Skill326203:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill326203:OnBefourHurt(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8214
	if SkillJudger:IsTypeOf(self, caster, target, true,2) then
	else
		return
	end
	-- 8429
	local count29 = SkillApi:BuffCount(self, caster, target,2,3,1003)
	-- 8112
	if SkillJudger:Greater(self, caster, self.card, true,count29,0) then
	else
		return
	end
	-- 326203
	self:AddTempAttr(SkillEffect[326203], caster, self.card, data, "damage",0.3)
end
