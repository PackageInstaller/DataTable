-- 防护领域
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill601900201 = oo.class(SkillBase)
function Skill601900201:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill601900201:DoSkill(caster, target, data)
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
	-- 601900201
	self.order = self.order + 1
	self:AddBuff(SkillEffect[601900201], caster, target, data, 4603,2)
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
	-- 601900211
	self.order = self.order + 1
	self:AddBuff(SkillEffect[601900211], caster, target, data, 4903,2)
end
-- 回合结束时
function Skill601900201:OnRoundOver(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8484
	local count84 = SkillApi:BuffCount(self, caster, target,3,3,601900301)
	-- 8175
	if SkillJudger:Less(self, caster, target, true,count84,1) then
	else
		return
	end
	-- 601900402
	self:ChangeSkill(SkillEffect[601900402], caster, target, data, 3,601900301)
end
