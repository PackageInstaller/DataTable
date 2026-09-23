-- 音阶
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4201105 = oo.class(SkillBase)
function Skill4201105:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击开始
function Skill4201105:OnAttackBegin(caster, target, data)
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
	-- 4201106
	self:AddBuff(SkillEffect[4201106], caster, caster, data, 4201103)
end
-- 攻击结束
function Skill4201105:OnAttackOver(caster, target, data)
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
	-- 4201103
	if self:Rand(6000) then
		self:AddProgress(SkillEffect[4201103], caster, self.card, data, 200)
	end
end
