-- 剑境
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill600200405 = oo.class(SkillBase)
function Skill600200405:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill600200405:DoSkill(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8624
	local count624 = SkillApi:SkillLevel(self, caster, target,3,3263)
	-- 4600203
	self.order = self.order + 1
	self:AddBuff(SkillEffect[4600203], caster, target, data, 4600203,math.ceil(3+count624/2))
end
