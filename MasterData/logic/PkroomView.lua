-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pk/view/PkroomView.lua

module("logic.extensions.pk.view.PkroomView", package.seeall)

local PkroomView = class("PkroomView", ViewComponent)

function PkroomView:ctor()
	PkroomView.super.ctor(self)
end

function PkroomView:unbindEvents()
	PkroomView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnStart:RemoveClickListener()
	self._customInput:RemoveListener()
	self._btnInvate:RemoveClickListener()
	self._btnKickout:RemoveClickListener()
	self._btnOp:RemoveClickListener()
	self._btnTip:RemoveClickListener()
	self._btnChat:RemoveClickListener()
end

function PkroomView:bindEvents()
	PkroomView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
	self._btnStart:AddClickListener(self._onClickbtnStart, self)
	self._customInput:AddListener(self._onCustomInputCallback, self)
	self._btnInvate:AddClickListener(self._onClickbtnInvate, self)
	self._btnKickout:AddClickListener(self._onClickbtnKickout, self)
	self._btnOp:AddClickListener(self._onClickbtnOp, self)
	self._btnTip:AddClickListener(self._onClickbtnTip, self)
	self._btnChat:AddClickListener(self._onClickChat, self)
end

function PkroomView:buildUI()
	PkroomView.super.buildUI(self)

	self._btnClose = self:getBtn("leftTop/btnClose")
	self._btnStart = self:getBtn("btnStart")
	self._chatPanelGo = self:getGo("chatPanel")
	self._customInput = UICustomInput.Get(self._chatPanelGo)
	self._txtEnemyPower = self:getTxt("power/2/txtPower")
	self._txtMyPower = self:getTxt("power/1/txtPower")
	self._palyersGo = self:getGo("palyers")
	self._tableviewGo = self:getGo("chatPanel/tableview")
	self._tablecellGo = self:getGo("chatPanel/tablecell")
	self._ui3dCamGo = self:getGo("ui3dCam")

	self:_buildPlayers(self._palyersGo)

	self._commonAttrSelectOnGo = self:getGo("power/commonattr/btnCommonAttr/on")
	self._commonAttrSelectOffGo = self:getGo("power/commonattr/btnCommonAttr/off")
	self._txtBtnStart = self:getTxt("btnStart/Text")
	self._btnInvate = self:getBtn("palyers/player2/btnInvate")
	self._btnKickout = self:getBtn("palyers/player2/btnKickout")
	self._btnOp = self:getBtn("palyers/player2/btnOp")
	self._btnTip = self:getBtn("leftTop/btnTip")
	self._btnChat = self:getBtn("Nego_Chat")
	self._bgGo = self:getGo("ui3dCam/bg")

	goutil.setActive(self._bgGo, true)
end

function PkroomView:_buildPlayers(root)
	self._playerItems = {}

	for i = 1, 2 do
		local go = goutil.findChild(root, "player" .. i)

		self._playerItems[i] = {
			headGo = goutil.findChild(go, "head"),
			roleCon = goutil.findChild(self._ui3dCamGo, "role" .. i),
			houseownerTagGo = goutil.findChild(go, "houseownerTag"),
			readyGo = goutil.findChild(go, "ready"),
			bubbleGo = goutil.findChild(go, "bubble"),
			txtBubble = goutil.findChildTextComponent(go, "bubble/txt"),
			btnOp = Framework.ButtonAdapter.GetFrom(go, "btnOp"),
			btnInvate = Framework.ButtonAdapter.GetFrom(go, "btnInvate"),
			btnKickout = Framework.ButtonAdapter.GetFrom(go, "btnKickout"),
			txtLv = goutil.findChildTextComponent(go, "txtLv"),
			txtName = goutil.findChildTextComponent(go, "txtName"),
			txtArea = goutil.findChildTextComponent(go, "txtArea"),
			invatingGo = goutil.findChild(go, "invating"),
			nameBgGo = goutil.findChild(go, "nameBg")
		}

		if i == 1 then
			goutil.setActive(self._playerItems[i].btnInvate.gameObject, false)
			goutil.setActive(self._playerItems[i].btnKickout.gameObject, false)
			goutil.setActive(self._playerItems[i].btnOp.gameObject, false)
			goutil.setActive(self._playerItems[i].btnOp.gameObject, false)
			goutil.setActive(self._playerItems[i].invatingGo, false)
			goutil.setActive(self._playerItems[i].nameBgGo, false)
		end
	end
