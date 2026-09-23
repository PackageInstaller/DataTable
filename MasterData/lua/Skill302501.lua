-- 天赋效果302501
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill302501 = oo.class(SkillBase)
function Skill302501:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill302501:OnBefourHurt(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8422
	local count22 = SkillApi:BuffCount(self, caster, target,1,4,650)
	-- 302501
	self:AddTempAttr(SkillEffect[302501], caster, self.card, data, "damage",count22*0.06)
end
