-- 能量光盾
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill901400201 = oo.class(SkillBase)
function Skill901400201:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill901400201:DoSkill(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 901400201
	self.order = self.order + 1
	self:AddLightShieldCount(SkillEffect[901400201], caster, target, data, 2309,2,10)
end
