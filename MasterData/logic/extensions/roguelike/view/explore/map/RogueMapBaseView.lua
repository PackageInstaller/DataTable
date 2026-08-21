-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/explore/map/RogueMapBaseView.lua

module("logic.extensions.roguelike.view.explore.map.RogueMapBaseView", package.seeall)

local M = class("RogueMapBaseView", ViewComponent)

function M:ctor()
	M.super.ctor(self)

	self._mapItems = {}
end

function M:buildUI()
	self._btnRetreat = self:getBtn("run_group_main_view_27766643")
	self._btnEquip = self:getBtn("run_group_main_view_-1748836174")
	self._btnProp = self:getBtn("run_group_main_view_1831121106")
	self._btnExplain = self:getBtn("run_group_main_view_copy_345340226")
	self._btnDiffDetail = self:getBtn("run_group_main_view_copy_-2069075577")
	self._txtLayer = self:getText("run_group_main_view_140677608")
	self._txtTargetName = self:getText("run_group_main_view_444096072")
	self._txtScriptName = self:getText("run_group_main_view_1583694224")
	self._txtMapName = self:getText("run_group_main_view_copy_-1559783707")
	self._goTargetName = self:getGo("run_group_main_view_444096072")
	self._goTop = self:getGo("run_group_main_view_-1853555595")
	self._goHeadGroup = self:getGo("run_group_main_view_copy_691812377")
	self._goSanity = self:getGo("21&rungroup_sanity_item_-1911028484")
	self._goMoney = self:getGo("run_group_main_view_copy_-665216554")
	self._goPropList = self:getGo("run_group_main_view_copy_-1680710239")
	self._goRoleInfo = goutil.findChild(self.mainGO, "role_info_detail")
	self._goMapItem = self:getGo("run_group_main_view_-312601926")
	self._goMapPointItem = self:getGo("run_group_main_view_-1080460436")
	self._goDiff = self:getGo("run_group_main_view_copy_-1379657274")
	self._goDiffTips = self:getGo("run_group_main_view_copy_-156721915")
	self._goDiffBuffItem = self:getGo("run_group_main_view_copy_-999203497")
	self._goScriptName = self:getGo("run_group_main_view_1426532831")
	self._traMapParent = self:getGo("run_group_main_view_-518790481").transform
	self._traMapPlateParent = self:getGo("run_group_main_view_-177127969").transform
	self._traMapScroller = self:getGo("run_group_main_view_2135037092").transform
	self._traDiffBuffParent = self:getGo("run_group_main_view_copy_1168978649").transform
	self._guiAnimation = goutil.addComponentOnce(self.mainGO, typeof(Astral.GUITimelineAniLua))
	self._sanityItem = Astral.LuaComponentContainer.Add(self._goSanity, RogueSanityItem)

	self._sanityItem:updateData()

	self._propBtnItem = Astral.LuaComponentContainer.Add(self._btnProp.gameObject, RoguePropBtnItem)
	self._moneyItem = Astral.LuaComponentContainer.Add(self._goMoney, RogueMoneyItem)
	self._teamHead = Astral.LuaComponentContainer.Add(self._goHeadGroup, RogueTeamHead)

	self._teamHead:setClickCallback(function(idx)
		self:_onRoleHeadClick(idx)
	end)

	self._propListTips = Astral.LuaComponentContainer.Add(self._goPropList, RoguePropListTips)
	self._roleInfoDetail = Astral.LuaComponentContainer.Add(self._goRoleInfo, RogueRoleInfoDetail)
	self._equipBtnItem = Astral.LuaComponentContainer.Add(self._btnEquip.gameObject, RogueEquipBtnItem)

	local goLeftContent = self:getGo("run_group_main_view_copy_1857662089")

	self._equipTips = Astral.LuaComponentContainer.Add(goutil.findChild(goLeftContent, "run_group_equip_tips"), RogueEquipTips)
end

