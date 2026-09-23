-- 卡提那·联域4
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill780200403 = oo.class(SkillBase)
function Skill780200403:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill780200403:DoSkill(caster, target, data)
	-- 12002
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12002], caster, target, data, 0.5,2)
end
-- 行动结束
function Skill780200403:OnActionOver(caster, target, data)
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
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8767
	local count767 = SkillApi:BuffCount(self, caster, target,2,4,780200201)
	-- 8633
	local count633 = SkillApi:GetDamage(self, caster, target,1)
	-- 8770
	local count770 = SkillApi:SkillLevel(self, caster, target,3,47802)
	-- 780200403
	local targets = SkillFilter:All(self, caster, target, 4)
	for i,target in ipairs(targets) do
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
		-- 8073
		if SkillJudger:TargetIsEnemy(self, caster, target, true) then
		else
			return
		end
		-- 8767
		local count767 = SkillApi:BuffCount(self, caster, target,2,4,780200201)
		-- 8633
		local count633 = SkillApi:GetDamage(self, caster, target,1)
		-- 8770
		local count770 = SkillApi:SkillLevel(self, caster, target,3,47802)
		-- 780200408
		self:AddHp(SkillEffect[780200408], caster, target, data, -math.floor(count633*(math.floor((count770+1)/2)+1)*0.25*count767))
	end
end
