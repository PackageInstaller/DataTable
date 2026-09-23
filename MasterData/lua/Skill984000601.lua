-- 双子宫
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill984000601 = oo.class(SkillBase)
function Skill984000601:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合开始处理完成后
function Skill984000601:OnAfterRoundBegin(caster, target, data)
	-- 8580
	local count101 = SkillApi:BuffCount(self, caster, target,1,2,2)
	-- 984000604
	if SkillJudger:Greater(self, caster, target, true,count101,4) then
	else
		return
	end
	-- 984000601
	self:AddBuff(SkillEffect[984000601], caster, self.card, data, 984000602)
	-- 984000602
	self:CallOwnerSkill(SkillEffect[984000602], caster, self.card, data, 984000301)
end
