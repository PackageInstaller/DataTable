-- chunkname: @IQIGame\\UI\\Girl\\Whisper\\WhisperView.lua

local m = {
	needUpdateResSize = 0,
	isOpen = false,
	ChangePageEffectPlayId = 0,
	whisperCellPool = {}
}
local WhisperCell = require("IQIGame.UI.Girl.Whisper.WhisperCell")

function m.New(view, root)
	local obj = Clone(m)

	obj:Init(view, root)

	return obj
end

function m:Init(view, root)
	self.View = view
	self.rootUI = root

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.delegateOnBuyGoodsSuccess()
		self:OnBuyGoodsSuccess()
	end

	function self.DelegateOnResourceUpdateChanged(sender, args)
		self:OnResourceUpdateChanged(sender, args)
	end

	function self.DelegateOnDownloadCompleteEvent(tag, isRepair, isAllComplete)
		self:OnDownloadCompleteEvent(tag, isRepair, isAllComplete)
	end

	UGUIUtil.SetText(self.WhisperTitle, GirlUIApi:GetString("WhisperTitle"))

	self.scrollList = self.WhisperScroll:GetComponent("ScrollAreaList")

	function self.scrollList.onRenderCell(renderCell)
		self:OnRenderCell(renderCell)
	end

	function self.scrollList.onSelectedCell(cell)
		self:OnSelectedCell(cell)
	end

	self.DelayShowDLBlockViewTimer = Timer.New(function()
		self.WaitingBlockView:SetActive(true)
	end, 0.5)
end

function m:AddListener()
	EventDispatcher.AddEventListener(EventID.BuyGoodsSuccess, self.delegateOnBuyGoodsSuccess)
	EventDispatcher.AddEventListener(EventID.DownloadResByTagComplete, self.DelegateOnDownloadCompleteEvent)
	GameEntry.LuaEvent:Subscribe(UnityGameFramework.Runtime.ResourceUpdateChangedEventArgs.EventId, self.DelegateOnResourceUpdateChanged)
end

function m:RemoveListener()
	EventDispatcher.RemoveEventListener(EventID.BuyGoodsSuccess, self.delegateOnBuyGoodsSuccess)
	EventDispatcher.RemoveEventListener(EventID.DownloadResByTagComplete, self.DelegateOnDownloadCompleteEvent)
	GameEntry.LuaEvent:Unsubscribe(UnityGameFramework.Runtime.ResourceUpdateChangedEventArgs.EventId, self.DelegateOnResourceUpdateChanged)
end

function m:Open()
	self:AddListener()
	self.View:SetActive(true)

	self.isOpen = true
end

function m:OnBuyGoodsSuccess()
	if self.soulCid then
		self:UpdateView(self.soulCid)
	end
end

