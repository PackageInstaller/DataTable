-- 特性：界限突破
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4800604 = oo.class(SkillBase)
function Skill4800604:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill4800604:OnActionOver(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4800604
	self:AddUplimitBuff(SkillEffect[4800604], caster, self.card, data, 3,3,4800601,5,4800601)
end