end

function PkroomView:onExit()
	PkroomView.super.onExit(self)
	NewChatController.instance:setShowTeamChannel(nil)
	GlobalModel.instance:visibleSceneHUDs(true)
	self._ui3dCamGo.transform:SetParent(self.mainGO.transform)
	removetimer(self._hideChatBubble, self)

	for k, data in pairs(self._roleData) do
		data.avatar:removeListener(AvatarNotify.OnAvatarLoaded, self._onAvatarLoaded)
		AvatarsMgrNew.instance:removeAvatar(data.avatar)
	end

	self._roleData = {}

	TraincampqiecuoModel.instance:clearInvateId()
	ViewMgr.instance:close(ViewName.chat)
end

function PkroomView:onEnter()
	PkroomView.super.onEnter(self)
	UIStateManager.instance:popByName(ViewName.chat)
	NewChatController.instance:setShowTeamChannel(true)
	self._ui3dCamGo.transform:SetParent(nil)
	GlobalModel.instance:visibleSceneHUDs(false)
	self.addGEvent(self, TrainCampQieCuoAgent.TC_NotifyTeamChangeRes, self._onTeamChange, self)
	self.addGEvent(self, TrainCampQieCuoAgent.TC_NotifyReadyRes, self._onRedayStateChange, self)
	self.addGEvent(self, TrainCampQieCuoAgent.TC_NotifyStartRes, self.close, self)
	self.addGEvent(self, TrainCampQieCuoAgent.TC_NotifyBeKickRes, self._onBeKickRes, self)
	self.addGEvent(self, TrainCampQieCuoAgent.TC_NotifyRefuseInviteRes, self._onRefuse, self)
	self.addGEvent(self, TrainCampQieCuoAgent.TC_NotifyCancelReadyRes, self._onRedayStateChange, self)
	self.addGEvent(self, TrainCampQieCuoAgent.TC_NotifyBack2ReformRes, self._onTeamChange, self)
	self.addGEvent(self, GlobalNotify.LanternTriggerInfo, self._onLanternTriggerInfo, self)

	local params = self:getOpenParam() or {}

	self._isFirstEnterRoom = params[1]

	goutil.setActive(self._chatPanelGo, false)

	self._chatCd = 5
	self._lastSendChatTime = 0
	self._kickoutState = false
	self._playBubbleList = {}
	self._roleData = {}
	self._txtBtnStart.text = "准备"

	self:_onTeamChange()
	self:_setCommonAttrState()
	settimer(1, self._hideChatBubble, self, true)
	self:_sendReformIn()
end

function PkroomView:_onClickbtnClose()
	TrainCampQieCuoAgent.instance:sendPM_TC_LeaveTeamReq()
	self:close()
end

function PkroomView:_onClickbtnStart()
	if self._isMyRoom then
		local playerIds = TraincampqiecuoModel.instance:getPkRoomPlayerIds()

		if not TraincampqiecuoModel.instance:isReady(playerIds[2]) then
			FloatWordMgr.instance:show("对方未准备")

			return
		end
	end

	local ready = TraincampqiecuoModel.instance:isReady(RoleModel.instance:getUserId())

	if ready then
		TrainCampQieCuoAgent.instance:sendPM_TC_CancelReadyReq()

		return
	end

	TrainCampQieCuoAgent.instance:sendPM_TC_ReadyReq()
end

function PkroomView:_onClickChat()
	ViewMgr.instance:open(ViewName.chat, GameEnum.ChatChannel.Team)
end

function PkroomView:_onClickbtnInvate()
	local data = TraincampqiecuoModel.instance:getPkRoomData()
	local playerIds = TraincampqiecuoModel.instance:getPkRoomPlayerIds()
	local player1 = TraincampqiecuoModel.instance:getNewAddPlayerData(playerIds[1])
	local power = player1 and player1.zdl
	local roomNameId = data.settings.teamNameId
	local teamId = data.teamId
	local teamCode = data.teamCode

	UIStateManager.instance:push(ViewName.PkinvatetoroomView, power, roomNameId, teamId, teamCode)
end

function PkroomView:_onClickbtnKickout()
	if self._otherUserId then
		TrainCampQieCuoAgent.instance:sendPM_TC_KickReq(self._otherUserId)
	end
end

function PkroomView:_onClickbtnOp()
	self._kickoutState = not self._kickoutState

	goutil.setActive(self._btnKickout.gameObject, self._kickoutState)
