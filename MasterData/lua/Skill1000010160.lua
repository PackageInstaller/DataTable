-- 加速词条
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1000010160 = oo.class(SkillBase)
function Skill1000010160:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 驱散buff时
function Skill1000010160:OnDelBuff(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 1000010160
	self:AddBuff(SkillEffect[1000010160], caster, self.card, data, 1000010161,3)
end
