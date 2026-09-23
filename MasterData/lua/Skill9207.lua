-- 能量屏障
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill9207 = oo.class(SkillBase)
function Skill9207:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill9207:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 9207
	self:AddLightShieldCount(SkillEffect[9207], caster, self.card, data, 2309,7,10)
end
