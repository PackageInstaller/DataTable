-- SP昆仑4
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill337202 = oo.class(SkillBase)
function Skill337202:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill337202:OnBefourHurt(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 305000320
	local xuneng = SkillApi:GetFury(self, caster, self.card,3)
	-- 8244
	if SkillJudger:IsBeatBack(self, caster, target, true) then
	else
		return
	end
	-- 337202
	self:AddTempAttr(SkillEffect[337202], caster, self.card, data, "damage",0.004*xuneng)
end
