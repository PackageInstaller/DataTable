-- 破空烈刃（OD）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill300111303 = oo.class(SkillBase)
function Skill300111303:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill300111303:DoSkill(caster, target, data)
	-- 300110301
	self.order = self.order + 1
	self:AddBuff(SkillEffect[300110301], caster, self.card, data, 300110301)
	-- 11009
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[11009], caster, target, data, 0.111,9)
end
