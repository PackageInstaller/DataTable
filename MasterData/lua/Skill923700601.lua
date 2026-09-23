-- 世界树手高倍率技能1
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill923700601 = oo.class(SkillBase)
function Skill923700601:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill923700601:DoSkill(caster, target, data)
	-- 12001
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12001], caster, target, data, 1,1)
end
-- 行动结束
function Skill923700601:OnActionOver(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8200
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	-- 8467
	local count67 = SkillApi:GetAttr(self, caster, target,2,"hp")
	-- 923700601
	self:AddHp(SkillEffect[923700601], caster, target, data, math.floor(-count67*0.6))
end
