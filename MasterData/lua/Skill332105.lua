-- 哈托莉2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill332105 = oo.class(SkillBase)
function Skill332105:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 加buff时
function Skill332105:OnAddBuff(caster, target, data, buffer)
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
	-- 332105
	self:AddProgress(SkillEffect[332105], caster, self.card, data, 150)
end
