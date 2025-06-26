-- chunkname: @IQIGame\\UI\\HomeLandWorkRoomUI.lua

local HomeLandWorkRoomUI = Base:Extend("HomeLandWorkRoomUI", "IQIGame.Onigao.UI.HomeLandWorkRoomUI", {
	startTimer = false,
	cellPool = {},
	itemCellPool = {}
})

function HomeLandWorkRoomUI:OnInit()
	self:Initialize()
end

function HomeLandWorkRoomUI:GetPreloadAssetPaths()
	return nil
end

function HomeLandWorkRoomUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function HomeLandWorkRoomUI:IsManualShowOnOpen(userData)
	return false
end

function HomeLandWorkRoomUI:GetBGM(userData)
	return nil
end

function HomeLandWorkRoomUI:OnOpen(userData)
	self:Refresh(userData)
end

function HomeLandWorkRoomUI:OnClose(userData)
	self:OnHide()
end

function HomeLandWorkRoomUI:OnPause()
	return
end

function HomeLandWorkRoomUI:OnResume()
	return
end

function HomeLandWorkRoomUI:OnCover()
	return
end

function HomeLandWorkRoomUI:OnReveal()
	return
end

function HomeLandWorkRoomUI:OnRefocus(userData)
	return
end

function HomeLandWorkRoomUI:OnUpdate(elapseSeconds, realElapseSeconds)
	if self.startTimer and self.affairData.status ~= 2 then
		self.timer = self.timer + elapseSeconds

		if self.timer >= 1 then
			self:UpdateTime()

			self.timer = 0
		end
	end
end

function HomeLandWorkRoomUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function HomeLandWorkRoomUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function HomeLandWorkRoomUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function HomeLandWorkRoomUI:Initialize()
	self.tw = self.goTween:GetComponent("TweenPosition")
	self.tfWorkName = self.goWorkName:GetComponent("Text")
	self.tfWorkDesc = self.goWorkDesc:GetComponent("Text")

	for i = 1, 3 do
		local go = self.goCellParent.transform:Find("Mould_" .. i):GetChild(0).gameObject

		self.itemCellPool[i] = ItemCell.PackageOrReuseView(self, go, true, true)
	end

	self.toggleMove = self.goToggleMove:GetComponent("Toggle")

	function self.onClickToggleMoveDelegate(isOn)
		self:OnToggleMove(isOn)
	end

	self.barProgress = self.goProgress:GetComponent("Slider")
	self.scrollRect = self.goScrollRect:GetComponent("ScrollRect")
	self.tfProgress = self.goProgressDesc:GetComponent("Text")
	self.tfTime = self.goTime:GetComponent("Text")

	self.goDescCell:SetActive(false)

	self.btnClose = self.goBtnClose:GetComponent("Button")

	function self.onClickBtnCloseDelegate()
		self:OnClickBtnClose()
	end

	function self.onBuildingUpdateDelegate(userData)
		self:OnBuildingUpdate(userData)
	end

	self.goBtnClose.transform:Find("Text"):GetComponent("Text").text = HomeLandWorkRoomUIApi:GetString("title")
	self.goTitle:GetComponent("Text").text = HomeLandWorkRoomUIApi:GetString("title2")
	self.goRewardTitle:GetComponent("Text").text = HomeLandWorkRoomUIApi:GetString("rewardTitle")
	self.goRewardTitle2:GetComponent("Text").text = HomeLandWorkRoomUIApi:GetString("rewardTitle2")
end

function HomeLandWorkRoomUI:Refresh(userData)
	self.affairData = HLWorkModule.affairDataOnEnterRoom
	self.lastEventCount = #self.affairData.events
	self.hasRefreshed = false

	self:ResetTween()
	self:StartTimer()
	self:RefreshMisc()
	self:RefreshEventBlock()

	self.hasRefreshed = true
end

function HomeLandWorkRoomUI:OnHide()
	self:StopTimer()
end

function HomeLandWorkRoomUI:OnDestroy()
	for i, v in pairs(self.itemCellPool) do
		v:Dispose()
	end
end

function HomeLandWorkRoomUI:OnAddListeners()
	self.btnClose.onClick:AddListener(self.onClickBtnCloseDelegate)
	self.toggleMove.onValueChanged:AddListener(self.onClickToggleMoveDelegate)
	EventDispatcher.AddEventListener(EventID.HomeUpdateBuildingEvent, self.onBuildingUpdateDelegate)
end

function HomeLandWorkRoomUI:OnRemoveListeners()
	self.btnClose.onClick:RemoveListener(self.onClickBtnCloseDelegate)
	self.toggleMove.onValueChanged:RemoveListener(self.onClickToggleMoveDelegate)
	EventDispatcher.RemoveEventListener(EventID.HomeUpdateBuildingEvent, self.onBuildingUpdateDelegate)
end

function HomeLandWorkRoomUI:OnClickBtnClose()
	UIModule.CloseSelf(self)
	HLWorkModule.QuiteWorkRoom()
end

function HomeLandWorkRoomUI:OnBuildingUpdate(userData)
	if Constant.HomelandBuildType.BuildWork ~= userData then
		return
	end

	for i = self.lastEventCount + 1, #self.affairData.events do
		self:AddEventDesc(i, self.affairData.events[i])
	end

	self:RefreshReward()

	self.lastEventCount = #self.affairData.events
