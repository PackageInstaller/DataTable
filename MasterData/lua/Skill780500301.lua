-- 奥西里斯3
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill780500301 = oo.class(SkillBase)
function Skill780500301:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill780500301:DoSkill(caster, target, data)
	-- 12006
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12006], caster, target, data, 0.167,6)
end
-- 行动结束
function Skill780500301:OnActionOver(caster, target, data)
	-- 8200
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	-- 8965
	if SkillJudger:IsCallSkill(self, caster, target, false) then
	else
		return
	end
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
	-- 780500306
	self:AddBuff(SkillEffect[780500306], caster, target, data, 780500301)
	-- 8794
	local count794 = SkillApi:BuffCount(self, caster, target,2,4,780500301)
	-- 780500317
	if SkillJudger:Greater(self, caster, target, true,count794,0) then
	else
		return
	end
	-- 780500316
	self:AddProgress(SkillEffect[780500316], caster, target, data, 500)
end
-- 伤害后
function Skill780500301:OnAfterHurt(caster, target, data)
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
	-- 8200
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	-- 8261
	if SkillJudger:IsCallSkill(self, caster, target, true) then
	else
		return
	end
	-- 780500358
	self:LimitDamage(SkillEffect[780500358], caster, target, data, 0.05,1.2)
end
-- 回合结束时
function Skill780500301:OnRoundOver(caster, target, data)
	-- 8795
	local count795 = SkillApi:BuffCount(self, caster, target,1,4,780500301)
	-- 780500319
	if SkillJudger:Greater(self, caster, target, true,count795,0) then
	else
		return
	end
	-- 9768
	local count9768 = SkillApi:GetAttr(self, caster, target,1,"hp")
	-- 9743
	local count818 = SkillApi:GetAttr(self, caster, target,1,"maxhp")
	-- 8420
	local count20 = SkillApi:GetAttr(self, caster, target,3,"hp")
	-- 8449
	local count49 = SkillApi:GetAttr(self, caster, target,3,"maxhp")
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 780500320
	if SkillJudger:Greater(self, caster, target, true,count9768/count818,count20/count49) then
		-- 8970
		local count970 = SkillApi:BuffCount(self, caster, target,3,4,780500202)
		-- 780500342
		if SkillJudger:Greater(self, caster, target, true,count970,2) then
			-- 780500330
			self:AddHp(SkillEffect[780500330], caster, self.card, data, math.max(math.floor(count9768/count818*count49-count20),1))
			-- 8462
			local count62 = SkillApi:GetAttr(self, caster, target,3,"attack")
			-- 8796
			local count796 = SkillApi:SkillLevel(self, caster, target,3,7805001)
			-- 8796
			local count796 = SkillApi:SkillLevel(self, caster, target,3,7805001)
			-- 8797
			local count797 = SkillApi:GetCount(self, caster, target,3,780500100+count796)
			-- 8969
			local count969 = SkillApi:SkillLevel(self, caster, target,3,47805)
			-- 8970
			local count970 = SkillApi:BuffCount(self, caster, target,3,4,780500202)
			-- 8973
			local count973 = SkillApi:BuffCount(self, caster, target,1,4,780501301)
			-- 8974
			local count974 = SkillApi:GetAttr(self, caster, target,3,"damage")
			-- 8975
			local count975 = SkillApi:GetAttr(self, caster, target,1,"bedamage")
			-- 8976
			local count976 = SkillApi:GetAttr(self, caster, target,3,"damage2")
			-- 8977
			local count977 = SkillApi:GetAttr(self, caster, target,1,"bedamage2")
			-- 780500335
			self:AddHp(SkillEffect[780500335], self.card, caster, data, math.max(math.floor(count20/count49*count818-count9768),-math.floor((1+count970*(math.floor(count969/2+1.5)*0.05))*count62*count974*count975*count976*count977*(10+count973*10+count797*0.4*count796))))
			-- 8796
			local count796 = SkillApi:SkillLevel(self, caster, target,3,7805001)
			-- 780500340
			self:DelBufferForce(SkillEffect[780500340], caster, self.card, data, 780500100+count796)
			-- 8798
			local count798 = SkillApi:SkillLevel(self, caster, target,3,7805003)
			-- 780500341
			self:DelBufferForce(SkillEffect[780500341], caster, caster, data, 780500300+count798)
			-- 780500357
			self:DelBufferForce(SkillEffect[780500357], caster, caster, data, 780501301)
		else
			-- 780500347
			self:AddHp(SkillEffect[780500347], caster, self.card, data, math.max(math.floor(count9768/count818*count49-count20),1))
			-- 8462
			local count62 = SkillApi:GetAttr(self, caster, target,3,"attack")
			-- 8796
			local count796 = SkillApi:SkillLevel(self, caster, target,3,7805001)
			-- 8796
			local count796 = SkillApi:SkillLevel(self, caster, target,3,7805001)
			-- 8797
			local count797 = SkillApi:GetCount(self, caster, target,3,780500100+count796)
			-- 8973
			local count973 = SkillApi:BuffCount(self, caster, target,1,4,780501301)
			-- 8974
			local count974 = SkillApi:GetAttr(self, caster, target,3,"damage")
			-- 8975
			local count975 = SkillApi:GetAttr(self, caster, target,1,"bedamage")
			-- 8976
			local count976 = SkillApi:GetAttr(self, caster, target,3,"damage2")
			-- 8977
			local count977 = SkillApi:GetAttr(self, caster, target,1,"bedamage2")
			-- 780500352
			self:AddHp(SkillEffect[780500352], self.card, caster, data, math.max(math.floor(count20/count49*count818-count9768),-math.floor(count62*count974*count975*count976*count977*(10+count973*10+count797*0.4*count796))))
			-- 8796
			local count796 = SkillApi:SkillLevel(self, caster, target,3,7805001)
			-- 780500340
			self:DelBufferForce(SkillEffect[780500340], caster, self.card, data, 780500100+count796)
			-- 8798
			local count798 = SkillApi:SkillLevel(self, caster, target,3,7805003)
			-- 780500341
			self:DelBufferForce(SkillEffect[780500341], caster, caster, data, 780500300+count798)
			-- 780500357
			self:DelBufferForce(SkillEffect[780500357], caster, caster, data, 780501301)
		end
	else
		-- 780500325
		self:CallOwnerSkill(SkillEffect[780500325], caster, caster, data, 780500301)
		-- 8796
		local count796 = SkillApi:SkillLevel(self, caster, target,3,7805001)
		-- 780500340
		self:DelBufferForce(SkillEffect[780500340], caster, self.card, data, 780500100+count796)
		-- 8798
		local count798 = SkillApi:SkillLevel(self, caster, target,3,7805003)
		-- 780500341
		self:DelBufferForce(SkillEffect[780500341], caster, caster, data, 780500300+count798)
		-- 780500357
		self:DelBufferForce(SkillEffect[780500357], caster, caster, data, 780501301)
	end
end
-- 回合开始时
function Skill780500301:OnRoundBegin(caster, target, data)
	-- 780500359
	local targets = SkillFilter:All(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:SetProtect(SkillEffect[780500359], caster, target, data, 0)
	end
	-- 8795
	local count795 = SkillApi:BuffCount(self, caster, target,1,4,780500301)
	-- 780500319
	if SkillJudger:Greater(self, caster, target, true,count795,0) then
	else
		return
	end
	-- 780500360
	local targets = SkillFilter:All(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:SetProtect(SkillEffect[780500360], caster, target, data, 10000)
	end
end
