-- 无限血boss无限血机制 25操作
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1100070059 = oo.class(SkillBase)
function Skill1100070059:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 战斗开始
function Skill1100070059:OnStart(caster, target, data)
	-- 1100070059
	self:SetInvincible(SkillEffect[1100070059], caster, target, data, 1,1,9999999999,25)
end
