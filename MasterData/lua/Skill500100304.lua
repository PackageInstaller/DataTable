-- 数据剥离
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill500100304 = oo.class(SkillBase)
function Skill500100304:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill500100304:DoSkill(caster, target, data)
	-- 11004
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[11004], caster, target, data, 0.25,4)
	-- 500100301
	self.order = self.order + 1
	self:HitAddBuff(SkillEffect[500100301], caster, target, data, 10000,500100301)
	-- 500100302
	self.order = self.order + 1
	self:HitAddBuff(SkillEffect[500100302], caster, target, data, 10000,500100302)
end
-- 行动结束
function Skill500100304:OnActionOver(caster, target, data)
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
	-- 8474
	local count74 = SkillApi:GetAttr(self, caster, target,2,"sp")
	-- 500100303
	self:AddSp(SkillEffect[500100303], caster, target, data, -math.min(count74,20))
	-- 500100304
	self:AddSp(SkillEffect[500100304], caster, self.card, data, math.min(count74,20))
end
