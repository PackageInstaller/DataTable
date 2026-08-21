-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tooltips/component/ToolTipsAirWorkPlayerInfosViewComp.lua

module("logic.extensions.tooltips.component.ToolTipsAirWorkPlayerInfosViewComp", package.seeall)

local M = class("ToolTipsAirWorkPlayerInfosViewComp", ViewComponent)

function M:buildUI()
	self._imgPlayerMask = self:getImage("air_workshop_player_info_tips_-547575588")
	self._txtPlayerName = self:getUIComponent("air_workshop_player_info_tips_-2075754841", UIComponentType.Text)
	self._txtUID = self:getUIComponent("air_workshop_player_info_tips_-932522311", UIComponentType.Text)
	self._txtPlayerLv = self:getUIComponent("air_workshop_player_info_tips_-2115171579", UIComponentType.Text)
	self._btnMingPian = self:getBtn("air_workshop_player_info_tips_-88176056")
	self._btnChat = self:getBtn("air_workshop_player_info_tips_-2030637648")
	self._btnBeiZhu = self:getBtn("air_workshop_player_info_tips_245947602")
	self._btnAirWorkShop = self:getBtn("air_workshop_player_info_tips_1016291882")
	self._btnHeiMingDan = self:getBtn("air_workshop_player_info_tips_-978896662")
	self._btnDeleteFriend = self:getBtn("air_workshop_player_info_tips_1836281792")
	self._btnJuBao = self:getBtn("air_workshop_player_info_tips_578962301")
end

function M:destroyUI()
	self:_setEvent(false)
end

function M:bindEvents()
	self._btnMingPian:AddClickListener(self._onClickMingPian, self)
	self._btnChat:AddClickListener(self._onClickChat, self)
	self._btnBeiZhu:AddClickListener(self._onClickBeiZhu, self)
	self._btnAirWorkShop:AddClickListener(self._onClickAirWorkShop, self)
	self._btnHeiMingDan:AddClickListener(self._onClickHeiMingDan, self)
	self._btnDeleteFriend:AddClickListener(self._onClickDeleteFriend, self)
	self._btnJuBao:AddClickListener(self._onClickJuBao, self)
end

function M:unbindEvents()
	self._btnMingPian:RemoveClickListener()
	self._btnChat:RemoveClickListener()
	self._btnBeiZhu:RemoveClickListener()
	self._btnAirWorkShop:RemoveClickListener()
	self._btnHeiMingDan:RemoveClickListener()
	self._btnDeleteFriend:RemoveClickListener()
	self._btnJuBao:RemoveClickListener()
end

function M:onEnter()
	self:_setEvent(true)

	local info = self:getFirstParam()

	self._uid = info.uid
	self._isSelf = self._uid == PlayerModel.instance:getId()

	self:refreshView()
	self:refreshBtnShow()
end

function M:onExit()
	self:_setEvent(false)
end

function M:onExitFinished()
	return
end

function M:_setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(AirWorkShopEventType.ON_PERSONAL_PAGE_ENTER, self._handleOnPersonalPageEnter, self)
	else
		GlobalDispatcher:removeEventListener(AirWorkShopEventType.ON_PERSONAL_PAGE_ENTER, self._handleOnPersonalPageEnter, self)
	end
end

function M:_handleOnPersonalPageEnter(e, userId)
	self:close()
end

function M:refreshBtnShow()
	goutil.setActive(self._btnMingPian.gameObject, not self._isSelf and SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.DisplayCard, false))
	goutil.setActive(self._btnChat.gameObject, not self._isSelf and SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.Chat, false))
	goutil.setActive(self._btnBeiZhu.gameObject, not self._isSelf)

	local sysOpenAirWorkShop = AirWorkShopUtil.isSystemOpen(false)

	goutil.setActive(self._btnAirWorkShop.gameObject, sysOpenAirWorkShop)
	goutil.setActive(self._btnHeiMingDan.gameObject, not self._isSelf and SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.Friend, false))
	goutil.setActive(self._btnDeleteFriend.gameObject, not self._isSelf and SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.Friend, false))
	goutil.setActive(self._btnJuBao.gameObject, not self._isSelf)
end

function M:refreshView()
	local info = self:getFirstParam()

	self._txtPlayerName.text = info.nickName
	self._txtUID.text = info.uid
	self._txtPlayerLv.text = self:_formatLevel(info.playerLv)

	local portraitCO = BackpackConfig.instance:getItemInfoByItemId(info.portrait)

	if portraitCO then
		IconLoader.setSprite(self._imgPlayerMask, IconType.PlayerInfoMask, portraitCO.icon)
	end
end

function M:_formatLevel(level)
	local a = math.floor(level / 10)
	local b = level % 10

	return string.format("%s-%s", a, b)
end

function M:_onClickMingPian()
	if Astral.OSDef.isEditor then
		printWarn("点击名片：", self._uid, self._isSelf)
	end

	if not SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.DisplayCard, true) then
		return
	end

	PlayerAgent.instance:sendGetPlayerCardInfoRequest(self._uid)
	self:close()
