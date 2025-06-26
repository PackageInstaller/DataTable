-- chunkname: @IQIGame\\UI\\HomeLandAlchemyUI.lua

local HomeLandAlchemyUI = Base:Extend("HomeLandAlchemyUI", "IQIGame.Onigao.UI.HomeLandAlchemyUI", {
	lastPer = 0,
	ItemMouldObj = {}
})
local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")

function HomeLandAlchemyUI:OnInit()
	UGUIUtil.SetText(self.TextTitle1, HomeLandAlchemyUIApi:GetString("TextTitle1"))
	UGUIUtil.SetText(self.TextTitle2, HomeLandAlchemyUIApi:GetString("TextTitle2"))
	UGUIUtil.SetText(self.TextBtnGetReward, HomeLandAlchemyUIApi:GetString("TextBtnGetReward"))
	UGUIUtil.SetText(self.TextBtnLevelUp, HomeLandAlchemyUIApi:GetString("TextBtnLevelUp"))

	self.btnCloseComponent = self.BtnBack:GetComponent("Button")
	self.btnHarvestComponent = self.BtnGetReward:GetComponent("Button")
	self.btnHelpComponent = self.BtnHelp:GetComponent("Button")

	function self.delegateBtnClose()
		self:OnBtnClose()
	end

	function self.delegateClickBtnHarvest()
		self:OnClickBtnHarvest()
	end

	function self.delegateHomeUpdateBuildingEvent(cfgBuildingID)
		self:OnHomeUpdateBuildingEvent(cfgBuildingID)
	end

	function self.delegateBtnHelp()
		self:OnBtnHelp()
	end

	function self.delegateBtnLevelUp()
		self:OnBtnLevelUp()
	end

	function self.DelegateBtnGuide()
		self.OnBtnGuide()
	end

	self.ItemMould:SetActive(false)

	self.ItemMouldPool = UIObjectPool.New(10, function()
		return UnityEngine.Object.Instantiate(self.ItemMould)
	end, function(cell)
		UnityEngine.Object.Destroy(cell)
	end)
end

function HomeLandAlchemyUI:GetPreloadAssetPaths()
	return nil
end

function HomeLandAlchemyUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function HomeLandAlchemyUI:OnOpen(userData)
	self.homeBuildingData = userData[1]
	self.decorate = userData[2]

	local roomPOD = HomeLandLuaModule.GetRoomDataByID(self.homeBuildingData.cfgBuilding.BelongRoom)

	GameEntry.LuaEvent:Fire(nil, HomelandSetRoleVisibleEventArgs():Fill(0, false))
	GameEntry.LuaEvent:Fire(nil, HomelandLookObjEventArgs():Fill(HomeLandAlchemyUIApi:GetString("CameraPosition", self.homeBuildingData.buildingPOD.lv, roomPOD.suitCid), HomeLandAlchemyUIApi:GetString("CameraSize")))
	self.Point1:SetActive(false)
	self.Point2:SetActive(false)
	self.UIController.gameObject:SetActive(false)

	self.timerShow = Timer.New(function()
		self.UIController.gameObject:SetActive(true)
		self.Point1:SetActive(true)
		self.Point2:SetActive(true)
	end, 0.5)

	self.timerShow:Start()

	if UIModule.HasUI(Constant.UIControllerName.HomeLandChooseCastleUI) then
		GameEntry.UI:ChangeDisableUIFormByName(Constant.UIControllerName.HomeLandChooseCastleUI, false)
	end

	self:UpDateView()
end

function HomeLandAlchemyUI:OnClose(userData)
	if self.timerShow then
		self.timerShow:Stop()
	end

	self.timerShow = nil

	if UIModule.HasUI(Constant.UIControllerName.HomeLandChooseCastleUI) then
		GameEntry.UI:ChangeDisableUIFormByName(Constant.UIControllerName.HomeLandChooseCastleUI, true)
	end

	GameEntry.LuaEvent:Fire(nil, HomelandLookObjEventArgs():Fill(HomeLandLuaModule.cameraPosition, HomeLandLuaModule.cameraSize))
	GameEntry.LuaEvent:Fire(nil, HomelandSetRoleVisibleEventArgs():Fill(0, true))
end

