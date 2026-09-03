-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/club/view/ClubInfoTipMediator.lua

ClubInfoTipMediator = class("ClubInfoTipMediator", DmPopupViewMediator, _M)

ClubInfoTipMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
ClubInfoTipMediator:has("_clubSystem", {
	is = "r"
}):injectWith("ClubSystem")

local kBtnHandlers = {
	["main.btn_apply.button"] = {
		ignoreClickAudio = true,
		func = "onClickApply"
	},
	["main.btn_friend.button"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickChat"
	}
}

function ClubInfoTipMediator:initialize()
	super.initialize(self)
end

function ClubInfoTipMediator:dispose()
	super.dispose(self)
end

function ClubInfoTipMediator:userInject()
	return
end

function ClubInfoTipMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
	self:bindWidget("main.btn_apply", OneLevelMainButton, {
		ignoreAddKerning = true
	})
	self:bindWidget("main.btn_friend", OneLevelMainButton, {
		ignoreAddKerning = true
	})
end

function ClubInfoTipMediator:createBgWidget()
	local injector = self:getInjector()
	local bgNode = self:getView():getChildByFullName("main.bg")
	local widget = self:bindWidget(bgNode, PopupNormalWidget, {
		bg = "bg_popup_dark.png",
		btnHandler = {
			clickAudio = "Se_Click_Close_1",
			func = bind1(self.onCloseClicked, self)
		},
		title = Strings:get("Club_Text152"),
		bgSize = {
			width = 573,
			height = 498
		}
	})
end

function ClubInfoTipMediator:initWidget()
	self._mainPanel = self:getView():getChildByFullName("main")
	self._applyBtn = self._mainPanel:getChildByFullName("btn_apply.button")
	self._goChatBtn = self._mainPanel:getChildByFullName("btn_friend.button")
end

function ClubInfoTipMediator:enterWithData(data)
	self._data = data

	self:createBgWidget()
	self:initWidget()

	local iconPanel = self._mainPanel:getChildByFullName("iconpanel")

	iconPanel:removeAllChildren()

	local icon = IconFactory:createClubIcon({
		id = self._data:getClubHeadImg()
	})

	icon:addTo(iconPanel):center(iconPanel:getContentSize()):offset(0, -3)

	local nameLabel = self._mainPanel:getChildByFullName("clubnamelabel")

	nameLabel:setString(self._data:getClubName())

	local proprieterLabel = self._mainPanel:getChildByFullName("proprieter2label")

	proprieterLabel:setString(self._data:getPresidentName())

	local rankLabel = self._mainPanel:getChildByFullName("rank2label")

	rankLabel:setString(self._data:getRank())

	local idLabel = self._mainPanel:getChildByFullName("id2label")
	local clubId = self._data:getClubId()

	idLabel:setString(clubId)

	local numLabel = self._mainPanel:getChildByFullName("num2label")

	numLabel:setString(self._data:getPlayerCount() .. "/" .. self._data:getPlayerMax())

	local manifestoLabel = self._mainPanel:getChildByFullName("manifestolabel")

	manifestoLabel:setString(self._data:getAnnounce())

	local presidentId = self._data:getRid()

	if presidentId == self._developSystem:getPlayer():getRid() then
		self._goChatBtn:setVisible(false)
		self._applyBtn:setVisible(false)

		return
	end

	if clubId == self._clubSystem:getClubId() then
		self._applyBtn:setVisible(false)
		self._goChatBtn:getParent():setPositionX(570)
	end
end

function ClubInfoTipMediator:onCloseClicked(sender, eventType)
	self:close()
end

function ClubInfoTipMediator:onClickChat(sender, eventType)
	AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
	self:close()

	local friendSystem = self:getInjector():getInstance(FriendSystem)

	local function gotoFriendChat(response)
		local var_10_0 = {
			rid = self._data:getRid(),
			nickname = self._data:getPresidentName(),
			level = self._data:getLevel(),
			combat = self._data:getCombat(),
			headImage = self._data:getHeadId(),
			vip = self._data:getVipLevel(),
			online = self._data:getOnline() == ClubMemberOnLineState.kOnline,
			lastOfflineTime = self._data:getLastOfflineTime(),
			heroes = self._data:getHeroes(),
			slogan = self._data:getSlogan(),
			isFriend = response.isFriend
		}

		if response.isFriend == 1 then
			var_10_0.close = response.close or nil
		end

		var_10_0.block = response.block
		var_10_0.leadStageId = self._data:getLeadStageId()
		var_10_0.leadStageLevel = self._data:getLeadStageLevel()

		local data = var_10_0

		friendSystem:addRecentFriend(data)

		local data = {
			subTabType = 2,
			selectFriendIndex = 1,
			tabType = kFriendType.kRecent
		}

		friendSystem:tryEnter(data)
	end

	friendSystem:requestSimpleFriendInfo(self._data:getRid(), function(response)
		gotoFriendChat(response)
	end)
end

function ClubInfoTipMediator:onClickApply(sender, eventType)
	if self._data.isApply == 1 then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("ClubHasApplay_Text")
		}))
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)

		return
	end

	if self._clubSystem:getHasJoinClub() then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("ChatEnterClub_Text")
		}))
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)

		return
	end

	if self._clubSystem:getClubId() ~= self._data:getClubId() then
		AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
		self._clubSystem:requestApplyEnterClub(self._data:getClubId(), nil, function()
			self:dispatch(ShowTipEvent({
				tip = Strings:get("Club_Text172")
			}))
		end, true)
	end

	self:close()
end

function ClubInfoTipMediator:onClickOk(sender, eventType)
	self:close()
end