function M:destroyUI()
	self._sanityItem:OnDestroy()
	self._propBtnItem:OnDestroy()
	self._moneyItem:OnDestroy()
	self._teamHead:OnDestroy()
	self._propListTips:OnDestroy()
	self._roleInfoDetail:OnDestroy()
	self._equipBtnItem:OnDestroy()
end

function M:onEnter()
	self:setEvent(true)
	IconLoader.bindSpriteAtlas(IconType.DynSpriteAtlas_Dice)
	self:updateMapByRooms(true)

	for k, v in pairs(self._mapItems) do
		v:bindEvents()
	end

	self:setAniGoActive(false)
	self:setRoleModel()
	self:updateRoleInfo(true)
	self:updateLayerInfo()
	self:updateTarget()
	self:updateProp()
	RoguelikeAgent.instance:delayShowProps()
end

function M:onEnterFinished()
	LoadingFacade.instance:hideLoading()
	RogueJudgeController.instance:checkEndSelect()
end

function M:onExit()
	self:setEvent(false)
	removetimer(self._delayShowScriptName, self)
	removetimer(self.delayClickItemCallback, self)
	removetimer(self.delayResetClickInterval, self)
	removetimer(self._delayHideScriptName, self, false)
end

function M:onExitFinished()
	for k, v in pairs(self._mapItems) do
		v:unbindEvents()
	end
end

function M:setEvent(isAdd)
	if isAdd then
		GlobalDispatcher:addEventListener(EventType.ROGUE_QUIT_SUCCESS, self._onQuitSuccess, self)
		GlobalDispatcher:addEventListener(EventType.ROGUE_ROOM_INFO_REFRESH, self._onRoomRefresh, self)
		GlobalDispatcher:addEventListener(EventType.ROGUE_EXPLORE_INFO, self._onExploreRefresh, self)
		GlobalDispatcher:addEventListener(EventType.ROGUE_ADD_PROP_SUCCESS, self._onAddPropSuccess, self)
		GlobalDispatcher:addEventListener(EventType.ROGUE_REFRESH_ROLE_INFO, self._onRoleInfoUpdate, self)
		GlobalDispatcher:addEventListener(EventType.ROGUE_SET_MAP_ICON_ACTIVE, self._onMapIconActive, self)
		GlobalDispatcher:addEventListener(EventType.ROGUE_SHOW_CHANGE_COLLECTOR, self._onShowChangeCollector, self)
		GlobalDispatcher:addEventListener(EventType.ROGUE_SHOW_MAP_NAME, self._onShowMapName, self)
		GlobalDispatcher:addEventListener(EventType.ROGUE_SHOW_MAP_VIEW_ACTIVE, self._onShowMapViewActive, self)
	else
		GlobalDispatcher:removeEventListener(EventType.ROGUE_QUIT_SUCCESS, self._onQuitSuccess, self)
		GlobalDispatcher:removeEventListener(EventType.ROGUE_ROOM_INFO_REFRESH, self._onRoomRefresh, self)
		GlobalDispatcher:removeEventListener(EventType.ROGUE_EXPLORE_INFO, self._onExploreRefresh, self)
		GlobalDispatcher:removeEventListener(EventType.ROGUE_ADD_PROP_SUCCESS, self._onAddPropSuccess, self)
		GlobalDispatcher:removeEventListener(EventType.ROGUE_REFRESH_ROLE_INFO, self._onRoleInfoUpdate, self)
		GlobalDispatcher:removeEventListener(EventType.ROGUE_SET_MAP_ICON_ACTIVE, self._onMapIconActive, self)
		GlobalDispatcher:removeEventListener(EventType.ROGUE_SHOW_CHANGE_COLLECTOR, self._onShowChangeCollector, self)
		GlobalDispatcher:removeEventListener(EventType.ROGUE_SHOW_MAP_NAME, self._onShowMapName, self)
		GlobalDispatcher:removeEventListener(EventType.ROGUE_SHOW_MAP_VIEW_ACTIVE, self._onShowMapViewActive, self)
	end
end