end

function PkroomView:_onClickbtnTip()
	TipsFacade.instance:openRulesView("pkroomview")
end

function PkroomView:_onCustomInputCallback(hover)
	if not hover then
		goutil.setActive(self._chatPanelGo, false)
	end
end

function PkroomView:_calPower()
	local playerIds = TraincampqiecuoModel.instance:getPkRoomPlayerIds()
	local player1 = TraincampqiecuoModel.instance:getNewAddPlayerData(playerIds[1])
	local player2 = TraincampqiecuoModel.instance:getNewAddPlayerData(playerIds[2])

	if player1 then
		self._txtMyPower.text = player1.zdl or "无"
	end

	if player2 then
		self._txtEnemyPower.text = player2.zdl or "无"
	end
end

function PkroomView:_setCommonAttrState()
	self._isOpenCommonAttr = TraincampqiecuoModel.instance:getPkRoomCommonAttrState()

	goutil.setActive(self._commonAttrSelectOnGo, self._isOpenCommonAttr)
	goutil.setActive(self._commonAttrSelectOffGo, not self._isOpenCommonAttr)
	self:_calPower()
end

function PkroomView:_setPlayerData(index, playerData)
	local item = self._playerItems[index]

	self:_setEmptyPlayer(index)
	self:_setInvateState(index, playerData)

	if not playerData then
		return
	end

	goutil.setActive(item.nameBgGo, true)
	self:_showRole(index, playerData.headInfo.userId)

	item.txtName.text = playerData.headInfo.userName
	item.txtLv.text = string.format("等级:%s", playerData.headInfo.playerLv)
	item.txtArea.text = playerData.headInfo.areaName

	local proxy = HeadItemController.instance:setHeadCellByInfo(item.headGo, playerData.headInfo)

	if proxy then
		proxy:setCallBack(function()
			FriendController.instance:showInfoView(playerData.headInfo.userId, item.headGo)
		end)
	end

	local isHouseowner = self._roomOwerUserId == playerData.headInfo.userId

	goutil.setActive(item.houseownerTagGo, isHouseowner)
	self:_setPlayerReadyState(index, playerData.headInfo.userId)
end

function PkroomView:_setPlayerReadyState(index, playerId)
	local item = self._playerItems[index]

	goutil.setActive(item.readyGo, false)

	if string.nilorempty(playerId) then
		return
	end

	local playerData = TraincampqiecuoModel.instance:getNewAddPlayerData(playerId)

	if not playerData then
		return
	end

	goutil.setActive(item.readyGo, TraincampqiecuoModel.instance:isReady(playerId))
end

function PkroomView:_setEmptyPlayer(index)
	local item = self._playerItems[index]

	item.txtName.text = ""
	item.txtLv.text = ""
	item.txtArea.text = ""
	item.txtBubble.text = ""

	HeadItemController.instance:resetHeadCell(item.headGo)
	goutil.setActive(item.houseownerTagGo, false)
	goutil.setActive(item.readyGo, false)
	goutil.setActive(item.bubbleGo, false)
	goutil.setActive(item.invatingGo, false)
	goutil.setActive(item.nameBgGo, false)

	local data = self._roleData[index]

	if data then
		data.avatar:removeListener(AvatarNotify.OnAvatarLoaded, self._onAvatarLoaded)
		AvatarsMgrNew.instance:removeAvatar(data.avatar)

		self._roleData[index] = nil
	end
end

function PkroomView:_setInvateState(index, playerData)
	local showInvate = false

	if playerData and TraincampqiecuoModel.instance:getBack2Reform() then
		local isIn = TraincampqiecuoModel.instance:isInBack2Reform(playerData.headInfo.userId)

		showInvate = not isIn
	end

	if not showInvate and index == 2 then
		local id = TraincampqiecuoModel.instance:getInvatingId()

		showInvate = checknumber(id) > 0
	end

	local item = self._playerItems[index]

	goutil.setActive(item.invatingGo, showInvate)
end

function PkroomView:_playChat(content, playerId)
	local isMe = RoleModel.instance:getUserId() == playerId
	local itemIndex = self._isMyRoom and (isMe and 1 or 2) or isMe and 2 or 1
	local item = self._playerItems[itemIndex]

	goutil.setActive(item.bubbleGo, true)

	item.txtBubble.text = content

	for i, v in ipairs(self._playBubbleList) do
		if v.playerId == playerId then
			v.time = ServerTime.now()

			return
		end
	end

	table.insert(self._playBubbleList, {
		go = item.bubbleGo,
		time = ServerTime.now(),
		playerId = playerId
	})
