-- 天赋效果307101
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill307101 = oo.class(SkillBase)
function Skill307101:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害后
function Skill307101:OnAfterHurt(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8213
	if SkillJudger:IsCrit(self, caster, target, true) then
	else
		return
	end
	-- 8201
	if SkillJudger:IsSingle(self, caster, target, true) then
	else
		return
	end
	-- 307101
	if self:Rand(1600) then
		self:AddBuff(SkillEffect[307101], caster, self.card, data, 4204)
	end
end
