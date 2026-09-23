-- 瑞泽2技能
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill100700203 = oo.class(SkillBase)
function Skill100700203:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill100700203:DoSkill(caster, target, data)
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
	-- 100700101
	self.order = self.order + 1
	self:AddBuffCount(SkillEffect[100700101], caster, self.card, data, 100700101,1,8)
	-- 100700203
	self.order = self.order + 1
	self:AddBuff(SkillEffect[100700203], caster, target, data, 100700203)
end
