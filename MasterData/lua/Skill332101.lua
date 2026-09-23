-- 哈托莉2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill332101 = oo.class(SkillBase)
function Skill332101:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 加buff时
function Skill332101:OnAddBuff(caster, target, data, buffer)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8256
	if SkillJudger:IsCtrlBuff(buffer or self, caster, target, true) then
	else
		return
	end
	-- 332101
	self:AddProgress(SkillEffect[332101], caster, self.card, data, 30)
end
