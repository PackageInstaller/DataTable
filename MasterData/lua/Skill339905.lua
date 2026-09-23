-- 皮洛可2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill339905 = oo.class(SkillBase)
function Skill339905:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill339905:OnBefourHurt(caster, target, data)
	-- 8062
	if SkillJudger:CasterIsTeammate(self, caster, target, true) then
	else
		return
	end
	-- 8777
	local count777 = SkillApi:SkillLevel(self, caster, target,3,42003)
	-- 8783
	local count783 = SkillApi:GetCount(self, caster, target,2,4200305+count777)
	-- 339906
	if SkillJudger:Greater(self, caster, target, true,count783,9) then
	else
		return
	end
	-- 339905
	self:AddTempAttr(SkillEffect[339905], caster, caster, data, "damage",0.2)
end
