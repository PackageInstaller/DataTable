-- 装填III级
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill22503 = oo.class(SkillBase)
function Skill22503:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill22503:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 22503
	self:AddNp(SkillEffect[22503], caster, self.card, data, 20)
	-- 225010
	self:ShowTips(SkillEffect[225010], caster, self.card, data, 2,"装填",true,225010)
end
