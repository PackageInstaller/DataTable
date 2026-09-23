-- 护盾词条
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1000020150 = oo.class(SkillBase)
function Skill1000020150:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合结束时
function Skill1000020150:OnRoundOver(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 1000020150
	self:AddBuff(SkillEffect[1000020150], caster, self.card, data, 1000020151)
end
