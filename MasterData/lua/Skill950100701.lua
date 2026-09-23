-- 怪物被动：减少伤害50%，召唤怪物call3技能
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill950100701 = oo.class(SkillBase)
function Skill950100701:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill950100701:OnBefourHurt(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8476
	local count76 = SkillApi:LiveCount(self, caster, target,3)
	-- 8892
	if SkillJudger:Greater(self, caster, target, true,count76,1) then
	else
		return
	end
	-- 950100701
	self:AddBuff(SkillEffect[950100701], caster, self.card, data, 950100701)
end
-- 行动开始
function Skill950100701:OnActionBegin(caster, target, data)
	-- 8476
	local count76 = SkillApi:LiveCount(self, caster, target,3)
	-- 8904
	if SkillJudger:LessEqual(self, caster, target, true,count76,3) then
	else
		return
	end
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 93002
	if SkillJudger:CheckCD(self, caster, target, false) then
	else
		return
	end
	-- 950100703
	self:CallSkill(SkillEffect[950100703], caster, target, data, 950100301)
	-- 93001
	self:ResetCD(SkillEffect[93001], caster, target, data, 2)
end
