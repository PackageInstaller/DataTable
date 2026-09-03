-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/friendPvp/view/FriendPvpInvitePopWidget.lua

FriendPvpInvitePopWidget = class("FriendPvpInvitePopWidget", BaseWidget, _M)

FriendPvpInvitePopWidget:has("_friendPvpSystem", {
	is = "r"
}):injectWith("FriendPvpSystem")

function FriendPvpInvitePopWidget:initialize(closeDelegate)
	local view = ccui.Layout:create()

	view:setContentSize(300, 200)
	view:setTouchEnabled(false)

	local node = cc.CSLoader:createNode("asset/ui/FriendPvpInviteTips.csb")

	node:addTo(view)
	node:setName("main")
	node:setPosition(cc.p(0, 0))
	super.initialize(self, view)

	self._closeDelegate = closeDelegate
end

function FriendPvpInvitePopWidget:dispose()
	self._friendPvpSystem:delReceiveDataByRid(self._data.id)

	if self._closeDelegate then
		self._closeDelegate()
	end

	super.dispose(self)
end

function FriendPvpInvitePopWidget:onInit()
	self._main = self:getView():getChildByName("main")
	self._refuseBtn = self._main:getChildByName("btn_refuse")
	self._agreeBtn = self._main:getChildByName("btn_agree")
	self._checkBox = self._main:getChildByName("CheckBox")

	local function agreeFunc()
		self:onClickAgree()
	end

	mapButtonHandlerClick(nil, self._agreeBtn:getChildByName("touchPanel"), {
		ignoreClickAudio = true,
		func = agreeFunc
	})

	local function refuseFunc()
		self:onClickRefuse()
	end

	mapButtonHandlerClick(nil, self._refuseBtn:getChildByName("touchPanel"), {
		ignoreClickAudio = true,
		func = refuseFunc
	})
end

function FriendPvpInvitePopWidget:initView(data)
	self:onInit()

	self._data = data
	self._isScreen = 1

	self:setupView()
end

function FriendPvpInvitePopWidget:setupView()
	local nameText = self._main:getChildByName("guestName")

	nameText:setString(self._data.nickName)

	local combatText = self._main:getChildByName("combat")

	combatText:setString(self._data.combat)

	local headIcon = self._main:getChildByName("head")
	local playerHead = IconFactory:createPlayerIcon({
		frameStyle = 2,
		id = self._data.headImage,
		size = cc.size(76, 76)
	})

	playerHead:setScale(0.87)
	playerHead:addTo(headIcon):center(headIcon:getContentSize())
	self._checkBox:setTouchEnabled(true)
	self._checkBox:addTouchEventListener(function(sender, eventType)
		self:onClickCheckBox(sender, eventType)
	end)
	self._checkBox:setSelected(true)

	local time = 300
	local checkBoxText = self._checkBox:getChildByName("Text_desc")

	checkBoxText:setString(Strings:get("Friend_Pvp_Invite_Tips3", {
		time = time / 60
	}))
end

function FriendPvpInvitePopWidget:onClickClose()
	self._friendPvpSystem:requestRefuseInvitation(self._data.id, self._isScreen, function()
		return
	end)
	self:close()
end

function FriendPvpInvitePopWidget:onClickAgree()
	self._friendPvpSystem:requestAcceptInvitation(self._data.id, function(response)
		self:close()
	end)
end

function FriendPvpInvitePopWidget:onClickRefuse()
	self._friendPvpSystem:requestRefuseInvitation(self._data.id, self._isScreen, function()
		self:close()
	end)
end

function FriendPvpInvitePopWidget:close()
	if checkDependInstance(self) and self._view then
		self:getView():removeFromParent(true)
		self:dispose()
	end
end

function FriendPvpInvitePopWidget:onClickCheckBox(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		local selectImage = self._checkBox:getChildByName("select")

		if sender:isSelected() then
			self._isScreen = 1

			selectImage:setVisible(true)
		else
			self._isScreen = 0

			selectImage:setVisible(false)
		end
	end
end
