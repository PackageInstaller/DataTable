-- 凝霜
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill601100202 = oo.class(SkillBase)
function Skill601100202:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill601100202:DoSkill(caster, target, data)
	-- 601100201
	self.order = self.order + 1
	self:AddBuffCount(SkillEffect[601100201], caster, self.card, data, 601100201,1,5)
	-- 601100202
	self.order = self.order + 1
	self:AddBuff(SkillEffect[601100202], caster, self.card, data, 601100202)
end
-- 行动结束
function Skill601100202:OnActionOver(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8200
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	-- 601100212
	self:AddProgress(SkillEffect[601100212], caster, self.card, data, 300)
end
