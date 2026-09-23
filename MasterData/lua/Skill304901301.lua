-- 赤溟3（OD）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill304901301 = oo.class(SkillBase)
function Skill304901301:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill304901301:DoSkill(caster, target, data)
	-- 11006
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[11006], caster, target, data, 0.167,6)
	-- 12002
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12002], caster, target, data, 0.5,2)
end
-- 行动开始
function Skill304901301:OnActionBegin(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8200
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	-- 304900301
	self:AddBuff(SkillEffect[304900301], caster, self.card, data, 304900301)
end
-- 暴击伤害前(OnBefourHurt之前)
function Skill304901301:OnBefourCritHurt(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8200
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	-- 8620
	local count620 = SkillApi:GetAttr(self, caster, target,3,"hit")
	-- 8900
	if SkillJudger:Greater(self, caster, target, true,count620,0.5) then
	else
		return
	end
	-- 304900307
	self:AddTempAttr(SkillEffect[304900307], caster, self.card, data, "crit",0.5)
end
