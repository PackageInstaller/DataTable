-- 无尽寂静
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill322205 = oo.class(SkillBase)
function Skill322205:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 死亡时
function Skill322205:OnDeath(caster, target, data)
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
	-- 8495
	local count95 = SkillApi:BuffCount(self, caster, target,1,3,907100206)
	-- 8192
	if SkillJudger:Greater(self, caster, target, true,count95,0) then
	else
		return
	end
	-- 8467
	local count67 = SkillApi:GetAttr(self, caster, target,2,"hp")
	-- 8190
	if SkillJudger:Less(self, caster, target, true,count67,1) then
	else
		return
	end
	-- 322205
	self:OwnerAddBuffCount(SkillEffect[322205], caster, self.card, data, 322205,1,5)
end
