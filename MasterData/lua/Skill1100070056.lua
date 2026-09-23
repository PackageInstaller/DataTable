-- 护盾减伤机制，每层3层减伤，回合开始时恢复
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1100070056 = oo.class(SkillBase)
function Skill1100070056:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合开始时
function Skill1100070056:OnRoundBegin(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 1100070056
	self:AddBuffCount(SkillEffect[1100070056], caster, self.card, data, 932900701,3,3)
end
-- 攻击结束2
function Skill1100070056:OnAttackOver2(caster, target, data)
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
	-- 932900705
	self:OwnerAddBuffCount(SkillEffect[932900705], caster, self.card, data, 932900701,-1,6)
end
