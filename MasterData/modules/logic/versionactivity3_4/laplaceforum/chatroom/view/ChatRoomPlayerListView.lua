-- chunkname: @modules/logic/versionactivity3_4/laplaceforum/chatroom/view/ChatRoomPlayerListView.lua

module("modules.logic.versionactivity3_4.laplaceforum.chatroom.view.ChatRoomPlayerListView", package.seeall)

local ChatRoomPlayerListView = class("ChatRoomPlayerListView", BaseView)

function ChatRoomPlayerListView:onInitView()
	self._goplayerhead = gohelper.findChild(self.viewGO, "root/#go_headInfo")
	self._txtroomNum = gohelper.findChildText(self.viewGO, "root/#go_chatroom/#txt_roomNum")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ChatRoomPlayerListView:addEvents()
	self.addEventCb(self, ChatRoomController.instance, ChatRoomEvent.ShowChatEmoji, self.onShowChatEmoji, self)
	self.addEventCb(self, ChatRoomController.instance, ChatRoomEvent.OnChatRoomUserInfoChange, self.checkPlayerInfoChange, self)
	self.addEventCb(self, PartyGameLobbyController.instance, PartyGameLobbyEvent.MoveJoystick, self.onMoveJoystick, self)
	self.addEventCb(self, PartyGameLobbyController.instance, PartyGameLobbyEvent.ChangePlayerWearClothIds, self.onChangePlayerWearClothIds, self)
	self.addEventCb(self, PartyClothController.instance, PartyClothEvent.WearClothUpdate, self.onWearClothUpdate, self)
end

function ChatRoomPlayerListView:removeEvents()
	self.removeEventCb(self, ChatRoomController.instance, ChatRoomEvent.ShowChatEmoji, self.onShowChatEmoji, self)
	self.removeEventCb(self, ChatRoomController.instance, ChatRoomEvent.OnChatRoomUserInfoChange, self.checkPlayerInfoChange, self)
	self.removeEventCb(self, PartyGameLobbyController.instance, PartyGameLobbyEvent.MoveJoystick, self.onMoveJoystick, self)
	self.removeEventCb(self, PartyGameLobbyController.instance, PartyGameLobbyEvent.ChangePlayerWearClothIds, self.onChangePlayerWearClothIds, self)
	self.removeEventCb(self, PartyClothController.instance, PartyClothEvent.WearClothUpdate, self.onWearClothUpdate, self)
end

function ChatRoomPlayerListView:_editableInitView()
	local scene = GameSceneMgr.instance:getCurScene()
	local sceneGo = scene.level:getSceneGo()

	self._goPlayerContent = UnityEngine.GameObject.New("playerContent")

	gohelper.addChild(sceneGo, self._goPlayerContent)

	self.mainPlayerUid = PlayerModel.instance:getMyUserId()
	self.playerItemMap = self:getUserDataTb_()
	self.playerHeadItemMap = self:getUserDataTb_()
	self.allHeadInfoItemList = self:getUserDataTb_()
	self.mainPlayerPosX, self.mainPlayerPosZ = self:getPlayerInitPos()
	self.tempMainPlayerPosX = 0
	self.tempMainPlayerPosZ = 0
	self.sendPlayerPosTime = Activity225Config.instance:getConstValue(ChatRoomEnum.ConstId.SendMoveRequestRate, true) / 1000
	self.interactRange = Activity225Config.instance:getConstValue(ChatRoomEnum.ConstId.InteractiveRange, true)

	local playMoveRangeStr = Activity225Config.instance:getConstValue(ChatRoomEnum.ConstId.RoleMoveRange)

	self.playMoveRangeList = GameUtil.splitString2(playMoveRangeStr, true)
	self.maxPlayerNum = Activity225Config.instance:getConstValue(ChatRoomEnum.ConstId.ChatRoomRoleNum, true)
	self.mainPlayerIsMoving = false
end

function ChatRoomPlayerListView:getPlayerInitPos()
	local createPlayerRange = Activity225Config.instance:getConstValue(ChatRoomEnum.ConstId.CreatePlayerRange)
	local posRangeList = GameUtil.splitString2(createPlayerRange, true)
	local minX = posRangeList[1][1]
	local maxX = posRangeList[1][2]
	local minY = posRangeList[2][1]
	local maxY = posRangeList[2][2]

	return (minX + maxX) / 2, (minY + maxY) / 2
end

function ChatRoomPlayerListView:onShowChatEmoji(msg)
	local curRoomUid = ChatRoomModel.instance:getRoomUid()
	local playerItem = self.playerItemMap[msg.sendUserId]

	if msg.activityId == self.activityId and msg.uid == curRoomUid and playerItem then
		playerItem.headInfoItem:showEmoji(msg.emojiId)
	end

	self:sendEmojiStatInfo(msg.emojiId)
