-- chunkname: @IQIGame\\UI\\HomeLandWorkSoulUI.lua

local HomeLandWorkSoulUI = Base:Extend("HomeLandWorkSoulUI", "IQIGame.Onigao.UI.HomeLandWorkSoulUI", {
	soulCellPool = {},
	headCellPool = {},
	itemCellPool = {},
	soulDatum = {}
})
local HLWorkSoulSoulCell = require("IQIGame.UI.HomeLand.HLWorkSoul.HLWorkSoulSoulCell")
local HLWorkSoulHeadCell = require("IQIGame.UI.HomeLand.HLWorkSoul.HLWorkSoulHeadCell")

function HomeLandWorkSoulUI:OnInit()
	self:Initialize()
end

function HomeLandWorkSoulUI:GetPreloadAssetPaths()
	return nil
end

function HomeLandWorkSoulUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function HomeLandWorkSoulUI:OnOpen(userData)
	self:Refresh(userData)
end

function HomeLandWorkSoulUI:OnClose(userData)
	self:OnHide()
end

function HomeLandWorkSoulUI:OnPause()
	return
end

function HomeLandWorkSoulUI:OnResume()
	return
end

function HomeLandWorkSoulUI:OnCover()
	return
end

function HomeLandWorkSoulUI:OnReveal()
	return
end

function HomeLandWorkSoulUI:OnRefocus(userData)
	return
end

function HomeLandWorkSoulUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function HomeLandWorkSoulUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function HomeLandWorkSoulUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function HomeLandWorkSoulUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function HomeLandWorkSoulUI:Initialize()
	for i = 1, 3 do
		local go = self.goHeadParent.transform:Find("Mould_" .. i).gameObject

		self.headCellPool[i] = HLWorkSoulHeadCell.New(go, self)
	end

	for i = 1, 3 do
		local go = self.goCellParent.transform:Find("Mould_" .. i):GetChild(0).gameObject

		self.itemCellPool[i] = ItemCell.PackageOrReuseView(self, go, true, true)
	end

	self.soulList = self.goSoulList:GetComponent("ScrollAreaList")

	function self.soulList.onRenderCell(cell)
		self:OnRenderSoul(cell)
	end

	function self.soulList.onSelectedCell(cell)
		self:OnSelectSoul(cell)
	end

	self.tfAffairName = self.goAffairName:GetComponent("Text")
	self.tfAffairDesc = self.goAffairDesc:GetComponent("Text")
	self.tfNeedSoulCount = self.goNeedSoulCount:GetComponent("Text")
	self.tfNeedMood = self.goNeedMood:GetComponent("Text")
	self.tfNeedFavorLv = self.goNeedFavorLv:GetComponent("Text")
	self.tfNeedTime = self.goNeedTime:GetComponent("Text")
	self.btnClose = self.goBtnClose:GetComponent("Button")
	self.btnWork = self.goBtnWork:GetComponent("Button")
	self.btnCloseTip = self.goBtnCloseTip:GetComponent("Button")

	function self.onClickBtnCloseDelegate()
		self:OnClickBtnClose()
	end

	function self.onClickBtnWorkDelegate()
		self:OnClickBtnWork()
	end

	function self.onWorkSuccessDelegate()
		self:OnWorkSuccess()
	end

	function self.onBuildingUpdateDelegate(userData)
		self:OnBuildingUpdate(userData)
	end

	function self.onClickBtnCloseTipDelegate()
		self:OnClickBtnCloseTip()
	end

	self.goBtnWork.transform:Find("Text"):GetComponent("Text").text = HomeLandWorkSoulUIApi:GetString("btnWorkTxt")
	self.goBtnWorkGray.transform:Find("Text"):GetComponent("Text").text = HomeLandWorkSoulUIApi:GetString("btnWorkTxt")
	self.goTips:GetComponent("Text").text = HomeLandWorkSoulUIApi:GetString("tips")
	self.goRewardTitle:GetComponent("Text").text = HomeLandWorkSoulUIApi:GetString("rewardTitle")
	self.goTip:GetComponent("Text").text = HomeLandWorkSoulUIApi:GetString("recommendTip")
	self.goDesc:GetComponent("Text").text = HomeLandWorkSoulUIApi:GetString("desc")
end

function HomeLandWorkSoulUI:Refresh(userData)
	self.selectedSoulDatum = {}
	self.buildingCid = userData[1]
	self.affairData = userData[2]

	self.goBtnCloseTip:SetActive(false)
	self:RefreshData()
	self:RefreshMisc()
	self:RefreshSoulList()
	self:RefreshHeadBlock()
end

function HomeLandWorkSoulUI:OnAddListeners()
	self.goBtnClose1:GetComponent("Button").onClick:AddListener(self.onClickBtnCloseDelegate)
	self.btnClose.onClick:AddListener(self.onClickBtnCloseDelegate)
	self.btnWork.onClick:AddListener(self.onClickBtnWorkDelegate)
	self.btnCloseTip.onClick:AddListener(self.onClickBtnCloseTipDelegate)
	EventDispatcher.AddEventListener(EventID.HLWorkSuccess, self.onWorkSuccessDelegate)
	EventDispatcher.AddEventListener(EventID.HomeUpdateBuildingEvent, self.onBuildingUpdateDelegate)