end

function HomeLandWorkRoomUI:OnToggleMove(isOn)
	if self.hasRefreshed == false then
		return
	end

	if isOn then
		self.tw:PlayForward()
	else
		self.tw:PlayReverse()
	end
end

function HomeLandWorkRoomUI:UpdateTime()
	local time = self.affairData.finishTime - PlayerModule.GetServerTime()

	time = math.max(0, time)
	self.tfTime.text = HomeLandWorkRoomUIApi:GetString("time", getTimeDurationText2(time))

	self:RefreshProgress()

	if time == 0 then
		self:StopTimer()
	end
end

function HomeLandWorkRoomUI:StartTimer()
	self.startTimer = true
	self.timer = 0

	self:UpdateTime()
end

function HomeLandWorkRoomUI:StopTimer()
	self.startTimer = false
end

function HomeLandWorkRoomUI:RefreshProgress()
	local total = self.affairData.cfgAffairData.WorkNeedTime
	local cur = math.ceil(total - (self.affairData.finishTime - PlayerModule.GetServerTime()))

	self.barProgress.value = cur / total
	self.tfProgress.text = HomeLandWorkRoomUIApi:GetString("progress", cur, total)
end

function HomeLandWorkRoomUI:RefreshMisc()
	self.tfWorkName.text = HomeLandWorkRoomUIApi:GetString("workName", self.affairData.cfgAffairData.WorkName)
	self.tfWorkDesc.text = HomeLandWorkRoomUIApi:GetString("workDesc", self.affairData.cfgAffairData.WorkWord)
end

function HomeLandWorkRoomUI:RefreshEventBlock()
	self.scrollRect.content.transform.anchoredPosition = Vector2.New(0, 0)

	for i, v in ipairs(self.cellPool) do
		v:SetActive(i <= #self.affairData.events)
	end

	for i, v in ipairs(self.affairData.events) do
		self:AddEventDesc(i, v)
	end

	self:RefreshReward()
end

function HomeLandWorkRoomUI:RefreshReward()
	local id2CountDic = {}

	for i, v in ipairs(self.affairData.events) do
		local cfgEventData = CfgHomeLandWorkEventListTable[v.cid]

		for m, n in ipairs(cfgEventData.Params) do
			if (cfgEventData.Type == 2 or cfgEventData.Type == 3) and m % 2 == 1 then
				if id2CountDic[n] == nil then
					id2CountDic[n] = 0
				end

				local num = cfgEventData.Params[m + 1]

				if cfgEventData.Type == 2 then
					id2CountDic[n] = id2CountDic[n] + num
				elseif cfgEventData.Type == 3 then
					id2CountDic[n] = id2CountDic[n] - num

					if id2CountDic[n] <= 0 then
						table.remove(id2CountDic, n)
					end
				end
			end
		end
	end

	for i, v in pairs(self.affairData.cfgAffairData.Reward) do
		if i % 2 == 1 then
			if id2CountDic[v] == nil then
				id2CountDic[v] = 0
			end

			local num = self.affairData.cfgAffairData.Reward[i + 1] * #self.affairData.soulCids

			id2CountDic[v] = id2CountDic[v] + num
		end
	end

	local rewardList = {}

	for i, v in pairs(id2CountDic) do
		if v > 0 then
			rewardList[#rewardList + 1] = {
				i,
				v
			}
		end
	end

	table.sort(rewardList, function(a, b)
		return a[1] < b[1]
	end)
	self.goRewardBlock:SetActive(#rewardList > 0)

	if #rewardList > 0 then
		for i, v in ipairs(self.itemCellPool) do
			v.ViewGo.transform.parent.gameObject:SetActive(i <= #rewardList)
		end

		for i, v in ipairs(rewardList) do
			local id = v[1]
			local count = v[2]

			self.itemCellPool[i]:SetItemByCID(id, count)
		end
	end
end

function HomeLandWorkRoomUI:AddEventDesc(index, data)
	local cell = self:GetDescCell(index)
	local tfTime = cell.transform:Find("Text_01"):GetComponent("Text")
	local tfDes = cell.transform:Find("Text_02"):GetComponent("Text")
	local cfgEventData = CfgHomeLandWorkEventListTable[data.cid]

	tfTime.text = HomeLandWorkRoomUIApi:GetString("eventTime", getTimeText(data.time))
	tfDes.text = HomeLandWorkRoomUIApi:GetString("eventDesc", CfgSoulTable[data.soulCid].Name, cfgEventData.EventDes, cfgEventData.EffectDes)
end

function HomeLandWorkRoomUI:GetDescCell(index)
	local go = self.cellPool[index]

	if go == nil then
		go = UnityEngine.Object.Instantiate(self.goDescCell)

		go.transform:SetParent(self.goDescCell.transform.parent, false)

		self.cellPool[index] = go
	end

	go:SetActive(true)

	return go
end

function HomeLandWorkRoomUI:ResetTween()
	self.tw:PlayForward()
	self.tw:ResetToBeginning()

	self.tw.enabled = false
	self.toggleMove.isOn = false
end

return HomeLandWorkRoomUI
