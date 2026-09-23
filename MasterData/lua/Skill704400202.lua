-- 朝晖技能2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill704400202 = oo.class(SkillBase)
function Skill704400202:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill704400202:OnActionOver(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 704400202
	if self:Rand(1500) then
		self:OwnerAddBuffCount(SkillEffect[704400202], caster, self.card, data, 704400101,1,6)
	end
end
