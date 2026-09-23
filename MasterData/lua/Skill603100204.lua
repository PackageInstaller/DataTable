-- 提泽纳2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill603100204 = oo.class(SkillBase)
function Skill603100204:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill603100204:DoSkill(caster, target, data)
	-- 12003
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12003], caster, target, data, 0.333,3)
end
-- 回合开始时
function Skill603100204:OnRoundBegin(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 603100203
	self:DelBuffQuality(SkillEffect[603100203], caster, self.card, data, 2,3)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8721
	local count721 = SkillApi:SkillLevel(self, caster, target,3,6031002)
	-- 603100204
	local targets = SkillFilter:MinPercentHp(self, caster, target, 1,"hp",1)
	for i,target in ipairs(targets) do
		self:CallOwnerSkill(SkillEffect[603100204], caster, target, data, 603100500+count721)
	end
end
