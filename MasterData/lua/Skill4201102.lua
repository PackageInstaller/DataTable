-- 音阶
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4201102 = oo.class(SkillBase)
function Skill4201102:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击开始
function Skill4201102:OnAttackBegin(caster, target, data)
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
	-- 4201104
	self:AddBuff(SkillEffect[4201104], caster, caster, data, 4201101)
end
-- 攻击结束
function Skill4201102:OnAttackOver(caster, target, data)
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
	-- 4201102
	if self:Rand(5000) then
		self:AddProgress(SkillEffect[4201102], caster, self.card, data, 200)
	end
end
