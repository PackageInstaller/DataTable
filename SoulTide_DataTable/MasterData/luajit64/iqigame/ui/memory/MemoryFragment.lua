-- chunkname: @IQIGame\\UI\\Memory\\MemoryFragment.lua

MemoryFragment = {}

function MemoryFragment.New(ui, memoryChapterView)
	local cloneObject = Clone(MemoryFragment)

	cloneObject:InitView(ui, memoryChapterView)

	return cloneObject
end

function MemoryFragment:InitView(ui, memoryChapterView)
	self.ui = ui
	self.memoryChapterView = memoryChapterView

	LuaCodeInterface.BindOutlet(self.ui, self)

	self.btnFragment = self.ui:GetComponent("Button")

	function self.delegateOnClickBtnFragment()
		self:OnClickBtnFragment()
	end
end

function MemoryFragment:AddEventListeners()
	self.btnFragment.onClick:AddListener(self.delegateOnClickBtnFragment)
end

function MemoryFragment:RemoveEventListeners()
	self.btnFragment.onClick:RemoveListener(self.delegateOnClickBtnFragment)
end

function MemoryFragment:OnClickBtnFragment()
	if self.isUnlock then
		self.memoryChapterView:OpenFragmentDetailView(self.cfgFragmentData)
	else
		self.memoryChapterView:OpenFragmentRequirementView(self.cfgFragmentData)
	end
end

function MemoryFragment:CloseUI()
	self:RemoveEventListeners()
	self.ui.gameObject:SetActive(false)
end

function MemoryFragment:IsAdequateMaterial()
	if self.cfgFragmentData then
		for i = 1, #self.cfgFragmentData.Cost, 2 do
			local itemId = self.cfgFragmentData.Cost[i]
			local needNum = self.cfgFragmentData.Cost[i + 1]
			local haveNum = WarehouseModule.GetItemNumByCfgID(itemId)

			if haveNum < needNum then
				return false
			end
		end
	end

	return true
end

function MemoryFragment:OpenUI(fragmentCid, isFragmentUnLock)
	self.ui.gameObject:SetActive(true)

	self.fragmentCid = fragmentCid
	self.isUnlock = isFragmentUnLock
	self.cfgFragmentData = CfgSoulMemoryPieceTable[self.fragmentCid]

	local imageComponent = self.imgIcon:GetComponent("Image")
	local imgPath

	if self.isUnlock then
		imgPath = UIGlobalApi.GetImagePath(self.cfgFragmentData.Icon)
	else
		imgPath = MemoryUIApi:GetString("UnlockIconPath")
	end

	AssetUtil.LoadImage(self, imgPath, imageComponent, self.OnLoadSucceed, self.OnLoadFailed)
	self.Effect1:SetActive(false)
	self.Effect2:SetActive(false)

	if self.isUnlock then
		self.Effect1:SetActive(true)
	else
		local top = self:IsAdequateMaterial()

		self.Effect2:SetActive(top)
	end

	self:AddEventListeners()
end

function MemoryFragment:Dispose()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.ui, self)

	self.ui = nil
end

function MemoryFragment:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function MemoryFragment:OnLoadFailed(assetName, status, errorMessage, userData)
	logError("error occurs when load item icon : " .. assetName)
end
