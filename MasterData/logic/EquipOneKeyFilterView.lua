-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/equipment/view/EquipOneKeyFilterView.lua

module("logic.extensions.equipment.view.EquipOneKeyFilterView", package.seeall)

local EquipOneKeyFilterView = class("EquipOneKeyFilterView", ViewComponent)
local filterInfoList = {
	{
		[0] = {},
		{
			"水"
		},
		{
			"火"
		},
		{
			"草"
		},
		{
			"光"
		},
		{
			"暗"
		},
		{
			"空"
		},
		{
			"创"
		}
	},
	{
		[0] = {},
		{
			"疾速",
			"利爪"
		},
		{
			"魔法",
			"治疗"
		},
		{
			"肉盾",
			"平衡"
		}
	}
}

function EquipOneKeyFilterView:ctor()
	EquipOneKeyFilterView.super.ctor(self)
end

function EquipOneKeyFilterView:unbindEvents()
	EquipOneKeyFilterView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._closeBtn)
end

function EquipOneKeyFilterView:bindEvents()
	EquipOneKeyFilterView.super.bindEvents(self)
	GameUtil.addClickHandler(self._closeBtn, self.close, self)
end

function EquipOneKeyFilterView:onExit()
	EquipOneKeyFilterView.super.onExit(self)
end

function EquipOneKeyFilterView:buildUI()
	EquipOneKeyFilterView.super.buildUI(self)

	self._raceFilter = self:getGo("content/RaceFilter")
	self._jobFilter = self:getGo("content/JobFilter")
	self._qualityFilter = self:getGo("content/QualityFilter")
	self._posFilter = self:getGo("content/PosFilter")
	self._content = self:getGo("content")
	self._adjustPosition = self._content:GetComponent("UIAdjustPosition")
	self._closeBtn = self:getGo("clickGo")
end

function EquipOneKeyFilterView:onEnter()
	EquipOneKeyFilterView.super.onEnter(self)

	self._params = self:getFirstParam()
	self._filterRace = {}

	if not self._params.typeList then
		for attrType, v in pairs(self._params.typeList) do
			if v == true then
				self._filterRace[attrType] = true
			end
		end

		self._filterJob = {}

		if not self._params.jobList then
			for i, job in ipairs(self._params.jobList) do
				self._filterJob[job] = true
			end

			self:_adjustView()
			self:_initFilter()
		end
	end
end

function EquipOneKeyFilterView:_initFilter()
	self:_initList(1, self._raceFilter, self._filterRace)
	self:_initList(2, self._jobFilter, self._filterJob)
end

function EquipOneKeyFilterView:_initList(index, parent, filterMap)
	local condDataList = filterInfoList[index]

	for condIndex, v in pairs(condDataList) do
		local temp = {}

		temp.go = goutil.findChild(parent, "Cell" .. condIndex)
		temp.select = goutil.findChild(temp.go, "Mark")
		temp.name = goutil.findChildTextComponent(temp.go, "txt")
		temp.maskName = goutil.findChildTextComponent(temp.select, "txt")

		local isSelected = false

		if condIndex == 0 then
			isSelected = true

			for i, result in pairs(filterMap) do
				if result == true then
					isSelected = false

					break
				end
			end
		else
			for j, item in ipairs(v) do
				if filterMap[item] == true then
					isSelected = true

					break
				end
			end
		end

		goutil.setActive(temp.select, isSelected)
		GameUtil.asBtn(temp.go):RemoveClickListener()
		GameUtil.asBtn(temp.go):AddClickListener(function()
			self:_setSifterSelected(index, condIndex, filterMap)
		end)
	end
end

function EquipOneKeyFilterView:_setSifterSelected(index, cellIndex, filterMap)
	if cellIndex == 0 then
		table.clear(filterMap)
	else
		local condDataList = filterInfoList[index][cellIndex]
		local isFind = false

		for i, v in ipairs(condDataList) do
			if filterMap[v] == true then
				isFind = true

				break
			end
		end

		for i, v in ipairs(condDataList) do
			if isFind == true then
				filterMap[v] = nil
			else
				filterMap[v] = true
			end
		end
	end

	self:_initFilter()

	if index == 1 then
		local nums = table.nums(filterMap)

		if nums > 0 then
			GlobalDispatcher:dispatch(GlobalNotify.EquipBatchBreakoutRaceTypeFilter, filterMap)
		else
			GlobalDispatcher:dispatch(GlobalNotify.EquipBatchBreakoutRaceTypeFilter, nil)
		end
	elseif index == 2 then
		local result = {}

		for i, v in pairs(filterMap) do
			table.insert(result, i)
		end

		if #result > 0 then
			GlobalDispatcher:dispatch(GlobalNotify.EquipBatchBreakoutJobTypeFilter, result)
		else
			GlobalDispatcher:dispatch(GlobalNotify.EquipBatchBreakoutJobTypeFilter, nil)
		end
	end
end

function EquipOneKeyFilterView:_getPosAndSizeDelta(go)
	local rect = go.gameObject:GetComponent("RectTransform")
	local pos = go.gameObject.transform.position
	local uiCamera = CameraTargetMgr.instance:getUICameraTarget():getCamera()

	pos = uiCamera:WorldToScreenPoint(pos)

	return pos, (rect ~= nil or nil) and {
		rect.sizeDelta.x,
		rect.sizeDelta.y
	}
end

function EquipOneKeyFilterView:_adjustView()
	local pos, sizeDelta = self:_getPosAndSizeDelta(self._params.itemGo)

	self.pos = pos
	self.sizeDelta = sizeDelta

	if pos then
		Framework.TransformUtil.SetLocalScale(self.mainGO.transform, 1, 1, 1)
		self._adjustPosition:AdjustScreenPosition(self.pos, self.sizeDelta[1], self.sizeDelta[2])
	else
		Framework.TransformUtil.SetLocalPos(self._content.transform, 0, 0, 0)
	end
end

return EquipOneKeyFilterView
