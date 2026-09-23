-- 坍缩炸弹
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill404000304 = oo.class(SkillBase)
function Skill404000304:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill404000304:DoSkill(caster, target, data)
	-- 12004
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12004], caster, target, data, 0.25,4)
end
-- 伤害前
function Skill404000304:OnBefourHurt(caster, target, data)
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
	-- 404000302
	if self:Rand(2500) then
		self:AddProgress(SkillEffect[404000302], caster, target, data, -250)
		-- 404000304
		self:DelBufferGroup(SkillEffect[404000304], caster, target, data, 2,1)
	end
end
-- 攻击结束
function Skill404000304:OnAttackOver(caster, target, data)
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
	-- 999999983
	self:AddNp(SkillEffect[999999983], caster, self.card, data, 10)
end
