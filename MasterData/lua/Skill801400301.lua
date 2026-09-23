-- 雷枪贯通
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill801400301 = oo.class(SkillBase)
function Skill801400301:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill801400301:DoSkill(caster, target, data)
	-- 12002
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12002], caster, target, data, 0.5,2)
end
-- 行动结束2
function Skill801400301:OnActionOver2(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8200
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	-- 801400301
	local targets = SkillFilter:All(self, caster, target, 2)
	for i,target in ipairs(targets) do
		-- 8438
		local count38 = SkillApi:BuffCount(self, caster, target,2,3,3009)
		-- 801400302
		if SkillJudger:Greater(self, caster, self.card, true,count38,0) then
			-- 801400303
			self:AddBuff(SkillEffect[801400303], caster, target, data, 801400301)
		end
	end
end
