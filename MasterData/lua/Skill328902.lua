-- 卡提那天赋4
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill328902 = oo.class(SkillBase)
function Skill328902:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 驱散buff时
function Skill328902:OnDelBuff(caster, target, data)
	-- 8647
	local count647 = SkillApi:GetCount(self, caster, target,3,4600901)
	-- 8847
	if SkillJudger:Greater(self, caster, target, true,count647,7) then
	else
		return
	end
	-- 328902
	self:AddBuffCount(SkillEffect[328902], caster, self.card, data, 328902,1,5)
end
