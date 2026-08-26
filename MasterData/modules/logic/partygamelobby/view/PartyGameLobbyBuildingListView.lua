-- chunkname: @modules/logic/partygamelobby/view/PartyGameLobbyBuildingListView.lua

module("modules.logic.partygamelobby.view.PartyGameLobbyBuildingListView", package.seeall)

local PartyGameLobbyBuildingListView = class("PartyGameLobbyBuildingListView", BaseView)

function PartyGameLobbyBuildingListView:onInitView()
	self._gobuilding = gohelper.findChild(self.viewGO, "root/#go_building")
	self._goqte = gohelper.findChild(self.viewGO, "root/#go_qte")
	self._btnqte1 = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_qte/#btn_qte1")
	self._imageicon1 = gohelper.findChildImage(self.viewGO, "root/#go_qte/#btn_qte1/#image_icon1")
	self._btnqte2 = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_qte/#btn_qte2")
	self._imageicon2 = gohelper.findChildImage(self.viewGO, "root/#go_qte/#btn_qte2/#image_icon2")
	self._btnclickbuilding = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_clickbuilding")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function PartyGameLobbyBuildingListView:addEvents()
	self._btnqte1:AddClickListener(self._btnqte1OnClick, self)
	self._btnqte2:AddClickListener(self._btnqte2OnClick, self)
	self._btnclickbuilding:AddClickListener(self._btnclickbuildingOnClick, self)
end

function PartyGameLobbyBuildingListView:removeEvents()
	self._btnqte1:RemoveClickListener()
	self._btnqte2:RemoveClickListener()
	self._btnclickbuilding:RemoveClickListener()
end

function PartyGameLobbyBuildingListView:_btnclickbuildingOnClick()
	local pos = GamepadController.instance:getMousePosition()
	local camera = CameraMgr.instance:getMainCamera()
	local ray = camera:ScreenPointToRay(pos)
	local result, hitInfo = UnityEngine.Physics.Raycast(ray.origin, ray.direction, nil, 100, LayerMask.GetMask("SceneOpaque"))

	if result and hitInfo then
		local name = hitInfo.transform.name

		if string.find(name, "shangdian") then
			PartyGameLobbyController.instance:dispatchEvent(PartyGameLobbyEvent.ClickBuilding, PartyGameLobbyEnum.BuildingType.Shop)
		elseif string.find(name, "fuzhuangchouqu") then
			PartyGameLobbyController.instance:dispatchEvent(PartyGameLobbyEvent.ClickBuilding, PartyGameLobbyEnum.BuildingType.Lottery)
		elseif string.find(name, "huanzhuangdidian") then
			PartyGameLobbyController.instance:dispatchEvent(PartyGameLobbyEvent.ClickBuilding, PartyGameLobbyEnum.BuildingType.DressUp)
		end
	end
end

function PartyGameLobbyBuildingListView:_btnqte1OnClick()
	if self._showBuilding1 then
		self:_onClickBuilding(self._showBuilding1)
	end
end

function PartyGameLobbyBuildingListView:_btnqte2OnClick()
	if self._showBuilding2 then
		self:_onClickBuilding(self._showBuilding2)
	end
end

function PartyGameLobbyBuildingListView:_editableInitView()
	local scene = GameSceneMgr.instance:getCurScene()
	local sceneGo = scene.level:getSceneGo()

	self._goSceneBuilding = UnityEngine.GameObject.New("buildlist")

	gohelper.addChild(sceneGo, self._goSceneBuilding)
	gohelper.setActive(self._btnqte1, false)
	gohelper.setActive(self._btnqte2, false)
end

function PartyGameLobbyBuildingListView:_onClickBuilding(id)
	if PartyGameRoomModel.instance:inGameMatch() then
		logNormal("_onClickBuilding in game match")

		return
	end

	local myPlayerInfo = PartyGameRoomModel.instance:getMyPlayerInfo()
	local isReady = myPlayerInfo and myPlayerInfo.status == PartyGameLobbyEnum.RoomOperateState.Ready

	if isReady then
		GameFacade.showToast(ToastEnum.PartyGameNeedCancelReady)

		return
	end

	if id == PartyGameLobbyEnum.BuildingType.Shop then
		PartyGameLobbyController.instance:enterStore()
	elseif id == PartyGameLobbyEnum.BuildingType.DressUp then
		PartyClothController.instance:openPartyClothView()
	elseif id == PartyGameLobbyEnum.BuildingType.Lottery then
		PartyClothController.instance:openPartyClothLotteryView()
	end
