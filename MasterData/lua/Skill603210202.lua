-- 赫格尼技能2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill603210202 = oo.class(SkillBase)
function Skill603210202:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill603210202:DoSkill(caster, target, data)
	-- 603210202
	self.order = self.order + 1
	self:AddSp(SkillEffect[603210202], caster, self.card, data, 50)
	-- 603210102
	self.order = self.order + 1
	self:OwnerAddBuffCount(SkillEffect[603210102], caster, self.card, data, 4603211,2,60)
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
	-- 603210211
	self.order = self.order + 1
	self:AlterBufferByGroup(SkillEffect[603210211], caster, self.card, data, 1,2)
end
