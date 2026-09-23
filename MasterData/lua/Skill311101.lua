-- 适者生存
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill311101 = oo.class(SkillBase)
function Skill311101:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合开始时
function Skill311101:OnRoundBegin(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8084
	if SkillJudger:CasterPercentHp(self, caster, target, false,0.3) then
	else
		return
	end
	-- 311101
	if self:Rand(5000) then
		self:AddBuff(SkillEffect[311101], caster, self.card, data, 2102)
	end
end
