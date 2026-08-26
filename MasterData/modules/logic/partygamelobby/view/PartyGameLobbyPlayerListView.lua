-- chunkname: @modules/logic/partygamelobby/view/PartyGameLobbyPlayerListView.lua

module("modules.logic.partygamelobby.view.PartyGameLobbyPlayerListView", package.seeall)

local PartyGameLobbyPlayerListView = class("PartyGameLobbyPlayerListView", BaseView)

function PartyGameLobbyPlayerListView:onInitView()
	self._goplayerhead = gohelper.findChild(self.viewGO, "root/#go_playerhead")
	self._goplayeremoji = gohelper.findChild(self.viewGO, "root/#go_playeremoji")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function PartyGameLobbyPlayerListView:addEvents()
	return
end

function PartyGameLobbyPlayerListView:removeEvents()
	return
end

function PartyGameLobbyPlayerListView:_editableInitView()
	local scene = GameSceneMgr.instance:getCurScene()
	local sceneGo = scene.level:getSceneGo()

	self._goPlayerList = UnityEngine.GameObject.New("playerList")

	gohelper.addChild(sceneGo, self._goPlayerList)

	self._mainPlayerUid = PlayerModel.instance:getMyUserId()
	self._playerCompMap = self:getUserDataTb_()
	self._playerHeadMap = self:getUserDataTb_()
	self._playerEmojiMap = self:getUserDataTb_()
	self._mainPlayerPosChange = false

	local x, z = PartyGameRoomModel.instance:getMainPlayerPos()

	if x and z then
		self._tempMainPlayerPosX = x
		self._tempMainPlayerPosZ = z
	else
		self._tempMainPlayerPosX = PartyGameLobbyEnum.InitPos.x
		self._tempMainPlayerPosZ = PartyGameLobbyEnum.InitPos.z
	end

	self._mainPlayerPosX = self._tempMainPlayerPosX
	self._mainPlayerPosZ = self._tempMainPlayerPosZ
	self._mainPlayerIsMoving = false
end

function PartyGameLobbyPlayerListView:_onPartyRoomInfoPush()
	self:_checkPlayerListChange()
end

function PartyGameLobbyPlayerListView:_onKickOutPlayer()
	self:_checkPlayerListChange()
end

function PartyGameLobbyPlayerListView:_onKickedOutPush()
	self:_checkPlayerListChange()
end

function PartyGameLobbyPlayerListView:_onJoinPartyRoom()
	self:_checkPlayerListChange()
end

function PartyGameLobbyPlayerListView:_onGetPartyRoomInfo()
	self:_checkPlayerListChange()
end

function PartyGameLobbyPlayerListView:_onExitPartyRoom()
	self:_checkPlayerListChange()
end

function PartyGameLobbyPlayerListView:_onWearClothUpdate()
	self:_refreshPlayerSkin(self._mainPlayer, PartyClothModel.instance:getWearClothIdMap())
end

function PartyGameLobbyPlayerListView:_refreshPlayerSkin(player, wearClothIdMap)
	if player and wearClothIdMap then
		local resMap = PartyClothConfig.instance:getSkinRes(wearClothIdMap)

		player:refreshSkin(resMap[PartyClothEnum.ClothType.Hat], resMap[PartyClothEnum.ClothType.Jacket], resMap[PartyClothEnum.ClothType.Pant], resMap[PartyClothEnum.ClothType.Shoes], resMap[PartyClothEnum.ClothType.Head], resMap[PartyClothEnum.ClothType.Body])
	end
end

function PartyGameLobbyPlayerListView:_onChangePlayerWearClothIds(uid)
	local playerComp = self._playerCompMap[uid]

	if not playerComp then
		return
	end

	self:_refreshPlayerSkin(playerComp, playerComp:getPlayerInfo().wearClothIds)
end

function PartyGameLobbyPlayerListView:_onSendEmoji(index)
	if PartyGameRoomModel.instance:inGameRoom() then
		PartyGameLobbyController.instance:sendInteraction(index, self._mainPlayerPosX, self._mainPlayerPosZ)
	end

	if self._mainPlayerEmoji then
		self._mainPlayerEmoji:showEmoji(index)
		AudioMgr.instance:trigger(AudioEnum3_4.PartyGameLobby.play_ui_tangren_chess_move)
	end
end

function PartyGameLobbyPlayerListView:_onGetInteractionPush(params)
	local playerComp = self._playerCompMap[params.fromUserId]

	if playerComp then
		local interaction = params.interaction
		local emojiIndex = interaction.emoj
		local headComp = self._playerEmojiMap[params.fromUserId]

		if headComp then
			headComp:showEmoji(emojiIndex)
		end
	end
