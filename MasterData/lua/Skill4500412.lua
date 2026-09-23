-- 翎羽
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4500412 = oo.class(SkillBase)
function Skill4500412:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 特殊入场时(复活，召唤，合体)
function Skill4500412:OnBornSpecial(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4500416
	self:CallSkill(SkillEffect[4500416], caster, self.card, data, 500410401)
end
-- 回合开始处理完成后
function Skill4500412:OnAfterRoundBegin(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 4500412
	if self:Rand(7000) then
		self:OwnerAddBuff(SkillEffect[4500412], caster, caster, data, 4500402)
	end
end
-- 解体时
function Skill4500412:OnResolve(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4500417
	self:CallSkill(SkillEffect[4500417], caster, self.card, data, 500410501)
end
