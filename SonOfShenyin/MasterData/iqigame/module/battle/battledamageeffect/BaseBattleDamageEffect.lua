-- chunkname: @IQIGame\\Module\\Battle\\BattleDamageEffect\\BaseBattleDamageEffect.lua

BaseBattleDamageEffect = class()

function BaseBattleDamageEffect:ctor(rootObj, fontMaterial)
	self:Init(rootObj, fontMaterial)
end

function BaseBattleDamageEffect:Init(rootObj, fontMaterial)
	self.RootObj = rootObj
	self.EffectHelper = self.RootObj.transform:GetComponent("BattleDamageEffectHelper")
	self.DamageStr = ""

	LuaCodeInterface.BindOutlet(self.RootObj, self)

	if self.TagsRoot ~= nil then
		self.tagItems = {}

		LuaCodeInterface.BindOutlet(self.TagsRoot, self.tagItems)
	end

	self.BattleDamageAnimation = self.BattleDamageAnimationObj ~= nil and self.BattleDamageAnimationObj:GetComponent("Animation") or nil
	self.BattleDamageTextAnimatorPlayer = self.BattleDamageTextAnimatorPlayerObj ~= nil and self.BattleDamageTextAnimatorPlayerObj:GetComponent("TextAnimatorPlayer") or nil
	self.textMeshProUGUI = self.BattleDamageTextAnimatorPlayerObj ~= nil and self.BattleDamageTextAnimatorPlayerObj:GetComponent(typeof(TMPro.TextMeshProUGUI)) or nil

	self:InitProperties()
	self:SetTMPProperties(fontMaterial)
end

function BaseBattleDamageEffect:InitProperties()
	return
end

function BaseBattleDamageEffect:DisposeProperties()
	return
end

function BaseBattleDamageEffect:SetTMPProperties(fontMaterial)
	if self.textMeshProUGUI == nil then
		return
	end

	if fontMaterial ~= nil then
		self.textMeshProUGUI.fontSharedMaterial = fontMaterial

		local criticalTMP = self.CriticalObj ~= nil and self.CriticalObj:GetComponent(typeof(TMPro.TextMeshProUGUI)) or nil

		if criticalTMP ~= nil then
			criticalTMP.fontSharedMaterial = fontMaterial
		end
	end
end

function BaseBattleDamageEffect:SetShowInfo(damage)
	local _damage = damage

	if type(_damage) == "number" then
		_damage = math.abs(damage)
	end

	if self.EffectHelper ~= nil then
		self.DamageStr = self.EffectHelper.PrefixTags .. tostring(_damage)
	else
		self.DamageStr = tostring(_damage)
	end
end

function BaseBattleDamageEffect:SetAdvantageTagInfo(advantage)
	if self.TagsRoot == nil then
		return
	end

	if advantage == 1 then
		self.tagItems.Restrained.gameObject:SetActive(false)
		self.tagItems.UnRestrained.gameObject:SetActive(true)
	elseif advantage == 2 then
		self.tagItems.Restrained.gameObject:SetActive(true)
		self.tagItems.UnRestrained.gameObject:SetActive(false)
	else
		self.tagItems.Restrained.gameObject:SetActive(false)
		self.tagItems.UnRestrained.gameObject:SetActive(false)
	end

	if self.EffectHelper ~= nil then
		self.EffectHelper:ChangeColor()
	end
end

function BaseBattleDamageEffect:Show()
	if self.EffectHelper ~= nil then
		self.EffectHelper:RandomOffset()
	end

	if self.BattleDamageAnimation ~= nil then
		self.BattleDamageAnimation:Play()
	end

	if self.RootObj ~= nil and self.RootObj.activeInHierarchy then
		if type(self.DamageStr) == "string" then
			self.BattleDamageTextAnimatorPlayer:ShowText(self.DamageStr)
			self.BattleDamageTextAnimatorPlayer:StartShowingText(true)

			return true
		else
			logError("BaseBattleDamageEffect:Show:  self.DamageStr is invalid.")
		end
	end

	return false
end

function BaseBattleDamageEffect:Hide()
	if self.RootObj == nil then
		return
	end

	if self.BattleDamageAnimation ~= nil then
		self.BattleDamageAnimation:Stop()
	end

	if self.BattleDamageTextAnimatorPlayer ~= nil then
		self.BattleDamageTextAnimatorPlayer:StopShowingText()
	end

	self:BeforeDestroy()
	self:Destroy()
end

function BaseBattleDamageEffect:BeforeDestroy()
	return
end

function BaseBattleDamageEffect:Destroy()
	self:DisposeProperties()

	if self.TagsRoot ~= nil then
		LuaCodeInterface.ClearOutlet(self.TagsRoot, self.tagItems)
	end

	LuaCodeInterface.ClearOutlet(self.RootObj, self)

	self.EffectHelper = nil
	self.BattleDamageAnimation = nil
	self.BattleDamageTextAnimatorPlayer = nil
	self.RootObj = nil

	if self.textMeshProUGUI ~= nil then
		self.textMeshProUGUI = nil
	end
end

function BaseBattleDamageEffect:GetAnimationDuration()
	local time = 0

	if self.BattleDamageAnimation ~= nil then
		time = self.BattleDamageAnimation.clip.length
	end

	return time
end
