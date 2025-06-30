-- chunkname: @IQIGame\\UI\\HomeLandWorkListUI.lua

local HomeLandWorkListUI = Base:Extend("HomeLandWorkListUI", "IQIGame.Onigao.UI.HomeLandWorkListUI", {
	cellPool = {},
	cfgBuildingLvUpDatum = {}
})
local HLWorkListCell = require("IQIGame.UI.HomeLand.HLWorkList.HLWorkListCell")
local WorkRecordView = require("IQIGame.UI.HomeLand.HLWorkList.WorkRecordView")

function HomeLandWorkListUI:OnInit()
	self:Initialize()
end

function HomeLandWorkListUI:GetPreloadAssetPaths()
	return nil
end

function HomeLandWorkListUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function HomeLandWorkListUI:IsManualShowOnOpen(userData)
	return false
end

function HomeLandWorkListUI:GetBGM(userData)
	return nil
end

function HomeLandWorkListUI:OnOpen(userData)
	self.goBtnQuickStartWork:SetActive(true)
	self:Refresh(userData)
end

function HomeLandWorkListUI:OnClose(userData)
	self:OnHide()
end

function HomeLandWorkListUI:OnPause()
	return
end

function HomeLandWorkListUI:OnResume()
	return
end

function HomeLandWorkListUI:OnCover()
	return
end

function HomeLandWorkListUI:OnReveal()
	return
end

function HomeLandWorkListUI:OnRefocus(userData)
	return
end

function HomeLandWorkListUI:OnUpdate(elapseSeconds, realElapseSeconds)
	for i, v in pairs(self.cellPool) do
		v:OnUpdate(realElapseSeconds)
	end
end

function HomeLandWorkListUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function HomeLandWorkListUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function HomeLandWorkListUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function HomeLandWorkListUI:Initialize()
	self.workRecordView = WorkRecordView.New(self.goRecordView)
	self.cellMaxCount = CfgDiscreteDataTable[6520036].Data[3]

	for i = 1, self.cellMaxCount do
		if i == 1 then
			self.cellPool[i] = HLWorkListCell.New(self.goWorkCell)
		else
			local go = UnityEngine.Object.Instantiate(self.goWorkCell)

			go.transform:SetParent(self.goWorkCell.transform.parent, false)

			self.cellPool[i] = HLWorkListCell.New(go)
		end
	end

	self.tfTitle = self.goTitle:GetComponent("Text")
	self.tfCountDesc = self.goCountDesc:GetComponent("Text")
	self.btnClose = self.goBtnClose:GetComponent("Button")
	self.btnLvUp = self.goBtnLvUp:GetComponent("Button")
	self.btnShop = self.goBtnShop:GetComponent("Button")
	self.btnRecord = self.goBtnRecord:GetComponent("Button")

	function self.onClickBtnRecordDelegate()
		self:OnClickBtnRecord()
	end

	function self.onClickBtnCloseDelegate()
		self:OnClickBtnClose()
	end

	function self.onClickBtnLvUpDelegate()
		self:OnClickBtnLvUp()
	end

	function self.onBuildingUpdateDelegate(userData)
		self:OnBuildingUpdate(userData)
	end

	function self.onWorkSuccessDelegate()
		self:OnWorkSuccess()
	end

	function self.onClickBtnShopDelegate()
		self:OnClickBtnShop()
	end

	function self.onUpdateDailySupplyDelegate()
		self:OnUpdateDailySupply()
	end

	function self.DelegateBtnQuickWork()
		self:OnBtnQuickWork()
	end

	function self.DelegateBtnGuide()
		self.OnBtnGuide()
	end

	self.goBtnLvUp.transform:Find("Text"):GetComponent("Text").text = HomeLandWorkListUIApi:GetString("btnLvUpTxt")
	self.goBtnShop.transform:Find("Text"):GetComponent("Text").text = HomeLandWorkListUIApi:GetString("btnShopTxt")
	self.goBtnRecord.transform:Find("Text"):GetComponent("Text").text = HomeLandWorkListUIApi:GetString("btnRecordTxt")
end

function HomeLandWorkListUI:Refresh(userData)
	self.buildingCid = userData[1]
	self.decorate = userData[2]
	self.workData = HLWorkModule.GetWorkData(self.buildingCid)

	self.workRecordView:Close()
	self:RefreshMisc()
	self:RefreshData()
	self:RefreshCells()
end

function HomeLandWorkListUI:OnHide()
	for i, v in pairs(self.cellPool) do
		v:OnHide()
	end

	self.workRecordView:OnHide()
end

function HomeLandWorkListUI:OnDestroy()
	for i, v in pairs(self.cellPool) do
		v:OnDestroy()
	end

	self.workRecordView:OnDestroy()
end