function HomeLandAlchemyUI:OnAddListeners()
	self.btnCloseComponent.onClick:AddListener(self.delegateBtnClose)
	self.btnHarvestComponent.onClick:AddListener(self.delegateClickBtnHarvest)
	self.btnHelpComponent.onClick:AddListener(self.delegateBtnHelp)
	self.BtnLevelUp:GetComponent("Button").onClick:AddListener(self.delegateBtnLevelUp)
	self.BtnGuide:GetComponent("Button").onClick:AddListener(self.DelegateBtnGuide)
	EventDispatcher.AddEventListener(EventID.HomeUpdateBuildingEvent, self.delegateHomeUpdateBuildingEvent)
end

function HomeLandAlchemyUI:OnRemoveListeners()
	self.btnCloseComponent.onClick:RemoveListener(self.delegateBtnClose)
	self.btnHarvestComponent.onClick:RemoveListener(self.delegateClickBtnHarvest)
	self.btnHelpComponent.onClick:RemoveListener(self.delegateBtnHelp)
	self.BtnLevelUp:GetComponent("Button").onClick:RemoveListener(self.delegateBtnLevelUp)
	self.BtnGuide:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnGuide)
	EventDispatcher.RemoveEventListener(EventID.HomeUpdateBuildingEvent, self.delegateHomeUpdateBuildingEvent)
end

function HomeLandAlchemyUI:OnPause()
	return
end

function HomeLandAlchemyUI:OnResume()
	return
end

function HomeLandAlchemyUI:OnCover()
	return
end

function HomeLandAlchemyUI:OnReveal()
	return
end

function HomeLandAlchemyUI:OnRefocus(userData)
	return
end

function HomeLandAlchemyUI:OnUpdate(elapseSeconds, realElapseSeconds)
	if self.homeBuildingData ~= nil then
		local num = self:GetCurrentNum(self.homeBuildingData.buildingPOD.productionData)

		if num < self.homeBuildingData.buildingPOD.productionData.storageLimit then
			self:UpdateTime()
		end
	end
end

function HomeLandAlchemyUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function HomeLandAlchemyUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function HomeLandAlchemyUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function HomeLandAlchemyUI:OnDestroy()
	for i, v in pairs(self.ItemMouldObj) do
		self.ItemMouldPool:Release(v)
	end

	self.ItemMouldObj = {}

	self.ItemMouldPool:Dispose()
end

function HomeLandAlchemyUI:OnBtnClose()
	UIModule.Close(Constant.UIControllerName.HomeLandAlchemyUI)
end

function HomeLandAlchemyUI:OnClickBtnHarvest()
	if self.homeBuildingData ~= nil then
		local num = self:GetCurrentNum(self.homeBuildingData.buildingPOD.productionData)

		if num > 0 then
			HomeLandLuaModule.HarvestBuilding(self.homeBuildingData.cfgBuildingID)
			self:PlayStateEffect(2)
		else
			NoticeModule.ShowNoticeByType(1, HomeLandAlchemyUIApi:GetString("ErrorMsg"))
		end
	end
end

function HomeLandAlchemyUI:UpDateView()
	if self.homeBuildingData ~= nil then
		UGUIUtil.SetText(self.TextTitle, HomeLandAlchemyUIApi:GetString("TextTitle", self.homeBuildingData.buildingPOD.lv))

		self.TextPer:GetComponent("Text").text = ""

		local productionPOD = self.homeBuildingData.buildingPOD.productionData

		if productionPOD ~= nil then
			local outNum = self:GetCurrentNum(productionPOD)

			self.BtnGetReward:SetActive(outNum > 0)
			UGUIUtil.SetText(self.TextSpeed, HomeLandAlchemyUIApi:GetString("TextSpeed", productionPOD.oneProduceTime))
			UGUIUtil.SetText(self.TextMax, HomeLandAlchemyUIApi:GetString("TextMax", outNum, productionPOD.storageLimit))

			for i, v in pairs(self.ItemMouldObj) do
				v:SetActive(false)
				self.ItemMouldPool:Release(v)
			end

			self.ItemMouldObj = {}

			local tab = {}
			local showTab = HomeLandAlchemyUIApi:GetString("ShowItem")

			for i, v in pairs(showTab) do
				local num, tag = self:GetValue(v)
				local itemShowPOD = {}

				itemShowPOD.cid = v
				itemShowPOD.num = num
				itemShowPOD.tag = tag

				table.insert(tab, itemShowPOD)
			end

			for i = 1, #tab do
				local rendObj = self.ItemMouldPool:Obtain()

				rendObj:SetActive(true)
				rendObj.transform:SetParent(self.Grid.transform, false)

				local itemShowPOD = tab[i]
				local itemObj = rendObj.transform:Find("Slot/CommonSlotUI").gameObject
				local itemCell = ItemCell.PackageOrReuseView(self, itemObj)

				itemCell:SetItem(CfgItemTable[itemShowPOD.cid])
				itemCell:SetNum(itemShowPOD.num)
				UGUIUtil.SetText(rendObj.transform:Find("Text").gameObject, CfgItemTable[itemShowPOD.cid].Name)
				table.insert(self.ItemMouldObj, rendObj)
			end

			if outNum >= self.homeBuildingData.buildingPOD.productionData.storageLimit then
				self.ImgPer:GetComponent("Image").fillAmount = 1
			end
		end
	end