end

function PartyGameLobbyBuildingListView:_onMainPlayerMove()
	local x, y = PartyGameRoomModel.instance:getMainPlayerPos()

	if not x or not y then
		return
	end

	self._mainPlayerPos.x = x
	self._mainPlayerPos.y = y

	gohelper.setActive(self._btnqte1, false)
	gohelper.setActive(self._btnqte2, false)

	local index = 1

	for i, info in ipairs(self._buildingGroundPos) do
		if Vector2.Distance(self._mainPlayerPos, info.pos) < 8 then
			gohelper.setActive(self["_btnqte" .. index], true)

			local icon = self["_imageicon" .. index]

			UISpriteSetMgr.instance:setV3a4LaplaceSprite(icon, info.config.icon .. "_3")

			self["_showBuilding" .. index] = i
			index = index + 1
		end
	end
end

function PartyGameLobbyBuildingListView:_checkQte()
	if PartyGameLobbyController.instance:getRoomState() == PartyGameLobbyEnum.RoomState.InMatch then
		gohelper.setActive(self._goqte, false)

		return
	end

	local myPlayerInfo = PartyGameRoomModel.instance:getMyPlayerInfo()
	local isReady = myPlayerInfo and myPlayerInfo.status == PartyGameLobbyEnum.RoomOperateState.Ready

	gohelper.setActive(self._goqte, not isReady)
end

function PartyGameLobbyBuildingListView:_onChangePartyRoomStatus()
	self:_checkQte()
end

function PartyGameLobbyBuildingListView:_onRoomStateChange()
	self:_checkQte()
end

function PartyGameLobbyBuildingListView:onOpen()
	self.addEventCb(self, PartyGameLobbyController.instance, PartyGameLobbyEvent.ClickBuilding, self._onClickBuilding, self)
	self.addEventCb(self, PartyGameLobbyController.instance, PartyGameLobbyEvent.MainPlayerMove, self._onMainPlayerMove, self)
	self.addEventCb(self, PartyGameLobbyController.instance, PartyGameLobbyEvent.ChangePartyRoomStatus, self._onChangePartyRoomStatus, self)
	self.addEventCb(self, PartyGameLobbyController.instance, PartyGameLobbyEvent.RoomStateChange, self._onRoomStateChange, self)

	self._mainPlayerPos = Vector2()
	self._showBuilding1 = nil
	self._showBuilding2 = nil

	self:_initBuildingList()
	self:_onMainPlayerMove()
	self:_checkQte()
end

function PartyGameLobbyBuildingListView:_initBuildingList()
	self._buildingGroundPos = self:getUserDataTb_()

	for i, v in ipairs(lua_party_building.configList) do
		self:_addBuilding(i, v)
	end
end

function PartyGameLobbyBuildingListView:_addBuilding(id, config)
	local resPath = self.viewContainer:getSetting().otherRes.buildinginfo
	local go = self.viewContainer:getResInst(resPath, self._gobuilding)
	local buildingComp = MonoHelper.addNoUpdateLuaComOnceToGo(go, PartyGameLobbyBuildingInfo)

	buildingComp:onUpdateMO(id, config)

	local buildingGo = UnityEngine.GameObject.New("building_" .. tostring(config.name))

	gohelper.addChild(self._goSceneBuilding, buildingGo)

	local pos = config.pos

	transformhelper.setLocalPos(buildingGo.transform, pos[1], pos[2], pos[3])
	buildingComp:bindBuildingGo(buildingGo)

	self._buildingGroundPos[id] = id == PartyGameLobbyEnum.BuildingType.DressUp and {
		pos = Vector2(-7, -13),
		config = config
	} or {
		pos = Vector2(pos[1], pos[3]),
		config = config
	}
end

function PartyGameLobbyBuildingListView:onClose()
	return
end

function PartyGameLobbyBuildingListView:onDestroyView()
	return
end

return PartyGameLobbyBuildingListView