end

function PkroomView:_hideChatBubble(force)
	local len = #self._playBubbleList
	local time = ServerTime.now()

	for i = len, 1, -1 do
		local data = self._playBubbleList[i]

		if force then
			data.time = 0
		end

		if time > data.time + self._chatCd then
			goutil.setActive(data.go, false)
			table.remove(self._playBubbleList, i)
		end
	end
end

function PkroomView:_onTeamChange()
	local playerIds = TraincampqiecuoModel.instance:getPkRoomPlayerIds()

	self._pkRoomData = TraincampqiecuoModel.instance:getPkRoomData()
	self._isMyRoom = TraincampqiecuoModel.instance:isMyRoom()
	self._otherUserId = playerIds[2]
	self._roomOwerUserId = playerIds[1]

	goutil.setActive(self._btnInvate.gameObject, self._isMyRoom and not self._otherUserId)
	goutil.setActive(self._btnOp.gameObject, self._isMyRoom and self._otherUserId)

	self._kickoutState = false

	goutil.setActive(self._btnKickout.gameObject, false)
	self:_showPlayers()
	self:_calPower()
	self:_hideChatBubble(true)
	self:_onRedayStateChange()
end

function PkroomView:_showPlayers()
	local playerIds = TraincampqiecuoModel.instance:getPkRoomPlayerIds()
	local player1 = TraincampqiecuoModel.instance:getNewAddPlayerData(playerIds[1])
	local player2 = TraincampqiecuoModel.instance:getNewAddPlayerData(playerIds[2])

	self:_setPlayerData(1, player1)
	self:_setPlayerData(2, player2)
end

function PkroomView:_showRole(index, userId)
	local item = self._playerItems[index]
	local data = self._roleData[index]
	local newAddData = TraincampqiecuoModel.instance:getNewAddPlayerData(userId)

	if not newAddData then
		return
	end

	if not data then
		data = {
			avatar = AvatarsMgrNew.instance:getAvatarByType(AvatarCreateType.Player)
		}
		data.avatar.useType = AvatarUseType.Scene

		data.avatar:setParent(item.roleCon.transform)
		data.avatar:setLayer(SceneLayer.UI3D_Value)
		data.avatar:addListener(AvatarNotify.OnAvatarLoaded, self._onAvatarLoaded, self)

		self._roleData[index] = data
	end

	local avatarMo = DressModel.instance:getAvatarMoByGrCosAndMount(newAddData.gender, newAddData.dresses)

	data.avatar:updateByMo(avatarMo)
end

function PkroomView:_onAvatarLoaded(avatar)
	local animator = avatar.animatorCtrl:getAnimator()

	if animator then
		animator:SetBool("ui", false)
	end
end

function PkroomView:_onBeKickRes()
	UIStateManager.instance:push(ViewName.PkmainView)
	self:close()
end

function PkroomView:_onRedayStateChange()
	local playerIds = TraincampqiecuoModel.instance:getPkRoomPlayerIds()
	local player1 = playerIds[1]
	local player2 = playerIds[2]

	self:_setPlayerReadyState(1, player1)
	self:_setPlayerReadyState(2, player2)

	self._txtBtnStart.text = self._isMyRoom and "开始" or TraincampqiecuoModel.instance:isReady(player2) and "取消准备" or "准备"
end

function PkroomView:_onRefuse()
	self:_setPlayerWatingState()
end

function PkroomView:_setPlayerWatingState()
	local item = self._playerItems[2]

	goutil.setActive(item.invatingGo, false)
end

function PkroomView:_sendReformIn()
	if not self._isFirstEnterRoom then
		TrainCampQieCuoAgent.instance:sendPM_TC_ReformInReq()
	end
end

function PkroomView:_onLanternTriggerInfo(msg)
	if msg and #msg > 0 then
		for _, v in ipairs(msg) do
			if v.channelType ~= GameEnum.ChatChannel.Team or v.msgType ~= GameEnum.ChatType.Word then
				return
			end

			local playerIds = TraincampqiecuoModel.instance:getPkRoomPlayerIds()

			if v.senderId == playerIds[1] or v.senderId == playerIds[2] then
				self:_playChat(v.content, v.senderId)
			end

			break
		end
	end
end

return PkroomView
