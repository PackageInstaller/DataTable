-- 溯源探查ex技能7
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1100070087 = oo.class(SkillBase)
function Skill1100070087:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合开始处理完成后
function Skill1100070087:OnAfterRoundBegin(caster, target, data)
	-- 8580
	local count101 = SkillApi:BuffCount(self, caster, target,1,2,2)
	-- 984000604
	if SkillJudger:Greater(self, caster, target, true,count101,4) then
	else
		return
	end
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 1100070088
	self:AddBuff(SkillEffect[1100070088], caster, self.card, data, 1100080020)
	-- 1100070089
	self:DelBuffQuality(SkillEffect[1100070089], caster, self.card, data, 2,3)
end
