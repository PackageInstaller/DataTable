-- 消除I级
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill24001 = oo.class(SkillBase)
function Skill24001:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击开始
function Skill24001:OnAttackBegin(caster, target, data)
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
	-- 24001
	if self:Rand(3500) then
		self:DelBufferGroup(SkillEffect[24001], caster, target, data, 2,1,2)
	end
end
-- 驱散buff时
function Skill24001:OnDelBuff(caster, target, data)
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
	-- 240010
	self:ShowTips(SkillEffect[240010], caster, self.card, data, 2,"消除",true,240010)
end
