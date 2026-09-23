-- 形态切换
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill700510401 = oo.class(SkillBase)
function Skill700510401:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill700510401:DoSkill(caster, target, data)
	-- 90011
	self.order = self.order + 1
	self:Transform(SkillEffect[90011], caster, target, data, {progress=1010})
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
	-- 95001
	self.order = self.order + 1
	self:AlterBufferByGroup(SkillEffect[95001], caster, self.card, data, 1,1)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 907200202
	self.order = self.order + 1
	self:AddBuff(SkillEffect[907200202], caster, self.card, data, 907100202)
end
