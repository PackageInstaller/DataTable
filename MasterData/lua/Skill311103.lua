-- 适者生存
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill311103 = oo.class(SkillBase)
function Skill311103:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合开始时
function Skill311103:OnRoundBegin(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8086
	if SkillJudger:CasterPercentHp(self, caster, target, false,0.5) then
	else
		return
	end
	-- 311103
	if self:Rand(5000) then
		self:AddBuff(SkillEffect[311103], caster, self.card, data, 2102)
	end
end
