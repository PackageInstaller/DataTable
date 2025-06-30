-- chunkname: @IQIGame\\UI\\HomeLandMapUI.lua

local RoomItem = {
	roomCid = 0
}

function RoomItem.New(view, clickHandler)
	local obj = Clone(RoomItem)

	obj:__Init(view, clickHandler)

	return obj
end

function RoomItem:__Init(view, clickHandler)
	self.gameObject = view
	self.onClickHandler = clickHandler

	LuaCodeInterface.BindOutlet(self.gameObject, self)

	function self.__OnItemClickEventProxy()
		if self.onClickHandler ~= nil then
			self.onClickHandler(self.roomCid)
		end
	end

	self.gameObject:GetComponent("Button").onClick:AddListener(self.__OnItemClickEventProxy)

	local roomCid = tonumber(self.gameObject.name)

	self:Show(roomCid)
end

function RoomItem:Show(roomCid)
	self.roomCid = roomCid

	self.gameObject:SetActive(true)
	LuaUtility.SetText(self.nameText, self.roomCid)
end

function RoomItem:Refresh()
	local isOpen = HomeModule.IsRoomOpen(self.roomCid)

	self.lockTag.gameObject:SetActive(not isOpen)
end

function RoomItem:Hide()
	self.gameObject:SetActive(false)
end

function RoomItem:Dispose()
	self.gameObject:GetComponent("Button").onClick:RemoveListener(self.__OnItemClickEventProxy)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

local HomeLandMapUI = {
	roomItems = {}
}

HomeLandMapUI = Base:Extend("HomeLandMapUI", "IQIGame.Onigao.UI.HomeLandMapUI", HomeLandMapUI)

function HomeLandMapUI:OnInit()
	self:__OnInitEventDelegateFunc()
	self:__InitRoomView()
end

function HomeLandMapUI:GetPreloadAssetPaths()
	return nil
end

function HomeLandMapUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function HomeLandMapUI:IsManualShowOnOpen(userData)
	return false
end

function HomeLandMapUI:GetBGM(userData)
	return nil
end

function HomeLandMapUI:OnOpen(userData)
	self:__Refresh()
end

function HomeLandMapUI:OnClose(userData)
	return
end

function HomeLandMapUI:__OnInitEventDelegateFunc()
	function self.__delegateOnCloseBtnClick()
		UIModule.Close(Constant.UIControllerName.HomeLandMapUI)
	end
end

function HomeLandMapUI:OnAddListeners()
	self.closeBtn:GetComponent("Button").onClick:AddListener(self.__delegateOnCloseBtnClick)
end

function HomeLandMapUI:OnRemoveListeners()
	self.closeBtn:GetComponent("Button").onClick:RemoveListener(self.__delegateOnCloseBtnClick)
end

function HomeLandMapUI:OnPause()
	return
end

function HomeLandMapUI:OnResume()
	return
end

function HomeLandMapUI:OnCover()
	return
end

function HomeLandMapUI:OnReveal()
	return
end

function HomeLandMapUI:OnRefocus(userData)
	return
end

function HomeLandMapUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function HomeLandMapUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function HomeLandMapUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function HomeLandMapUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function HomeLandMapUI:OnDestroy()
	ForPairs(self.roomItems, function(_, _item)
		_item:Dispose()
	end)
end

function HomeLandMapUI:__InitRoomView()
	for i = 0, self.roomRoot.transform.childCount - 1 do
		local childTrans = self.roomRoot.transform:GetChild(i)
		local item = RoomItem.New(childTrans.gameObject, function(_roomCid)
			self:__OnRoomItemClick(_roomCid)
		end)

		self.roomItems[item.roomCid] = item
	end
end

function HomeLandMapUI:__OnRoomItemClick(roomCid)
	local isOpen = HomeModule.IsRoomOpen(roomCid)

	if not isOpen then
		return
	end

	UIModule.Close(Constant.UIControllerName.HomeLandMapUI)
	WorldMapModule.EnterRoom(roomCid, true)
end

function HomeLandMapUI:__Refresh()
	ForPairs(self.roomItems, function(_, _item)
		_item:Refresh()
	end)
end

return HomeLandMapUI
