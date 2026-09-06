-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pk/view/PkinvatetoroomView.lua

module("logic.extensions.pk.view.PkinvatetoroomView", package.seeall)

local PkinvatetoroomView = class("PkinvatetoroomView", ViewComponent)

function PkinvatetoroomView:ctor()
	PkinvatetoroomView.super.ctor(self)
end

function PkinvatetoroomView:unbindEvents()
	PkinvatetoroomView.super.unbindEvents(self)
	self._btnWorld:RemoveClickListener()
	self._btnClose:RemoveClickListener()
	self._btnFamily:RemoveClickListener()
	self._btnFriend:RemoveClickListener()
end

function PkinvatetoroomView:bindEvents()
	PkinvatetoroomView.super.bindEvents(self)
	self._btnWorld:AddClickListener(self._onClickbtnWorld, self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
	self._btnFamily:AddClickListener(self._onClickbtnFamily, self)
	self._btnFriend:AddClickListener(self._onClickbtnFriend, self)
end

function PkinvatetoroomView:buildUI()
	PkinvatetoroomView.super.buildUI(self)

	self._btnWorld = self:getBtn("world/btn")
	self._btnClose = self:getBtn("btnClose")
	self._btnFamily = self:getBtn("family/btn")
	self._btnFriend = self:getBtn("friend/btn")
	self._all = self:getGo("world")
	self._txtContent = self:getTxt("txtContent")
end

function PkinvatetoroomView:onExit()
	PkinvatetoroomView.super.onExit(self)
end

function PkinvatetoroomView:onEnter()
	PkinvatetoroomView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.FriendSelected, self._onFriendSelected, self)

	self._receiveId = nil

	local params = self:getOpenParam()
	local power = params[1]
	local roomNameId = params[2]
	local teamId = params[3]
	local teamCode = params[4]

	self._msgType = GameEnum.ChatType.System

	local cfg = ChatConfig.instance:getSystemMsgT(63)
	local content = cfg.template

	content = string.gsub(content, "{power}", power)
	content = string.gsub(content, "{roomName}", TraincampqiecuoConfig.instance:getRoomName(roomNameId))
	self._txtContent.text = content

	local dataT = {
		tpId = 63,
		params = {
			power = power,
			roomName = TraincampqiecuoConfig.instance:getRoomName(roomNameId),
			teamId = teamId,
			teamCode = teamCode,
			teamNameId = roomNameId
		}
	}

	self._content = GameUtil.jsonToString(dataT)

	self:_updateChannel(self._all, GameEnum.ChatChannel.All)
end

function PkinvatetoroomView:_onClickbtnClose()
	self:close()
end

function PkinvatetoroomView:_onClickbtnWorld()
	local channel = GameEnum.ChatChannel.All

	self:_checkAndSend(channel)
end

function PkinvatetoroomView:_onClickbtnFamily()
	if FamilyController.instance:checkFamilyOpen(true) then
		self:sendMsg(GameEnum.ChatChannel.League)
	end
end

function PkinvatetoroomView:_onClickbtnFriend()
	UIStateManager.instance:open(ViewName.FriendSelect, self._shareType, 1)
end

function PkinvatetoroomView:_checkAndSend(channel)
	local cfg = ChatConfig.instance:getSendCfg(channel)

	if cfg and not string.nilorempty(cfg.sendDecMaterial) then
		local matType, matId, matNum = MaterialMgr.getMatParams(cfg.sendDecMaterial)

		if matNum > MaterialModel.instance:getMaterialsNumber(matType, matId) then
			FloatWordMgr.instance:show(langPara("%s数量不够了，到商城补给一下吧！", MaterialMgr.getMaterialsName(matType, matId)))

			return
		end
	end

	self:sendMsg(channel)
end

function PkinvatetoroomView:sendMsg(channel)
	ChatAgent.instance:sendSendMsgReq(channel, self._msgType, self._content, self._receiveId, nil)
	self:close()
end

function PkinvatetoroomView:_updateChannel(go, channel)
	local cfg = ChatConfig.instance:getSendCfg(channel)
	local imgIcon = goutil.findChild(go, "myNum/imgIcon")
	local txtNum = goutil.findChildTextComponent(go, "myNum/txtNum")

	if cfg then
		local matType, matId, matNum = unpack(string.splitToNumber(cfg.sendDecMaterial, ":"))

		MaterialMgr.setIcon(imgIcon, matType, matId)

		txtNum.text = MaterialModel.instance:getMaterialsNumber(matType, matId)
	end
end

function PkinvatetoroomView:_onFriendSelected(playerIds)
	if playerIds and playerIds[1] then
		self._receiveId = playerIds[1]

		self:_checkAndSend(GameEnum.ChatChannel.Private)
	end
end

return PkinvatetoroomView
