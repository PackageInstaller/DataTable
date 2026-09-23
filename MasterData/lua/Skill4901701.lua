-- 迅捷特性
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4901701 = oo.class(SkillBase)
function Skill4901701:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合结束时
function Skill4901701:OnRoundOver(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 21501
	if self:Rand(3500) then
		self:AddProgress(SkillEffect[21501], caster, self.card, data, 200)
		-- 215010
		self:ShowTips(SkillEffect[215010], caster, self.card, data, 2,"灵巧",true,215010)
	end
end
