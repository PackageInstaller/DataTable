-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/explore/hacktool/RogueHackToolMapView.lua

module("logic.extensions.roguelike.view.explore.hacktool.RogueHackToolMapView", package.seeall)

local MapItem = class("MapItem")
local kMapItemSize = 102

function MapItem:ctor(go)
	self._go = go
	self._btnClick = UIComponentType.ButtonAdapter(go)
	self._imgIcon = goutil.findChildImageComponent(go, "icon")
	self._txtName = goutil.findChildTextComponent(go, "name")

	self:bindEvents()
end

function MapItem:getGo()
	return self._go
end

function MapItem:bindEvents()
	if self._isBind then
		return
	end

	self._btnClick:AddClickListener(self.onClick, self)

	self._isBind = true
end

function MapItem:unbindEvents()
	self._isBind = false

	self._btnClick:RemoveClickListener()
end

function MapItem:onClick()
	if self._callback then
		self._callback()
	end
end

function MapItem:setPointItem(pointItem)
	self._point = pointItem
end

function MapItem:updateData(data)
	self._callback = data.callback

	local coordinate = data.coordinate
	local tra = self._go.transform
	local pos = Vector3.New((coordinate[1] + data.offset) * kMapItemSize, coordinate[2] * -kMapItemSize + 100, 0)

	tra.localPosition = pos

	local pointData = {}

	pointData.isFinish = data.isFinish
	pointData.icon = data.icon
	pointData.mo = data.mo

	self._point:updateData(pointData)

	self._go.name = string.format("%d %d-%d", data.mapId, coordinate[1], coordinate[2])

	goutil.setActive(self._go, data.visible)
end

function MapItem:onClear()
	return
end

local DebuffItem = class("DebuffItem")

function DebuffItem:ctor(container)
	local go = container.gameObject

	self._go = go
	self._txtDesc = goutil.findChildTextComponent(go, "txtAttribute")
end

function DebuffItem:setActive(isActive)
	goutil.setActive(self._go, isActive)
end

function DebuffItem:updateData(data)
	self._txtDesc.text = data.desc

	self:setActive(true)
end

local kMoveSpeed = 500
local M = class("RogueHackToolMapView", ViewComponent)

function M:ctor()
	M.super.ctor(self)

	self._mapItems = {}
	self._debuffItems = {}
	self._roundTextItems = {}
	self._roundTexts = {}
	self._curRoundTextIndex = 1
end

function M:buildUI()
	self._btnClose = self:getBtn("title_view_-878360263")
	self._traMapParent = self:getGo("run_group_main_view_-518790481").transform
	self._traMapPlateParent = self:getGo("run_group_main_view_-177127969").transform
	self._goMapItem = self:getGo("run_group_main_view_-312601926")
	self._goMapPointItem = self:getGo("run_group_main_view_-1080460436")
	self._goRoleSpine = self:getGo("run_group_main_view_22233933")
	self._spineRole = UISpine.Get(self._goRoleSpine)
	self._btnRectify = self:getBtn("run_group_main_view_296659947")
	self._btnRetreat = self:getBtn("run_group_main_view_27766643")
	self._btnEvent = self:getBtn("run_group_main_view_47990322")
	self._btnSituation = self:getBtn("run_group_main_view_968999557")
	self._btnProp = self:getBtn("run_group_main_view_1831121106")
	self._btnEquip = self:getBtn("run_group_main_view_-1748836174")
	self._txtLayer = self:getText("run_group_main_view_140677608")
	self._traMapScroller = self:getGo("run_group_main_view_2135037092").transform
	self._goBuffParent = self:getGo("run_group_main_view_copy_1168978649")
	self._goBuffItem = self:getGo("run_group_main_view_copy_-999203497")
	self._txtLayer2 = self:getText("run_group_main_view_copy_-1559783707")
	self._goEquipEffect = self:getGo("run_group_main_view_copy_288050291")
	self._goDiff = self:getGo("run_group_main_view_copy_-1379657274")
	self._goDiffTips = self:getGo("run_group_main_view_copy_-156721915")
	self._goDiffBuffItem = self:getGo("run_group_main_view_copy_-999203497")
	self._traDiffBuffParent = self:getGo("run_group_main_view_copy_1168978649").transform
	self._btnDiffDetail = self:getBtn("run_group_main_view_copy_-2069075577")
	self._goHintFace = self:getGo("run_group_main_view_copy_1272252893")
	self._txtHintFace = self:getText("run_group_main_view_copy_1285830356")
	self._goHintCoin = self:getGo("run_group_main_view_copy_1592323688")
	self._txtHintCoin = self:getText("run_group_main_view_copy_63856710")
	self._goHackTool = self:getGo("run_group_main_view_copy_-6909581")
	self._inputEventId = Astral.InputFieldAdapter.Get(self:getGo("run_group_main_view_copy_-748412202"))
	self._inputMonsterId = Astral.InputFieldAdapter.Get(self:getGo("run_group_main_view_copy_-293129974"))
	self._inputSeedProp = Astral.InputFieldAdapter.Get(self:getGo("run_group_main_view_copy_-450526438"))
	self._inputSeedBet = Astral.InputFieldAdapter.Get(self:getGo("run_group_main_view_copy_-1696355196"))
	self._inputSeedStore = Astral.InputFieldAdapter.Get(self:getGo("run_group_main_view_copy_839760536"))
	self._inputKnowRoomNum = Astral.InputFieldAdapter.Get(self:getGo("run_group_main_view_copy_658332990"))
	self._inputUnKnowRoomNum = Astral.InputFieldAdapter.Get(self:getGo("run_group_main_view_copy_-417199032"))
	self._dropdownBetType = self:getUIComponent("run_group_main_view_copy_1463248407", UIComponentType.DropdownApapter)
	self._btnMeetEvent = self:getBtn("run_group_main_view_copy_-1624223861")
	self._btnMeetMonster = self:getBtn("run_group_main_view_copy_927603518")
	self._btnPropRoom = self:getBtn("run_group_main_view_copy_-774387158")
	self._btnBetRoom = self:getBtn("run_group_main_view_copy_1099284424")
	self._btnStoreRoom = self:getBtn("run_group_main_view_copy_1060211932")
	self._btnNextLayer = self:getBtn("run_group_main_view_copy_-843541071")
	self._btnCopyLog = self:getBtn("run_group_main_view_copy_1463948412")
	self._goLogItem = self:getGo("run_group_main_view_copy_1590275911")
	self._traLogParent = self:getGo("run_group_main_view_copy_355783777").transform
	self._scrollRect = self:getGo("run_group_main_view_copy_-1771047964"):GetComponent(UIComponentType.ScrollRect)
	self._goSanity = self:getGo("21&rungroup_sanity_item_-1911028484")
	self._sanityItem = Astral.LuaComponentContainer.Add(self._goSanity, RogueSanityItem)

	self._sanityItem:updateData()
	self:initHeroItem()
	self:initRoleDetailTips()
	self:initTeamDetailTips()
	self:initOwnPropTips()
	self:initEquipTips()
	self:initThrowPropTips()
	self:initThreadTips()
	self:initTestCameraParam()
	self:initDiffDetailTips()
	self:setGoActive()
