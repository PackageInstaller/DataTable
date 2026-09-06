-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/treasureraider/view/TreasureraideresourcedescView.lua

module("logic.extensions.treasureraider.view.TreasureraideresourcedescView", package.seeall)

local TreasureraideresourcedescView = class("TreasureraideresourcedescView", ViewComponent)

function TreasureraideresourcedescView:ctor()
	TreasureraideresourcedescView.super.ctor(self)
end

function TreasureraideresourcedescView:unbindEvents()
	TreasureraideresourcedescView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSure)
end

function TreasureraideresourcedescView:bindEvents()
	TreasureraideresourcedescView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)
end

function TreasureraideresourcedescView:buildUI()
	TreasureraideresourcedescView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnSure = self:getGo("btnSure")
	self._txtName = self:getTxt("txtName")
	self._txtTime = self:getTxt("txtTime")
	self._txtLevel = self:getTxt("txtLevel")
	self._buildingChange = goutil.findChildComponent(self.mainGO, "building", "UIImageSpriteChange")

	local formationCell = self:getGo("formation/cell")
	local formationTableView = self:getGo("formation/tableview")

	self._formationList = ScrollerList.create(formationTableView, formationCell, GameUtil.handler(self._updateFormationCell, self), GameUtil.handler(self._clearFormationCell, self))

	local rewardCell = self:getGo("reward/item")
	local rewardTableView = self:getGo("reward/tableview")

	self._rewardList = ScrollerList.create(rewardTableView, rewardCell, GameUtil.handler(self._updateRewardCell, self), GameUtil.handler(self._clearRewardCell, self))
end

function TreasureraideresourcedescView:onExit()
	TreasureraideresourcedescView.super.onExit(self)
	self._formationList:dispose()
	self._rewardList:dispose()
	removetimer(self._showTime, self)
end

function TreasureraideresourcedescView:onEnter()
	TreasureraideresourcedescView.super.onEnter(self)

	local params = self:getFirstParam()

	self._curGridId = params.id
	self._activityId = params.activityId
	self._curMapBuildingMo = params.buildingMo
	self._curSceneMo = params.sceneMo
	self._buildingConfig = TreasureRaiderConfig.instance:getBuildingConfig(self._curMapBuildingMo.buildingId)
	self._txtName.text = self._buildingConfig.name
	self._txtLevel.text = langPara("Lv.%s", self._curMapBuildingMo.buildingLevel or 0)

	self._buildingChange:ChangeSprite(self._buildingConfig.viewPath)

	local formationData = self._curSceneMo:getFormationByBuildingId(self._curMapBuildingMo.buildingId)
	local formationMo = FormationMO.New()

	formationMo:SetData(formationData)

	local team, formation, speed = formationMo:getTeamAndFormation()
	local teamDataList = {}

	if #team > 0 then
		for _, v in ipairs(team) do
			local data = {}

			data.mo = v

			table.insert(teamDataList, data)
		end
	else
		for i = 1, 6 do
			local data = {}

			data.mo = nil

			table.insert(teamDataList, data)
		end
	end

	self._formationList:reloadData(teamDataList)

	local produceCount = self._curMapBuildingMo:getProduceCount()
	local itemKeyArray = string.split(self._buildingConfig.itemKey or "", "#")
	local array = {}

	for i, v in ipairs(itemKeyArray) do
		table.insert(array, string.format("%s:%s", v, produceCount))
	end

	self._rewardList:reloadData(array)
	self:_showTime()
	removetimer(self._showTime, self)

	if self._curMapBuildingMo:isStopProduce() then
		settimer(1, self._showTime, self)
	end
end

function TreasureraideresourcedescView:_showTime()
	if self._curMapBuildingMo:isStopProduce() then
		local timer = self._curMapBuildingMo:getResourceStartTime()
		local sec = math.ceil((timer - ServerTime.nowMs()) / 1000)
		local str = GameUtil.FormatTimeSymbol(sec)

		self._txtTime.text = langPara("复产时间：%s", str)
	else
		self._txtTime.text = ""
	end
end

function TreasureraideresourcedescView:_updateFormationCell(view, cell, data, tag)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")
	local empty = goutil.findChild(mainGo, "empty")
	local isHasPet = data.mo ~= nil

	if isHasPet then
		local proxy = MaterialMgr.setCellByMo(data.mo, item)

		if proxy then
			proxy.binder:setCallBack(function()
				CommonTipsMgr.instance:showPetTips(data.mo)
			end)
		end
	else
		MaterialMgr.resetAll(item)
	end

	GameUtil.SetActive(item, isHasPet)
	GameUtil.SetActive(empty, not isHasPet)
end

function TreasureraideresourcedescView:_clearFormationCell(cell)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")

	MaterialMgr.resetAll(item)
end

function TreasureraideresourcedescView:_updateRewardCell(view, cell, data, tag)
	MaterialMgr.resetAll(cell.gameObject)

	local proxy = MaterialMgr.setCellByCfg(data, cell.gameObject)

	if proxy then
		local _, _, num = MaterialMgr.getMatParams(data or "")

		proxy:setNumStr(StringUtil.numberToString(num or 0))
	end
end

function TreasureraideresourcedescView:_clearRewardCell(cell)
	MaterialMgr.resetAll(cell.gameObject)
end

function TreasureraideresourcedescView:_onClickSure()
	local formationData = self._curSceneMo:getFormationByBuildingId(self._curMapBuildingMo.buildingId)
	local lockPetMap = self._curSceneMo:getFormationLockPetIdMapWithoutBuildingId(self._curMapBuildingMo.buildingId)
	local customFmtMo = TRDefendFmtMo.New()

	customFmtMo:initParams(self._activityId, self._curMapBuildingMo.buildingId, lockPetMap, formationData)
	self:close()
	CustomFmtController.instance:showMissionFormationView(customFmtMo)
end

return TreasureraideresourcedescView