end

function ChatRoomPlayerListView:sendEmojiStatInfo(emojiId)
	local curPlayerNum = tabletool.len(self.playerItemMap)

	StatController.instance:track(StatEnum.EventName.PartyGameMeme, {
		[StatEnum.EventProperties.Members] = curPlayerNum,
		[StatEnum.EventProperties.Meme] = emojiId
	})
end

function ChatRoomPlayerListView:onOpen()
	self.activityId = ChatRoomModel.instance:getCurActivityId()
	self.npcListView = self.viewContainer:getNpcListView()

	self:initMainPlayer()
	self:checkPlayerInfoChange()
	TaskDispatcher.runRepeat(self._updatePlayersPos, self, 0)
	TaskDispatcher.runRepeat(self._sendMainPlayerPos, self, self.sendPlayerPosTime)
end

function ChatRoomPlayerListView:_updatePlayersPos()
	self:_checkKeyPress()
	self:_updateMainPlayerPos()
	self:_checkShowInteract()

	for uid, playerItem in pairs(self.playerItemMap) do
		if uid ~= self.mainPlayerUid then
			playerItem.comp:update()
		end
	end

	self:updateHeadInfoLayer()
end

function ChatRoomPlayerListView:_checkKeyPress()
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

function ChatRoomPlayerListView:_updateMainPlayerPos()
	local spineComp = self.mainPlayer:getSpineComp()
	local mainPlayerAnimator = self.mainPlayer:getAnimator()

	if not self._joyStickLengthIndex or self._joyStickLengthIndex == 0 or not self.mainPlayerContainer or not spineComp then
		if mainPlayerAnimator then
			mainPlayerAnimator:SetBool("isMove", false)
			mainPlayerAnimator:SetFloat("speed", 0)

			if self.mainPlayerIsMoving then
				AudioMgr.instance:trigger(AudioEnum3_4.LaplaceChatRoom.stop_ui_bulaochuan_walk_loop)

				self.mainPlayerIsMoving = false
			end
		end

		return
	end

	local x, y, z = transformhelper.getPos(self.mainPlayerContainer.transform)
	local length = self._joyStickLengthIndex * PartyGameLobbyEnum.PlayerMoveSpeed * Time.deltaTime
	local angle = self._joystickIndex * PartyGameLobbyEnum.JoystickPerRadians
	local deltaX = length * math.cos(angle)
	local deltaZ = length * math.sin(angle)
	local x = Mathf.Clamp(x + deltaX, self.playMoveRangeList[1][1], self.playMoveRangeList[1][2])
	local z = Mathf.Clamp(z + deltaZ, self.playMoveRangeList[2][1], self.playMoveRangeList[2][2])

	if ZProj.AStarPathBridge.IsWalkable(x, y, z) then
		transformhelper.setPos(self.mainPlayerContainer.transform, x, y, z)

		self.tempMainPlayerPosX = Mathf.Floor(x * 1000) / 1000
		self.tempMainPlayerPosZ = Mathf.Floor(z * 1000) / 1000
	end

	spineComp:SetScaleX(deltaX > 0 and -1 or 1)
	mainPlayerAnimator:SetFloat("speed", 10)
	mainPlayerAnimator:SetBool("isMove", true)

	if not self.mainPlayerIsMoving then
		AudioMgr.instance:trigger(AudioEnum3_4.LaplaceChatRoom.play_ui_bulaochuan_walk_loop)
	end

	self.mainPlayerIsMoving = true
end

function ChatRoomPlayerListView:_checkShowInteract()
	local npcInfoMap = ChatRoomModel.instance:getNpcInfoMap()
	local interactRoleInfo = {}

	for npcType, npcInfo in pairs(npcInfoMap) do
		local canShowNpc = ChatRoomModel.instance:checkCanShowNpc(npcType)

		if canShowNpc then
			local npcPosList = npcInfo.posList
			local distance = self:getOtherRoleDistance(npcPosList[1], npcPosList[2])

			if distance <= self.interactRange and (not interactRoleInfo.distance or distance < interactRoleInfo.distance) then
				interactRoleInfo.distance = distance
				interactRoleInfo.roleId = npcInfo.npcConfig.npcId
				interactRoleInfo.roleType = npcType
			end
		end
	end

	local userMoMap = ChatRoomModel.instance:getChatRoomUserMoMap()

	for userId, chatRoomUserMo in pairs(userMoMap) do
		local distance = self:getOtherRoleDistance(chatRoomUserMo.posX, chatRoomUserMo.posY)

		if distance <= self.interactRange and userId ~= self.mainPlayerUid and (not interactRoleInfo.distance or distance < interactRoleInfo.distance) then
			interactRoleInfo.distance = distance
			interactRoleInfo.roleId = userId
			interactRoleInfo.roleType = ChatRoomEnum.NpcType.Player
		end
	end

	ChatRoomController.instance:dispatchEvent(ChatRoomEvent.OnShowNpcPlayerType, interactRoleInfo)

	return interactRoleInfo
