-- 奥西里斯3(OD)
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill780501303 = oo.class(SkillBase)
function Skill780501303:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill780501303:DoSkill(caster, target, data)
	-- 12006
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12006], caster, target, data, 0.167,6)
end
-- 行动结束
function Skill780501303:OnActionOver(caster, target, data)
	-- 8200
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	-- 8965
	if SkillJudger:IsCallSkill(self, caster, target, false) then
	else
		return
	end
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
	-- 780501308
	self:AddBuff(SkillEffect[780501308], caster, target, data, 780500303)
	-- 8794
	local count794 = SkillApi:BuffCount(self, caster, target,2,4,780500301)
	-- 780500317
	if SkillJudger:Greater(self, caster, target, true,count794,0) then
	else
		return
	end
	-- 780501316
	self:AddProgress(SkillEffect[780501316], caster, target, data, 1000)
	-- 780501317
	self:AddBuff(SkillEffect[780501317], caster, target, data, 780501301)
end
-- 伤害后
function Skill780501303:OnAfterHurt(caster, target, data)
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
	-- 8261
	if SkillJudger:IsCallSkill(self, caster, target, true) then
	else
		return
	end
	-- 780500358
	self:LimitDamage(SkillEffect[780500358], caster, target, data, 0.05,1.2)
end
