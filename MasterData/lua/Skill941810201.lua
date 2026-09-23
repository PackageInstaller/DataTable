-- 朝晖技能2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill941810201 = oo.class(SkillBase)
function Skill941810201:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill941810201:OnActionOver(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 704400205
	if self:Rand(3000) then
		self:OwnerAddBuffCount(SkillEffect[704400205], caster, self.card, data, 704400101,1,6)
	end
end
