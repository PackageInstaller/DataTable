-- 适者生存
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill311102 = oo.class(SkillBase)
function Skill311102:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合开始时
function Skill311102:OnRoundBegin(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8085
	if SkillJudger:CasterPercentHp(self, caster, target, false,0.4) then
	else
		return
	end
	-- 311102
	if self:Rand(5000) then
		self:AddBuff(SkillEffect[311102], caster, self.card, data, 2102)
	end
end
