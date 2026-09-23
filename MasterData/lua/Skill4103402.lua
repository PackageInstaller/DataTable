-- 乌鲁鲁
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4103402 = oo.class(SkillBase)
function Skill4103402:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害后
function Skill4103402:OnAfterHurt(caster, target, data)
	-- 8062
	if SkillJudger:CasterIsTeammate(self, caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 9764
	if SkillJudger:IsCrit(self, caster, target, false) then
	else
		return
	end
	-- 8978
	local count978 = SkillApi:BuffCount(self, caster, target,1,4,103400301)
	-- 8979
	local count979 = SkillApi:BuffCount(self, caster, target,1,4,103401301)
	-- 4103402
	self:OwnerAddBuffCount(SkillEffect[4103402], caster, caster, data, 4103402,1+count978+count979,30)
end
