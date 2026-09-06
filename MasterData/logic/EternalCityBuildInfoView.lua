-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/eternalcity/view/EternalCityBuildInfoView.lua

module("logic.extensions.eternalcity.view.EternalCityBuildInfoView", package.seeall)

local EternalCityBuildInfoView = class("EternalCityBuildInfoView", ViewComponent)

function EternalCityBuildInfoView:buildUI()
	EternalCityBuildInfoView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnAuto = self:getGo("btnAuto")
	self._btnSure = self:getGo("btnSure")
	self._txtTitle = self:getTxt("txtTitle")
	self._txtSpeed = self:getTxt("activePet/txtSpeed")
	self._activePetScrView = self:getGo("activePet/scrView")
	self._activePetScrCell = self:getGo("activePet/scrCell")
	self._activePetScrollerList = ScrollerList.create(self._activePetScrView, self._activePetScrCell, GameUtil.handler(self._updateActivePetScrCell, self), GameUtil.handler(self._clearActivePetScrCell, self))
	self._bagPetScrView = self:getGo("bagPet/scrView")
	self._bagPetScrCell = self:getGo("bagPet/scrCell")
	self._bagPetScrollerList = ScrollerList.create(self._bagPetScrView, self._bagPetScrCell, GameUtil.handler(self._updateBagPetScrCell, self), GameUtil.handler(self._clearBagPetScrCell, self))
	self._buffColScrView = self:getGo("buffCol/scrView")
	self._buffColScrCell = self:getGo("buffCol/scrCell")
	self._buffColScrollerList = ScrollerList.create(self._buffColScrView, self._buffColScrCell, GameUtil.handler(self._updateBuffColScrCell, self), GameUtil.handler(self._clearBuffColScrCell, self))

	self._buffColScrollerList:regGetCellSize(GameUtil.handler(self._getBuffCellSize, self))

	self._minHeightBuffScrCell = GameUtil.getHeight(self._buffColScrCell)
	self._buffScrCellTemp = goutil.cloneAndSetParent(self._buffColScrCell, self._buffColScrCell.transform.parent, self._buffColScrCell.name .. "(clone)")
	self._txtDescBuffScrCellTemp = goutil.findChildTextComponent(self._buffScrCellTemp, "txtDesc")
	self._buffScrCellWidth = GameUtil.getWidth(self._buffScrCellTemp)

	local layoutGroup = self._buffScrCellTemp:GetComponent(typeof(UnityEngine.UI.LayoutGroup))
	local padding = layoutGroup.padding

	self._buffScrCellHeightBase = padding.top + padding.bottom

	GameUtil.SetActive(self._buffScrCellTemp, false)
end

function EternalCityBuildInfoView:bindEvents()
	EternalCityBuildInfoView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnAuto, self._onClickBtnAuto, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickBtnSure, self)
end

function EternalCityBuildInfoView:unbindEvents()
	EternalCityBuildInfoView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnAuto)
	GameUtil.rmClickHandler(self._btnSure)
end

function EternalCityBuildInfoView:onEnter()
	EternalCityBuildInfoView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._buildingId = checknumber(params[2])
	self._level = checknumber(params[3])
	self._position = params[4]
	self._subMo = EternalCityController.instance:getSubMo(self._activityId)
	self._buildData = EternalCityConfig.instance:getBuildingData(self._activityId, self._buildingId, self._level)
	self._txtTitle.text = self._buildData and self._buildData.name

	self.addGEvent(self, GlobalNotify.HandlePMEternalCityInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_EternalCityOperaPetRes, self._onHandlePM_EternalCityOperaPetRes, self)
	self:_onUpdate()
end

function EternalCityBuildInfoView:onExit()
	EternalCityBuildInfoView.super.onExit(self)
	self:_onClearActivePetCol()
	self:_onClearBagPetCol()
	self:_onClearBuffCol()
end