function M:bindEvents()
	self._btnRetreat:AddClickListener(self._onClickRetreat, self)
	self._btnEquip:AddClickListener(self._onClickEquip, self)
	self._btnProp:AddClickListener(self._onClickProp, self)
	self._btnExplain:AddClickListener(self._onClickExplain, self)
end

function M:unbindEvents()
	self._btnRetreat:RemoveClickListener()
	self._btnEquip:RemoveClickListener()
	self._btnProp:RemoveClickListener()
	self._btnExplain:RemoveClickListener()
end

function M:initOwnPropTips()
	local content = self:getGo("run_group_main_view_133990976")
	local tips = goutil.findChild(content, "props_owner_tips")

	self._ownPropTips = Astral.LuaComponentContainer.Add(tips, RogueOwnPropTips)
	self._txtBtnPropCount = goutil.findChildComponent(self._btnProp.gameObject, "normal/Text1", UIComponentType.Text)
end

function M:initDiffDetailTips()
	local diffBuffs = RoguelikeModel.instance:getCurDiffBuffIds()

	for k, v in pairs(self._debuffItems) do
		v:setActive(false)
	end

	if diffBuffs then
		for k, v in pairs(diffBuffs) do
			local effectCo = RoguelikeConfig.instance:getEffectById(v)
			local item = self._debuffItems[v]

			if not item then
				local go = goutil.cloneAndSetParent(self._goDiffBuffItem, self._traDiffBuffParent)

				item = Astral.LuaComponentContainer.Add(go, DebuffItem)
				self._debuffItems[k] = item
			end

			local data = {}

			data.desc = effectCo.description

			item:updateData(data)
		end
	end

	local txtDiff = goutil.findChildTextComponent(self._goDiff, "Text2")
	local diffLevel = RoguelikeModel.instance:getScriptDiffLevel()

	if diffLevel > 0 then
		local diffLevelCo = RoguelikeConfig.instance:getDiffLevelByLevel(diffLevel, RoguelikeModel.instance:getCurScriptId())

		if diffLevelCo then
			txtDiff.text = diffLevelCo.name
		end
	end

	goutil.setActive(self._goDiff, diffBuffs ~= nil and #diffBuffs > 0 and diffLevel > 0)
end

function M:setAniGoActive(isActive)
	if self._btnEquip == nil then
		return
	end

	goutil.setActive(self._btnEquip.gameObject, isActive)
	goutil.setActive(self._btnProp.gameObject, isActive)
	goutil.setActive(self._goHeadGroup, isActive)
	goutil.setActive(self._goTop.gameObject, isActive)

	if isActive then
		self:playAniByName("open")
	end
end

function M:playAniByName(name)
	self._guiAnimation:StopTimelineAni()
	self._guiAnimation:PlayAniByName(name)
end

function M:setRoleModel()
	RogueMgr.instance:getRogueFlow().mapMgr:setRoleSpine()
end

function M:updateRoleInfo(isEnter)
	local isInRogue = RoguelikeModel.instance:getIsInRogue()

	if not isInRogue and isEnter then
		RoguelikeController.instance:checkNeedQuit()

		return
	end

	if isEnter then
		self._teamHead:updateData()
	end
end

function M:_onClickEquip()
	if self._isSpineMoving then
		return
	end

	local equips = RoguelikeModel.instance:getCurEquipMOS() or {}

	if #equips == 0 then
		FloatWordMgr.instance:show(lang("tip_r_not_equip"))

		return
	end

	self._equipTips:updateData(equips[1])
	GlobalDispatcher:dispatchEvent(EventType.ROGUE_GUIDE_INFO, GuideEnum.GuideRoguelikeTriggerType.ActiveUI, ViewName.RogueMap, self._equipTips._go)
end

function M:_onClickProp()
	self._propListTips:updateData()
end

function M:_onClickExplain()
	ViewMgr.instance:open(ViewName.ImageGuide, {
		CommEnum.ManualKey.RogueExplore
	})
end

function M:_onClickRetreat()
	local dialog = Dialog.showMessage(lang("tip_title"), lang("tip_r_quit_cur_script"), 0)

	dialog:setConfirmListener(function()
		self:_onClickClose()
	end, self)
	dialog:setCancelListener(function()
		local dialog1 = Dialog.showMessage(lang("tip_title"), lang("撤退会失去当前探索的全部进度，是否撤退"), 0)

		dialog1:setConfirmListener(function()
			RoguelikeAgent.instance:sendQuitRequest()
		end, self)
	end, self)
	dialog:setConfirmText(lang("tip_r_quit_save"))
	dialog:setCancelText(lang("tip_r_quit_confirm"))
end

function M:_onClickClose()
	self:back()
	RoguelikeController.instance:exitRunGroupSceneFlow()
end

function M:_onRoleHeadClick(index)
	local data = {}

	data.index = index

	function data.closeCallback()
		self._teamHead:reset()
	end

	self._roleInfoDetail:updateData(data)
end

function M:updateLayerInfo()
	local curLayer = RoguelikeModel.instance:getCurLayer()
	local scriptId = RoguelikeModel.instance:getCurScriptId()
	local maxLayer = RoguelikeConfig.instance:getLayerCount(scriptId)

	self._txtLayer.text = string.format("%d/%d", curLayer, maxLayer)

	local mapId = RoguelikeModel.instance:getCurMapId()
	local mapCo = RoguelikeConfig.instance:getMapById(mapId)

	self._txtScriptName.text = mapCo.name
	self._txtMapName.text = mapCo.name
end

function M:updateTarget()
	self._txtTargetName.text = RoguelikeModel.instance:getTargetText()

	goutil.setActive(self._goTargetName, true)
end

function M:updateProp()
	self._propBtnItem:updateData()
end

function M:getMapItemOffset(mapId)
	if not RoguelikeModel.instance:getShowAllMap() then
		return 0
	end

	local allMapIds = RoguelikeModel.instance:getAllMapIds()
	local offset = 0

	for k, v in ipairs(allMapIds) do
		if mapId == v then
			return offset
		end

		local mapRooms = RoguelikeModel.instance:getRoomMoByMapId(v)
		local maxX = 0

		for k1, v1 in pairs(mapRooms) do
			if maxX < v1:getCoordinate()[1] then
				maxX = v1:getCoordinate()[1]
			end
		end

		offset = offset + maxX

		if mapId == v then
			return offset
		end
	end

	return offset
end

function M:getMaxMapOffset()
	local allMapIds = RoguelikeModel.instance:getAllMapIds()
	local offset = 0

	for k, v in ipairs(allMapIds) do
		local mapRooms = RoguelikeModel.instance:getRoomMoByMapId(v)
		local maxX = 0

		for k1, v1 in pairs(mapRooms) do
			if maxX < v1:getCoordinate()[1] then
				maxX = v1:getCoordinate()[1]
			end
		end

		offset = offset + maxX
	end

	return offset
end

function M:checkIsQuit()
	local allRoleState = RoguelikeModel.instance:getAllRoleState()

	if not allRoleState then
		self:_onQuitSuccess()
	end
end

function M:_onQuitSuccess()
	self:back()
	RoguelikeController.instance:exitRunGroupSceneFlow()
end

function M:_onRoomRefresh()
	self:updateMapByRooms()
	self:updateLayerInfo()
end

function M:_onExploreRefresh()
	self:updateLayerInfo()
	self:updateTarget()
	RoguelikeController.instance:checkNeedQuit()
end

function M:_onShowMapName()
	local mapId = RoguelikeModel.instance:getCurMapId()
	local mapCo = RoguelikeConfig.instance:getMapById(mapId)

	if mapCo.name == "" then
		self:checkCurOpenView()

		return
	end

	self._txtScriptName.text = mapCo.name
	self._txtMapName.text = mapCo.name

	self:setMapNameActive(true, 0.5)
	settimer(2.5, self._delayHideScriptName, self, false)
end

function M:_delayHideScriptName()
	self:setMapNameActive(false)
	self:checkCurOpenView()
end

function M:_onShowMapViewActive(sender, isActive)
	self:setAniGoActive(isActive)
end

function M:setMapNameActive(isActive, delayTime)
	if delayTime then
		settimer(delayTime, self._delayShowScriptName, self, false)
	else
		goutil.setActive(self._goScriptName, isActive)
	end

	self:_onMapIconActive(nil, not isActive)
	self:setAniGoActive(not isActive)
end

function M:_onMapIconActive(sender, isActive)
	if goutil.isNil(self._traMapParent) then
		return
	end

	goutil.setActive(self._traMapParent.gameObject, isActive)
end

function M:_delayShowScriptName()
	goutil.setActive(self._goScriptName, true)
end

function M:_onAddPropSuccess()
	if RoguelikeModel.instance:getCurRoomMo():getRoomType() == RoguelikeExtension_pb.RoomType.PROPS then
		RoguelikeAgent.instance:sendEndJudgeRequest()
	end
end

function M:_onRoleInfoUpdate()
	self:updateRoleInfo()
end

function M:_onShowChangeCollector(sender, changes)
	settimer(0.2, function()
		if RogueMgr.instance:getRogueFlow() then
			RogueMgr.instance:getRogueFlow().mapMgr:setRoleSpine()
		end
	end, self, false)
end

function M:checkCurOpenView()
	if not self._allRoomMos or not RoguelikeModel.instance:getIsInRogue() then
		return
	end

	local roomMo = self._allRoomMos[self._curIndex]

	if not roomMo then
		return
	end

	RoguelikeModel.instance:setCurRoomId(roomMo:getId())
	RoguelikeModel.instance:setCurRoomMo(roomMo)

	if roomMo:getIsFinish() then
		return
	end

	if RoguelikeController.instance:getPlotPlayingStatus() then
		RoguelikeController.instance:setPlayingEnterPlotStatus(false)
		RoguelikeController.instance:setPlayingWorkReplyPlotStatus(false)

		return
	end

	local isInExitEvent = RogueMgr.instance:getRogueFlow().model:getInExitEvent()

	if isInExitEvent then
		RogueMgr.instance:getRogueFlow().model:setInExitEvent(false)

		return
	end

	self:setClickIntervalTime()

	if roomMo:getRoomType() == RoguelikeExtension_pb.RoomType.EVENT then
		if RoguelikeController.instance:getPlayingReplyPlotStatus() then
			print("播放剧情中")

			return
		end

		if roomMo:getTouchesNoFinish() then
			ViewMgr.instance:open(ViewName.RogueSurvey, roomMo)

			return
		end

		local eventId = roomMo:getParam()
		local eventCo = RoguelikeConfig.instance:getRoguelikeEventById(eventId)

		if eventCo.type == RoguelikeConst.ROGUE_EVENT_TYPE_1.SECOND_ENTRANCE or eventCo.type == RoguelikeConst.ROGUE_EVENT_TYPE_1.SECOND_EXIT then
			return
		end

		RoguelikeController.instance:enterRogueMeetView(eventId)
	elseif roomMo:getRoomType() == RoguelikeExtension_pb.RoomType.MONSTER then
		local monsterId = roomMo:getParam()

		ViewMgr.instance:open(ViewName.RogueMeetMonster, monsterId)
	elseif roomMo:getRoomType() == RoguelikeExtension_pb.RoomType.BOSS then
		local param = roomMo:getParam()
		local monsterCo = RoguelikeConfig.instance:getRoguelikeMonsterById(param)

		if monsterCo ~= nil then
			ViewMgr.instance:open(ViewName.RogueMeetMonster, param)
		else
			RoguelikeController.instance:enterRogueMeetView(param)
		end
	elseif roomMo:getRoomType() == RoguelikeExtension_pb.RoomType.GAMBLE then
		local betType = roomMo:getParam()

		if betType == 6001 then
			ViewMgr.instance:open(ViewName.RogueGuessDiceGame)
		elseif betType == 6002 then
			ViewMgr.instance:open(ViewName.RogueMoonyDiceGame)
		end
	elseif roomMo:getRoomType() == RoguelikeExtension_pb.RoomType.MALL then
		local _roomMo = roomMo

		ViewMgr.instance:open(ViewName.RogueVendingMachine, _roomMo)
	end

	RoguelikeAgent.instance:delayShowProps()
end

function M:setClickIntervalTime()
	self._isInOpenView = true

	settimer(0.5, self.delayResetClickInterval, self, false)
end

function M:delayResetClickInterval()
	self._isInOpenView = false
end

function M:onMapItemClick(index)
	if self._isSpineMoving or RoguelikeController.instance:getInAnimation() or self._isInOpenView or RoguelikeController.instance:getIsViewOpening() then
		return
	end

	self._targetIndex = index

	self:moveToTarget(self._curIndex, index)

	function self._mapItemClickCallback()
		self:onMapItemSelect(self._targetIndex)
	end
end

function M:moveToTarget(lastIndex, newIndex)
	local curMapId = RoguelikeModel.instance:getIsInSecondRoom() and RoguelikeModel.instance:getCurSecondMapId() or RoguelikeModel.instance:getCurMapId()

	if self._allRoomMos[newIndex]:getMapId() ~= curMapId then
		printError("不在当前所在地图")

		return
	end

	if lastIndex == newIndex then
		if self._mapItemClickCallback ~= nil then
			self._isSpineMoving = true

			settimer(0.3, self.delayClickItemCallback, self, false)
		end

		return
	end

	local coordinate1 = self._allRoomMos[lastIndex]:getCoordinate()
	local coordinate2 = self._allRoomMos[newIndex]:getCoordinate()
	local offset = RoguelikeModel.instance:getCurMapOffset()

	function canMoveToTarget(indexs)
		for k, v in pairs(indexs) do
			if not self._allRoomMos[v + offset] then
				return false
			end

			if not self._allRoomMos[v + offset]:getIsVisible() then
				return false
			end
		end

		return true
	end

	function getUnClearCount(indexs)
		local count = 0

		for k, v in pairs(indexs) do
			if self._allRoomMos[v + offset] and not self._allRoomMos[v + offset]:getIsClear() then
				count = count + 1
			end
		end

		return count
	end

	function getLastIsNextRoom(indexs)
		local mo = self._allRoomMos[indexs[#indexs] + offset]

		if mo then
			return mo:getIsNextRoom()
		end

		return false
	end

	function getIsFreeRoom(indexs)
		local mo = self._allRoomMos[indexs[#indexs] + offset]

		if mo then
			return mo:getIsFreeMove()
		end

		return false
	end

	RoguelikeUtil.instance:getLineCoordinate(coordinate1, coordinate2, function(indexs)
		if not canMoveToTarget(indexs) then
			FloatWordMgr.instance:show(lang("tip_r_room_cant_reach"))

			return
		end

		local temp = {}

		for k, v in ipairs(indexs) do
			table.insert(temp, v + offset)
		end

		local unVisibleCount = getUnClearCount(indexs)

		function execMove()
			self._curIndex = temp[#indexs]
			self._targetIndex = temp[#indexs]
			self._isSpineMoving = true

			RogueMgr.instance:getRogueFlow().mapMgr:moveToTarget(temp[#indexs], temp, function()
				local roomMo = self._allRoomMos[self._targetIndex]

				RoguelikeAgent.instance:sendMoveRequest(roomMo:getCoordinateStr())
				RoguelikeModel.instance:setCurRoomId(roomMo:getId())
				RoguelikeModel.instance:setCurRoomMo(roomMo)
				settimer(1, self.delayClickItemCallback, self, false)
			end)
		end

		local allRoleSanOne = RoguelikeModel.instance:getRoleSanIsOne()

		if allRoleSanOne and unVisibleCount > 0 and not getIsFreeRoom(indexs) then
			local dialog = Dialog.showMessage(lang("tip_title"), lang("tip_r_move_san_one"))

			dialog:setConfirmListener(function()
				execMove()
			end, self)
		elseif getLastIsNextRoom(indexs) then
			local dialog = Dialog.showMessage(lang("tip_title"), lang("tip_r_move_next_layer"))

			dialog:setConfirmListener(function()
				execMove()
			end, self)
		else
			execMove()
		end
	end)
end

function M:delayClickItemCallback()
	if self._mapItemClickCallback then
		self:_mapItemClickCallback()
	end

	self._isSpineMoving = false

	RoguelikeAgent.instance:delayShowProps()
end

function M:onMapItemSelect(index)
	local roomMo = self._allRoomMos[index]

	if not roomMo or roomMo:getIsVisibleTemp() or self._isInOpenView then
		return
	end

	local lastRoomMo = RoguelikeModel.instance:getCurRoomMo()

	if lastRoomMo == nil or lastRoomMo:getCoordinateStr() ~= roomMo:getCoordinateStr() then
		RoguelikeAgent.instance:sendMoveRequest(roomMo:getCoordinateStr())
	end

	RoguelikeModel.instance:setCurRoomId(roomMo:getId())
	RoguelikeModel.instance:setCurRoomMo(roomMo)

	if roomMo:getIsFinish() then
		return
	end

	if roomMo:getRoomType() == RoguelikeExtension_pb.RoomType.EVENT then
		local eventId = roomMo:getParam()
		local eventCo = RoguelikeConfig.instance:getRoguelikeEventById(eventId)

		if not eventCo then
			return
		end

		if roomMo:getTouchesNoFinish() then
			ViewMgr.instance:open(ViewName.RogueSurvey, roomMo)

			return
		end

		RoguelikeController.instance:enterRogueMeetView(eventId)
	elseif roomMo:getRoomType() == RoguelikeExtension_pb.RoomType.MONSTER then
		local monsterId = roomMo:getParam()

		ViewMgr.instance:open(ViewName.RogueMeetMonster, monsterId)
	elseif roomMo:getRoomType() == RoguelikeExtension_pb.RoomType.GAMBLE then
		local betType = roomMo:getParam()

		if betType == 6001 then
			ViewMgr.instance:open(ViewName.RogueGuessDiceGame)
		elseif betType == 6002 then
			ViewMgr.instance:open(ViewName.RogueMoonyDiceGame)
		end
	elseif roomMo:getRoomType() == RoguelikeExtension_pb.RoomType.PROPS then
		RoguelikeAgent.instance:sendTakeEffectRequest({
			roomMo:getParam()
		}, 0, -1)
	elseif roomMo:getRoomType() == RoguelikeExtension_pb.RoomType.NEXT then
		RoguelikeAgent.instance:sendNextLayerRequest()
	elseif roomMo:getRoomType() == RoguelikeExtension_pb.RoomType.MALL then
		local _roomMo = roomMo

		ViewMgr.instance:open(ViewName.RogueVendingMachine, _roomMo)
	elseif roomMo:getRoomType() == RoguelikeExtension_pb.RoomType.BOSS then
		local param = roomMo:getParam()
		local monsterCo = RoguelikeConfig.instance:getRoguelikeMonsterById(param)

		if monsterCo ~= nil then
			ViewMgr.instance:open(ViewName.RogueMeetMonster, param)
		else
			RoguelikeController.instance:enterRogueMeetView(param)
		end
	elseif roomMo:getRoomType() == RoguelikeExtension_pb.RoomType.Blank then
		-- block empty
	end

	self:setClickIntervalTime()
end

function M:setClickIntervalTime()
	self._isInOpenView = true

	settimer(0.5, self.delayResetClickInterval, self, false)
end

function M:delayResetClickInterval()
	self._isInOpenView = false
end

return M
