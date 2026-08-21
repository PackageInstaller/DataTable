-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/friend/view/FriendBaseItemCell.lua

module("logic.extensions.friend.view.FriendBaseItemCell", package.seeall)

local M = class("FriendBaseItemCell")

function M:ctor(go)
	self._go = go
	self._registry = ViewElementsRegistry.New(go)

	self:_buildUI()
end

function M:_buildUI()
	local headLockGo = self._registry:getGo("1&head_item_-765526646")

	headLockGo:SetActive(false)

	self._imgDressUp = self._registry:getImage("friend_item_1262080593")
	self._imgHeadIcon = self._registry:getImage("1&head_item_1770823988")
	self._imgHeadIconGray = self._registry:getImage("1&head_item_2073113669")
	self._txtName = self._registry:getText("friend_item_89180480")
	self._txtRemark = self._registry:getText("friend_item_1691348705")
	self._txtSignature = self._registry:getText("friend_item_-1723372043")
	self._txtLv = self._registry:getText("friend_item_1650482762")
	self._txtType1 = self._registry:getText("friend_item_26863056")
	self._txtType2 = self._registry:getText("friend_item_591777019")
	self._btnChat = self._registry:getBtn("friend_item_1716157671")
	self._btnRemove = self._registry:getBtn("friend_item_1968149752")
	self._requestGo = self._registry:getGo("friend_item_1742869968")
	self._btnAgree = self._registry:getBtn("friend_item_28732711")
	self._btnRefuse = self._registry:getBtn("friend_item_383282187")
	self._btnAddFriends = self._registry:getBtn("friend_item_641472657")
	self._addedSignGo = self._registry:getGo("friend_item_131447158")
	self._btnClick = self._registry:getBtn("friend_item_347941739")
	self._outLineGo = self._registry:getGo("1&head_item_864381482")

	self:_bindEvents()
end

function M:_bindEvents()
	self._btnChat:AddClickListener(self._onClickBtnChat, self)
	self._btnRemove:AddClickListener(self._onClickBtnRemove, self)
	self._btnAgree:AddClickListener(self._onClickBtnAgree, self)
	self._btnRefuse:AddClickListener(self._onClickBtnRefuse, self)
	self._btnAddFriends:AddClickListener(self._onClickBtnAddFriends, self)
	self._btnClick:AddClickListener(self._onClickBtnClick, self)
end

function M:_unbindEvents()
	self._btnChat:RemoveClickListener()
	self._btnRemove:RemoveClickListener()
	self._btnAgree:RemoveClickListener()
	self._btnRefuse:RemoveClickListener()
	self._btnAddFriends:RemoveClickListener()
	self._btnClick:RemoveClickListener()
end

function M:updateData(data)
	self._data = data

	local itemCo = BackpackConfig.instance:getItemInfoByItemId(data:getPortrait())

	IconLoader.setSprite(self._imgHeadIcon, IconType.HeadIcon, itemCo.icon)
	IconLoader.setSprite(self._imgHeadIconGray, IconType.HeadIcon, itemCo.icon)

	self._txtName.text = data:getNickName()

	self._txtName.gameObject:SetActive(string.nilorempty(data:getAlias()))

	self._txtRemark.text = data:getAlias()

	self._txtRemark.gameObject:SetActive(not string.nilorempty(data:getAlias()))

	self._txtLv.text = string.format("Lv.%d", data:getLv())

	local signDef = ConstConfig.instance:getStrValueByKey("DefaultSign")

	if signDef == data:getSignature() then
		self._txtSignature.text = ""
	else
		self._txtSignature.text = StringUtil.getShortName(data:getSignature(), 32) or ""
	end

	local lastLoginTime = data:getLastLoginTime()

	goutil.setActive(self._txtType1.transform.parent.gameObject, lastLoginTime == 0)
	goutil.setActive(self._txtType2.transform.parent.gameObject, lastLoginTime > 0)
	goutil.setActive(self._imgHeadIcon.gameObject, lastLoginTime == 0)
	goutil.setActive(self._imgHeadIconGray.gameObject, lastLoginTime > 0)
	goutil.setActive(self._outLineGo, lastLoginTime > 0)

	if lastLoginTime > 0 then
		local curTime = ServerTime.now() * 1000
		local offset = curTime - lastLoginTime
		local pastTimeStr = TextFormatter.formatFullPastTime(offset / 1000)

		if string.nilorempty(pastTimeStr) then
			pastTimeStr = lang("tip_one_minute_before")
		end

		self._txtType2.text = pastTimeStr
	end

	local visitCardCO = BackpackConfig.instance:getItemInfoByItemId(data:getCard())

	if visitCardCO then
		IconLoader.setSprite(self._imgDressUp, IconType.PlayerCardSpecial, visitCardCO.icon)
	end
end

function M:OnDestroy()
	self:_destroyUI()
end

function M:_destroyUI()
	self:_unbindEvents()
end

function M:_onClickBtnChat()
	return
end

function M:_onClickBtnRemove()
	return
end

function M:_onClickBtnAgree()
	return
end

function M:_onClickBtnRefuse()
	return
end

function M:_onClickBtnAddFriends()
	return
end

function M:_onClickBtnClick()
	return
end

return M
