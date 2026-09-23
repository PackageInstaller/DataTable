-- 特殊涂层
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill910600702 = oo.class(SkillBase)
function Skill910600702:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合开始时
function Skill910600702:OnRoundBegin(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 910600702
	self:DelBufferGroup(SkillEffect[910600702], caster, self.card, data, 3,5)
end