end

function M:_onClickChat()
	if Astral.OSDef.isEditor then
		printWarn("点击聊天：", self._uid, self._isSelf)
	end

	if self._isSelf then
		return
	end

	if not SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.Chat, true) then
		return
	end

	local friendMo = self:_isFriend(self._uid, true)

	if not friendMo then
		self:close()

		return
	end

	local channelType = GameEnum.ChannelTypeEnum.Friend

	ChatMainFacade.instance:openChatMainView(channelType, self._uid)
	self:close()
end

function M:_onClickBeiZhu()
	if Astral.OSDef.isEditor then
		printWarn("点击添加备注：", self._uid, self._isSelf)
	end

	if self._isSelf then
		return
	end

	local friendMo = self:_isFriend(self._uid, true)

	if not friendMo then
		self:close()

		return
	end

	ViewMgr.instance:open(ViewName.FriendChangeAlias, friendMo)
	self:close()
end

function M:_onClickAirWorkShop()
	AirWorkShopUtil.openPersonalPage(self._uid, AirWorkShopEnum.PersonalPageType.Main)
	self:close()
end

function M:_onClickHeiMingDan()
	if Astral.OSDef.isEditor then
		printWarn("点击黑名单：", self._uid, self._isSelf)
	end

	if self._isSelf then
		return
	end

	if not SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.Friend, true) then
		return
	end

	local friendMo = self:_isFriend(self._uid, true)

	if not friendMo then
		self:close()

		return
	end

	if friendMo:getRelationShip() == GameEnum.RelationTypeEnum.Block then
		FloatWordMgr.instance:show(lang("tip_add_back_list"))
		self:close()

		return
	end

	local cur = FriendModel.instance:getUserCountByType(GameEnum.RelationTypeEnum.Block)
	local max = ConstConfig.instance:getNumValueByKey("MaxBlockNum")

	if max <= cur then
		FloatWordMgr.instance:show(lang("tip_back_list_full"))
		self:close()

		return
	end

	local function confirmCallback()
		FriendAgent.instance:sendBlockUserRequest(self._uid)
		self:close()
	end

	local name = friendMo:getNickName()
	local content

	if friendMo:getRelationShip() == GameEnum.RelationTypeEnum.Friend then
		content = string.format(lang("tip_add_back_list_relieve"), name, name)
	else
		content = string.format(lang("tip_add_back_list_not_receive"), name, name)
	end

	local dialog = Dialog.showMessage(lang("tip_title"), content)

	dialog:setConfirmListener(confirmCallback, self)
end

function M:_onClickDeleteFriend()
	if Astral.OSDef.isEditor then
		printWarn("点击删除好友：", self._uid, self._isSelf)
	end

	if self._isSelf then
		return
	end

	if not SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.Friend, true) then
		return
	end

	local friendMo = self:_isFriend(self._uid, true)

	if not friendMo then
		self:close()

		return
	end

	local function confirmCallback()
		FriendAgent.instance:sendRemoveFriendRequest(self._uid)
		self:close()
	end

	local name = friendMo:getNickName()
	local content = string.format(lang("tip_delete_friend"), name)
	local dialog = Dialog.showMessage(lang("tip_title"), content)

	dialog:setConfirmListener(confirmCallback, self)
end

function M:_onClickJuBao()
	if Astral.OSDef.isEditor then
		printWarn("点击举报：", self._uid, self._isSelf)
	end

	if self._isSelf then
		return
	end

	local data = {
		playerId = self._uid
	}

	ReportFacade.instance:openReportView(data)
	self:close()
end

function M:_onClickAddFriend()
	if Astral.OSDef.isEditor then
		printWarn("点击加好友：", self._uid, self._isSelf)
	end

	if self._isSelf then
		return
	end

	if not SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.Friend, true) then
		return
	end

	local friendMo = self:_isFriend(self._uid, false)

	if friendMo then
		return
	end

	if FriendModel.instance:getUser(GameEnum.RelationTypeEnum.Apply, self._uid) then
		return
	end

	local cur = FriendModel.instance:getUserCountByType(GameEnum.RelationTypeEnum.Friend)
	local max = ConstConfig.instance:getNumValueByKey("MaxFriendNum")

	if max <= cur then
		FloatWordMgr.instance:show(lang("tip_friend_full"))

		return
	end

	FriendAgent.instance:sendApplyFriendRequest(self._uid)
	self:close()
end

function M:_isFriend(uid, showToast)
	local friendMo = false

	if uid and uid ~= PlayerModel.instance:getId() then
		friendMo = FriendModel.instance:getUser(GameEnum.RelationTypeEnum.Friend, uid)

		if not friendMo and showToast then
			FloatWordMgr.instance:show(lang("tip_not_friend"))
		end
	end

	return friendMo
end

return M
