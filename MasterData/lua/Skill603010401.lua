-- 莫拉鲁塔合体
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill603010401 = oo.class(SkillBase)
function Skill603010401:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 解体时
function Skill603010401:OnResolve(caster, target, data)
	-- 8735
	local count735 = SkillApi:SkillLevel(self, caster, target,3,6030102)
	-- 603010401
	self:CallSkill(SkillEffect[603010401], caster, self.card, data, 603010200+count735)
end
