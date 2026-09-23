-- 世界树手被动1
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill923700501 = oo.class(SkillBase)
function Skill923700501:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill923700501:DoSkill(caster, target, data)
	-- 12006
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12006], caster, target, data, 0.167,6)
end
-- 拉条时
function Skill923700501:OnAddProgress(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 923700501
	self:AddBuffCount(SkillEffect[923700501], caster, self.card, data, 923700501,1,10)
end
-- 行动结束
function Skill923700501:OnActionOver(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 923700502
	self:DelBufferTypeForce(SkillEffect[923700502], caster, self.card, data, 923700501,10)
end
