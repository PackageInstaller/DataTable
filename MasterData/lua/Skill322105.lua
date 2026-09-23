-- 永恒沉沦
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill322105 = oo.class(SkillBase)
function Skill322105:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill322105:OnBefourHurt(caster, target, data)
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
	-- 8435
	local count35 = SkillApi:BuffCount(self, caster, target,2,3,3006)
	-- 8118
	if SkillJudger:Greater(self, caster, self.card, true,count35,0) then
	else
		return
	end
	-- 8485
	local count85 = SkillApi:BuffCount(self, caster, target,1,3,907100202)
	-- 8191
	if SkillJudger:Greater(self, caster, target, true,count85,0) then
	else
		return
	end
	-- 322105
	self:AddTempAttr(SkillEffect[322105], caster, self.card, data, "damage",0.50)
end
