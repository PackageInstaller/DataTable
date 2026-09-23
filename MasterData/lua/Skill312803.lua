-- 排击护盾
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill312803 = oo.class(SkillBase)
function Skill312803:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill312803:OnBefourHurt(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8071
	if SkillJudger:TargetIsFriend(self, caster, target, true) then
	else
		return
	end
	-- 8444
	local count44 = SkillApi:BuffCount(self, caster, target,2,4,3)
	-- 8125
	if SkillJudger:Greater(self, caster, self.card, true,count44,0) then
	else
		return
	end
	-- 312803
	self:AddTempAttr(SkillEffect[312803], caster, caster, data, "damage",-0.09)
end
