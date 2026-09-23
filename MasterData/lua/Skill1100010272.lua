-- 自身传送机神机动+30，效果命中+30%，SP+30
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1100010272 = oo.class(SkillBase)
function Skill1100010272:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 特殊入场时(复活，召唤，合体)
function Skill1100010272:OnBornSpecial(caster, target, data)
	-- 8166
	if SkillJudger:CasterIsOwnSummon(self, caster, target, true) then
	else
		return
	end
	-- 1100010272
	self:AddBuff(SkillEffect[1100010272], caster, caster, data, 1100010272)
end
