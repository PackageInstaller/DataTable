-- 盾斧排击
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill950900201 = oo.class(SkillBase)
function Skill950900201:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill950900201:DoSkill(caster, target, data)
	-- 3001
	self.order = self.order + 1
	self:HitAddBuff(SkillEffect[3001], caster, target, data, 10000,3001)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 9204
	self.order = self.order + 1
	self:AddLightShieldCount(SkillEffect[9204], caster, self.card, data, 2309,4,10)
end
