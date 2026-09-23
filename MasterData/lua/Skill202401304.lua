-- 皮奥维利奇（OD）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill202401304 = oo.class(SkillBase)
function Skill202401304:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill202401304:DoSkill(caster, target, data)
	-- 202400304
	self.order = self.order + 1
	self:AddBuff(SkillEffect[202400304], caster, target, data, 202400303)
	-- 202400307
	self.order = self.order + 1
	self:Cure(SkillEffect[202400307], caster, target, data, 2,0.15)
	-- 202400309
	self.order = self.order + 1
	self:AddProgress(SkillEffect[202400309], caster, target, data, 1010)
	-- 202401301
	self.order = self.order + 1
	self:AddBuff(SkillEffect[202401301], caster, target, data, 402901301)
end
