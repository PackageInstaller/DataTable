-- 主角登场
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill317503 = oo.class(SkillBase)
function Skill317503:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill317503:OnActionOver(caster, target, data)
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
	-- 8481
	local count81 = SkillApi:BuffCount(self, caster, target,2,3,4300201)
	-- 8169
	if SkillJudger:Greater(self, caster, target, true,count81,0) then
	else
		return
	end
	-- 8214
	if SkillJudger:IsTypeOf(self, caster, target, true,2) then
	else
		return
	end
	-- 317503
	if self:Rand(6000) then
		self:BeatAgain(SkillEffect[317503], caster, target, data, nil)
	end
end
