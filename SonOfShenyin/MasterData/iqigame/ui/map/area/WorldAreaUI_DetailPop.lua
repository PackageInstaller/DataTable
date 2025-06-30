-- chunkname: @IQIGame\\UI\\Map\\Area\\WorldAreaUI_DetailPop.lua

local WorldAreaUI_DetailPop = {}
local roomItemClass = require("IQIGame/UI/Map/Area/WorldAreaUI_DetailPop_RoomItem")
local UIViewObjectPool = require("IQIGame.UI.Common.UIViewObjectPool")

function WorldAreaUI_DetailPop.New(go, mainView)
	local o = Clone(WorldAreaUI_DetailPop)

	o:Initialize(go, mainView)

	return o
end

function WorldAreaUI_DetailPop:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function WorldAreaUI_DetailPop:InitComponent()
	self.rect = self.gameObject:GetComponent("RectTransform")
	self.roomItemPool = UIViewObjectPool.New(self.roomPrefab, self.detailContent.transform, function(_view)
		return roomItemClass.New(_view, self)
	end)
end

function WorldAreaUI_DetailPop:InitDelegate()
	function self.delegateOnClickButtonEnter()
		self:OnClickButtonEnter()
	end

	function self.delegateOnClickButtonMask()
		self:OnClickButtonMask()
	end
end

function WorldAreaUI_DetailPop:AddListener()
	self.buttonEnter:GetComponent("Button").onClick:AddListener(self.delegateOnClickButtonEnter)
	self.buttonMask:GetComponent("Button").onClick:AddListener(self.delegateOnClickButtonMask)
end

function WorldAreaUI_DetailPop:RemoveListener()
	self.buttonEnter:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickButtonEnter)
	self.buttonMask:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickButtonMask)
end

function WorldAreaUI_DetailPop:OnClickButtonMask()
	self:Hide()
end

function WorldAreaUI_DetailPop:OnClickButtonEnter()
	if not self.currentSelectRoomItem then
		return
	end

	WorldMapModule.EnterRoom(self.currentSelectRoomItem.data.cid, true)
	UIModule.Close(Constant.UIControllerName.WorldAreaUI)
end

function WorldAreaUI_DetailPop:Show()
	LuaUtility.SetGameObjectShow(self.gameObject, true)
end

function WorldAreaUI_DetailPop:Hide()
	LuaUtility.SetGameObjectShow(self.gameObject, false)

	if self.mainView.currentSelectedArea then
		self.mainView.currentSelectedArea:UnSelected()

		self.mainView.currentSelectedArea = nil
	end
end

function WorldAreaUI_DetailPop:Refresh(anchorPosX, anchorPosY, areaId)
	self.areaId = areaId

	local areaData = WorldMapModule.GetAreaDataWithID(self.areaId)
	local roomArray = areaData:GetUnlockRoomArray()

	self.roomItemPool:ForItems(function(_item)
		_item:Hide()
	end)
	table.sort(roomArray, function(a, b)
		return a.cid < b.cid
	end)

	local len = #roomArray

	for i = 1, len do
		local tabItem = self.roomItemPool:GetFree(function(_item)
			return not _item.gameObject.activeSelf
		end)

		tabItem:Show()
		tabItem:Refresh(roomArray[i])

		if i == 1 then
			tabItem:OnClickButtonClick()
		end
	end

	LuaUtility.SetText(self.textArea, WorldMapModule.GetAreaName(areaData:GetCfg()))
end

function WorldAreaUI_DetailPop:SelectRoom(item)
	if self.currentSelectRoomItem then
		self.currentSelectRoomItem:UnSelected()

		self.currentSelectRoomItem = nil
	end

	self.currentSelectRoomItem = item

	self.currentSelectRoomItem:Selected()
end

function WorldAreaUI_DetailPop:OnDestroy()
	self:RemoveListener()
	self.roomItemPool:Dispose(function(item)
		item:OnDestroy()
	end)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)
	AssetUtil.UnloadAsset(self)

	self.rect = nil
	self.gameObject = nil
end

return WorldAreaUI_DetailPop
