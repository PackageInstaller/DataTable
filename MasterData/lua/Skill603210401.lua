-- 形态切换
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill603210401 = oo.class(SkillBase)
function Skill603210401:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill603210401:DoSkill(caster, target, data)
	-- 90012
	self.order = self.order + 1
	self:Transform(SkillEffect[90012], caster, target, data, {progress=1010})
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4603213
	self.order = self.order + 1
	self:AddBuff(SkillEffect[4603213], caster, self.card, data, 603210401)
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
end