end

function HomeLandWorkSoulUI:OnRemoveListeners()
	self.goBtnClose1:GetComponent("Button").onClick:RemoveListener(self.onClickBtnCloseDelegate)
	self.btnClose.onClick:RemoveListener(self.onClickBtnCloseDelegate)
	self.btnWork.onClick:RemoveListener(self.onClickBtnWorkDelegate)
	self.btnCloseTip.onClick:RemoveListener(self.onClickBtnCloseTipDelegate)
	EventDispatcher.RemoveEventListener(EventID.HLWorkSuccess, self.onWorkSuccessDelegate)
	EventDispatcher.RemoveEventListener(EventID.HomeUpdateBuildingEvent, self.onBuildingUpdateDelegate)
end

function HomeLandWorkSoulUI:OnHide()
	for i, v in pairs(self.headCellPool) do
		v:OnHide()
	end
end

function HomeLandWorkSoulUI:OnDestroy()
	for i, v in pairs(self.headCellPool) do
		v:OnDestroy()
	end

	for i, v in pairs(self.itemCellPool) do
		v:Dispose()
	end
end

function HomeLandWorkSoulUI:OnClickBtnClose()
	UIModule.CloseSelf(self)
end

function HomeLandWorkSoulUI:OnClickBtnCloseTip()
	self.goBtnCloseTip:SetActive(false)
end

function HomeLandWorkSoulUI:OnClickBtnWork()
	if not HLWorkModule.CheckWorkTimesOk() then
		NoticeModule.ShowNoticeNoCallback(21042019)

		return
	end

	if #self.selectedSoulDatum < self.affairData.cfgAffairData.SoulNumNeed[1] then
		return
	end

	local cids = {}

	for i, v in ipairs(self.selectedSoulDatum) do
		cids[i] = v.soulCid
	end

	HLWorkModule.ReqStartWork(self.buildingCid, cids, self.affairData)
end

function HomeLandWorkSoulUI:OnWorkSuccess()
	self:OnClickBtnClose()
end

function HomeLandWorkSoulUI:OnRenderSoul(cell)
	local luaIndex = cell.index + 1
	local insID = cell.gameObject:GetInstanceID()
	local data = self.soulDatum[luaIndex]
	local soulCell = self.soulCellPool[insID]

	if soulCell == nil then
		soulCell = HLWorkSoulSoulCell.New(cell.gameObject, self)
		self.soulCellPool[insID] = soulCell
	end

	soulCell:Refresh(data, self.affairData)

	local isSelected = self:CheckIsSelectedSoul(data)

	soulCell:SetSignSelectedVisible(isSelected)
end