end

function PartyGameLobbyPlayerListView:_onGetPosPush(params)
	local playerComp = self._playerCompMap[params.fromUserId]

	if playerComp then
		local interaction = params.interaction
		local posX = interaction.x / PartyGameLobbyEnum.MovePosScale
		local posZ = interaction.y / PartyGameLobbyEnum.MovePosScale

		playerComp:setTargetPos(posX, posZ)
	end
end

function PartyGameLobbyPlayerListView:onOpen()
	self.addEventCb(self, PartyGameLobbyController.instance, PartyGameLobbyEvent.MoveJoystick, self.onMoveJoystick, self)
	self.addEventCb(self, PartyGameLobbyController.instance, PartyGameLobbyEvent.KickOutPlayer, self._onKickOutPlayer, self)
	self.addEventCb(self, PartyGameLobbyController.instance, PartyGameLobbyEvent.KickedOutPush, self._onKickedOutPush, self)
	self.addEventCb(self, PartyGameLobbyController.instance, PartyGameLobbyEvent.PartyRoomInfoPush, self._onPartyRoomInfoPush, self)
	self.addEventCb(self, PartyGameLobbyController.instance, PartyGameLobbyEvent.SendEmoji, self._onSendEmoji, self)
	self.addEventCb(self, PartyGameLobbyController.instance, PartyGameLobbyEvent.GetInteractionPush, self._onGetInteractionPush, self)
	self.addEventCb(self, PartyGameLobbyController.instance, PartyGameLobbyEvent.GetPosPush, self._onGetPosPush, self)
	self.addEventCb(self, PartyGameLobbyController.instance, PartyGameLobbyEvent.JoinPartyRoom, self._onJoinPartyRoom, self)
	self.addEventCb(self, PartyGameLobbyController.instance, PartyGameLobbyEvent.ExitPartyRoom, self._onExitPartyRoom, self)
	self.addEventCb(self, PartyGameLobbyController.instance, PartyGameLobbyEvent.ChangePlayerWearClothIds, self._onChangePlayerWearClothIds, self)
	self.addEventCb(self, PartyClothController.instance, PartyClothEvent.WearClothUpdate, self._onWearClothUpdate, self)
	self.addEventCb(self, PartyGameLobbyController.instance, PartyGameLobbyEvent.CustomGetPartyRoomInfo, self._onClearAndRefreshPartyRoomInfo, self)
	self:_initMainPlayer()
	self:_initOtherPlayer()
	TaskDispatcher.runRepeat(self._updatePlayersPos, self, 0)
	TaskDispatcher.runRepeat(self._sendMainPlayerPos, self, 2.2)
end

function PartyGameLobbyPlayerListView:_initOtherPlayer()
	local model = PartyGameRoomModel.instance:getPlayerInfosModel()
	local list = model:getList()

	for i, v in ipairs(list) do
		local id = tonumber(v.id)

		if id > 0 and v.id ~= self._mainPlayerUid then
			self:_addPlayer(v.id, v, true)
		end
	end
end

function PartyGameLobbyPlayerListView:_onClearAndRefreshPartyRoomInfo()
	self:_initOtherPlayer()
end

function PartyGameLobbyPlayerListView:_checkPlayerListChange()
	local model = PartyGameRoomModel.instance:getPlayerInfosModel()
	local list = model:getList()

	for id, v in pairs(self._playerCompMap) do
		if not model:getById(id) then
			self:_removePlayer(id)
		end
	end

	for i, v in ipairs(list) do
		local id = tonumber(v.id)

		if id > 0 and v.id ~= self._mainPlayerUid then
			self:_addPlayer(v.id, v)
		end
	end
end

function PartyGameLobbyPlayerListView:_removePlayer(id)
	local playerComp = self._playerCompMap[id]

	if playerComp and id ~= self._mainPlayerUid then
		gohelper.destroy(playerComp:getRootGo())

		self._playerCompMap[id] = nil

		local headComp = self._playerHeadMap[id]

		if headComp then
			self._playerHeadMap[id] = nil

			gohelper.destroy(headComp.viewGO)
		end

		headComp = self._playerEmojiMap[id]

		if self._playerEmojiMap[id] then
			self._playerEmojiMap[id] = nil

			gohelper.destroy(headComp.viewGO)
		end
	end
end

