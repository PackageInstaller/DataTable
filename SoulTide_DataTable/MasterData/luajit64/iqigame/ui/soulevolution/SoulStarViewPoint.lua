-- chunkname: @IQIGame\\UI\\SoulEvolution\\SoulStarViewPoint.lua

local SoulStarViewPoint = {}

function SoulStarViewPoint.New(view)
	local obj = Clone(SoulStarViewPoint)

	obj:Init(view)

	return obj
end

function SoulStarViewPoint:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
end

function SoulStarViewPoint:Refresh(soulData, cfgQuality)
	self.soulData = soulData
	self.cfgQuality = cfgQuality

	self:StopEffectUpStarSuccess()
	self:StopLineEffect()
	self:RefreshState()
end

function SoulStarViewPoint:OnHide()
	self:StopEffectUpStarSuccess()
	self:StopLineEffect()
end

function SoulStarViewPoint:OnDestroy()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

function SoulStarViewPoint:RefreshState()
	local curCfgQuality = self.soulData:GetCfgSoulQuality()

	self.isUnlock = self.cfgQuality.Id <= curCfgQuality.Id
	self.isTarget = self.cfgQuality.Id == curCfgQuality.Id + 1

	if self.goLine ~= nil then
		self.goLine.transform:Find("Type_01").gameObject:SetActive(not self.isUnlock)
		self.goLine.transform:Find("Type_02").gameObject:SetActive(self.isUnlock)
	end

	if self.isTarget then
		self.goSignTarget:SetActive(true)
		self.goSignUnlock:SetActive(false)
		self.goSignLock:SetActive(false)
	elseif self.isUnlock then
		self.goSignTarget:SetActive(false)
		self.goSignUnlock:SetActive(true)
		self.goSignLock:SetActive(false)
	else
		self.goSignTarget:SetActive(false)
		self.goSignUnlock:SetActive(false)
		self.goSignLock:SetActive(true)
	end
end

function SoulStarViewPoint:OnUpStarSuccess()
	self:RefreshState()
	self:PlayEffectUpStarSuccess()
	self:PlayLineEffect()
end

function SoulStarViewPoint:PlayEffectUpStarSuccess()
	self.goEffectUpStarSuccess:SetActive(true)
end

function SoulStarViewPoint:StopEffectUpStarSuccess()
	self.goEffectUpStarSuccess:SetActive(false)
end

function SoulStarViewPoint:PlayLineEffect()
	self:StopLineEffect()

	if self.goLine ~= nil then
		self.goLine.transform:Find("ExplosiveLight").gameObject:SetActive(true)
	end
end

function SoulStarViewPoint:StopLineEffect()
	if self.goLine ~= nil then
		self.goLine.transform:Find("ExplosiveLight").gameObject:SetActive(false)
	end
end

return SoulStarViewPoint