function HomeLandWorkSoulUI:OnSelectSoul(cell)
	local luaIndex = cell.index + 1
	local insID = cell.gameObject:GetInstanceID()
	local data = self.soulDatum[luaIndex]
	local isSelected = self:CheckIsSelectedSoul(data)
	local soulCell = self.soulCellPool[insID]

	if isSelected then
		local index = self:GetSelectedSoulDataIndex(data)

		table.remove(self.selectedSoulDatum, index)
		soulCell:SetSignSelectedVisible(false)
		self:RefreshHeadBlock()
	elseif self:CheckCanSelectSoul(data) then
		self.selectedSoulDatum[#self.selectedSoulDatum + 1] = data

		soulCell:SetSignSelectedVisible(true)
		self:RefreshHeadBlock()
	end

	self:RefreshMisc()
end

function HomeLandWorkSoulUI:OnBuildingUpdate(userData)
	if self.buildingCid ~= userData then
		return
	end

	if self.affairData.status == 3 then
		self:OnClickBtnClose()

		return
	end

	self.soulList:RenderCells()
end

function HomeLandWorkSoulUI:RefreshData()
	self.soulDatum = {}

	for i, v in pairs(SoulModule.GetSortedUnlockSoulDataList()) do
		self.soulDatum[#self.soulDatum + 1] = v
	end

	if #self.soulDatum > 1 then
		table.sort(self.soulDatum, function(a, b)
			if a.workStatus == Constant.Soul.WorkStatusNone and b.workStatus == Constant.Soul.WorkStatusNone then
				if a.mood > b.mood then
					return true
				end

				if a.mood == b.mood then
					if a.favorLv > b.favorLv then
						return true
					end

					if a.favorLv == b.favorLv and a:GetCfgSoul().Id < b:GetCfgSoul().Id then
						return true
					end
				end

				return false
			end

			if a.workStatus == Constant.Soul.WorkStatusNone then
				return true
			end

			if b.workStatus == Constant.Soul.WorkStatusNone then
				return false
			end

			if a.workStatus == Constant.Soul.WorkStatusWorking and b.workStatus ~= Constant.Soul.WorkStatusWorking then
				return true
			end

			if a.workStatus == Constant.Soul.WorkStatusWorking and b.workStatus == Constant.Soul.WorkStatusWorking then
				if a.mood == b.mood and a:GetCfgSoul().Id < b:GetCfgSoul().Id then
					return true
				end

				return false
			end

			if b.workStatus == Constant.Soul.WorkStatusWorking then
				return false
			end

			if a.mood == b.mood and a:GetCfgSoul().Id < b:GetCfgSoul().Id then
				return true
			end

			return false
		end)
	end

	for i, v in ipairs(self.soulDatum) do
		for m, n in pairs(self.affairData.soulCids) do
			if v.soulCid == n then
				self.selectedSoulDatum[#self.selectedSoulDatum + 1] = v
			end
		end
	end
end

function HomeLandWorkSoulUI:RefreshMisc()
	self.tfAffairName.text = HomeLandWorkSoulUIApi:GetString("affairName", self.affairData.cfgAffairData.WorkName)
	self.tfAffairDesc.text = HomeLandWorkSoulUIApi:GetString("affairDesc", self.affairData.cfgAffairData.WorkWord)
	self.tfNeedSoulCount.text = HomeLandWorkSoulUIApi:GetString("needSoulCount", self.affairData.cfgAffairData.SoulNumNeed[1], self.affairData.cfgAffairData.SoulNumNeed[2])
	self.tfNeedMood.text = HomeLandWorkSoulUIApi:GetString("needMood", self.affairData.cfgAffairData.ModeNum)
	self.tfNeedFavorLv.text = HomeLandWorkSoulUIApi:GetString("needFavorLv", self.affairData.cfgAffairData.FavorLevel)

	local buildingData = HomeLandLuaModule.GetBuildingDataByID(self.buildingCid)
	local cfgLvData = buildingData:GetCfgBuildLevelUpByLv(buildingData.buildingPOD.lv)

	self.tfNeedTime.text = HomeLandWorkSoulUIApi:GetString("needTime", getTimeDurationText2(self.affairData.cfgAffairData.WorkNeedTime), cfgLvData.Params[1][1])

	for i, v in ipairs(self.itemCellPool) do
		v.ViewGo.transform.parent.gameObject:SetActive(i <= #self.affairData.cfgAffairData.Reward / 2)
	end

	local idleGridIndex = 1

	for i, v in ipairs(self.affairData.cfgAffairData.Reward) do
		if i % 2 ~= 0 then
			local id = v
			local count = self.affairData.cfgAffairData.Reward[i + 1]

			if #self.selectedSoulDatum > 0 then
				count = count * #self.selectedSoulDatum
			end

			self.itemCellPool[idleGridIndex]:SetItemByCID(id, count)

			idleGridIndex = idleGridIndex + 1
		end
	end
end

function HomeLandWorkSoulUI:RefreshSoulList()
	self.soulList:Refresh(#self.soulDatum)
end

function HomeLandWorkSoulUI:RefreshHeadBlock()
	for i, v in ipairs(self.headCellPool) do
		v:SetActive(i <= self.affairData.cfgAffairData.SoulNumNeed[2])

		if i <= self.affairData.cfgAffairData.SoulNumNeed[2] then
			local data = self.selectedSoulDatum[i]

			v:Refresh(data)
		end
	end

	self:RefreshBtnWork()
end

function HomeLandWorkSoulUI:RefreshBtnWork()
	local isOK = #self.selectedSoulDatum >= self.affairData.cfgAffairData.SoulNumNeed[1]

	self.goBtnWorkGray:SetActive(not isOK)
	self.goBtnWork:SetActive(isOK)
end

function HomeLandWorkSoulUI:ClearSelectedSoul(soulData)
	if self.affairData.status == 1 then
		return
	end

	local index = self:GetSelectedSoulDataIndex(soulData)

	table.remove(self.selectedSoulDatum, index)
	self.soulList:RenderCells()
	self:RefreshHeadBlock()
end

function HomeLandWorkSoulUI:ShowTip()
	self.goBtnCloseTip:SetActive(true)
end

function HomeLandWorkSoulUI:CheckIsSelectedSoul(soulData)
	for i, v in pairs(self.selectedSoulDatum) do
		if v.soulCid == soulData.soulCid then
			return true
		end
	end

	return false
end

function HomeLandWorkSoulUI:CheckCanSelectSoul(soulData)
	if #self.selectedSoulDatum >= self.affairData.cfgAffairData.SoulNumNeed[2] then
		NoticeModule.ShowNoticeNoCallback(21042029)

		return false
	end

	if soulData.workStatus == Constant.Soul.WorkStatusWorking then
		NoticeModule.ShowNoticeNoCallback(21042025)

		return false
	end

	if soulData.mood < self.affairData.cfgAffairData.ModeNum then
		NoticeModule.ShowNoticeNoCallback(21042027)

		return false
	end

	if soulData.favorLv < self.affairData.cfgAffairData.FavorLevel then
		NoticeModule.ShowNoticeNoCallback(21042028)

		return false
	end

	return true
end

function HomeLandWorkSoulUI:GetSelectedSoulDataIndex(soulData)
	for i, v in ipairs(self.selectedSoulDatum) do
		if v.soulCid == soulData.soulCid then
			return i
		end
	end

	return nil
end

return HomeLandWorkSoulUI