function EternalCityBuildInfoView:_onHandlePM_EternalCityOperaPetRes()
	FloatWordMgr.instance:show("保存成功")
	self:_onUpdate()
end

function EternalCityBuildInfoView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function EternalCityBuildInfoView:_onUpdateData()
	self._activePetList = {}

	local placePositionInfo = self._subMo:getPlacePositionInfoByPos(self._position.x, self._position.y)

	if placePositionInfo and placePositionInfo.petIds then
		table.insertto(self._activePetList, placePositionInfo.petIds)
	end

	self._creepsIdListInBag = {}

	local creepsInfos = self._subMo:getCreepsInfos()

	for _, info in pairs(creepsInfos) do
		for i = 1, info.num do
			table.insert(self._creepsIdListInBag, info.creepsId)
		end
	end

	local placePositionInfos = self._subMo:getPlacePositionInfos()

	for _, info in ipairs(placePositionInfos) do
		for _, creepsId in ipairs(info.petIds) do
			table.removebyvalue(self._creepsIdListInBag, creepsId)
		end
	end

	self:_sortCreepsIdListInBag()
end

function EternalCityBuildInfoView:_sortCreepsIdListInBag()
	if self._creepsIdListInBag == nil then
		return
	end

	table.sort(self._creepsIdListInBag, function(a, b)
		if a ~= b then
			local dataA = EternalCityConfig.instance:getSupportPetData(self._activityId, a)
			local dataB = EternalCityConfig.instance:getSupportPetData(self._activityId, b)

			if dataA then
				if not dataA.productionRate then
					local productionRateA = 0

					if dataB then
						if not dataB.productionRate then
							local productionRateB = 0

							return productionRateB < productionRateA
						end
					end
				end
			end
		end

		return false
	end)
end

function EternalCityBuildInfoView:_onUpdateUI()
	self:_onUpdateActivePetCol()
	self:_onUpdateBagPetCol()
	self:_onUpdateBuffCol()
end

function EternalCityBuildInfoView:_onUpdateActivePetCol()
	local maxLevel = self._subMo:getBuildingMaxLevel(self._buildingId)
	local maxBuildData = EternalCityConfig.instance:getBuildingData(self._activityId, self._buildingId, maxLevel)
	local canPlacePetNum = maxBuildData.canPlacePetNum
	local creepsIdList = {}

	for idx = 1, canPlacePetNum do
		if not self._activePetList[idx] then
			table.insert(creepsIdList, self._activePetList[idx])
		end
	end

	self._activePetScrollerList:reloadData(creepsIdList)

	local productionRate = 0

	for _, creepsId in ipairs(self._activePetList) do
		local supportPetData = EternalCityConfig.instance:getSupportPetData(self._activityId, creepsId)

		if supportPetData then
			productionRate = productionRate + supportPetData.productionRate
		else
			printError(string.format("永恒之城:精灵配置无法找到( 活动id:%s, creepsId: %s )", self._activityId, creepsId))
		end
	end

	self._productionRate = productionRate
	self._txtSpeed.text = string.format("%s%%", self._productionRate)
end

function EternalCityBuildInfoView:_onClearActivePetCol()
	self._activePetScrollerList:dispose()
end

