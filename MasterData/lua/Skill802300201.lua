-- 祝福
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill802300201 = oo.class(SkillBase)
function Skill802300201:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill802300201:DoSkill(caster, target, data)
	-- 802300201
	self.order = self.order + 1
	self:DelBuffQuality(SkillEffect[802300201], caster, target, data, 2,10)
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
	-- 802300202
	self.order = self.order + 1
	self:AddBuff(SkillEffect[802300202], caster, target, data, 802300202,2)
end
