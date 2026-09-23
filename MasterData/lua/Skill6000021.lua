-- 连锁阵线6.0版本（燃血技能）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill6000021 = oo.class(SkillBase)
function Skill6000021:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill6000021:OnActionOver(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8282
	if SkillJudger:IsCtrlType(self, caster, target, true,16) then
	else
		return
	end
	-- 60000076
	self:AddBuffCount(SkillEffect[60000076], caster, self.card, data, 60000076,1,20)
end
