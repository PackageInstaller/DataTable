-- 强震音符
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill321703 = oo.class(SkillBase)
function Skill321703:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束2
function Skill321703:OnActionOver2(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8214
	if SkillJudger:IsTypeOf(self, caster, target, true,2) then
	else
		return
	end
	-- 8493
	local count93 = SkillApi:BuffCount(self, caster, target,2,3,3501)
	-- 8186
	if SkillJudger:Less(self, caster, target, true,count93,1) then
	else
		return
	end
	-- 321703
	self:AddProgress(SkillEffect[321703], caster, target, data, -200)
end
