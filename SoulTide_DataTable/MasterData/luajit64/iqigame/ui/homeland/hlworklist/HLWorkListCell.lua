-- chunkname: @IQIGame\\UI\\HomeLand\\HLWorkList\\HLWorkListCell.lua

local HLWorkListCell = {
	startTimer = false,
	itemCellPool = {},
	starSmallPool = {},
	headCellPool = {}
}
local D3Cell = require("IQIGame.UI.HomeLand.HLWorkList.D3Cell")

function HLWorkListCell.New(view)
	local obj = Clone(HLWorkListCell)

	obj:Init(view)

	return obj
end

function HLWorkListCell:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	for i = 1, 3 do
		local go = self.goCellParent.transform:Find("Mould_" .. i):GetChild(0).gameObject

		self.itemCellPool[i] = ItemCell.PackageOrReuseView(self, go, true, true)
	end

	for i = 1, 3 do
		self.headCellPool[i] = self.goHeadCellParent.transform:Find("Mould_" .. i).gameObject
	end

	self.d3Cell = D3Cell.New()
	self.starSmallPool[1] = self.goStarSmall
	self.tfAffairName = self.goAffairName:GetComponent("Text")
	self.tfRewardEng = self.goRewardEng:GetComponent("Text")
	self.tfStatusDesc = self.goStatusDesc:GetComponent("Text")
	self.tfMood = self.goMood:GetComponent("Text")
	self.tfFavor = self.goFavor:GetComponent("Text")
	self.tfSoulCount = self.goSoulCount:GetComponent("Text")
	self.tfResidueTime = self.goResidueTime:GetComponent("Text")
	self.tfResidueTime2 = self.goResidueTime2:GetComponent("Text")
	self.tfBestSoulName = self.goBestSoulName:GetComponent("Text")
	self.imgStatusBg = self.goStatusBg:GetComponent("Image")
	self.imgNameBg = self.goNameBg:GetComponent("Image")
	self.imgCellBg = self.goCellBg:GetComponent("Image")
	self.btnSelf = self.goBtnSelf:GetComponent("Button")
	self.btnSwitch = self.goBtnSwitch:GetComponent("Button")
	self.btnGetReward = self.goBtnReward:GetComponent("Button")
	self.btnGiveUp = self.goBtnGiveUp:GetComponent("Button")
	self.btnRefresh = self.goBtnRefresh:GetComponent("Button")

	function self.onClickBtnRefreshDelegate()
		self:OnClickBtnRefresh()
	end

	function self.onClickBtnSelfDelegate()
		self:OnClickSelf()
	end

	function self.onClickBtnGetRewardDelegate()
		self:OnClickBtnGetReward()
	end

	function self.onClickBtnGiveUpDelegate()
		self:OnClickBtnGiveUp()
	end

	function self.onConfirmDelegate()
		self:OnConfirm()
	end

	function self.onClickBtnSwitchDelegate()
		self:OnClickBtnSwitch()
	end

	self.goMoodTitle:GetComponent("Text").text = HomeLandWorkListUIApi:GetString("needMoodTitle")
	self.goCountTitle:GetComponent("Text").text = HomeLandWorkListUIApi:GetString("needCountTitle")
	self.goFavorTitle:GetComponent("Text").text = HomeLandWorkListUIApi:GetString("needFavorTitle")
	self.tfFree = self.goBtnRefresh.transform:Find("Type_Free/Text"):GetComponent("Text")
	self.goBtnRefresh.transform:Find("Text"):GetComponent("Text").text = HomeLandWorkListUIApi:GetString("btnRefreshTxt")
	self.goBtnRefresh.transform:Find("Type_Cost/Text"):GetComponent("Text").text = HomeLandWorkListUIApi:GetString("refreshCost", CfgDiscreteDataTable[6520058].Data[2])

	local path = UIGlobalApi.GetIconPath(CfgItemTable[CfgDiscreteDataTable[6520058].Data[1]].Icon)

	AssetUtil.LoadImage(self, path, self.goBtnRefresh.transform:Find("Type_Cost/Image_Icon"):GetComponent("Image"))

	self.goTimeTitle:GetComponent("Text").text = HomeLandWorkListUIApi:GetString("timeTitle")
end

function HLWorkListCell:OnUpdate(elapseTime)
	if self.startTimer and self.affairData.status ~= 2 then
		self.timer = self.timer + elapseTime

		if self.timer >= 1 then
			self:UpdateTime()

			self.timer = 0
		end
	end
end

function HLWorkListCell:Refresh(index, affairData, buildingCid, cfgLvUpData)
	self.index = index
	self.affairData = affairData
	self.buildingCid = buildingCid
	self.cfgLvUpData = cfgLvUpData
	self.workData = HLWorkModule.GetWorkData(self.buildingCid)

	self:RefreshMisc()
	self:RefreshTime()
	self:Show3DMould()
end

