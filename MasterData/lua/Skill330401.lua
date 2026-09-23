-- 啊图姆天赋4
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill330401 = oo.class(SkillBase)
function Skill330401:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合开始处理完成后
function Skill330401:OnAfterRoundBegin(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 330401
	if self:Rand(2000) then
		local r = self.card:Rand(3)+1
		if 1 == r then
			-- 330411
			self:OwnerAddBuff(SkillEffect[330411], caster, self.card, data, 330401,1)
		elseif 2 == r then
			-- 330412
			self:OwnerAddBuff(SkillEffect[330412], caster, self.card, data, 330402,1)
			-- 330414
			self:OwnerAddBuff(SkillEffect[330414], caster, self.card, data, 330404)
		elseif 3 == r then
			-- 330413
			self:OwnerAddBuff(SkillEffect[330413], caster, self.card, data, 330403,1)
		end
	end
end
