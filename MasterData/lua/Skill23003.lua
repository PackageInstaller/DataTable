-- 寒铁III级
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill23003 = oo.class(SkillBase)
function Skill23003:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击结束2
function Skill23003:OnAttackOver2(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 23003
	self:AddBuff(SkillEffect[23003], caster, caster, data, 23003)
	-- 230010
	self:ShowTips(SkillEffect[230010], caster, self.card, data, 2,"钝化",true,230010)
end
