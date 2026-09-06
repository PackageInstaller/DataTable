-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chuangjingroad/view/ChuangjingroadbossgrassView.lua

module("logic.extensions.chuangjingroad.view.ChuangjingroadbossgrassView", package.seeall)

local ChuangjingroadbossgrassView = class("ChuangjingroadbossgrassView", ViewComponent)

function ChuangjingroadbossgrassView:ctor()
	ChuangjingroadbossgrassView.super.ctor(self)
end

function ChuangjingroadbossgrassView:unbindEvents()
	ChuangjingroadbossgrassView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function ChuangjingroadbossgrassView:bindEvents()
	ChuangjingroadbossgrassView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function ChuangjingroadbossgrassView:buildUI()
	ChuangjingroadbossgrassView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnTip = self:getGo("btnTip")
	self._txtTitle = self:getTxt("txtTitle")
	self._txtDesc = self:getTxt("txtDesc")
	self._tablecell = self:getGo("tablecell")
	self._tableview = self:getGo("tableview")
	self._changeBg = self:getGo("changeBg")
	self._scrollList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function ChuangjingroadbossgrassView:onExit()
	ChuangjingroadbossgrassView.super.onExit(self)
	self._scrollList:dispose()
	uGuiUtil.clearImage(self._changeBg)
end

function ChuangjingroadbossgrassView:onEnter()
	ChuangjingroadbossgrassView.super.onEnter(self)

	self._activityId = 396001
	self._zoneId = 4

	local params = self:getOpenParam() or {}
	local actId = checknumber(params[1])
	local zoneId = checknumber(params[2])

	if actId > 0 then
		self._activityId = actId
	end

	if zoneId > 0 then
		self._zoneId = zoneId
	end

	self.addGEvent(self, GlobalNotify.CHUANG_JING_ROAD_INFO_UPDATE, self._onRefershUI, self)
	ChuangJingRoadController.instance:sendGetInfo(self._activityId)
	self:_onRefershUI()
end

function ChuangjingroadbossgrassView:_onRefershUI()
	local info = ChuangJingRoadModel.instance:getInfo(self._activityId) or {}

	if not info.zones then
		local zones = {}

		self._zoneInfo = nil

		for i, v in ipairs(zones) do
			if v.zoneId == self._zoneId then
				self._zoneInfo = v

				break
			end
		end

		self._zoneInfo = self._zoneInfo or {}
		self._grassBoss = self._zoneInfo.grassBoss or {}
		self._stageIdList = self._grassBoss.stageId or {}

		local extCfg = ChuangJingRoadConfig.instance:getExtStageById(self._activityId, self._zoneId)

		self._txtDesc.text = extCfg.desc

		local zoneCfg = ChuangJingRoadConfig.instance:getZoneCfgById(self._activityId, self._zoneId) or {}

		uGuiUtil.setSpriteToImage(self._changeBg.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getBigbgPngUrl(zoneCfg.imageUrl), function()
			self._changeBg.gameObject:GetComponent("Image"):SetNativeSize()
		end)

		self._txtTitle.text = zoneCfg.desc

		local cfgList = ChuangJingRoadConfig.instance:getGrassBossListCfgById(self._activityId, self._zoneId) or {}

		self._scrollList:reloadData(cfgList)
	end
end

function ChuangjingroadbossgrassView:_updateCell(view, cell, data, tag)
	local txtDesc = goutil.findChildTextComponent(cell, "txtDesc")
	local btnStart = goutil.findChild(cell, "btnStart")
	local pass = goutil.findChild(cell, "fmt/pass")
	local fmt = goutil.findChild(cell, "fmt")
	local creepsMasterId = data.creepsMasterId
	local masterCfg = ChuangJingRoadConfig.instance:getMonsterCfgById(creepsMasterId) or {}
	local creeps = ChuangJingRoadConfig.instance:getCreepsCfgById(creepsMasterId) or {}

	GameUtil.SetActive(pass, table.indexof(self._stageIdList, data.stageId) ~= false)
	GameUtil.SetActive(btnStart, table.indexof(self._stageIdList, data.stageId) == false)

	txtDesc.text = masterCfg.WinDesc

	local map = {}

	for k, pet in pairs(creeps) do
		map[pet.posId] = pet
	end

	for j = 1, 9 do
		local petCell = goutil.findChild(cell, "fmt/cell_" .. j)
		local cc = map[j]

		GameUtil.SetActive(petCell, false)

		if cc then
			GameUtil.SetActive(petCell, true)

			local icon = goutil.findChild(cell, "fmt/cell_" .. j .. "/icon")

			MaterialMgr.setIcon(icon, MatType.Pet, cc.raceId)
		end
	end

	GameUtil.addClickHandler(btnStart, GameUtil.handler(self._onClickStart, self, data))
end

function ChuangjingroadbossgrassView:_clearCell(cell)
	local fmt = goutil.findChild(cell, "fmt")

	for j = 1, 9 do
		local icon = goutil.findChild(cell, "fmt/cell_" .. j .. "/icon")

		MaterialMgr.resetAll(icon)
	end
end

function ChuangjingroadbossgrassView:_onClickStart(data)
	ChuangJingRoadController.instance:openGrassBossMissionView(self._activityId, self._zoneId, data.stageId)
end

return ChuangjingroadbossgrassView
