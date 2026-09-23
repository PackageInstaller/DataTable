-- 怒潮潜抑(无限血)
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill922800702 = oo.class(SkillBase)
function Skill922800702:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill922800702:OnActionOver(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 922800702
	self:AddBuffCount(SkillEffect[922800702], caster, self.card, data, 922800702,1,40)
end
