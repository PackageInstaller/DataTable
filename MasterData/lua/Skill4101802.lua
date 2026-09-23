-- 自我修复
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4101802 = oo.class(SkillBase)
function Skill4101802:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合开始时
function Skill4101802:OnRoundBegin(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8085
	if SkillJudger:CasterPercentHp(self, caster, target, false,0.4) then
	else
		return
	end
	-- 4101802
	self:Cure(SkillEffect[4101802], caster, self.card, data, 1,0.1)
	-- 4101806
	self:ShowTips(SkillEffect[4101806], caster, self.card, data, 2,"自我修复",true,4101806)
end
