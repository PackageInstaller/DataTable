-- 协同防御
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill318103 = oo.class(SkillBase)
function Skill318103:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill318103:OnBefourHurt(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8072
	if SkillJudger:TargetIsTeammate(self, caster, target, true) then
	else
		return
	end
	-- 8222
	if SkillJudger:IsDamageType(self, caster, target, true,1) then
	else
		return
	end
	-- 318103
	self:AddTempAttr(SkillEffect[318103], caster, caster, data, "damage",-0.16)
end
