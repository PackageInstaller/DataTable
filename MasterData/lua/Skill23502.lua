-- 光盾II级
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill23502 = oo.class(SkillBase)
function Skill23502:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 特殊入场时(复活，召唤，合体)
function Skill23502:OnBornSpecial(caster, target, data)
	-- 8166
	if SkillJudger:CasterIsOwnSummon(self, caster, target, true) then
	else
		return
	end
	-- 23502
	self:AddBuff(SkillEffect[23502], caster, caster, data, 23402)
	-- 235010
	self:ShowTips(SkillEffect[235010], caster, self.card, data, 2,"神速",true,235010)
end
