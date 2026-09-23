-- 抵御反击
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill932700401 = oo.class(SkillBase)
function Skill932700401:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill932700401:DoSkill(caster, target, data)
	-- 12001
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12001], caster, target, data, 1,1)
end
-- 入场时
function Skill932700401:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 932700401
	self:AddBuff(SkillEffect[932700401], caster, self.card, data, 932700404)
end
-- 攻击结束
function Skill932700401:OnAttackOver(caster, target, data)
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
	-- 932700404
	self:AddBuff(SkillEffect[932700404], caster, self.card, data, 932700405)
end
-- 行动结束2
function Skill932700401:OnActionOver2(caster, target, data)
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
	-- 932700406
	if self:Rand(3500) then
		self:BeatBack(SkillEffect[932700406], caster, target, data, 932700501)
	end
end
