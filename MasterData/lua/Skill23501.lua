-- 光盾I级
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill23501 = oo.class(SkillBase)
function Skill23501:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 特殊入场时(复活，召唤，合体)
function Skill23501:OnBornSpecial(caster, target, data)
	-- 8166
	if SkillJudger:CasterIsOwnSummon(self, caster, target, true) then
	else
		return
	end
	-- 23501
	self:AddBuff(SkillEffect[23501], caster, caster, data, 23401)
	-- 235010
	self:ShowTips(SkillEffect[235010], caster, self.card, data, 2,"神速",true,235010)
end