function EternalCityBuildInfoView:_updateActivePetScrCell(view, cell, creepsId, tag)
	local index = cell.data
	local data = EternalCityConfig.instance:getSupportPetData(self._activityId, creepsId)
	local isEmpty = data == nil
	local skinId = checknumber(data and data.faceId)

	if skinId <= 0 then
		skinId = checknumber(data and data.raceId)
	end

	if data then
		if not data.productionRate then
			local productionRate = 0
			local isUnlock = self._subMo:isUnlockedPlacePet(self._buildingId, self._level, index)
			local minUnlockLevel = self._subMo:getBuildingMinUnlockLevel(self._buildingId, index)
			local mainGo = cell.gameObject
			local contentGO = goutil.findChild(mainGo, "content")
			local icon = goutil.findChild(mainGo, "content/icon")
			local btnDown = goutil.findChild(mainGo, "content/btnDown")
			local txtSpeed = goutil.findChildTextComponent(mainGo, "content/speed/txt")
			local tagEmpty = goutil.findChild(mainGo, "tagEmpty")
			local tagLock = goutil.findChild(mainGo, "tagLock")
			local txtTagLock = goutil.findChildTextComponent(mainGo, "tagLock/txt")

			GameUtil.SetActive(contentGO, not isEmpty)
			GameUtil.SetActive(tagEmpty, isUnlock and isEmpty)
			GameUtil.SetActive(tagLock, not isUnlock)

			if skinId > 0 then
				MaterialMgr.setIcon(icon, MatType.Pet, skinId, nil, nil)
			else
				MaterialMgr.clearIcon(icon)
			end

			txtSpeed.text = string.format("%s%%", productionRate)
			txtTagLock.text = string.format("Lv%s解锁", minUnlockLevel)

			GameUtil.addClickHandler(btnDown, function()
				local result = self:_getTryUnequipPetResultAndTips(true, self._buildingId, self._level, creepsId)

				if result ~= GameEnum.ResultCode.Success then
					return
				end

				table.removebyvalue(self._activePetList, creepsId)
				table.insert(self._creepsIdListInBag, creepsId)
				self:_sortCreepsIdListInBag()
				self:_onUpdateUI()
			end, self)
		end
	end
end

function EternalCityBuildInfoView:_clearActivePetScrCell(cell)
	local mainGo = cell.gameObject
	local icon = goutil.findChild(mainGo, "content/icon")
	local btnDown = goutil.findChild(mainGo, "content/btnDown")

	MaterialMgr.clearIcon(icon)
	GameUtil.rmClickHandler(btnDown)
end

function EternalCityBuildInfoView:_onUpdateBagPetCol()
	self._bagPetScrollerList:reloadData(self._creepsIdListInBag)
end

function EternalCityBuildInfoView:_onClearBagPetCol()
	self._bagPetScrollerList:dispose()
end

function EternalCityBuildInfoView:_updateBagPetScrCell(view, cell, creepsId, tag)
	local data = EternalCityConfig.instance:getSupportPetData(self._activityId, creepsId)
	local skinId = checknumber(data and data.faceId)

	if skinId <= 0 then
		skinId = checknumber(data and data.raceId)
	end

	if data then
		if not data.productionRate then
			local productionRate = 0
			local mainGo = cell.gameObject
			local icon = goutil.findChild(mainGo, "icon")
			local txtSpeed = goutil.findChildTextComponent(mainGo, "speed/txt")

			MaterialMgr.setIcon(icon, MatType.Pet, skinId, nil, nil)

			txtSpeed.text = string.format("%s%%", productionRate)

			GameUtil.addClickHandler(mainGo, function()
				local result = self:_getTryPlacePetResultAndTips(true, self._buildingId, self._level, creepsId)

				if result ~= GameEnum.ResultCode.Success then
					return
				end

				table.insert(self._activePetList, creepsId)
				table.removebyvalue(self._creepsIdListInBag, creepsId)
				self:_sortCreepsIdListInBag()
				self:_onUpdateUI()
			end, self)
		end
	end
end

function EternalCityBuildInfoView:_clearBagPetScrCell(cell)
	local mainGo = cell.gameObject
	local icon = goutil.findChild(mainGo, "icon")

	MaterialMgr.clearIcon(icon)
end

function EternalCityBuildInfoView:_onUpdateBuffCol()
	local dataList = {}
	local datas = EternalCityConfig.instance:getBuildingEffectDatas(self._activityId, self._buildingId) or {}

	for rate, data in pairs(datas) do
		table.insert(dataList, data)
	end

	table.sort(dataList, function(a, b)
		return a.rate < b.rate
	end)

	self._curActiveData = EternalCityConfig.instance:getBuildingEffectData(self._activityId, self._buildingId, self._productionRate)

	self._buffColScrollerList:reloadData(dataList)

	local index = 0

	for idx, data in ipairs(dataList) do
		if self._curActiveData and data.buildingId == self._curActiveData.buildingId and data.rate == self._curActiveData.rate then
			index = idx - 1

			break
		end
	end

	self._buffColScrollerList:MoveCellToCenter(index)
