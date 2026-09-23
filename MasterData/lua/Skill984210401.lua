-- 狮子座狂暴形态技能4
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill984210401 = oo.class(SkillBase)
function Skill984210401:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill984210401:DoSkill(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 984210401
	self.order = self.order + 1
	self:AddBuff(SkillEffect[984210401], caster, self.card, data, 984210401)
end
