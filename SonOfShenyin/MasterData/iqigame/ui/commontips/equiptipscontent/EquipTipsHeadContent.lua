-- chunkname: @IQIGame\\UI\\CommonTips\\EquipTipsContent\\EquipTipsHeadContent.lua

local EquipTipsHeadContent = {}

function EquipTipsHeadContent.New(view)
	local obj = Clone(EquipTipsHeadContent)

	obj:__Init(view)

	return obj
end

function EquipTipsHeadContent:__Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)

	function self.__onLockButtonClickEventProxy()
		self:__OnLockButtonClickEventHandler()
	end

	function self.__onLockEquipSucceedEventProxy()
		self:__OnLockEquipSucceedEventHandler()
	end

	self:__AddListeners()
end

function EquipTipsHeadContent:__AddListeners()
	EventDispatcher.AddEventListener(EventID.LockEquipSucceedNew, self.__onLockEquipSucceedEventProxy)
	self.lockBtn:GetComponent("Button").onClick:AddListener(self.__onLockButtonClickEventProxy)
end

function EquipTipsHeadContent:__RemoveListeners()
	EventDispatcher.RemoveEventListener(EventID.LockEquipSucceedNew, self.__onLockEquipSucceedEventProxy)
	self.lockBtn:GetComponent("Button").onClick:RemoveListener(self.__onLockButtonClickEventProxy)
end

function EquipTipsHeadContent:Dispose()
	self:__RemoveListeners()

	self.equipData = nil

	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

function EquipTipsHeadContent:SetData(itemData, params)
	local cfgData = itemData:GetCfg()

	self.equipData = itemData.equipData

	AssetUtil.LoadImage(self, CommonTipsApi:GetQualityBackground(cfgData.Quality), self.qualityBg:GetComponent("Image"))

	self.equipNameText:GetComponent("Text").text = CommonEquipTipsUIApi:GetEquipName(cfgData.Name, cfgData.Quality)
	self.equipTypeText:GetComponent("Text").text = CommonEquipTipsUIApi:GetEquipPartText(cfgData.ItemSubTypes)
	self.equipLv:GetComponent("Text").text = CommonEquipTipsUIApi:GetEquipLevelText(self.equipData.lv)

	AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(cfgData.Icon), self.equipImg:GetComponent("Image"))
	AssetUtil.LoadImage(self, EquipApi:GetEquipPartImg(cfgData.Part), self.equipPartImg:GetComponent("Image"))
	AssetUtil.LoadImage(self, CommonEquipTipsUIApi:GetEquipQualityImg(cfgData.Quality), self.equipQualityImg:GetComponent("Image"))
	self:__RefreshMainAttribute(self.equipData.baseAttribute.Main[1])
	self:__RefreshLockState(self.equipData.isLock)
end

function EquipTipsHeadContent:__RefreshMainAttribute(mainAttribute)
	if mainAttribute == nil then
		self.equipMainAttNameText:GetComponent("Text").text = ""
		self.equipMainAttNumText:GetComponent("Text").text = ""

		self.lockBtn:SetActive(false)
		LuaUtility.SetGameObjectShow(self.equipMainAttImg, false)

		return
	end

	self.equipMainAttNameText:GetComponent("Text").text = mainAttribute.Name
	self.equipMainAttNumText:GetComponent("Text").text = CommonEquipTipsUIApi:GetMainAttributeText(mainAttribute.AddAttNum)

	self.lockBtn:SetActive(true)
	LuaUtility.SetGameObjectShow(self.equipMainAttImg, true)
end

function EquipTipsHeadContent:__RefreshLockState(isLock)
	LuaCodeInterface.SetGameObjectShow(self.on, isLock)
	LuaCodeInterface.SetGameObjectShow(self.off, not isLock)
end

function EquipTipsHeadContent:__OnLockEquipSucceedEventHandler()
	if self.equipData == nil then
		return
	end

	self.equipData = WarehouseModule.FindItem(self.equipData.id).equipData

	self:__RefreshLockState(self.equipData.isLock)
end

function EquipTipsHeadContent:__OnLockButtonClickEventHandler()
	EquipModule.LockEquip({
		self.equipData.id
	})
end

return EquipTipsHeadContent
