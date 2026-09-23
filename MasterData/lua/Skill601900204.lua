-- 防护领域
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill601900204 = oo.class(SkillBase)
function Skill601900204:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill601900204:DoSkill(caster, target, data)
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
	-- 601900204
	self.order = self.order + 1
	self:AddBuff(SkillEffect[601900204], caster, target, data, 4605,2)
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
	-- 601900214
	self.order = self.order + 1
	self:AddBuff(SkillEffect[601900214], caster, target, data, 4905,2)
end
-- 回合结束时
function Skill601900204:OnRoundOver(caster, target, data)
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