function PartyGameLobbyPlayerListView:_addPlayer(id, mo, hideBornEffect)
	if self._playerCompMap[id] or not self._goPlayerList then
		return
	end

	local go = UnityEngine.GameObject.New("player_" .. tostring(id))

	gohelper.addChild(self._goPlayerList, go)

	local playerComp = MonoHelper.addNoUpdateLuaComOnceToGo(go, PartyGameLobbyPlayerComp)

	self._playerCompMap[id] = playerComp

	if not mo.pos.x then
		local x = PartyGameLobbyEnum.InitPos.x + Mathf.Random(-200, 200) / 100

		if not mo.pos.z then
			local z = PartyGameLobbyEnum.InitPos.z + Mathf.Random(-100, -200) / 100

			playerComp:setRootInitPos(mo.pos.x, z)
			playerComp:onUpdateMO(mo)
			self:_refreshPlayerSkin(playerComp, mo.wearClothIds)

			if not hideBornEffect then
				local effectLoader = PrefabInstantiate.Create(go)

				effectLoader:startLoad("modules/party_game/scene/effects/v3a4_games/game_common04.prefab")
			end

			local headInfoItem = self:_getHeadInfoItem()

			self._playerHeadMap[id] = headInfoItem

			headInfoItem:bindPlayerGo(go)
			headInfoItem:onUpdateMO(mo)

			headInfoItem = self:_getHeadInfoItem(self._goplayeremoji)
			self._playerEmojiMap[id] = headInfoItem

			headInfoItem:bindPlayerGo(go)
			headInfoItem:onUpdateMO(mo, true)
		end
	end
end

function PartyGameLobbyPlayerListView:_updatePlayersPos()
	if not self._goPlayerList then
		return
	end

	self:_checkKeyPress()
	self:_updateMainPlayerPos()

	for id, v in pairs(self._playerCompMap) do
		if id ~= self._mainPlayerUid then
			v:update()
		end
	end
end

function PartyGameLobbyPlayerListView:_checkKeyPress()
	local value = -1

	if UnityEngine.Input.GetKey(UnityEngine.KeyCode.W) then
		value = UnityEngine.Input.GetKey(UnityEngine.KeyCode.D) and 1 or UnityEngine.Input.GetKey(UnityEngine.KeyCode.A) and 3 or 2
	elseif UnityEngine.Input.GetKey(UnityEngine.KeyCode.S) then
		value = UnityEngine.Input.GetKey(UnityEngine.KeyCode.D) and 7 or UnityEngine.Input.GetKey(UnityEngine.KeyCode.A) and 5 or 6
	elseif UnityEngine.Input.GetKey(UnityEngine.KeyCode.A) then
		value = 4
	elseif UnityEngine.Input.GetKey(UnityEngine.KeyCode.D) then
		value = 0
	end

	if ViewMgr.instance:isOpen(ViewName.PartyGameLobbyStoreView) then
		value = -1
	end

	if value >= 0 then
		self._keyPressMove = true
		self._joystickIndex = value
		self._joyStickLengthIndex = 1
	elseif self._keyPressMove then
		self._keyPressMove = false
		self._joystickIndex = self._indexFromJoyStick
		self._joyStickLengthIndex = self._lengthIndexFromJoyStick
	end
end

function PartyGameLobbyPlayerListView:_isDoingClickGuide()
	return not GuideModel.instance:isGuideFinish(PartyGameLobbyEnum.GuideIds.FirstGuideId) or not GuideModel.instance:isGuideFinish(PartyGameLobbyEnum.GuideIds.LastGuideId)
end

