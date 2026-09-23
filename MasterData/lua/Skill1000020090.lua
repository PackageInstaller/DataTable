-- 护盾词条
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1000020090 = oo.class(SkillBase)
function Skill1000020090:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill1000020090:OnActionOver(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8688
	local count688 = SkillApi:BuffCount(self, caster, target,3,4,3)
	-- 1000020199
	if SkillJudger:Greater(self, caster, target, true,count688,0) then
	else
		return
	end
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 1000020090
	if self:Rand(6500) then
		self:BeatBack(SkillEffect[1000020090], caster, target, data, nil)
	end
end
