-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill100101310 = oo.class(SkillBase)
function Skill100101310:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill100101310:DoSkill(caster, target, data)
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12004], caster, target, data, 0.25,4)
end
-- 行动结束
function Skill100101310:OnActionOver(caster, target, data)
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	local count53 = SkillApi:SkillLevel(self, caster, target,3,41001)
	local count71 = SkillApi:BuffCount(self, caster, target,3,4,640)
	if SkillJudger:Less(self, caster, target, true,count71,5) then
	else
		return
	end
	self:AddBuff(SkillEffect[4100101], caster, self.card, data, 6400+count53)
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	local count53 = SkillApi:SkillLevel(self, caster, target,3,41001)
	local count71 = SkillApi:BuffCount(self, caster, target,3,4,640)
	if SkillJudger:Less(self, caster, target, true,count71,5) then
	else
		return
	end
	self:AddBuff(SkillEffect[4100101], caster, self.card, data, 6400+count53)
end