function HLWorkListCell:OnHide()
	self.d3Cell:OnHide()
	self:StopTimer()
end

function HLWorkListCell:OnDestroy()
	self.index = nil

	self.d3Cell:OnDestroy()

	for i, v in pairs(self.itemCellPool) do
		v:Dispose()
	end

	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

function HLWorkListCell:OnAddListeners()
	self.btnSelf.onClick:AddListener(self.onClickBtnSelfDelegate)
	self.btnGiveUp.onClick:AddListener(self.onClickBtnGiveUpDelegate)
	self.btnGetReward.onClick:AddListener(self.onClickBtnGetRewardDelegate)
	self.btnSwitch.onClick:AddListener(self.onClickBtnSwitchDelegate)
	self.btnRefresh.onClick:AddListener(self.onClickBtnRefreshDelegate)
end

function HLWorkListCell:OnRemoveListeners()
	self.btnSelf.onClick:RemoveListener(self.onClickBtnSelfDelegate)
	self.btnGiveUp.onClick:RemoveListener(self.onClickBtnGiveUpDelegate)
	self.btnGetReward.onClick:RemoveListener(self.onClickBtnGetRewardDelegate)
	self.btnSwitch.onClick:RemoveListener(self.onClickBtnSwitchDelegate)
	self.btnRefresh.onClick:RemoveListener(self.onClickBtnRefreshDelegate)
end

function HLWorkListCell:OnClickSelf()
	if self.affairData == nil then
		return
	end

	if self.affairData.status == 1 then
		HLWorkModule.EnterWorkRoom(self.affairData)

		return
	elseif self.affairData.status == 2 then
		self:OnClickBtnGetReward()

		return
	elseif self.affairData.status == 3 then
		NoticeModule.ShowNoticeNoCallback(21042023)

		return
	end

	UIModule.Open(Constant.UIControllerName.HomeLandWorkSoulUI, Constant.UILayer.UI, {
		self.buildingCid,
		self.affairData
	})
end

function HLWorkListCell:OnClickBtnRefresh()
	HLWorkModule.ReqRefreshAffair(self.affairData.id, self.buildingCid, self.workData.residueFreeRefreshTimes > 0)
end

function HLWorkListCell:OnClickBtnGetReward()
	HLWorkModule.ReqGetReward(self.buildingCid, self.affairData.id)
end

function HLWorkListCell:OnClickBtnGiveUp()
	NoticeModule.ShowNotice(21042024, self.onConfirmDelegate)
end

function HLWorkListCell:OnConfirm()
	if self.affairData.status == 1 then
		HLWorkModule.ReqGiveUpWork(self.affairData.id, self.buildingCid)
	end
end

function HLWorkListCell:OnClickBtnSwitch()
	self.go3DBlock.transform.parent.gameObject:SetActive(not self.go3DBlock.transform.parent.gameObject.activeSelf)
end

function HLWorkListCell:OnLoad3DMouldSuccess(assetName, asset, duration, userData)
	if self.index ~= userData then
		return
	end

	local go = UnityEngine.Object.Instantiate(asset)

	go.transform:SetParent(self.go3DBlock.transform, false)
	self.d3Cell:Refresh(go, self.affairData)
end