function HomeLandWorkListUI:OnAddListeners()
	EventDispatcher.AddEventListener(EventID.HomeUpdateBuildingEvent, self.onBuildingUpdateDelegate)
	EventDispatcher.AddEventListener(EventID.HLWorkSuccess, self.onWorkSuccessDelegate)
	EventDispatcher.AddEventListener(EventID.UpdateDailySupply, self.onUpdateDailySupplyDelegate)
	self.btnShop.onClick:AddListener(self.onClickBtnShopDelegate)
	self.btnClose.onClick:AddListener(self.onClickBtnCloseDelegate)
	self.btnLvUp.onClick:AddListener(self.onClickBtnLvUpDelegate)
	self.btnRecord.onClick:AddListener(self.onClickBtnRecordDelegate)
	self.goBtnQuickStartWork:GetComponent("Button").onClick:AddListener(self.DelegateBtnQuickWork)

	for i, v in pairs(self.cellPool) do
		v:OnAddListeners()
	end

	self.BtnGuide:GetComponent("Button").onClick:AddListener(self.DelegateBtnGuide)
	self.workRecordView:OnAddListeners()
end

function HomeLandWorkListUI:OnRemoveListeners()
	EventDispatcher.RemoveEventListener(EventID.HomeUpdateBuildingEvent, self.onBuildingUpdateDelegate)
	EventDispatcher.RemoveEventListener(EventID.HLWorkSuccess, self.onWorkSuccessDelegate)
	EventDispatcher.RemoveEventListener(EventID.UpdateDailySupply, self.onUpdateDailySupplyDelegate)
	self.btnShop.onClick:RemoveListener(self.onClickBtnShopDelegate)
	self.btnClose.onClick:RemoveListener(self.onClickBtnCloseDelegate)
	self.btnLvUp.onClick:RemoveListener(self.onClickBtnLvUpDelegate)
	self.btnRecord.onClick:RemoveListener(self.onClickBtnRecordDelegate)
	self.goBtnQuickStartWork:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnQuickWork)

	for i, v in pairs(self.cellPool) do
		v:OnRemoveListeners()
	end

	self.BtnGuide:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnGuide)
	self.workRecordView:OnRemoveListeners()
end

function HomeLandWorkListUI:OnClickBtnClose()
	UIModule.CloseSelf(self)
end

function HomeLandWorkListUI:OnClickBtnRecord()
	self.workRecordView:Open(HLWorkModule.GetRecordDataList())
end

function HomeLandWorkListUI:OnWorkSuccess()
	self:RefreshCells()
	self:RefreshMisc()
end

function HomeLandWorkListUI:OnBuildingUpdate(userData)
	if self.buildingCid ~= userData then
		return
	end

	self:RefreshMisc()
	self:RefreshCells()
end

function HomeLandWorkListUI:OnClickBtnLvUp()
	UIModule.Open(Constant.UIControllerName.HomeLandFunctionLevelUpUI, Constant.UILayer.UI, {
		self.buildingCid,
		self.decorate
	})
end

function HomeLandWorkListUI:OnClickBtnShop()
	JumpModule.Jump(10202022)
end

function HomeLandWorkListUI:OnUpdateDailySupply()
	self:RefreshMisc()
end

function HomeLandWorkListUI:RefreshData()
	for i, v in pairsCfg(CfgHomeLandBuildingLevelUpTable) do
		if v.BuildingId == self.buildingCid then
			for m, n in ipairs(v.Type) do
				if n == 15 then
					self.cfgBuildingLvUpDatum[#self.cfgBuildingLvUpDatum + 1] = v

					break
				end
			end
		end
	end

	if #self.cfgBuildingLvUpDatum > 2 then
		table.sort(self.cfgBuildingLvUpDatum, function(a, b)
			return a.Level < b.Level
		end)
	end
end

function HomeLandWorkListUI:RefreshMisc()
	self.tfTitle.text = HomeLandWorkListUIApi:GetString("title", HomeLandLuaModule.GetBuildingDataByID(self.buildingCid).buildingPOD.lv)

	local limitTimes = HLWorkModule.GetWorkLimitTimes()

	self.tfCountDesc.text = HomeLandWorkListUIApi:GetString("countDesc", limitTimes - HLWorkModule.todayHomeWorkCount, limitTimes)
end

function HomeLandWorkListUI:RefreshCells()
	for i, v in ipairs(self.cellPool) do
		local data = self.workData.affairDatum[i]
		local cfgLvUpData, paramIndex

		for m, n in ipairs(self.cfgBuildingLvUpDatum) do
			for k, j in ipairs(n.Type) do
				if j == 15 then
					paramIndex = k

					break
				end
			end

			if i <= n.Params[paramIndex][1] then
				cfgLvUpData = n

				break
			end
		end

		v:Refresh(i, data, self.buildingCid, cfgLvUpData)
	end
end

function HomeLandWorkListUI:OnBtnGuide()
	UIModule.Open(Constant.UIControllerName.ComUIInfoUI, Constant.UILayer.UI, 4400)
end

function HomeLandWorkListUI:OnBtnQuickWork()
	if not HLWorkModule.CheckWorkTimesOk() then
		NoticeModule.ShowNoticeNoCallback(21042046)

		return
	end

	HLWorkModule.ReqStartWork(self.buildingCid, nil, nil)
end

return HomeLandWorkListUI
