-- chunkname: @IQIGame\\UI\\Maze\\UI\\MazeEquipHoleItem.lua

local gemElementItemView = {}

function gemElementItemView.New(view)
	local obj = Clone(gemElementItemView)

	obj:Init(view)

	return obj
end

function gemElementItemView:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.elementImgCom = self.ElementImg:GetComponent("Image")
end

function gemElementItemView:SetData(type, value)
	AssetUtil.LoadImage(self, MazeApi:GetGemElementBG(type), self.elementImgCom, function()
		self.elementImgCom:SetNativeSize()
	end)
	UGUIUtil.SetText(self.ElementNumText, string.format(MazeApi:GetTypeTextColor(type), value))
end

function gemElementItemView:Show()
	LuaUtility.SetGameObjectShow(self.View, true)
end

function gemElementItemView:Hide()
	LuaUtility.SetGameObjectShow(self.View, false)
end

function gemElementItemView:Dispose()
	self.elementImgCom = nil

	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

local gemstoneItem = require("IQIGame.UI.Maze.UI.SubUI.GemstoneItem")
local gemstoneElementItem = require("IQIGame.UI.Maze.UI.SubUI.GemstoneElementItem")
local m = {
	isLock = false,
	inTheMaze = false,
	gemAttrItemList = {},
	gemElementItemList = {}
}

m.GemElementItemView = gemElementItemView

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnClickItem()
		self:OnClickItem()
	end

	function self.DelegateSelectHoleEvent(SeatID, isUnLock)
		self:SelectHoleEvent(SeatID, isUnLock)
	end

	function self.DelegateUnlockHoleSuccessEvent(SeatID)
		self:UnlockHoleSuccessEvent(SeatID)
	end

	function self.DelegateSelectSeatEffectSuccessEvent(SeatID)
		self:SelectSeatEffectSuccessEvent(SeatID)
	end

	function self.DelegateCancelSeatEffectSuccessEvent(SeatID)
		self:CancelSeatEffectSuccessEvent(SeatID)
	end

	function self.DelegateWearGemstoneSuccessEvent(SeatId)
		self:WearGemstoneSuccessEvent(SeatId)
	end

	function self.DelegateRemoveGemstoneSuccessEvent(SeatId)
		return
	end

	self.gemImgCom = self.gemImg:GetComponent("Image")
	self.NormalBGCom = self.NormalBG:GetComponent("Image")
	self.LockBGCom = self.LockBG:GetComponent("Image")
	self.effectImageCom = self.effectImage:GetComponent("Image")

	self:AddListeners()
end

function m:AddListeners()
	self.View:GetComponent("Button").onClick:AddListener(self.DelegateOnClickItem)
	EventDispatcher.AddEventListener(EventID.SelectHoleEvent, self.DelegateSelectHoleEvent)
	EventDispatcher.AddEventListener(EventID.UnlockHoleSuccessEvent, self.DelegateUnlockHoleSuccessEvent)
	EventDispatcher.AddEventListener(EventID.SelectSeatEffectSuccessEvent, self.DelegateSelectSeatEffectSuccessEvent)
	EventDispatcher.AddEventListener(EventID.CancelSeatEffectSuccessEvent, self.DelegateCancelSeatEffectSuccessEvent)
	EventDispatcher.AddEventListener(EventID.InOrbmentDataChangeEvent, self.DelegateWearGemstoneSuccessEvent)
	EventDispatcher.AddEventListener(EventID.InOrbmentDataChangeEvent, self.DelegateRemoveGemstoneSuccessEvent)
end

function m:RemoveListeners()
	self.View:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickItem)
	EventDispatcher.RemoveEventListener(EventID.SelectHoleEvent, self.DelegateSelectHoleEvent)
	EventDispatcher.RemoveEventListener(EventID.UnlockHoleSuccessEvent, self.DelegateUnlockHoleSuccessEvent)
	EventDispatcher.RemoveEventListener(EventID.SelectSeatEffectSuccessEvent, self.DelegateSelectSeatEffectSuccessEvent)
	EventDispatcher.RemoveEventListener(EventID.CancelSeatEffectSuccessEvent, self.DelegateCancelSeatEffectSuccessEvent)
	EventDispatcher.RemoveEventListener(EventID.InOrbmentDataChangeEvent, self.DelegateWearGemstoneSuccessEvent)
	EventDispatcher.RemoveEventListener(EventID.InOrbmentDataChangeEvent, self.DelegateRemoveGemstoneSuccessEvent)
end

function m:SetData(seatId, hideSelectState)
	self.SeatId = seatId
	self.holeCfg = CfgMazeSeatTable[self.SeatId]
	self.seatData = MazeModule.GetServerHoleData(self.holeCfg.Id)
	self.isUnLock = self.seatData.state

	self:InitHolePosData(hideSelectState)
end

function m:InitHolePosData(hideSelectState)
	if hideSelectState == nil then
		LuaUtility.SetGameObjectShow(self.selectState, false)
	end

	LuaUtility.SetGameObjectShow(self.equipState, false)
	LuaUtility.SetGameObjectShow(self.lockState, not self.isUnLock)
	AssetUtil.LoadImage(self, MazeApi:GetSeatNormalBG(self.holeCfg.SeatType), self.NormalBGCom, function()
		self.NormalBGCom:SetNativeSize()
	end)
	AssetUtil.LoadImage(self, MazeApi:GetSeatLockBG(self.holeCfg.SeatType), self.LockBGCom, function()
		self.LockBGCom:SetNativeSize()
	end)
	self:RefreshHoleEffectShow()
	self:ReFreshHoleEquipGemShow()
