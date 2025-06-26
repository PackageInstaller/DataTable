-- chunkname: @IQIGame\\UI\\Maze\\UI\\SubUI\\ActivityBuffsView.lua

local elementItemView = {}

function elementItemView.New(view)
	local obj = Clone(elementItemView)

	obj:Init(view)

	return obj
end

function elementItemView:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.elementImgCom = self.elementImg:GetComponent("Image")
end

function elementItemView:SetData(type, value, elementNumList)
	AssetUtil.LoadImage(self, MazeApi:GetEffectBottomImage(type), self.elementImgCom, function()
		return
	end)

	if MazeModule.InTheMaze then
		local curElementNum = 0

		if elementNumList[type] ~= nil then
			curElementNum = elementNumList[type] <= 0 and 0 or elementNumList[type]
		end

		UGUIUtil.SetText(self.numText, string.format(MazeApi:GetTypeTextColor(type), curElementNum .. "/" .. value))
	end
end

function elementItemView:Show()
	LuaUtility.SetGameObjectShow(self.View, true)
end

function elementItemView:Hide()
	LuaUtility.SetGameObjectShow(self.View, false)
end

function elementItemView:Dispose()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

local buffItemView = {
	ElementItemList = {}
}

buffItemView.ElementItemView = elementItemView

function buffItemView.New(view)
	local obj = Clone(buffItemView)

	obj:Init(view)

	return obj
end

function buffItemView:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.titleIconImgCom = self.titleIcon:GetComponent("Image")
end

function buffItemView:SetData(data, elementNumListByType)
	self.buffCfg = data.cfg
	self.achieveState = data.state
	self.elementNumList = elementNumListByType[self.buffCfg.BuffType]

	UGUIUtil.SetText(self.buffNameText, self.buffCfg.Name)
	UGUIUtil.SetText(self.buffDetailText, self.buffCfg.Describe)
	AssetUtil.LoadImage(self, MazeApi:GetOrbmentImgByType(self.buffCfg.BuffIcon), self.titleIconImgCom, function()
		self.titleIconImgCom:SetNativeSize()
	end)
	self:RefreshElementInfo()

	if self.achieveState == 1 then
		self:SetLockState(false)
	else
		self:SetLockState(true)
	end
end

function buffItemView:RefreshElementInfo()
	for k, v in pairs(self.ElementItemList) do
		v:Hide()
	end

	for k, v in ipairs(self.buffCfg.Element) do
		if v ~= 0 then
			if self.ElementItemList[k] == nil then
				local obj = GameObject.Instantiate(self.elementItem)

				LuaUtility.SetGameObjectShow(obj, true)
				obj.transform:SetParent(self.elementGrid.transform, false)

				local mazeEquipBuffItemView = self.ElementItemView.New(obj)

				self.ElementItemList[k] = mazeEquipBuffItemView
			end

			self.ElementItemList[k]:SetData(k, v, self.elementNumList)
			self.ElementItemList[k]:Show()
		end
	end
end

function buffItemView:SetLockState(state)
	LuaUtility.SetGameObjectShow(self.lockState, state)
end

function buffItemView:Dispose()
	for k, v in pairs(self.ElementItemList) do
		v:Dispose()
	end

	self.ElementItemList = nil

	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

local UITabList = require("IQIGame.UI.Common.UITabList")
local m = {
	ElementDataList = {},
	ElementItemList = {}
}

m.BuffItemView = buffItemView

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnClickScreenTab()
		self:OnClickScreenTab()
	end

	self.wrapContent = self.ActivityBuffsScroll:GetComponent("ScrollAreaList")

	function self.wrapContent.onRenderCell(cell)
		self:OnRenderItem(cell)
	end

	self.tabList = UITabList.Create()

	for i = 0, 3 do
		self.tabList:AddTableItem(self["TabItem" .. i], nil, function(_isOn, _)
			if not _isOn then
				return
			end

			self.DelegateOnClickScreenTab()
		end)
	end

	self:AddListeners()
end

function m:AddListeners()
	return
end

function m:RemoveListeners()
	return
end

function m:SetData(...)
	local args = {
		...
	}

	self:RefreshShowInfo(self.tabList.selectIndex)
end

function m:RefreshShowInfo(indexOfType)
	self.ElementDataList = {}
	self.elementNumListByType = {}

	local allbuffCfgs = MazeModule.GetGemBuffCfgs()
	local tempAllAchieveList = {}
	local tempLeastOneList = {}
	local type = indexOfType - 1
	local loopStart, loopEnd = 1, #allbuffCfgs

	if type and type > 0 then
		loopStart, loopEnd = type, type
	end

	for i = loopStart, loopEnd do
		local allAchieveList = {}
		local leastOneList = {}
		local elementNumList = MazeModule.GetElementNumInSeatDataByType(allbuffCfgs[i][1].BuffType)

		allAchieveList, leastOneList = MazeModule.GetAchieveBuffList(allbuffCfgs[i], elementNumList)

		table.addAll(tempAllAchieveList, allAchieveList)
		table.addAll(tempLeastOneList, leastOneList)

		self.elementNumListByType[allbuffCfgs[i][1].BuffType] = elementNumList
	end

	table.addAll(self.ElementDataList, tempAllAchieveList)
	table.addAll(self.ElementDataList, tempLeastOneList)
	self.wrapContent:Refresh(#self.ElementDataList)
end

function m:OnRenderItem(cell)
	local itemData = self.ElementDataList[cell.index + 1]
	local instanceId = cell.gameObject:GetInstanceID()
	local itemCell = self.ElementItemList[instanceId]

	if itemCell == nil then
		itemCell = self.BuffItemView.New(cell.gameObject)
		self.ElementItemList[instanceId] = itemCell
	end

	itemCell:SetData(itemData, self.elementNumListByType)
end

function m:OnClickScreenTab()
	self:SetData()
end

function m:Show()
	LuaUtility.SetGameObjectShow(self.View, true)
end

function m:Hide()
	LuaUtility.SetGameObjectShow(self.View, false)
end

function m:Dispose()
	self:RemoveListeners()

	for k, v in pairs(self.ElementItemList) do
		v:Dispose()
	end

	self.ElementItemList = {}

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