end

function M:setGoActive()
	goutil.setActive(self._goHackTool, true)
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

	goutil.setActive(self._goDiff, diffBuffs ~= nil and #diffBuffs > 0)
end

function M:initTestCameraParam()
	self._goTestCamera = goutil.findChild(self.mainGO, "testCameraParam")
	self._inputTime = Astral.InputFieldAdapter.GetFrom(self._goTestCamera, "input1/InputField")
	self._inputCameraY = Astral.InputFieldAdapter.GetFrom(self._goTestCamera, "input2/InputField")
	self._inputCameraZ = Astral.InputFieldAdapter.GetFrom(self._goTestCamera, "input3/InputField")
	self._btnChangeCameraParam = Astral.ButtonAdapter.GetFrom(self._goTestCamera, "btn")
end

function M:initTeamDetailTips()
	local content = self:getGo("run_group_main_view_-1499683562")
	local tips = goutil.findChild(content, "run_group_team_situation_tips")

	self._teamDetailTips = Astral.LuaComponentContainer.Add(tips, RogueTeamSituationTips)
end

function M:initOwnPropTips()
	local content = self:getGo("run_group_main_view_133990976")
	local tips = goutil.findChild(content, "props_owner_tips")

	self._ownPropTips = Astral.LuaComponentContainer.Add(tips, RogueOwnPropTips)
	self._txtBtnPropCount = goutil.findChildComponent(self._btnProp.gameObject, "normal/Text1", UIComponentType.Text)
end

function M:initEquipTips()
	local content = self:getGo("run_group_main_view_-673051579")
	local tips = goutil.findChild(content, "run_group_equip_tips")

	self._equipTips = Astral.LuaComponentContainer.Add(tips, RogueEquipTips)
end

function M:initThrowPropTips()
	local content = self:getGo("run_group_main_view_133990976")
	local tips = goutil.findChild(content, "props_throw_tips")

	self._throwPropTips = Astral.LuaComponentContainer.Add(tips, RogueThorwPropTips)

	self._throwPropTips:setCloseCallback(function()
		return
	end)
end

function M:initThreadTips()
	local content = self:getGo("run_group_main_view_copy_2047983129")
	local tips = goutil.findChild(content, "run_group_thread_tips")

	self._threadTips = Astral.LuaComponentContainer.Add(tips, RogueThreadTips)

	self._threadTips:setCloseCallback(function()
		return
	end)
end

function M:initHeroItem()
	local go = self:getGo("run_group_main_view_1675700003")

	self._heroItems = {}

	for i = 1, 4 do
		local itemGo = goutil.findChild(go, "headLayout/hero_head_" .. i)
		local item = Astral.LuaComponentContainer.Add(itemGo, RogueRoleHeadItem2)

		table.insert(self._heroItems, item)
	end
end

function M:destroyUI()
	self:setEvent(false)
end

function M:bindEvents()
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnRectify:AddClickListener(self._onClickRectify, self)
	self._btnRetreat:AddClickListener(self._onClickRetreat, self)
	self._btnEvent:AddClickListener(self._onClickEvent, self)
	self._btnSituation:AddClickListener(self._onClickSituation, self)
	self._btnProp:AddClickListener(self._onClickProp, self)
	self._btnEquip:AddClickListener(self._onClickEquip, self)
	self._btnChangeCameraParam:AddClickListener(self._onClickChangeParam, self)
	self._btnDiffDetail:AddClickListener(self._onClickDiffDetail, self)
	self._btnMeetEvent:AddClickListener(self._onClickMeetEvent, self)
	self._btnMeetMonster:AddClickListener(self._onClickMeetMonster, self)
	self._btnPropRoom:AddClickListener(self._onClickPropRoom, self)
	self._btnBetRoom:AddClickListener(self._onClickBetRoom, self)
	self._btnStoreRoom:AddClickListener(self._onClickStoreRoom, self)
	self._btnNextLayer:AddClickListener(self._onClickNextLayer, self)
	self._btnCopyLog:AddClickListener(self._onClickCopyLog, self)
	self._dropdownBetType:AddListener(self._dealDropDownBetType, self)
end

function M:unbindEvents()
	self._btnClose:RemoveClickListener()
	self._btnRectify:RemoveClickListener()
	self._btnRetreat:RemoveClickListener()
	self._btnEvent:RemoveClickListener()
	self._btnSituation:RemoveClickListener()
	self._btnProp:RemoveClickListener()
	self._btnEquip:RemoveClickListener()
	self._btnChangeCameraParam:RemoveClickListener()
	self._btnDiffDetail:RemoveClickListener()
	self._btnMeetEvent:RemoveClickListener()
	self._btnMeetMonster:RemoveClickListener()
	self._btnPropRoom:RemoveClickListener()
	self._btnBetRoom:RemoveClickListener()
	self._btnStoreRoom:RemoveClickListener()
	self._btnNextLayer:RemoveClickListener()
	self._btnCopyLog:RemoveClickListener()
	self._dropdownBetType:RemoveClickListener()
end

function M:_onClickMeetEvent()
	local eventId = tonumber(self._inputEventId:GetText())
	local eventCo = RoguelikeConfig.instance:getRoguelikeEventById(eventId)

	if not eventCo then
		FloatWordMgr.instance:show(lang("没有事件配置" .. eventId))

		return
	end

	self:sendMockRoom(4, 0)
	ViewMgr.instance:open(ViewName.RogueMeetEvent, eventId)
end

function M:_onClickMeetMonster()
	local monsterId = tonumber(self._inputMonsterId:GetText())
	local monsterCo = RoguelikeConfig.instance:getRoguelikeMonsterById(monsterId)

	if not monsterCo then
		FloatWordMgr.instance:show(lang("没有怪物配置" .. monsterId))

		return
	end

	self:sendMockRoom(4, 0)
	RogueMgr.instance:getModel():setFirstActiveRoleIndex()
	RogueMgr.instance:getModel():setCurMonsterId(self._monsterId)
	RogueMgr.instance:enterFight(monsterId)

	local result = RogueMgr.instance:getModel():setFirstActiveRoleIndex()

	if result == 0 then
		print("全部阵亡")

		return
	end
end

function M:sendMockRoom(type, seed)
	local info = {}

	info.cmd = GameEnum.GMCmdEnum.RoguelikeMockRoom
	info.value = {}
	info.value.type = type
	seed = seed or 0
	info.value.seed = seed

	HackToolAgent.instance:sendGmRequest(info)
end

function M:sendMockOut()
	local info = {}

	info.cmd = GameEnum.GMCmdEnum.RoguelikeMockOut
	info.value = {}

	HackToolAgent.instance:sendGmRequest(info)
end

function M:sendNextLayer()
	local info = {}

	info.cmd = GameEnum.GMCmdEnum.NextLayer
	info.value = {}

	HackToolAgent.instance:sendGmRequest(info)
end

function M:_onClickPropRoom()
	local effectIds = {
		30001006,
		30001007,
		30001008
	}
	local effectId = effectIds[math.random(1, #effectIds)]

	RoguelikeController.instance:execEffectIds({
		effectId
	})
end

function M:_onClickBetRoom()
	local betSeed = tonumber(self._inputSeedBet:GetText())
	local betType = self._selectBetType and self._selectBetType + 1 or 1

	self:sendMockRoom(betType, betSeed)
end

function M:_onClickStoreRoom()
	local storeSeed = tonumber(self._inputSeedStore:GetText())

	self:sendMockRoom(3, storeSeed)
end

function M:_onClickNextLayer()
	self:sendNextLayer()
end

function M:_onClickCopyLog()
	local texts = ""

	for k, v in pairs(self._roundTexts) do
		texts = texts .. v .. "\n"
	end

	print("复制日志", texts)
	TextUtils.CopyText(texts)
end

function M:onEnter()
	self:setEvent(true)
	IconLoader.bindSpriteAtlas(IconType.DynSpriteAtlas_Dice)
	self:updateRoleInfo(true)
	self:updateLayerInfo()
	self:_onPropRefresh()
	self:checkLastProp()
	self:checkHadEquip()
	self:checkHadRectify()
	RogueMgr.instance:setNeedShowDice(false)
	RogueMgr.instance:setHackToolModel(true)
end

function M:_dealDropDownBetType(idx)
	self._selectBetType = idx
end

function M:switchToSecondaryMapCheck()
	if RoguelikeModel.instance:getIsInSecondRoom() then
		local sceneId = RoguelikeController.instance:getSceneId(RoguelikeModel.instance:getCurSecondMapId())

		sceneId = 6000

		RoguelikeController.instance:enterRunGroupSecondaryScene(sceneId)
	end
end

function M:setEvent(isAdd)
	if isAdd then
		GlobalDispatcher:addEventListener(EventType.ROGUE_QUIT_SUCCESS, self._onQuitSuccess, self)
		GlobalDispatcher:addEventListener(EventType.ROGUE_ROOM_INFO_REFRESH, self._onRoomRefresh, self)
		GlobalDispatcher:addEventListener(EventType.ROGUE_REFRESH_PROP, self._onPropRefresh, self)
		GlobalDispatcher:addEventListener(EventType.ROGUE_SELECT_PROP, self._onPropSelect, self)
		GlobalDispatcher:addEventListener(EventType.ROGUE_EXPLORE_INFO, self._onExploreRefresh, self)
		GlobalDispatcher:addEventListener(EventType.ROGUE_CHANGE_ROLE, self._onRoleChange, self)
		GlobalDispatcher:addEventListener(EventType.ROGUE_ADD_PROP_SUCCESS, self._onAddPropSuccess, self)
		GlobalDispatcher:addEventListener(EventType.ROGUE_REFRESH_ROLE_INFO, self._onRoleInfoUpdate, self)
		GlobalDispatcher:addEventListener(EventType.ROGUE_SET_MAP_ICON_ACTIVE, self._onMapIconActive, self)
		GlobalDispatcher:addEventListener(EventType.ROGUE_SHOW_CHANGE_COLLECTOR, self._onShowChangeCollector, self)
		GlobalDispatcher:addEventListener(EventType.ROGUE_ROUND_BROAD_CAST, self._onRoundBroadCast, self)
		GlobalDispatcher:addEventListener(EventType.GM_REPLY, self._onGMReply, self)
	else
		GlobalDispatcher:removeEventListener(EventType.ROGUE_QUIT_SUCCESS, self._onQuitSuccess, self)
		GlobalDispatcher:removeEventListener(EventType.ROGUE_ROOM_INFO_REFRESH, self._onRoomRefresh, self)
		GlobalDispatcher:removeEventListener(EventType.ROGUE_REFRESH_PROP, self._onPropRefresh, self)
		GlobalDispatcher:removeEventListener(EventType.ROGUE_SELECT_PROP, self._onPropSelect, self)
		GlobalDispatcher:removeEventListener(EventType.ROGUE_EXPLORE_INFO, self._onExploreRefresh, self)
		GlobalDispatcher:removeEventListener(EventType.ROGUE_CHANGE_ROLE, self._onRoleChange, self)
		GlobalDispatcher:removeEventListener(EventType.ROGUE_ADD_PROP_SUCCESS, self._onAddPropSuccess, self)
		GlobalDispatcher:removeEventListener(EventType.ROGUE_REFRESH_ROLE_INFO, self._onRoleInfoUpdate, self)
		GlobalDispatcher:removeEventListener(EventType.ROGUE_SET_MAP_ICON_ACTIVE, self._onMapIconActive, self)
		GlobalDispatcher:removeEventListener(EventType.ROGUE_SHOW_CHANGE_COLLECTOR, self._onShowChangeCollector, self)
		GlobalDispatcher:removeEventListener(EventType.ROGUE_ROUND_BROAD_CAST, self._onRoundBroadCast, self)
		GlobalDispatcher:removeEventListener(EventType.GM_REPLY, self._onGMReply, self)
	end
end

function M:_onGMReply(sender, data)
	local cmd = data.cmd

	if cmd == GameEnum.GMCmdEnum.RoguelikeMockRoom then
		if data.value.type == 1 then
			ViewMgr.instance:open(ViewName.RogueGuessDiceGame)
		elseif data.value.type == 2 then
			ViewMgr.instance:open(ViewName.RogueMoonyDiceGame)
		elseif data.value.type == 3 then
			ViewMgr.instance:open(ViewName.RogueVendingMachine)
		end
	end
end

function M:_onRoundBroadCast(sender, text)
	self:addBroadCast(text)
end

function M:clearBroadCast()
	for i = 0, self._traRoundTextParent.childCount - 1 do
		goutil.setActive(self._traRoundTextParent:GetChild(i).gameObject, false)
	end

	self._curRoundTextIndex = 1
	self._roundTexts = {}
end

function M:addBroadCast(text)
	table.insert(self._roundTexts, text)

	self._roundTextItems = self._roundTextItems or {}

	local item = self._roundTextItems[self._curRoundTextIndex]

	if not item then
		item = goutil.cloneAndSetParent(self._goLogItem, self._traLogParent)
		self._roundTextItems[self._curRoundTextIndex] = item
	end

	local itemText = item:GetComponent("Text")

	itemText.text = ""

	itemText:DOText(StringUtil.replaceAllGraphicText2(text), 0.5)

	self._curRoundTextIndex = self._curRoundTextIndex + 1

	goutil.setActive(item, true)
	RectTransformUtils.ForceRebuildLayoutImmediate(self._traLogParent)
	settimer(0.02, self._delayChangeScrollRect, self, false)
end

function M:_delayChangeScrollRect()
	self._scrollRect.verticalNormalizedPosition = 0
end

function M:updateLayerInfo()
	local curLayer = RoguelikeModel.instance:getCurLayer()
	local scriptId = RoguelikeModel.instance:getCurScriptId()
	local maxLayer = RoguelikeConfig.instance:getLayerCount(scriptId)

	self._txtLayer.text = curLayer
	self._txtLayer2.text = maxLayer
end

function M:updateRoleInfo(isEnter)
	local isAllDeath = true
	local allRoles = RogueMgr.instance:getModel():getAllRoleMos()

	for i = 1, #allRoles do
		local item = self._heroItems[i]
		local prop = allRoles[i].roleProp

		if not prop:getIsDeath() then
			isAllDeath = false
		end

		local data = {}

		data.level = 11
		data.roleId = prop:getRoleId()

		local index = i

		data.card = prop:getCard()

		function data.callback()
			self:showRoleDetail(index)
		end

		item:updateData(data)
	end

	if isAllDeath and isEnter then
		print("角色全部阵亡撤退")
		RoguelikeController.instance:checkNeedQuit()
	end
end

function M:checkLastProp()
	if ViewMgr.instance:isOpen(ViewName.RogueSelectPropAndRole) then
		GlobalDispatcher:dispatchEvent(EventType.ROGUE_CHECK_SETTLEMENT)
	end
end

function M:checkHadEquip()
	local equips = RoguelikeModel.instance:getCurEquipMOS() or {}

	goutil.setActive(self._goEquipEffect, #equips > 0)

	local goNormal = goutil.findChild(self._btnEquip.gameObject, "normal")
	local goLock = goutil.findChild(self._btnEquip.gameObject, "lock")

	goutil.setActive(goNormal, #equips > 0)
	goutil.setActive(goLock, #equips == 0)
end

function M:checkHadRectify()
	local count = RoguelikeModel.instance:getRectify()
	local goNormal = goutil.findChild(self._btnRectify.gameObject, "type1")
	local goLock = goutil.findChild(self._btnRectify.gameObject, "type2")

	goutil.setActive(goNormal, count > 0)
	goutil.setActive(goLock, count == 0)
end

function M:showRoleDetail(index)
	local allRoles = RogueMgr.instance:getModel():getAllRoleMos()
	local prop = allRoles[index].roleProp
	local data = {}

	data.roleId = prop:getRoleId()
	data.hp = prop:getHp()
	data.hpMax = prop:getHpMax()
	data.san = prop:getSan()
	data.sanMax = prop:getSanMax()

	self._roleDetailTips:updateData(data)
	self._roleDetailTips:setActive(true)
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

function M:updateMapByRooms()
	RoguelikeUtil.instance:saveCurCoordinate()

	local allRoomMos = RoguelikeModel.instance:getRoomMOs()

	self._curMapRoomMos = RoguelikeModel.instance:getCurMapRoomMOs()

	if self._curMapId ~= RoguelikeModel.instance:getCurMapId() and not RoguelikeModel.instance:getShowAllMap() then
		for k, v in pairs(self._mapItems) do
			v:onClear()
		end
	end

	self._curMapId = RoguelikeModel.instance:getCurMapId()
	self._allRoomMos = allRoomMos

	for i = 0, self._traMapParent.childCount - 1 do
		goutil.setActive(self._traMapParent:GetChild(i).gameObject, false)
	end

	if not RogueMgr.instance:getRogueFlow() then
		return
	end

	RogueMgr.instance:getRogueFlow().mapMgr:updateMapInfo()

	local hadCurRoom = false
	local firstRoomIndex = false
	local firstItem

	for i = 1, #allRoomMos do
		local item = self._mapItems[i]

		if item == nil then
			local go = Astral.GameObjectUtil.CloneAndSetParent(self._goMapItem, self._traMapParent, nil)

			item = MapItem.New(go)

			local point = Astral.GameObjectUtil.CloneAndSetParent(self._goMapPointItem, go.transform, nil)
			local pointItem = Astral.LuaComponentContainer.Add(point, RogueMapPointItem)

			item:setPointItem(pointItem)

			self._mapItems[i] = item
		end

		local mo = allRoomMos[i]
		local data = {}

		data.index = i

		local temp = i

		data.coordinate = mo:getCoordinate()
		data.icon = mo:getRoomIcon(i)
		data.name = mo:getTypeName()
		data.state = mo:getRoomState(i)
		data.visible = mo:getIsVisible()
		data.isFinish = mo:getIsFinish()
		data.viewPresentor = self._viewPresentor
		data.plateCo = mo:getShapeCo()
		data.mapId = mo:getMapId()
		data.plateParent = self._traMapPlateParent
		data.mo = mo
		data.offset = self:getMapItemOffset(mo:getMapId())

		function data.callback()
			self:onMapItemClick(temp)
		end

		item:updateData(data)

		if mo:getRoomType() == RoguelikeExtension_pb.RoomType.INIT then
			firstRoomIndex = i
			firstItem = item
		end

		if i == RoguelikeModel.instance:getCurRoomIndex() then
			self._curIndex = i

			self:_setSpinePosition(item:getGo())

			hadCurRoom = true
		end
	end

	RogueMgr.instance:getRogueFlow().mapMgr:setUIFollowGos(self._mapItems)

	if not hadCurRoom then
		self._curIndex = firstRoomIndex

		self:_setSpinePosition(firstItem:getGo())
	end

	local size = self._traMapScroller.sizeDelta

	size.x = self:getMaxMapOffset() * 130
	self._traMapScroller.sizeDelta = size
end

function M:checkCurOpenView()
	local roomMo = self._allRoomMos[self._curIndex]

	RoguelikeModel.instance:setCurRoomId(roomMo:getId())
	RoguelikeModel.instance:setCurRoomMo(roomMo)

	if RoguelikeController.instance:getPlotPlayingStatus() then
		RoguelikeController.instance:setPlayingEnterPlotStatus(false)
		RoguelikeController.instance:setPlayingWorkReplyPlotStatus(false)

		return
	end

	if roomMo:getIsFinish() then
		return
	end

	if roomMo:getRoomType() == RoguelikeExtension_pb.RoomType.EVENT then
		local eventId = roomMo:getParam()
		local eventCo = RoguelikeConfig.instance:getRoguelikeEventById(eventId)
		local replyIds = eventCo.replys or {}

		if #replyIds == 1 then
			local replyCo = RoguelikeConfig.instance:getEventReplyById(replyIds[1])
			local eventType = replyCo.type
		end

		RoguelikeController.instance:enterRogueMeetView(eventId)
	elseif roomMo:getRoomType() == RoguelikeExtension_pb.RoomType.MONSTER then
		local monsterId = roomMo:getParam()

		ViewMgr.instance:open(ViewName.RogueMeetMonster, monsterId)
	elseif roomMo:getRoomType() == RoguelikeExtension_pb.RoomType.MONSTER then
		if roomMo:getTouchesNoFinish() then
			ViewMgr.instance:open(ViewName.RogueSurvey, roomMo)
		end
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
end

function M:onMapItemClick(index)
	if self._isSpineMoving then
		return
	end

	self._targetIndex = index

	self:moveToTarget(self._curIndex, index)

	local temp = index

	function self._mapItemClickCallback()
		self:onMapItemSelect(self._targetIndex)
	end
end

function M:_startMoveSpine()
	if self._isSpineMoving then
		return
	end

	self._isSpineMoving = true
	self._curMoveIndex = 1

	self:_moveToNextNode()
end

function M:moveToTarget(lastIndex, newIndex)
	local curMapId = RoguelikeModel.instance:getCurMapId()

	if self._allRoomMos[newIndex]:getMapId() ~= curMapId then
		FloatWordMgr.instance:show("不在当前所在地图")

		return
	end

	if lastIndex == newIndex then
		if self._mapItemClickCallback ~= nil then
			self._mapItemClickCallback()
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

	RoguelikeUtil.instance:getLineCoordinate(coordinate1, coordinate2, function(indexs)
		if not canMoveToTarget(indexs) then
			FloatWordMgr.instance:show("当前房间不可达")

			return
		end

		local temp = {}

		for k, v in ipairs(indexs) do
			table.insert(temp, v + offset)
		end

		self._curIndex = temp[#indexs]
		self._targetIndex = temp[#indexs]
		self._isSpineMoving = true

		RogueMgr.instance:getRogueFlow().mapMgr:moveToTarget(temp[#indexs], temp, function()
			self:_mapItemClickCallback()

			self._isSpineMoving = false
		end)
	end)
end

function M:onMapItemSelect(index)
	local roomMo = self._allRoomMos[index]

	if not roomMo or roomMo:getIsVisibleTemp() then
		return
	end

	RoguelikeAgent.instance:sendMoveRequest(roomMo:getCoordinateStr())
	RoguelikeModel.instance:setCurRoomId(roomMo:getId())
	RoguelikeModel.instance:setCurRoomMo(roomMo)

	if roomMo:getIsFinish() then
		return
	end

	if roomMo:getRoomType() == RoguelikeExtension_pb.RoomType.EVENT then
		local eventId = roomMo:getParam()
		local eventCo = RoguelikeConfig.instance:getRoguelikeEventById(eventId)
		local replyIds = eventCo.replys or {}

		if #replyIds == 1 then
			local replyCo = RoguelikeConfig.instance:getEventReplyById(replyIds[1])
			local eventType = replyCo.type
		end

		RoguelikeController.instance:enterRogueMeetView(eventId)
	elseif roomMo:getRoomType() == RoguelikeExtension_pb.RoomType.MONSTER then
		local monsterId = roomMo:getParam()

		ViewMgr.instance:open(ViewName.RogueMeetMonster, monsterId)
	elseif roomMo:getRoomType() == RoguelikeExtension_pb.RoomType.MONSTER then
		if roomMo:getTouchesNoFinish() then
			ViewMgr.instance:open(ViewName.RogueSurvey, roomMo)
		end
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
end

function M:setRoleSpine(roleId)
	local index = 1

	roleId = RogueMgr.instance:getModel():getRoleMoByIndex(index):getRoleId()

	local roleCo = RoguelikeConfig.instance:getRoguelikeRoleById(roleId)

	goutil.setActive(self._goRoleSpine, false)
	RogueMgr.instance:getRogueFlow().mapMgr:setRoleSpine()
end

function M:onExit()
	removetimer(self._hideHintTips, self)
	RogueMgr.instance:setNeedShowDice(true)
	RogueMgr.instance:setHackToolModel(false)
	RogueMgr.instance:exit()
end

function M:onExitFinished()
	for k, v in pairs(self._mapItems) do
		v:unbindEvents()
	end

	self._spineRole:clear()
	self._throwPropTips:setActive(false)
	self._ownPropTips:setActive(false)
end

function M:_onClickClose()
	self:close()
	self:sendMockOut()
	ViewMgr.instance:open(ViewName.HackToolView)
end

function M:_onClickRectify()
	ViewMgr.instance:open(ViewName.RogueRectifyEntrance)
end

function M:_onClickRetreat()
	local dialog = Dialog.showMessage(lang("tip_title"), lang("tip_r_quit_cur_script"), 0)

	dialog:setConfirmListener(function()
		self:_onClickClose()
	end, self)
	dialog:setCancelListener(function()
		RoguelikeAgent.instance:sendQuitRequest()
	end, self)
	dialog:setConfirmText(lang("tip_r_quit_save"))
	dialog:setCancelText(lang("tip_r_quit_confirm"))
end

function M:_onClickEvent()
	return
end

function M:_onClickSituation()
	self._teamDetailTips:updateData()
end

function M:_onClickProp()
	self._ownPropTips:setActive(true)
end

function M:_onClickEquip()
	local equips = RoguelikeModel.instance:getCurEquipMOS() or {}

	if #equips == 0 then
		FloatWordMgr.instance:show("当前没有装备")

		return
	end

	self._equipTips:updateData(equips[1])
end

function M:_onClickChangeParam()
	local timeText = self._inputTime:GetText()

	if timeText ~= nil and timeText ~= "" then
		RoguelikeConst.MAP_CHANGE_CAMERA_TIME = tonumber(timeText)
	end

	local yText = self._inputCameraY:GetText()

	if yText ~= nil and yText ~= "" then
		RoguelikeConst.MAP_ROLE_OFFSET_Y = tonumber(yText)
	end

	local zText = self._inputCameraZ:GetText()

	if zText ~= nil and zText ~= "" then
		RoguelikeConst.MAP_ROLE_OFFSET_Z = tonumber(zText)
	end
end

function M:_onClickDiffDetail()
	self._isShowDiffDetail = not self._isShowDiffDetail

	goutil.setActive(self._goDiffTips, self._isShowDiffDetail)
end

function M:checkIsQuit()
	local allRoleState = RoguelikeModel.instance:getAllRoleState()

	if not allRoleState then
		self:_onQuitSuccess()
	end
end

function M:_onQuitSuccess()
	self:close()
	self:sendMockOut()
	self:setEvent(false)
	ViewMgr.instance:open(ViewName.HackToolView)
end

function M:_onRoomRefresh()
	self:updateMapByRooms()
	self:updateLayerInfo()
	self:switchToSecondaryMapCheck()
end

function M:_onExploreRefresh()
	self:updateLayerInfo()
	RoguelikeController.instance:checkNeedQuit()
end

function M:_onAddPropSuccess()
	if not RoguelikeModel.instance:getCurRoomMo() then
		return
	end

	if RoguelikeModel.instance:getCurRoomMo():getRoomType() == RoguelikeExtension_pb.RoomType.PROPS then
		RoguelikeAgent.instance:sendEndJudgeRequest()
	end
end

function M:_onRoleInfoUpdate()
	self:updateRoleInfo()
end

function M:_onMapIconActive(sender, isActive)
	goutil.setActive(self._traMapParent.gameObject, isActive)
end

function M:getRoleHeadItemById(roleId)
	for k, v in pairs(self._heroItems) do
		if v:getRoleId() == roleId then
			return v
		end
	end
end

function M:_onShowChangeCollector(sender, changes)
	if #changes > 0 then
		local attrType = RoguelikeExtension_pb.AttrType

		for k, v in ipairs(changes) do
			if v.type == attrType.HP or v.type == attrType.SAN then
				local heroId = v.heroId
				local headItem = self:getRoleHeadItemById(heroId)

				if headItem then
					local data = {}

					data.count = v.num
					data.isHp = v.type == attrType.HP

					headItem:showHintAni(data)
				else
					print("找不到效果生效对象", heroId)
				end
			elseif v.type == attrType.R_GOLD then
				self._txtHintCoin.text = string.format("+%d", v.num)

				goutil.setActive(self._goHintCoin, true)
				settimer(0.8, self._hideHintTips, self, false)
			elseif v.type == attrType.SAN then
				-- block empty
			else
				self._txtHintFace.text = string.format("获得额外面%s*%d", RoguelikeConst.AttrType2Name[v.type], v.num)

				goutil.setActive(self._goHintFace, true)
				settimer(0.8, self._hideHintTips, self, false)
			end
		end
	end
end

function M:_hideHintTips()
	goutil.setActive(self._goHintCoin, false)
	goutil.setActive(self._goHintFace, false)
end

function M:_onRoleChange(sender, index)
	local roleMo = RogueMgr.instance:getModel():getRoleMoByIndex(index)
end

function M:_onPropRefresh()
	local allProp = RoguelikeModel.instance:getAllPropNOs()
	local maxCount = 6

	self._txtBtnPropCount.text = string.format("%d", #allProp)

	self._ownPropTips:updateData()
end

function M:_onPropSelect(sender, propNo)
	self._throwPropTips:updateData(propNo)
	self._throwPropTips:setActive(true)
end

function M:_refreshSpinePosition()
	return
end

function M:_setSpinePosition(go)
	self:_stopTween()

	self._isSpineMoving = false

	self._spineRole:play(UnitAnimState.Idle, true)

	if go == nil then
		go = self._mapItems[self._curMoveIndexs[#self._curMoveIndexs]]:getGo()
	end

	local posX = Astral.TransformUtil.GetLocalPosX(go.transform)

	Astral.TransformUtil.SetLocalPosX(self._goRoleSpine.transform, posX)

	local posY = Astral.TransformUtil.GetLocalPosY(go.transform)

	Astral.TransformUtil.SetLocalPosY(self._goRoleSpine.transform, posY)
end

function M:_moveToNextNode()
	if self._curMoveIndex > #self._curMoveIndexs then
		self:_endMoveAndShow()

		return false
	end

	self:_stopTween()
	self._spineRole:play(UnitAnimState.Walk, true)

	local spinePosX, spinePosY, spinePosZ = Astral.TransformUtil.GetLocalPos(self._goRoleSpine.transform, 0, 0, 0)
	local go = self._mapItems[self._curMoveIndexs[self._curMoveIndex]]:getGo()
	local tragetPosX, tragetPosY = Astral.TransformUtil.GetLocalPos(go.transform, 0, 0, 0)

	if spinePosX <= tragetPosX then
		self._spineRole:setDirection(UnitSpineDir.Right)
	else
		self._spineRole:setDirection(UnitSpineDir.Left)
	end

	local distance = math.sqrt(math.pow(tragetPosX - spinePosX, 2) + math.pow(tragetPosY - spinePosY, 2))
	local sec = distance / kMoveSpeed
	local targetPos = Vector3.New(tragetPosX, tragetPosY, spinePosZ)

	self._curTween = DG.Tweening.DOTween.Sequence()

	self._curTween:Append(self._goRoleSpine.transform:DOLocalMove(targetPos, sec, false):SetEase(DG.Tweening.Ease.Linear))
	self._curTween:AppendCallback(self._moveToNextNode, self)

	self._curMoveIndex = self._curMoveIndex + 1
end

function M:_endMoveAndShow()
	self:_setSpinePosition()

	if self._mapItemClickCallback ~= nil then
		self._mapItemClickCallback()
	end
end

function M:_moveToNextFinish()
	self._spineRole:play(UnitAnimState.Idle, true)

	self._isSpineMoving = false

	if self._mapItemClickCallback ~= nil then
		self._mapItemClickCallback()
	end
end

function M:_stopTween()
	if self._curTween then
		self._curTween:Kill()
	end
end

return M