end

function m:OnClickItem()
	if self.selectEffectID ~= nil then
		GameEntry.Effect:StopEffect(self.selectEffectID)
	end

	if MazeModule.InTheMaze and not self.isUnLock then
		NoticeModule.ShowNotice(80005)

		return
	end

	EventDispatcher.Dispatch(EventID.SelectHoleEvent, self.SeatId, self.isUnLock)

	self.selectEffectID = GameEntry.Effect:PlayUIMountPointEffect(MazeApi:GetSeatEffectId(1, self.holeCfg.SeatType), 50000, 0, self.EffectParent, 0)

	LuaUtility.SetGameObjectShow(self.selectState, true)
end

function m:SelectHoleEvent(SeatID, isUnLock)
	if SeatID == self.holeCfg.Id then
		return
	end

	LuaUtility.SetGameObjectShow(self.selectState, false)
end

function m:UnlockHoleSuccessEvent(SeatID)
	if SeatID ~= self.holeCfg.Id then
		return
	end

	self.isUnLock = MazeModule.GetServerHoleData(SeatID).state

	LuaUtility.SetGameObjectShow(self.lockState, false)
end

function m:SelectSeatEffectSuccessEvent(SeatID)
	if self.effectID ~= nil then
		GameEntry.Effect:StopEffect(self.effectID)
	end

	if SeatID ~= self.SeatId then
		return
	end

	self.effectID = GameEntry.Effect:PlayUIMountPointEffect(MazeApi:GetSeatEffectId(2, self.holeCfg.SeatType), 50000, 0, self.EffectParent, 0)

	self:SetData(SeatID, false)
end

function m:CancelSeatEffectSuccessEvent(SeatID)
	if SeatID ~= self.SeatId then
		return
	end

	self:SetData(SeatID, false)
end

function m:WearGemstoneSuccessEvent(SeatID)
	self:SetData(self.SeatId, false)
end

function m:RemoveGemstoneSuccessEvent(SeatID)
	self:SetData(self.SeatId, false)
end

function m:RefreshHoleEffectShow()
	local seatData = MazeModule.GetServerHoleData(self.SeatId)

	LuaUtility.SetGameObjectShow(self.effectImage, seatData.effectId ~= 0)

	if seatData.effectId ~= 0 then
		AssetUtil.LoadImage(self, MazeApi:GetSeatEffectImg(self.holeCfg.SeatType, seatData.effectId), self.effectImageCom, function()
			self.effectImageCom:SetNativeSize()
		end)
	end

	for k, v in pairs(self.gemElementItemList) do
		v:Hide()
	end

	if MazeModule.InTheMaze and MazeModule.GetSeatIsEquipedGem(seatData) then
		local gemData = MazeModule.GetGemItemData(seatData.id)
		local gemCfg = CfgMazeGemstoneTable[gemData.cid]
		local index = 0

		for i = 1, #gemCfg.Element do
			if gemCfg.Element[i] ~= 0 then
				index = index + 1

				local elementNumStr = 0

				if i == self.seatData.effectId then
					elementNumStr = gemCfg.Element[i] * self.holeCfg.Effect[self.seatData.effectId]
				else
					elementNumStr = gemCfg.Element[i]
				end

				if self.gemElementItemList[index] == nil then
					local obj = GameObject.Instantiate(self.ElementItem)

					obj.transform:SetParent(self.ElementSort.transform, false)

					self.gemElementItemList[index] = m.GemElementItemView.New(obj)
				end

				self.gemElementItemList[index]:Show()
				self.gemElementItemList[index]:SetData(i, elementNumStr)
			end
		end
	end
end

function m:ReFreshHoleEquipGemShow()
	if not MazeModule.InTheMaze then
		return
	end

	local isEquiped = MazeModule.GetSeatIsEquipedGem(self.seatData)

	LuaUtility.SetGameObjectShow(self.equipState, isEquiped)

	if isEquiped then
		local gemItemData = MazeModule.GetGemItemData(self.seatData.id)

		AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(CfgItemTable[gemItemData.cid].Icon), self.gemImgCom, function()
			return
		end)
	end
end

function m:Show()
	LuaUtility.SetGameObjectShow(self.View, true)
end

function m:Hide()
	LuaUtility.SetGameObjectShow(self.View, false)
end

function m:Dispose()
	if self.effectID ~= nil then
		GameEntry.Effect:StopEffect(self.effectID)
	end

	if self.selectEffectID ~= nil then
		GameEntry.Effect:StopEffect(self.selectEffectID)
	end

	for k, v in pairs(self.gemAttrItemList) do
		v:Dispose()
	end

	self.gemAttrItemList = nil

	for k, v in pairs(self.gemElementItemList) do
		v:Dispose()
	end

	self.gemElementItemList = nil

	self:RemoveListeners()

	self.gemImgCom = nil

	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
