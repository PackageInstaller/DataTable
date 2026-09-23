-- 重突击
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill801400101 = oo.class(SkillBase)
function Skill801400101:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill801400101:DoSkill(caster, target, data)
	-- 12001
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12001], caster, target, data, 1,1)
end
-- 行动结束
function Skill801400101:OnActionOver(caster, target, data)
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
	-- 801400101
	local targets = SkillFilter:Exception(self, caster, target, 2)
	for i,target in ipairs(targets) do
		-- 8438
		local count38 = SkillApi:BuffCount(self, caster, target,2,3,3009)
		-- 801400102
		if SkillJudger:Greater(self, caster, self.card, true,count38,0) then
			-- 801400103
			self:AddBuff(SkillEffect[801400103], caster, target, data, 801400101)
		end
	end
end
