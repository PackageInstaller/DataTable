-- 音符
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill327405 = oo.class(SkillBase)
function Skill327405:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合开始时
function Skill327405:OnRoundBegin(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 327405
	if self:Rand(10000) then
		self:AddBuff(SkillEffect[327405], caster, self.card, data, 200800101)
	end
end
