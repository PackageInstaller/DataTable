-- chunkname: @IQIGame\\UI\\SoulList\\SoulListCell.lua

SoulListCell = {
	starPool = {},
	imgSoulClassPool = {}
}

function SoulListCell.New(go, mainView)
	local o = Clone(SoulListCell)

	o:Initialize(go, mainView)

	return o
end

function SoulListCell:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.goView = go
	self.mainView = mainView

	for i = 1, 5 do
		self.starPool[i] = self.goStarBlock.transform:Find("Image_0" .. i).gameObject
	end

	for i = 1, 2 do
		self.imgSoulClassPool[i] = self.goSoulClassParent.transform:Find("Image_0" .. i):GetComponent("Image")
	end

	self.grayComponent = self.goView:GetComponent("ImageGroupGrayComponent")
	self.tfName = self.goName:GetComponent("Text")
	self.tfNo = self.goNo:GetComponent("Text")
	self.tfLv = self.goLv:GetComponent("Text")
	self.tfClipNum = self.goClipNum:GetComponent("Text")
	self.imgSoul = self.goSoul:GetComponent("Image")
	self.imgBottomBg = self.goBottomBg:GetComponent("Image")

	local pos = self.imgSoul.transform.localPosition

	self.v3OldImgSoulPos = Vector3.New(pos.x, pos.y, pos.z)
	self.lockAlpha = self.goSoul:GetComponent("CanvasGroup").alpha
end

function SoulListCell:Refresh(soulData, isVirtual)
	self.soulData = soulData

	self:RefreshMisc()
	self:RefreshOnLock()
	self:RefreshImgSoul()
	self:RefreshClass()
	self:RefreshStar()

	if not isVirtual then
		self:RefreshRetPoint()
		self:RefreshOath()
	else
		self.goRedPoint:SetActive(false)
		self.goOath:SetActive(false)
	end
end

function SoulListCell:OnHide()
	return
end

function SoulListCell:OnDestroy()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.goView, self)

	self.goView = nil
	self.mainView = nil
end

function SoulListCell:OnLoadImgSoulSucceed(assetName, asset, duration, userData)
	local icon = self.imgSoul

	icon.sprite = LuaCodeInterface.ToSprite(asset)
	icon.transform.localPosition = self.v3OldImgSoulPos

	local v3Pos = icon.transform.localPosition

	v3Pos.x = v3Pos.x + self.soulData:GetCfgSoulRes2D().SoulListPosition[1]
	v3Pos.y = v3Pos.y + self.soulData:GetCfgSoulRes2D().SoulListPosition[2]
	v3Pos.z = v3Pos.z + self.soulData:GetCfgSoulRes2D().SoulListPosition[3]
	icon.transform.localPosition = v3Pos

	local v3Scale = Vector3.New(self.soulData:GetCfgSoulRes2D().SoulListScale[1], self.soulData:GetCfgSoulRes2D().SoulListScale[2], self.soulData:GetCfgSoulRes2D().SoulListScale[3])

	icon.transform.localScale = v3Scale

	icon:SetNativeSize()
end

function SoulListCell:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function SoulListCell:OnEvolveSoulSuccess()
	self:RefreshImgSoul()
	self:RefreshStar()
end

function SoulListCell:OnSoulExpAddSuccess()
	self:RefreshMisc()
end

function SoulListCell:OnUnlockSoul()
	self:RefreshOnLock()
end

function SoulListCell:RefreshMisc()
	self.tfName.text = SoulListCellApi:GetString("goName", self.soulData:GetCfgSoul().EnglishName, self.soulData.isUnlock)
	self.tfLv.text = SoulListCellApi:GetString("goLv", self.soulData.lv, self.soulData.isUnlock)
	self.tfNo.text = SoulListCellApi:GetString("goNo", self.soulData.No)
end

function SoulListCell:RefreshOnLock()
	self.grayComponent:EnableGray(not self.soulData.isUnlock)
	self.goStarBlock:SetActive(self.soulData.isUnlock)
	self.goImageLock:SetActive(not self.soulData.isUnlock)
	self.goLv.transform.parent.gameObject:SetActive(self.soulData.isUnlock)
	self.goSoulClassParent:SetActive(self.soulData.isUnlock)
	self.goBottomBg.transform.parent.gameObject:SetActive(self.soulData.isUnlock)
	self.goName.transform.parent.gameObject:SetActive(self.soulData.isUnlock)

	local alpha = self.lockAlpha

	if self.soulData.isUnlock then
		alpha = 1
	end

	self.goSoul:GetComponent("CanvasGroup").alpha = alpha

	if not self.soulData.isUnlock then
		local cfgData = self.soulData:GetCfgSoul()
		local needCount = cfgData.UnlockItem[2]
		local ownCount = WarehouseModule.GetItemNumByCfgID(cfgData.UnlockItem[1])

		self.tfClipNum.text = SoulListCellApi:GetString("goClipNum", ownCount, needCount)
	end
end

function SoulListCell:RefreshImgSoul()
	local path = UIGlobalApi.GetHarmoniousImagePath(self.soulData:GetCfgSoulRes2D().SoulSoulCard)
	local asset

	if self.mainView ~= nil then
		asset = self.mainView.UIController:GetPreloadedAsset(path)
	end

	if asset ~= nil then
		self:OnLoadImgSoulSucceed(nil, asset, nil, nil)
	else
		AssetUtil.LoadAsset(self, path, self.OnLoadImgSoulSucceed, self.OnLoadFailed)
	end
end

function SoulListCell:RefreshClass()
	local classTypes = self.soulData:GetCfgSoul().SoulClass

	for i, v in ipairs(self.imgSoulClassPool) do
		v.gameObject:SetActive(i <= #classTypes)
	end

	for i, v in ipairs(classTypes) do
		local path = MiscApi:GetString("SoulClassMixIconPath", v)

		AssetUtil.LoadImage(self, path, self.imgSoulClassPool[i])
	end
end

function SoulListCell:RefreshStar()
	local curStar = 1

	if self.soulData.isUnlock then
		curStar = self.soulData:GetCfgSoulQuality().Quality
	end

	for i, v in ipairs(self.starPool) do
		v:SetActive(i <= curStar)
	end

	local path = SoulListCellApi:GetString("goBottomBg", curStar)

	if path ~= nil and path ~= "" then
		AssetUtil.LoadImage(self, path, self.imgBottomBg)
	end
end

function SoulListCell:RefreshRetPoint()
	self.goRedPoint:SetActive(SoulModule.CheckSoulListRedPoint(self.soulData))
end

function SoulListCell:RefreshOath()
	self.goOath:SetActive(false)
	UGUIUtil.SetText(self.goOathText, SoulListUIApi:GetString("goOathText"))

	local isActivate = self.soulData.oathActivation

	self.goOath:SetActive(isActivate)
end
