-- 无视防御
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill323303 = oo.class(SkillBase)
function Skill323303:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill323303:OnBefourHurt(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8608
	local count608 = SkillApi:BuffCount(self, caster, target,3,4,600700301)
	-- 8804
	if SkillJudger:Greater(self, caster, target, true,count608,0) then
	else
		return
	end
	-- 8219
	if SkillJudger:IsUltimate(self, caster, target, true) then
	else
		return
	end
	-- 323303
	if self:Rand(900) then
		self:AddTempAttrPercent(SkillEffect[323303], caster, target, data, "defense",-1)
	end
end
