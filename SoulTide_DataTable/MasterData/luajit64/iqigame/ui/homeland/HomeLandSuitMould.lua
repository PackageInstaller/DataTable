-- chunkname: @IQIGame\\UI\\HomeLand\\HomeLandSuitMould.lua

local HomeLandSuitMould = {}

function HomeLandSuitMould.__New(view, mould)
	local obj = Clone(HomeLandSuitMould)

	obj:Init(view, mould)

	return obj
end

function HomeLandSuitMould:Init(view, mould)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
	UGUIUtil.SetText(self.TextBtnArrangement, HomeLandChangeRoomUIApi:GetString("BtnText"))
	UGUIUtil.SetText(self.TextBtnActive, HomeLandChangeRoomUIApi:GetString("BtnText1"))
	UGUIUtil.SetText(self.LockDes, HomeLandChangeRoomUIApi:GetString("LockDes"))

	function self.delegateBtnArrangement()
		self:OnClickBtnArrangement()
	end

	function self.delegateBtnActive()
		self:OnClickBtnActive()
	end

	self.BtnArrangement:GetComponent("Button").onClick:AddListener(self.delegateBtnArrangement)
	self.BtnActive:GetComponent("Button").onClick:AddListener(self.delegateBtnActive)
end

function HomeLandSuitMould:SetData(roomID, cid, isCurrent, isLock)
	self.roomID = roomID
	self.cfgSuitID = cid

	local cfgSuit = CfgHomeLandDecorateSuitTable[self.cfgSuitID]

	UGUIUtil.SetText(self.NormalText2, cfgSuit.Name)
	UGUIUtil.SetText(self.NowText2, cfgSuit.Name)
	UGUIUtil.SetText(self.LockText2, cfgSuit.Name)
	UGUIUtil.SetText(self.NormalText1, HomeLandChangeRoomUIApi:GetString("Text2", cfgSuit.Score))
	UGUIUtil.SetText(self.NowText1, HomeLandChangeRoomUIApi:GetString("Text2", cfgSuit.Score))
	UGUIUtil.SetText(self.NowText3, HomeLandChangeRoomUIApi:GetString("NowText3"))
	UGUIUtil.SetText(self.LockText1, HomeLandChangeRoomUIApi:GetString("Text2", cfgSuit.Score))
	UGUIUtil.SetText(self.TextAddDes, HomeLandChangeRoomUIApi:GetString("TextAddDes", cfgSuit.ChangeMoodSpeed, isLock))

	local bgPath = UIGlobalApi.GetImagePath("/Home" .. cfgSuit.Icon)

	AssetUtil.LoadImage(self, bgPath, self.ImgBg:GetComponent("Image"))
	self:UpdateState(cid, isCurrent, isLock)
end

function HomeLandSuitMould:UpdateState(cid, isCurrent, isLock)
	local cfgSuit = CfgHomeLandDecorateSuitTable[self.cfgSuitID]

	self.Lock:SetActive(not isLock)
	self.Now:SetActive(isCurrent)
	self.Normal:SetActive(isLock and not isCurrent)
	self.ImgBg:GetComponent("GrayComponent"):SetGray(not isLock)
	self.BtnActive:SetActive(not isLock)
	self.LockDes:SetActive(not isLock)

	for i = 1, 5 do
		local isShow = false

		if i <= cfgSuit.Star then
			isShow = true
		end

		self["Star" .. i].transform:GetChild(0).gameObject:SetActive(not isShow)
		self["Star" .. i].transform:GetChild(1).gameObject:SetActive(isShow)
	end
end

function HomeLandSuitMould:OnClickBtnArrangement()
	HomeLandLuaModule.ChangeSuit(self.roomID, self.cfgSuitID)
	UIModule.Close(Constant.UIControllerName.HomeLandChangeThemeRoomUI)
end

function HomeLandSuitMould:OnClickBtnActive()
	local cfgSuit = CfgHomeLandDecorateSuitTable[self.cfgSuitID]

	UIModule.Open(Constant.UIControllerName.BuyPanelUI, Constant.UILayer.UI, {
		mallCid = cfgSuit.BuyMallId
	})
end

function HomeLandSuitMould:Dispose()
	self.BtnArrangement:GetComponent("Button").onClick:RemoveListener(self.delegateBtnArrangement)
	self.BtnActive:GetComponent("Button").onClick:RemoveListener(self.delegateBtnActive)
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return HomeLandSuitMould