end

function ChatRoomPlayerListView:getOtherRoleDistance(rolePosX, rolePosZ)
	return (math.sqrt((rolePosX - self.tempMainPlayerPosX)^2 + (rolePosZ - self.tempMainPlayerPosZ)^2))
end

function ChatRoomPlayerListView:_sendMainPlayerPos()
	if math.abs(self.tempMainPlayerPosX - self.mainPlayerPosX) < 0.01 and math.abs(self.tempMainPlayerPosZ - self.mainPlayerPosZ) < 0.01 then
		return
	end

	self.mainPlayerPosX = Mathf.Floor(self.tempMainPlayerPosX * 1000) / 1000
	self.mainPlayerPosZ = Mathf.Floor(self.tempMainPlayerPosZ * 1000) / 1000

	if ChatRoomModel.instance:checkIsInRoom() then
		Activity225Rpc.instance:sendAct225MoveRequest(self.activityId, self.mainPlayerPosX * 1000, self.mainPlayerPosZ * 1000)
	end
end

function ChatRoomPlayerListView:onMoveJoystick(index, lengthIndex)
	self._joystickIndex = index
	self._joyStickLengthIndex = lengthIndex
	self._indexFromJoyStick = index
	self._lengthIndexFromJoyStick = lengthIndex
end

function ChatRoomPlayerListView:initMainPlayer()
	self.mainPlayerItem = self:addPlayer(self.mainPlayerUid)

	local scene = GameSceneMgr.instance:getCurScene()

	scene.camera:setFocusTrans(self.mainPlayerItem.go.transform)

	self.mainPlayerContainer = self.mainPlayerItem.go
	self.mainPlayer = self.mainPlayerItem.comp
	self.mainPlayerHeadInfo = self:getHeadInfoItem(self.mainPlayerUid)

	self.mainPlayerHeadInfo:bindPlayerGo(self.mainPlayerItem.go)
	self.mainPlayerHeadInfo:onUpdateMO(self.mainPlayerItem.userMo)

	self.tempMainPlayerPosX = self.mainPlayerItem.userMo.posX
	self.tempMainPlayerPosZ = self.mainPlayerItem.userMo.posY
	self.mainPlayerPosX = self.tempMainPlayerPosX
	self.mainPlayerPosZ = self.tempMainPlayerPosZ

	self:onWearClothUpdate()
end

function ChatRoomPlayerListView:onWearClothUpdate()
	self:refreshPlayerSkin(self.mainPlayer, self.mainPlayerItem.userMo:getWearClothIdMap())
end

function ChatRoomPlayerListView:refreshPlayerSkin(player, wearClothIdMap)
	if player and wearClothIdMap then
		local resMap = PartyClothConfig.instance:getSkinRes(wearClothIdMap)

		player:refreshSkin(resMap[PartyClothEnum.ClothType.Hat], resMap[PartyClothEnum.ClothType.Jacket], resMap[PartyClothEnum.ClothType.Pant], resMap[PartyClothEnum.ClothType.Shoes], resMap[PartyClothEnum.ClothType.Head], resMap[PartyClothEnum.ClothType.Body])
	end
end

function ChatRoomPlayerListView:onChangePlayerWearClothIds(uid)
	local playerItem = self.playerItemMap[uid]

	if not playerItem or not playerItem.comp then
		return
	end

	self:refreshPlayerSkin(playerItem.comp, playerItem.userMo:getWearClothIdMap())
end

function ChatRoomPlayerListView:getHeadInfoItem(userId)
	if self.playerHeadItemMap[userId] then
		return self.playerHeadItemMap[userId]
	end

	local resPath = self.viewContainer:getSetting().otherRes.playerheadinfo
	local go = self.viewContainer:getResInst(resPath, self._goplayerhead)
	local item = MonoHelper.addNoUpdateLuaComOnceToGo(go, ChatRoomPlayerHeadInfo)

	self.playerHeadItemMap[userId] = item

	return item
end