end

function EternalCityBuildInfoView:_onClearBuffCol()
	self._buffColScrollerList:dispose()
end

function EternalCityBuildInfoView:_updateBuffColScrCell(view, cell, data, tag)
	local isActive = self._curActiveData and data.buildingId == self._curActiveData.buildingId and data.rate == self._curActiveData.rate or false
	local mainGo = cell.gameObject
	local txtSpeed = goutil.findChildTextComponent(mainGo, "txtSpeed")
	local txtDesc = goutil.findChildTextComponent(mainGo, "txtDesc")
	local tagActive = goutil.findChild(mainGo, "tagActive")

	txtSpeed.text = string.format("%s%%", data.rate)
	txtDesc.text = data.desc

	GameUtil.SetActive(tagActive, isActive)
	GameUtil.setUIGroupIdx(mainGo, isActive and 1 or 0)
end

function EternalCityBuildInfoView:_clearBuffColScrCell(cell)
	return
end

function EternalCityBuildInfoView:_getBuffCellSize(view, idx)
	local datas = self._buffColScrollerList:getData()
	local data = datas[idx + 1]

	self._txtDescBuffScrCellTemp.text = data.desc

	local height = self._buffScrCellHeightBase + self._txtDescBuffScrCellTemp.preferredHeight

	return self._buffScrCellWidth, height
end

function EternalCityBuildInfoView:_getTryPlacePetResultAndTips(isNeedTips, buildingId, level, creepsId)
	local result = GameEnum.ResultCode.Success
	local tips = ""

	if not ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._activityId) then
		result = GameEnum.ResultCode.Error
		tips = "不在活动时间范围内"
	end

	if result == GameEnum.ResultCode.Success then
		local creepsData = EternalCityConfig.instance:getSupportPetData(self._activityId, creepsId)

		if creepsData == nil then
			result = GameEnum.ResultCode.Error
			tips = "精灵不存在"
		end
	end

	if result == GameEnum.ResultCode.Success then
		local canPlacePetNum = self._subMo:getBuildingCanPlacePetNum(buildingId, level)
		local curPlacePetNum = #self._activePetList

		if canPlacePetNum <= curPlacePetNum then
			result = GameEnum.ResultCode.Error
			tips = "栏目已满"
		end
	end

	if isNeedTips then
		FloatWordMgr.instance:show(tips)
	end

	return result
end

function EternalCityBuildInfoView:_getTryUnequipPetResultAndTips(isNeedTips, buildingId, level, creepsId)
	local result = GameEnum.ResultCode.Success
	local tips = ""

	if not ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._activityId) then
		result = GameEnum.ResultCode.Error
		tips = "不在活动时间范围内"
	end

	return result
end

function EternalCityBuildInfoView:_onClickBtnAuto()
	local canPlacePetNum = self._subMo:getBuildingCanPlacePetNum(self._buildingId, self._level)
	local curPlacePetNum = #self._activePetList
	local offest = canPlacePetNum - curPlacePetNum

	if offest <= 0 then
		FloatWordMgr.instance:show("栏目已满")

		return
	end

	local length = Mathf.Min(offest, #self._creepsIdListInBag)

	for idx = 1, length do
		local creepsId = table.remove(self._creepsIdListInBag, 1)

		table.insert(self._activePetList, creepsId)
	end

	self:_onUpdateUI()
end

function EternalCityBuildInfoView:_onClickBtnSure()
	EternalCityController.instance:sendPM_EternalCityOperaPetReq(self._activityId, self._buildingId, self._level, self._position.x, self._position.y, self._activePetList)
end

return EternalCityBuildInfoView
