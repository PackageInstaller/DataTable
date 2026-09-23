-- 巨蟹座技能3
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill984110301 = oo.class(SkillBase)
function Skill984110301:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill984110301:DoSkill(caster, target, data)
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
	-- 984110301
	self.order = self.order + 1
	self:AddBuffCount(SkillEffect[984110301], caster, self.card, data, 984110301,1,10)
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
	-- 984110302
	self.order = self.order + 1
	self:AddProgress(SkillEffect[984110302], caster, self.card, data, 300)
end
