--  袅韵1
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill202300103 = oo.class(SkillBase)
function Skill202300103:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill202300103:DoSkill(caster, target, data)
	-- 12001
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12001], caster, target, data, 1,1)
end
-- 伤害前
function Skill202300103:OnBefourHurt(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8449
	local count49 = SkillApi:GetAttr(self, caster, target,3,"maxhp")
	-- 8200
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	-- 8676
	local count676 = SkillApi:BuffCount(self, caster, target,3,4,4202301)
	-- 8888
	if SkillJudger:Greater(self, caster, self.card, true,count676,0) then
	else
		return
	end
	-- 202300101
	self:AddTempAttr(SkillEffect[202300101], caster, self.card, data, "attack",count49*0.1)
end