function PartyGameLobbyPlayerListView:_updateMainPlayerPos()
	if not self._goPlayerList then
		return
	end

	if not GuideController.instance:isForbidGuides() and self:_isDoingClickGuide() then
		return
	end

	local spineComp = self._mainPlayer:getSpineComp()

	if not spineComp then
		return
	end

	local mainPlayerAnimator = self._mainPlayer:getAnimator()

	if not self._joyStickLengthIndex or self._joyStickLengthIndex == 0 or not self._mainPlayerContainer then
		if mainPlayerAnimator then
			mainPlayerAnimator:SetBool("isMove", false)
			mainPlayerAnimator:SetFloat("speed", 0)

			if self._mainPlayerIsMoving then
				AudioMgr.instance:trigger(AudioEnum3_4.LaplaceChatRoom.stop_ui_bulaochuan_walk_loop)

				self._mainPlayerIsMoving = false
			end
		end

		return
	end

	local x, y, z = transformhelper.getPos(self._mainPlayerContainer.transform)
	local length = self._joyStickLengthIndex * PartyGameLobbyEnum.PlayerMoveSpeed * Time.deltaTime
	local angle = self._joystickIndex * PartyGameLobbyEnum.JoystickPerRadians
	local deltaX = length * math.cos(angle)
	local deltaZ = length * math.sin(angle)
	local x = x + deltaX
	local z = z + deltaZ

	if ZProj.AStarPathBridge.IsWalkable(x, y, z) then
		transformhelper.setPos(self._mainPlayerContainer.transform, x, y, z)

		self._tempMainPlayerPosX = x
		self._tempMainPlayerPosZ = z

		PartyGameRoomModel.instance:setMainPlayerPos(x, z)
		PartyGameLobbyController.instance:dispatchEvent(PartyGameLobbyEvent.MainPlayerMove)
	end

	spineComp:SetScaleX(deltaX > 0 and -1 or 1)

	if mainPlayerAnimator then
		mainPlayerAnimator:SetFloat("speed", 10)
		mainPlayerAnimator:SetBool("isMove", true)

		if not self._mainPlayerIsMoving then
			self._mainPlayerIsMoving = true

			AudioMgr.instance:trigger(AudioEnum3_4.LaplaceChatRoom.play_ui_bulaochuan_walk_loop)
		end
	end
end

function PartyGameLobbyPlayerListView:_sendMainPlayerPos()
	if math.abs(self._tempMainPlayerPosX - self._mainPlayerPosX) < 0.01 and math.abs(self._tempMainPlayerPosZ - self._mainPlayerPosZ) < 0.01 then
		return
	end

	self._mainPlayerPosX = self._tempMainPlayerPosX
	self._mainPlayerPosZ = self._tempMainPlayerPosZ

	if PartyGameRoomModel.instance:inGameRoom() then
		PartyGameLobbyController.instance:sendInteraction(0, self._mainPlayerPosX, self._mainPlayerPosZ)
	end
end

function PartyGameLobbyPlayerListView:onMoveJoystick(index, lengthIndex)
	self._joystickIndex = index
	self._joyStickLengthIndex = lengthIndex
	self._indexFromJoyStick = index
	self._lengthIndexFromJoyStick = lengthIndex
end

function PartyGameLobbyPlayerListView:_initMainPlayer()
	if not self._goPlayerList then
		return
	end

	local go = UnityEngine.GameObject.New("mainPlayer")

	gohelper.addChild(self._goPlayerList, go)

	local playerComp = MonoHelper.addNoUpdateLuaComOnceToGo(go, PartyGameLobbyPlayerComp)

	self._playerCompMap[self._mainPlayerUid] = playerComp

	playerComp:setRootInitPos(self._mainPlayerPosX, self._mainPlayerPosZ)

	local effectLoader = PrefabInstantiate.Create(go)

	effectLoader:startLoad("modules/party_game/scene/effects/v3a4_games/game_common02.prefab")

	local scene = GameSceneMgr.instance:getCurScene()

	scene.camera:setFocusTrans(go.transform)

	self._mainPlayerContainer = go
	self._mainPlayer = playerComp
	self._mainPlayerHeadInfo = self:_getHeadInfoItem()

	self._mainPlayerHeadInfo:bindPlayerGo(go)
	self._mainPlayerHeadInfo:showMainPlayerFlag()

	self._mainPlayerEmoji = self:_getHeadInfoItem(self._goplayeremoji)

	self._mainPlayerEmoji:bindPlayerGo(go)
	self:_onWearClothUpdate()
end

function PartyGameLobbyPlayerListView:_getHeadInfoItem(parentGo)
	local resPath = self.viewContainer:getSetting().otherRes.playerheadinfo
	local go = self.viewContainer:getResInst(resPath, parentGo or self._goplayerhead)

	gohelper.setAsFirstSibling(go)

	return (MonoHelper.addNoUpdateLuaComOnceToGo(go, PartyGameLobbyPlayerHeadInfo))
end

function PartyGameLobbyPlayerListView:onClose()
	gohelper.destroyAllChildren(self._goPlayerList)

	self._goPlayerList = nil

	TaskDispatcher.cancelTask(self._updatePlayersPos, self)
	TaskDispatcher.cancelTask(self._sendMainPlayerPos, self)

	if self._mainPlayerIsMoving then
		AudioMgr.instance:trigger(AudioEnum3_4.LaplaceChatRoom.stop_ui_bulaochuan_walk_loop)

		self._mainPlayerIsMoving = false
	end
end

function PartyGameLobbyPlayerListView:onDestroyView()
	return
end

return PartyGameLobbyPlayerListView