function ChatRoomPlayerListView:checkPlayerInfoChange()
	local chatRoomUserMoMap = ChatRoomModel.instance:getChatRoomUserMoMap()

	for userId, playerItem in pairs(self.playerItemMap) do
		if not chatRoomUserMoMap[userId] then
			self:removePlayer(userId)
		end
	end

	for userId, userMo in pairs(chatRoomUserMoMap) do
		if not self.playerItemMap[userId] then
			self:addPlayer(userId)
		else
			self:updatePlayer(userId)
		end
	end

	self:refreshPlayerNum()
end

function ChatRoomPlayerListView:refreshPlayerNum()
	local curPlayerNum = tabletool.len(self.playerItemMap)

	self._txtroomNum.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("laplace_chatroom_roomNum"), curPlayerNum, self.maxPlayerNum)
end

function ChatRoomPlayerListView:addPlayer(userId)
	local userMo = ChatRoomModel.instance:getChatRoomUserMo(userId)
	local playerItem = self.playerItemMap[userId]

	if not playerItem then
		playerItem = {
			isMain = userId == self.mainPlayerUid
		}
		playerItem.go = UnityEngine.GameObject.New(playerItem.isMain and "mainPlayer" or "player_" .. userId)

		gohelper.addChild(self._goPlayerContent, playerItem.go)

		local effectLoader = PrefabInstantiate.Create(playerItem.go)

		effectLoader:startLoad("modules/party_game/scene/effects/v3a4_games/game_common02.prefab")

		playerItem.comp = MonoHelper.addNoUpdateLuaComOnceToGo(playerItem.go, PartyGameLobbyPlayerComp)
		playerItem.headInfoItem = self:getHeadInfoItem(userId)
		self.playerItemMap[userId] = playerItem
	end

	playerItem.userMo = userMo

	playerItem.comp:setRootInitPos(userMo.posX, userMo.posY)
	playerItem.comp:setTargetPos(userMo.posX, userMo.posY)
	playerItem.headInfoItem:bindPlayerGo(playerItem.go)
	playerItem.headInfoItem:onUpdateMO(userMo)
	playerItem.headInfoItem:setNameBg(playerItem.isMain)
	self:refreshPlayerSkin(playerItem.comp, userMo:getWearClothIdMap())

	return playerItem
end

function ChatRoomPlayerListView:updatePlayer(userId)
	local playerItem = self.playerItemMap[userId]

	playerItem.userMo = ChatRoomModel.instance:getChatRoomUserMo(userId)

	if playerItem.userMo then
		playerItem.comp:setTargetPos(playerItem.userMo.posX, playerItem.userMo.posY)
		playerItem.headInfoItem:onUpdateMO(playerItem.userMo)
	end
end

function ChatRoomPlayerListView:updateHeadInfoLayer()
	self.allHeadInfoItemList = self:getUserDataTb_()

	if self.npcListView then
		local npcItemMap = self.npcListView:getNpcItemMap()

		for _, npcItem in pairs(npcItemMap) do
			local headInfoItem = {}

			headInfoItem.headInfoGO = npcItem.npcInfoComp.go
			headInfoItem.posZ = npcItem.npcComp:getPosZ()

			table.insert(self.allHeadInfoItemList, headInfoItem)
		end
	end

	for _, playerItem in pairs(self.playerItemMap) do
		local headInfoItem = {}

		headInfoItem.headInfoGO = playerItem.headInfoItem.viewGO
		headInfoItem.posZ = playerItem.comp:getPosZ()

		table.insert(self.allHeadInfoItemList, headInfoItem)
	end

	table.sort(self.allHeadInfoItemList, function(a, b)
		return a.posZ > b.posZ
	end)

	for index, headInfoItem in pairs(self.allHeadInfoItemList) do
		gohelper.setAsLastSibling(headInfoItem.headInfoGO)
	end
end

function ChatRoomPlayerListView:removePlayer(userId)
	local playerItem = self.playerItemMap[userId]

	if playerItem and userId ~= self.mainPlayerUid then
		gohelper.destroy(playerItem.go)
		gohelper.destroy(playerItem.headInfoItem.viewGO)

		self.playerItemMap[userId] = nil
		self.playerHeadItemMap[userId] = nil
	end
end

function ChatRoomPlayerListView:onClose()
	TaskDispatcher.cancelTask(self._updatePlayersPos, self)
	TaskDispatcher.cancelTask(self._sendMainPlayerPos, self)
	AudioMgr.instance:trigger(AudioEnum3_4.LaplaceChatRoom.stop_ui_bulaochuan_walk_loop)
end

function ChatRoomPlayerListView:onDestroyView()
	return
end

return ChatRoomPlayerListView
