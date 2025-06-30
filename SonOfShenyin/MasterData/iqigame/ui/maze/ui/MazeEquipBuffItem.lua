-- chunkname: @IQIGame\\UI\\Maze\\UI\\MazeEquipBuffItem.lua

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
	else
		UGUIUtil.SetText(self.numText, string.format(MazeApi:GetTypeTextColor(type), "×" .. value))
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

local buffDetailsItemView = {
	ElementItemList = {}
}

buffDetailsItemView.ElementItemView = elementItemView

function buffDetailsItemView.New(view)
	local obj = Clone(buffDetailsItemView)

	obj:Init(view)

	return obj
end

function buffDetailsItemView:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.titleIconImgCom = self.titleIcon:GetComponent("Image")
end

function buffDetailsItemView:SetData(data, elementNumList)
	self.buffCfg = data.cfg
	self.achieveState = data.state
	self.elementNumList = elementNumList

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

function buffDetailsItemView:RefreshElementInfo()
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

function buffDetailsItemView:SetLockState(state)
	LuaUtility.SetGameObjectShow(self.lockState, state)
end

function buffDetailsItemView:Dispose()
	for k, v in pairs(self.ElementItemList) do
		v:Dispose()
	end

	self.ElementItemList = nil

	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

local m = {
	MazeEquipBuffItemList = {}
}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

m.BuffDetailsItemView = buffDetailsItemView

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.titleImgCom = self.titleImg:GetComponent("Image")

	self:AddListeners()
end

function m:AddListeners()
	return
end

function m:RemoveListeners()
	return
end

function m:SetData(buffCfgs)
	local type = buffCfgs[1].BuffType
	local allAchieveList = {}
	local leastOneList = {}
	local nonAchieveList = {}
	local elementNumList = {}

	if MazeModule.InTheMaze then
		elementNumList = MazeModule.GetElementNumInSeatDataByType(type)
		allAchieveList, leastOneList, nonAchieveList = MazeModule.GetAchieveBuffList(buffCfgs, elementNumList)

		table.addAll(allAchieveList, leastOneList)
		table.addAll(allAchieveList, nonAchieveList)
	else
		for i = 1, #buffCfgs do
			table.insert(allAchieveList, {
				state = 1,
				cfg = buffCfgs[i]
			})
		end
	end

	for i = 1, #allAchieveList do
		if self.MazeEquipBuffItemList[i] == nil then
			local obj = GameObject.Instantiate(self.buffItem)

			LuaUtility.SetGameObjectShow(obj, true)
			obj.transform:SetParent(self.buffContent.transform, false)

			local mazeEquipBuffItemView = self.BuffDetailsItemView.New(obj)

			self.MazeEquipBuffItemList[i] = mazeEquipBuffItemView
		end

		self.MazeEquipBuffItemList[i]:SetData(allAchieveList[i], elementNumList)
	end

	self:RefreshBuffListInfo(type)
end

function m:RefreshBuffListInfo(type)
	UGUIUtil.SetText(self.titleText, MazeApi:GetOrbmentNameByType(type))
end

function m:Show()
	LuaUtility.SetGameObjectShow(self.View, true)
end

function m:Hide()
	LuaUtility.SetGameObjectShow(self.View, false)
end

function m:Dispose()
	self:RemoveListeners()

	for k, v in pairs(self.MazeEquipBuffItemList) do
		v:Dispose()
	end

	self.MazeEquipBuffItemList = nil

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
