-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/SeasonFindKeyBagView.lua

module("logic.extensions.season.view.SeasonFindKeyBagView", package.seeall)

local SeasonFindKeyBagView = class("SeasonFindKeyBagView", ViewComponent)

function SeasonFindKeyBagView:ctor()
	SeasonFindKeyBagView.super.ctor(self)
end

function SeasonFindKeyBagView:unbindEvents()
	SeasonFindKeyBagView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function SeasonFindKeyBagView:bindEvents()
	SeasonFindKeyBagView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function SeasonFindKeyBagView:buildUI()
	SeasonFindKeyBagView.super.buildUI(self)

	self._tableview = self:getGo("tableview")
	self._tableCell = self:getGo("cell")
	self._btnClose = self:getBtn("btnClose")
end

function SeasonFindKeyBagView:onExit()
	SeasonFindKeyBagView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.SeasonGetFindKeyInfo, self._refreshView, self)
	self._keyList:dispose()
end

function SeasonFindKeyBagView:onEnter()
	SeasonFindKeyBagView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.SeasonGetFindKeyInfo, self._refreshView, self)

	self._keyList = ScrollerList.create(self._tableview, self._tableCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	SeasonModePvePlusAgent.instance:sendPM_SMPVEFindKeyInfoReq()
end

function SeasonFindKeyBagView:_refreshView()
	local seasonId = SeasonModel.instance:getSeasonId()
	local array = SeasonConfig.instance:getGridEventMap(seasonId, SeasonGridEvtTypes.EVT_FIND_KEY) or {}

	self._keyMap = {}

	for i, mapCfg in ipairs(array) do
		local detailcfg = SeasonConfig.instance:getMapEvtDetail(seasonId, SeasonGridEvtTypes.EVT_FIND_KEY, mapCfg.eventId)

		if detailcfg and detailcfg.isKey == true then
			self._keyMap[detailcfg.id] = mapCfg
		end
	end

	self._keyList:reloadData(SeasonConfig.instance:getKeysCfg(seasonId))
end

function SeasonFindKeyBagView:_updateCell(view, cell, detailcfg, tag)
	local go = cell.gameObject
	local txtDesc = goutil.findChildTextComponent(go, "txtDesc")
	local btnPos = GameUtil.asBtn(goutil.findChild(go, "btnPos"))
	local imgCon = goutil.findChild(go, "imgCon")
	local isOccupied = false
	local teamId
	local mapCfg = self._keyMap[detailcfg.id]

	if mapCfg then
		isOccupied = SeasonModel.instance:isOccupied(mapCfg.id)

		if isOccupied == true then
			txtDesc.text = langPara("当前位置：队伍%d", SeasonModel.instance:getGainKeyTeam(detailcfg.keyGroupId))
			teamId = SeasonModel.instance:getGainKeyTeam(detailcfg.keyGroupId)
		else
			txtDesc.text = langPara("当前位置：(%d,%d)", mapCfg.x, mapCfg.y)
		end
	else
		txtDesc.text = lang("未定义桃符位置")
	end

	if not string.nilorempty(detailcfg.keyRes) then
		uGuiUtil.setSpriteToImage(imgCon, nil, GameUrl.getBigbgFolderUrl("season", detailcfg.keyRes))
	end

	if isOccupied == true and teamId then
		local teamMo = SeasonTeamsModel.instance:getTeam(teamId)

		btnPos:AddClickListener(function()
			self:_onClickGoto(teamMo.serverCurGridId)
		end, self)
	elseif mapCfg then
		btnPos:AddClickListener(function()
			self:_onClickGoto(mapCfg.id)
		end, self)
	end
end

function SeasonFindKeyBagView:_clearCell(cell)
	local go = cell.gameObject
	local imgCon = goutil.findChild(go, "imgCon")
	local btnPos = GameUtil.asBtn(goutil.findChild(go, "btnPos"))

	uGuiUtil.clearImage(imgCon)
	btnPos:RemoveClickListener()
end

function SeasonFindKeyBagView:_onClickGoto(jumpTo)
	self:close()

	local gridX, gridY = SeasonPathFindingDataModel.instance:id2Grid(jumpTo)
	local scene = SceneMgr.instance:getCurScene()

	if scene and scene.eventsAnimation then
		scene.eventsAnimation:playCamera2Grid(gridX, gridY)
		GlobalDispatcher:dispatch(GlobalNotify.SeasonSelectGrid_R_C, gridX, gridY)
	end
end

return SeasonFindKeyBagView
