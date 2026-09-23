-- 水能
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4700313 = oo.class(SkillBase)
function Skill4700313:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击结束
function Skill4700313:OnAttackOver(caster, target, data)
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
	-- 8472
	local count72 = SkillApi:BuffCount(self, caster, target,3,4,650)
	-- 8164
	if SkillJudger:Less(self, caster, target, true,count72,5) then
	else
		return
	end
	-- 4700305
	self:AddBuff(SkillEffect[4700305], caster, self.card, data, 6505)
	-- 4700306
	self:ShowTips(SkillEffect[4700306], caster, self.card, data, 2,"水能",true,4700306)
end
