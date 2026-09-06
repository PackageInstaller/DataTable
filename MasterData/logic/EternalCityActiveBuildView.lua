-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/eternalcity/view/EternalCityActiveBuildView.lua

module("logic.extensions.eternalcity.view.EternalCityActiveBuildView", package.seeall)

local EternalCityActiveBuildView = class("EternalCityActiveBuildView", ViewComponent)

function EternalCityActiveBuildView:buildUI()
	EternalCityActiveBuildView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._txtTitle = self:getTxt("txtTitle")

	local buildScrView = self:getGo("buildScrView")
	local buildScrCell = self:getGo("buildScrCell")

	self._buildScrollerList = ScrollerList.create(buildScrView, buildScrCell, GameUtil.handler(self._updateBuildCell, self), GameUtil.handler(self._clearBuildCell, self))
	self._emptyGo = self:getGo("emptyGo")
end

function EternalCityActiveBuildView:bindEvents()
	EternalCityActiveBuildView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function EternalCityActiveBuildView:unbindEvents()
	EternalCityActiveBuildView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function EternalCityActiveBuildView:onEnter()
	EternalCityActiveBuildView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	local isInTime = ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._subMo = EternalCityController.instance:getSubMo(self._activityId)
	self._actData = EternalCityConfig.instance:getActivityData(self._activityId)

	self.addGEvent(self, GlobalNotify.HandlePM_EternalCityInfoRes, self._onUpdate, self)
	self:_onUpdate()
end

function EternalCityActiveBuildView:onExit()
	EternalCityActiveBuildView.super.onExit(self)
	self._buildScrollerList:dispose()
end

function EternalCityActiveBuildView:_onUpdate()
	local buildInfoList = {}
	local placePositionInfos = self._subMo:getPlacePositionInfos()

	for _, placePositionInfo in ipairs(placePositionInfos) do
		local buildingId = placePositionInfo.buildingId
		local level = placePositionInfo.level
		local x = placePositionInfo.position.left
		local y = placePositionInfo.position.right
		local productionRate = self._subMo:getBuildingProductionRate(buildingId, level, x, y)
		local effectData = EternalCityConfig.instance:getBuildingEffectData(self._activityId, buildingId, productionRate)

		if effectData then
			table.insert(buildInfoList, {
				buildingId = buildingId,
				level = level,
				productionRate = productionRate,
				effectData = effectData
			})
		end
	end

	self._buildScrollerList:reloadData(buildInfoList)
	GameUtil.SetActive(self._emptyGo, #buildInfoList <= 0)
end

function EternalCityActiveBuildView:_updateBuildCell(view, cell, info, tag)
	local buildingId = info.buildingId
	local level = info.level
	local productionRate = info.productionRate
	local buildData = EternalCityConfig.instance:getBuildingData(self._activityId, buildingId, level)
	local effectData = EternalCityConfig.instance:getBuildingEffectData(self._activityId, buildingId, productionRate)
	local mainGo = cell.gameObject
	local icon = goutil.findChild(mainGo, "icon")
	local txtDesc = goutil.findChildTextComponent(mainGo, "txtDesc")
	local txtLevel = goutil.findChildTextComponent(mainGo, "level/txt")
	local iconUrl = string.format("ui/bigbg/%s.png", buildData.iconUrl)

	uGuiUtil.setSpriteToImage(icon, uGuiUtil.SpriteType.BigBg, iconUrl)

	txtDesc.text = effectData and effectData.desc
	txtLevel.text = string.format("%s级", level)
end

function EternalCityActiveBuildView:_clearBuildCell(cell)
	local mainGo = cell.gameObject
	local icon = goutil.findChild(mainGo, "icon")

	uGuiUtil.clearImage(icon)
end

return EternalCityActiveBuildView
