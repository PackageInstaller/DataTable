-- chunkname: @IQIGame\\UI\\Maze\\UI\\MazeEquipItem.lua

local seatElementItem = {}

function seatElementItem.New(view)
	local obj = Clone(seatElementItem)

	obj:Init(view)

	return obj
end

function seatElementItem:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.ElementImgCom = self.ElementImg:GetComponent("Image")
end

function seatElementItem:SetData(seatType, elementType)
	AssetUtil.LoadImage(self, MazeApi:GetSeatElementImage(elementType), self.ElementImgCom, function()
		return
	end)

	local nums = 0

	if MazeModule.InTheMaze then
		nums = MazeModule.GetSeatElementNums(seatType, elementType)
	end

	UGUIUtil.SetText(self.ElementNumText, "×" .. nums)
end

function seatElementItem:Show()
	LuaUtility.SetGameObjectShow(self.View, true)
end

function seatElementItem:Hide()
	LuaUtility.SetGameObjectShow(self.View, false)
end

function seatElementItem:Dispose()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

local mazeEquipHoleItem = require("IQIGame.UI.Maze.UI.MazeEquipHoleItem")
local m = {
	HoleItemList = {},
	SeatElementItemList = {}
}

m.SeatElementItem = seatElementItem

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOrbmentDataChangeEvent()
		self:OrbmentDataChangeEvent()
	end

	self.titleImgCom = self.titleImg:GetComponent("Image")
	self.typeBottomBGCom = self.typeBottomBG:GetComponent("Image")

	self:AddListeners()
end

function m:AddListeners()
	EventDispatcher.AddEventListener(EventID.InOrbmentDataChangeEvent, self.DelegateOrbmentDataChangeEvent)
end

function m:RemoveListeners()
	EventDispatcher.RemoveEventListener(EventID.InOrbmentDataChangeEvent, self.DelegateOrbmentDataChangeEvent)
end

function m:SetData(holeCfgs)
	self.holeCfgs = holeCfgs

	UGUIUtil.SetText(self.titleText, MazeApi:GetOrbmentNameByType(self.holeCfgs[1].SeatType))
	self:CreateHolePos()
	self:RefreshShowInfo()
end

function m:RefreshShowInfo()
	for i = 1, 3 do
		LuaUtility.SetGameObjectShow(self["TitleImg" .. i], false)
	end

	if self.holeCfgs[1].SeatType == 1 then
		LuaUtility.SetGameObjectShow(self.TitleImg1, true)
	elseif self.holeCfgs[1].SeatType == 2 then
		LuaUtility.SetGameObjectShow(self.TitleImg2, true)
	elseif self.holeCfgs[1].SeatType == 3 then
		LuaUtility.SetGameObjectShow(self.TitleImg3, true)
	end

	AssetUtil.LoadImage(self, MazeApi:GetOrbmentBottomBgByType(self.holeCfgs[1].SeatType), self.typeBottomBGCom, function()
		self.typeBottomBGCom:SetNativeSize()
	end)
end

function m:CreateHolePos()
	for i = 1, #self.holeCfgs do
		if self.HoleItemList[i] == nil then
			local obj = GameObject.Instantiate(self.holeItem)

			LuaUtility.SetGameObjectShow(obj, true)
			obj.transform:SetParent(self.holeGrid.transform, false)

			local mazeEquipHoleItemView = mazeEquipHoleItem.New(obj)

			self.HoleItemList[i] = mazeEquipHoleItemView
		end

		self.HoleItemList[i]:SetData(self.holeCfgs[i].Id)
		self.HoleItemList[i]:Show()
	end
end

function m:CreateSingleEffectElement()
	for i = 1, #self.holeCfgs[1].Effect do
		if self.SeatElementItemList[i] == nil then
			local obj = GameObject.Instantiate(self.ElementItem)

			LuaUtility.SetGameObjectShow(obj, true)
			obj.transform:SetParent(self.ElementSort.transform, false)

			local mazeEquipHoleItemView = m.SeatElementItem.New(obj)

			self.SeatElementItemList[i] = mazeEquipHoleItemView
		end

		self.SeatElementItemList[i]:SetData(self.holeCfgs[1].SeatType, i)
		self.SeatElementItemList[i]:Show()
	end
end

function m:OrbmentDataChangeEvent()
	return
end

function m:Show()
	LuaUtility.SetGameObjectShow(self.View, true)
end

function m:Hide()
	LuaUtility.SetGameObjectShow(self.View, false)
end

function m:Dispose()
	self:RemoveListeners()

	for k, v in pairs(self.HoleItemList) do
		v:Dispose()
	end

	self.HoleItemList = nil

	for k, v in pairs(self.SeatElementItemList) do
		v:Dispose()
	end

	self.SeatElementItemList = nil
	self.titleImgCom = nil
	self.typeBottomBGCom = nil

	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
