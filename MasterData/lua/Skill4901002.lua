-- 击退免疫
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4901002 = oo.class(SkillBase)
function Skill4901002:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合开始时
function Skill4901002:OnRoundBegin(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 305902
	if self:Rand(2000) then
		self:AddBuff(SkillEffect[305902], caster, self.card, data, 6107,1)
	end
end
