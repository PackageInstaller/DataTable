-- 溯源探查第二期ex新增技能5
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill5500005 = oo.class(SkillBase)
function Skill5500005:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害后
function Skill5500005:OnAfterHurt(caster, target, data)
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
	-- 8213
	if SkillJudger:IsCrit(self, caster, target, true) then
	else
		return
	end
	-- 5500005
	self:AddBuffCount(SkillEffect[5500005], caster, self.card, data, 603010106,1,20)
end