function m:UpdateView(soulCid)
	self.soulCid = soulCid
	self.soulWhisperList, self.soulOpenWhisperList = GirlModule.GetSoulWhisperListData(self.soulCid)

	table.sort(self.soulOpenWhisperList, function(a, b)
		return a.Sort < b.Sort
	end)
	self.scrollList:Refresh(#self.soulOpenWhisperList)
	self:StartCheckRes()
end

function m:StartCheckRes()
	self.WaitingBlockNode:SetActive(true)
	self.WaitingBlockView:SetActive(false)
	self.DelayShowDLBlockViewTimer:Start()
	ResourceUpdateChecker.CheckResourcesByTag(SoulModule.GetWhisperResTag(self.soulCid), function(tag, updateCount, updateTotalLength)
		if SoulModule.GetWhisperResTag(self.soulCid) ~= tag then
			return
		end

		if self.View == nil then
			return
		end

		self.needUpdateResSize = updateTotalLength

		self:RefreshCellStateAboutRes()
		self.WaitingBlockNode:SetActive(false)
		self:TryStopDelayShowDLBlockViewTimer()
	end)
end

function m:OnRenderCell(cell)
	local data = self.soulOpenWhisperList[cell.index + 1]

	if data == nil then
		cell.gameObject:SetActive(false)

		return
	end

	cell.gameObject:SetActive(true)

	local instanceID = cell.gameObject:GetInstanceID()
	local whisperCell = self.whisperCellPool[instanceID]

	if whisperCell == nil then
		whisperCell = WhisperCell.New(cell.gameObject, self)
		self.whisperCellPool[instanceID] = whisperCell
	end

	whisperCell:SetData(data)
end

function m:OnSelectedCell(cell)
	local data = self.soulOpenWhisperList[cell.index + 1]

	if self.needUpdateResSize == 0 then
		self:ShowWhisper(data)
	else
		if ResourceUpdateChecker.isDownloading then
			NoticeModule.ShowNotice(21045075)

			return
		end

		NoticeModule.ShowNotice(21045074, function()
			self:DownloadResource(self.soulCid, self.needUpdateResSize)
		end, function()
			ResourceUpdateChecker.CheckResourcesByTag(Constant.ResourceTag.Whisper, function(tag, updateCount, updateTotalLength)
				if self.View == nil then
					return
				end

				if tag ~= Constant.ResourceTag.Whisper then
					return
				end

				if updateTotalLength > 0 then
					self:DownloadResource(Constant.ResourceTag.Whisper, updateTotalLength)
				else
					self:DownloadComplete()
				end
			end)
		end)
	end
end

function m:DownloadResource(tag, resSize)
	local sizeStr = ResourceUpdateChecker.GetSizeStr(resSize)

	NoticeModule.ShowNotice(21045080, function()
		self.downloadProgress = 0

		ResourceUpdateChecker.UpdateResourcesByTag(tag)
	end, nil, nil, sizeStr)
end

function m:OnDownloadCompleteEvent(tag, isRepair, isAllComplete)
	if isAllComplete and not isRepair then
		if self.View == nil then
			return
		end

		if tag == Constant.ResourceTag.Whisper or tag == SoulModule.GetWhisperResTag(self.soulCid) then
			self:DownloadComplete()
		elseif self.needUpdateResSize > 0 then
			self.downloadProgress = nil

			self:RefreshCellStateAboutRes()
		end
	end
end

function m:DownloadComplete()
	self.needUpdateResSize = 0
	self.downloadProgress = nil

	self:RefreshCellStateAboutRes()
end

function m:OnResourceUpdateChanged(sender, args)
	if self.needUpdateResSize == 0 then
		return
	end

	local info = args.UserData

	self.downloadProgress = info.ProcessNormalize

	self:RefreshCellStateAboutRes()
end

function m:RefreshCellStateAboutRes()
	for instanceId, cell in pairs(self.whisperCellPool) do
		cell:RefreshStateAboutRes()
	end
end

function m:ShowWhisper(data)
	local isUnlock = GirlModule.CheckWhisperUnlock(data.Id)

	if isUnlock then
		local cfgSoulMarryData = GirlModule.GetSoulOathData(self.soulCid)
		local CVAction = cfgSoulMarryData == nil and 0 or cfgSoulMarryData.ClickOKCVAction

		if CVAction > 0 then
			GameEntry.LuaEvent:Fire(nil, L2DJumpToStateEventArgs():Fill(Constant.L2D_CustomStateName.GirlAction, CVAction))
		end

		self:StopChangePageEffect()

		self.ChangePageEffectPlayId = GameEntry.Effect:PlayUIMountPointEffect(9008003, 50000, 0, self.rootUI.SpineEffectPoint, self.View:GetComponentInParent(typeof(UIController)):GetComponent("Canvas").sortingOrder + 10)

		if self.changeTimer then
			self.changeTimer:Stop()

			self.changeTimer = nil
		end

		self.changeTimer = Timer.New(function()
			local openIndex = 1

			for i = 1, #self.soulOpenWhisperList do
				if self.soulOpenWhisperList[i].Id == data.Id then
					openIndex = i

					break
				end
			end

			UIModule.Open(Constant.UIControllerName.SoulMarryVideoUI, Constant.UILayer.UI, {
				whisperList = self.soulOpenWhisperList,
				index = openIndex
			})
		end, 3)

		self.changeTimer:Start()
	end
end

function m:StopChangePageEffect()
	if self.ChangePageEffectPlayId ~= 0 then
		GameEntry.Effect:StopEffect(self.ChangePageEffectPlayId)

		self.ChangePageEffectPlayId = 0
	end
end

function m:TryStopDelayShowDLBlockViewTimer()
	if self.DelayShowDLBlockViewTimer ~= nil and self.DelayShowDLBlockViewTimer.running then
		self.DelayShowDLBlockViewTimer:Stop()
	end
end

function m:Close()
	self:TryStopDelayShowDLBlockViewTimer()
	self:RemoveListener()

	if self.changeTimer then
		self.changeTimer:Stop()

		self.changeTimer = nil
	end

	self.isOpen = false
end

function m:Dispose()
	for i, v in pairs(self.whisperCellPool) do
		v:Dispose()
	end

	self:TryStopDelayShowDLBlockViewTimer()

	self.DelayShowDLBlockViewTimer = nil

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
