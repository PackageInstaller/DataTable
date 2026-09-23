-- 凝霜
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill602800403 = oo.class(SkillBase)
function Skill602800403:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill602800403:DoSkill(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 602800203
	self.order = self.order + 1
	self:AddBuffCount(SkillEffect[602800203], caster, self.card, data, 602800203,1,8)
	-- 602800206
	self.order = self.order + 1
	self:AddBuffCount(SkillEffect[602800206], caster, self.card, data, 602800206,1,8)
end
