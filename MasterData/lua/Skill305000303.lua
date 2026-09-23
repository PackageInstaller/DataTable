-- SP昆仑3
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill305000303 = oo.class(SkillBase)
function Skill305000303:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill305000303:DoSkill(caster, target, data)
	-- 305000303
	self.order = self.order + 1
	self:AddBuff(SkillEffect[305000303], caster, self.card, data, 305000303)
	-- 305000313
	self.order = self.order + 1
	self:AddBuff(SkillEffect[305000313], caster, self.card, data, 305000313)
	-- 305000310
	self.order = self.order + 1
	self:ChangeSkill(SkillEffect[305000310], caster, self.card, data, 3,305000401)
	-- 305000213
	self.order = self.order + 1
	self:AddFury(SkillEffect[305000213], caster, self.card, data, 20,100)
end