end

function HomeLandAlchemyUI:GetCurrentNum(productionPOD)
	local num = 0

	for i, v in pairs(productionPOD.output) do
		num = num + v
	end

	return num
end

function HomeLandAlchemyUI:GetValue(cid)
	local num = 0
	local tag = 0
	local productionPOD = self.homeBuildingData.buildingPOD.productionData

	for i, v in pairs(productionPOD.output) do
		if i == cid then
			num = v

			break
		end
	end

	return num, tag
end

function HomeLandAlchemyUI:OnBtnHelp()
	UIModule.Open(Constant.UIControllerName.TextTipsUI, Constant.UILayer.UI, {
		HomeLandAlchemyUIApi:GetString("TextTip", HomeLandLuaModule.GetHomeLandComfortLv())
	})
end

function HomeLandAlchemyUI:UpdateTime()
	local nowTime = PlayerModule.GetServerTime()
	local endTime = self.homeBuildingData.buildingPOD.productionData.nextProduceTime
	local totalTime = self.homeBuildingData.buildingPOD.productionData.oneProduceTime
	local per = 1 - (endTime - nowTime) / totalTime

	per = per < 0 and 0 or per
	self.ImgPer:GetComponent("Image").fillAmount = per

	if per < self.lastPer then
		self:PlayStateEffect(1)
		self:ShowGetPercent()
	end

	self.lastPer = per

	UGUIUtil.SetText(self.TextPer, tostring(self:GetFormatTime(endTime - nowTime)))
end

function HomeLandAlchemyUI:GetFormatTime(second)
	local timeText = ""
	local h = math.floor(second / 3600)

	h = h < 10 and "0" .. h or tostring(h)

	local m = math.floor(second % 3600 / 60)

	m = m < 10 and "0" .. m or tostring(m)

	local s = math.floor(second % 60)

	s = s < 10 and "0" .. s or tostring(s)
	timeText = string.format("%s:%s", m, s)

	return timeText
end

function HomeLandAlchemyUI:ShowGetPercent()
	local productionPOD = self.homeBuildingData.buildingPOD.productionData
	local num = self:GetCurrentNum(productionPOD)

	UGUIUtil.SetText(self.TextMax, HomeLandAlchemyUIApi:GetString("TextMax", num, productionPOD.storageLimit))
end

function HomeLandAlchemyUI:PlayStateEffect(type)
	return
end

function HomeLandAlchemyUI:OnHomeUpdateBuildingEvent(cfgBuildingID)
	if self.homeBuildingData ~= nil and self.homeBuildingData.buildingPOD.cid == cfgBuildingID then
		self.homeBuildingData = HomeLandLuaModule.GetBuildingDataByID(cfgBuildingID)

		self:UpDateView()

		if UnityEngine.Camera.main then
			local roomPOD = HomeLandLuaModule.GetRoomDataByID(self.homeBuildingData.cfgBuilding.BelongRoom)

			UnityEngine.Camera.main.transform.position = HomeLandAlchemyUIApi:GetString("CameraPosition", self.homeBuildingData.buildingPOD.lv, roomPOD.suitCid)
		end
	end
end

function HomeLandAlchemyUI:OnBtnLevelUp()
	UIModule.Open(Constant.UIControllerName.HomeLandFunctionLevelUpUI, Constant.UILayer.UI, {
		self.homeBuildingData.cfgBuildingID,
		self.decorate
	})
end

function HomeLandAlchemyUI:OnBtnGuide()
	UIModule.Open(Constant.UIControllerName.ComUIInfoUI, Constant.UILayer.UI, 4100)
end

return HomeLandAlchemyUI
