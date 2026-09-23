-- 水能转换
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill312401 = oo.class(SkillBase)
function Skill312401:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill312401:OnActionOver(caster, target, data)
	-- 8202
	if SkillJudger:IsNormal(self, caster, target, true) then
	else
		return
	end
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8454
	local count54 = SkillApi:SkillLevel(self, caster, target,3,47003)
	-- 8472
	local count72 = SkillApi:BuffCount(self, caster, target,3,4,650)
	-- 8164
	if SkillJudger:Less(self, caster, target, true,count72,5) then
	else
		return
	end
	-- 312401
	if self:Rand(3000) then
		self:AddBuff(SkillEffect[312401], caster, self.card, data, 6500+count54)
	end
end