function HLWorkListCell:RefreshMisc()
	self.go3DBlock.transform.parent.gameObject:SetActive(self.affairData.status == 1)
	self.goBtnReward:SetActive(self.affairData.status == 2)
	self.goBtnGiveUp:SetActive(self.affairData.status == 1)
	self.goBtnRefresh:SetActive(self.affairData.status == 0)
	self.goBtnSwitch:SetActive(self.affairData.status == 1)

	local isFree = self.workData.residueFreeRefreshTimes > 0

	self.goBtnRefresh.transform:Find("Type_Free").gameObject:SetActive(isFree)
	self.goBtnRefresh.transform:Find("Type_Cost").gameObject:SetActive(not isFree)

	self.tfFree.text = HomeLandWorkListUIApi:GetString("freeDesc", self.workData.residueFreeRefreshTimes, HLWorkModule.todayHomeWorkCount == 0)

	AssetUtil.LoadImage(self, HomeLandWorkListUIApi:GetString("statusBgPath", self.affairData.status), self.imgStatusBg)
	AssetUtil.LoadImage(self, HomeLandWorkListUIApi:GetString("nameBgPath", self.affairData.status), self.imgNameBg)
	AssetUtil.LoadImage(self, HomeLandWorkListUIApi:GetString("cellBg", self.affairData.status), self.imgCellBg)

	self.tfAffairName.text = HomeLandWorkListUIApi:GetString("affairName", self.affairData.cfgAffairData.WorkName)
	self.tfRewardEng.text = HomeLandWorkListUIApi:GetString("rewardEng", self.affairData ~= nil, self.affairData.status)
	self.tfStatusDesc.text = HomeLandWorkListUIApi:GetString("statusDesc", self.affairData.status)
	self.tfMood.text = HomeLandWorkListUIApi:GetString("needMood", self.affairData.cfgAffairData.ModeNum, self.affairData.status)
	self.tfSoulCount.text = HomeLandWorkListUIApi:GetString("needCount", self.affairData.status, self.affairData.cfgAffairData.SoulNumNeed[2])
	self.tfFavor.text = HomeLandWorkListUIApi:GetString("needFavor", self.affairData.status, self.affairData.cfgAffairData.FavorLevel)

	local names = {}

	if #self.affairData.cfgAffairData.RecommendSoul > 0 then
		for i, v in ipairs(self.affairData.cfgAffairData.RecommendSoul) do
			names[#names + 1] = CfgSoulTable[v].Name
		end

		self.tfBestSoulName.text = HomeLandWorkListUIApi:GetString("bestSoulName", names)
	end

	self.goBestSoulName:SetActive(#names > 0)

	for i, v in ipairs(self.itemCellPool) do
		v.ViewGo.transform.parent.gameObject:SetActive(i <= #self.affairData.cfgAffairData.Reward / 2)
	end

	local idleGridIndex = 1

	for i, v in ipairs(self.affairData.cfgAffairData.Reward) do
		if i % 2 ~= 0 then
			local id = v
			local count = self.affairData.cfgAffairData.Reward[i + 1]

			if #self.affairData.soulCids > 0 then
				count = count * #self.affairData.soulCids
			end

			self.itemCellPool[idleGridIndex]:SetItemByCID(id, count)

			idleGridIndex = idleGridIndex + 1
		end
	end

	self:RefreshStarBlock()
	self:RefreshHeadCellBlock()
end

function HLWorkListCell:RefreshHeadCellBlock()
	for i, v in ipairs(self.headCellPool) do
		v:SetActive(i <= #self.affairData.soulCids)
	end

	for i, v in ipairs(self.affairData.soulCids) do
		local go = self.headCellPool[i]
		local icon = go.transform:Find("Img_Soul").gameObject:GetComponent("Image")

		AssetUtil.LoadImage(self, UIGlobalApi.GetImagePath(SoulModule.GetSoulData(v):GetCfgSoulRes2D().HomelandHeadIcon), icon)
	end
end

function HLWorkListCell:RefreshStarBlock()
	if self.affairData.cfgAffairData.WorkStarLevel == 6 then
		for i, v in ipairs(self.starSmallPool) do
			v:SetActive(false)
		end
	else
		for i, v in ipairs(self.starSmallPool) do
			v:SetActive(i <= self.affairData.cfgAffairData.WorkStarLevel)
		end

		for i = 1, self.affairData.cfgAffairData.WorkStarLevel do
			self:ShowSmallStar(i)
		end
	end
end

function HLWorkListCell:ShowSmallStar(index)
	local ret = self.starSmallPool[index]

	if ret == nil then
		ret = UnityEngine.Object.Instantiate(self.goStarSmall)

		ret.transform:SetParent(self.goStarSmall.transform.parent, false)

		self.starSmallPool[index] = ret
	end

	ret:SetActive(true)

	return ret
end

function HLWorkListCell:Show3DMould()
	if self.affairData == nil then
		return
	end

	if self.affairData.status == 0 or self.affairData.status == 1 then
		local path = UIGlobalApi.GetUIPrefab(self.affairData.cfgAffairData.UiPrefabs)

		AssetUtil.LoadAsset(self, path, self.OnLoad3DMouldSuccess, nil, self.index)
	end
end

function HLWorkListCell:RefreshTime()
	if self.affairData == nil then
		return
	end

	if self.affairData.status == 0 or self.affairData.status == 3 then
		self.tfResidueTime.text = HomeLandWorkListUIApi:GetString("residueTime", getTimeDurationText2(self.affairData.cfgAffairData.WorkNeedTime))
		self.tfResidueTime2.text = self.tfResidueTime.text
	elseif self.affairData.status == 2 then
		self.tfResidueTime.text = HomeLandWorkListUIApi:GetString("residueTime", getTimeDurationText2(0))
		self.tfResidueTime2.text = self.tfResidueTime.text
	end

	if self.affairData.status == 0 or self.affairData.status == 1 or self.affairData.status == 3 then
		self:StartTimer()
	end
end

function HLWorkListCell:UpdateTime()
	local time = self.affairData.finishTime - PlayerModule.GetServerTime()

	if time < 0 then
		time = 0
	end

	if self.affairData.status == 1 or self.affairData.status == 2 then
		self.tfResidueTime.text = HomeLandWorkListUIApi:GetString("residueTime", getTimeDurationText2(time))
		self.tfResidueTime2.text = self.tfResidueTime.text
	end
end

function HLWorkListCell:StartTimer()
	self.startTimer = true
	self.timer = 0

	self:UpdateTime()
end

function HLWorkListCell:StopTimer()
	self.startTimer = false
end

return HLWorkListCell
