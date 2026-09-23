-- 音符指针
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill200700101 = oo.class(SkillBase)
function Skill200700101:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill200700101:DoSkill(caster, target, data)
	-- 12001
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12001], caster, target, data, 1,1)
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
	-- 200700401
	self.order = self.order + 1
	self:AddBuff(SkillEffect[200700401], caster, self.card, data, 200700102)
	-- 8449
	local count49 = SkillApi:GetAttr(self, caster, target,3,"maxhp")
	-- 200700101
	self.order = self.order + 1
	self:AddEnergy(SkillEffect[200700101], caster, self.card, data, count49*0.1,1)
end
