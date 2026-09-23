-- 溯源探查ex技能6
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1100070086 = oo.class(SkillBase)
function Skill1100070086:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 加buff时
function Skill1100070086:OnAddBuff(caster, target, data, buffer)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8258
	if SkillJudger:IsCtrlBuff(buffer or self, caster, target, true,2) then
	else
		return
	end
	-- 1100070087
	self:AddBuffCount(SkillEffect[1100070087], caster, self.card, data, 1100070087,1,60)
end
