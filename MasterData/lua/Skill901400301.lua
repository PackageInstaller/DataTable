-- 能量光盾
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill901400301 = oo.class(SkillBase)
function Skill901400301:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill901400301:DoSkill(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 901400301
	self.order = self.order + 1
	self:AddLightShieldCount(SkillEffect[901400301], caster, target, data, 2309,3,10)
end
