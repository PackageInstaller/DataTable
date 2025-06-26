-- chunkname: @IQIGame\\UI\\Tips\\BuffTipContent.lua

local BuffTipContent = {}

function BuffTipContent.New(go)
	local o = Clone(BuffTipContent)

	o:Initialize(go)

	return o
end

function BuffTipContent:Initialize(go)
	self.View = go

	LuaCodeInterface.BindOutlet(go, self)

	self.goEffectDescTitle:GetComponent("Text").text = BuffTipsUIApi:GetString("goEffectDescTitle")
	self.goRemoveBuffTitle:GetComponent("Text").text = BuffTipsUIApi:GetString("goRemoveBuffTitle")
end

function BuffTipContent:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

function BuffTipContent:Refresh(cfgData, puppetData)
	self.cfgBuffData = cfgData
	self.puppetData = puppetData

	self:RefreshDesc()
	self:RefreshEffectDesc()
	self:RefreshTagBlock()
end

function BuffTipContent:RefreshDesc()
	if self.cfgBuffData.Describe == "" or self.cfgBuffData.Describe == nil then
		self.goDesc.transform.parent.gameObject:SetActive(false)
	else
		self.goDesc.transform.parent.gameObject:SetActive(true)

		self.goDesc:GetComponent("Text").text = BuffTipsUIApi:GetString("goDesc", self.cfgBuffData.Describe)
	end
end

function BuffTipContent:RefreshEffectDesc()
	if self.cfgBuffData.BuffDescribe == "" or self.cfgBuffData.BuffDescribe == nil then
		self.goEffectDescTitle.transform.parent.gameObject:SetActive(false)
		self.goEffectDesc:SetActive(false)
	else
		self.goEffectDescTitle.transform.parent.gameObject:SetActive(true)
		self.goEffectDesc:SetActive(true)

		self.goEffectDesc:GetComponent("Text").text = BuffTipsUIApi:GetString("goEffectDesc", self.cfgBuffData.BuffDescribe)
	end
end

function BuffTipContent:RefreshTagBlock()
	self.goRemoveBuffTitle.transform.parent.gameObject:SetActive(false)
	self.goRemoveBuffContent:SetActive(false)

	if self.cfgBuffData.Tag == 5 then
		self:RefreshTag5()
	end
end

function BuffTipContent:RefreshTag5()
	if PlayerModule.InMaze == false then
		self.goRemoveBuffTitle.transform.parent.gameObject:SetActive(true)
		self.goRemoveBuffContent:SetActive(true)

		local cost = BuffTipsUIApi:GetString("clearBuffCost")

		self.goRemoveBuffContent.transform:Find("Life/Text"):GetComponent("Text").text = BuffTipsUIApi:GetString("goRemoveBuffCost", cost, self.puppetData.durable)
	end
end

return BuffTipContent
