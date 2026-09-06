-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/friend/view/ItemFriend.lua

module("logic.extensions.friend.view.ItemFriend", package.seeall)

local ItemFriend = class("ItemFriend")
local LuaComponentContainer = Framework.LuaComponentContainer

function ItemFriend.AddOnce(go)
	local component = ItemFriend.Get(go)

	component = component or LuaComponentContainer.Add(go, ItemFriend)

	return component
end

function ItemFriend.Remove(go)
	LuaComponentContainer.Remove(go, ItemFriend)
end

function ItemFriend.Get(go)
	return (LuaComponentContainer.Get(go, ItemFriend))
end

function ItemFriend:ctor(target)
	self._target = target
	self._Nego_Icon = goutil.findChild(self._target, "Nego_Icon")
	self._ImgChange_Icon = goutil.findChild(self._target, "Nego_Icon/ImgC_Icon")
	self._TxtC_Name = goutil.findChildComponent(self._target, "TxtC_Name", "Text")
	self._Nego_Selected = goutil.findChild(self._target, "ImgC_Select")
	self._Btn_Heart = Framework.ButtonAdapter.GetFrom(self._target.gameObject, "Btn_Heart")
	self._Btn_Icon = Framework.ButtonAdapter.GetFrom(self._target.gameObject, "Nego_Icon/ImgC_Icon")
	self._Btn_Info = Framework.ButtonAdapter.GetFrom(self._target.gameObject, "Btn_Info")
	self._txtZdl = goutil.findChildTextComponent(self._target, "ImgZdl/TxtZdl")
	self._Btn_Self = Framework.ButtonAdapter.Get(self._target.gameObject)
	self._friendIconObj = goutil.findChild(self._target, "ImgFriend")
	self._onlineIcon = goutil.findChild(self._target, "ImgOnline"):GetComponent("UIImageSpriteChange")
	self._redDotObj = goutil.findChild(self._target, "ImgRedDot")
	self._redDotTxt = goutil.findChildTextComponent(self._redDotObj, "TxtRed")

	goutil.setActive(self._Btn_Info.gameObject, false)
	self:bindEvents()
end

function ItemFriend:bindEvents()
	self._Btn_Heart:AddClickListener(self._onClickHeart, self)
	self._Btn_Icon:AddClickListener(function()
		self:_onClickIcon(self._Btn_Icon.gameObject)
	end, self)
	self._Btn_Info:AddClickListener(function()
		self:_onClickIcon(self._Btn_Info.gameObject)
	end, self)
	self._Btn_Self:AddClickListener(self._onClickSelf, self)
	GlobalDispatcher:addListener(GlobalNotify.MsgRead, self._refreshDot, self)
	GlobalDispatcher:addListener(GlobalNotify.OnMsgAdd, self._refreshDot, self)
end

function ItemFriend:onSetMo(mo)
	self._mo = mo

	HeadItemController.instance:setHeadCell(self._ImgChange_Icon, mo.headIconId, mo.headFrameId, mo.vipLv)

	self._TxtC_Name.text = self._mo:getValue("name")
	self._txtZdl.text = self._mo._zdl

	self._friendIconObj:SetActive(self._mo:Group() == GameEnum.FriendGroup.Friend)
	uGuiUtil.setGoGrayState(self._Nego_Icon, not self._mo:getIsOnline())
	uGuiUtil.setGoGrayState(self._TxtC_Name, not self._mo:getIsOnline())

	if self._mo:getIsOnline() then
		self._onlineIcon:SetState(0)
	else
		self._onlineIcon:SetState(1)
	end

	self:_refreshDot()
	self:setSelected()
end

function ItemFriend:_refreshDot()
	local newMsgCount = NewChatModel.instance:getNotReadMsgCount(GameEnum.ChatChannel.Private, self._mo:getValue("id"))

	self._redDotObj:SetActive(newMsgCount > 0)

	self._redDotTxt.text = math.min(newMsgCount, 99)
end

function ItemFriend:OnDestroy()
	self._Btn_Heart:RemoveClickListener()
	self._Btn_Icon:RemoveClickListener()
	self._Btn_Info:RemoveClickListener()
	self._Btn_Self:RemoveClickListener()
	GlobalDispatcher:removeListener(GlobalNotify.MsgRead, self._refreshDot, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnMsgAdd, self._refreshDot, self)
end

function ItemFriend:_onClickHeart()
	return
end

function ItemFriend:_onClickIcon(go)
	UIStateManager.instance:open(ViewName.playerInfo, self._mo.simpleInfo, self._mo:Group(), go)
end

function ItemFriend:_onClickSelf()
	FriendController.instance:onClickItemFriend(self._mo:getValue("id"))
	self:setSelected()
end

function ItemFriend:setSelected()
	local selected = self._mo:getValue("id") == FriendController.instance:getCurSelectedId()

	goutil.setActive(self._Nego_Selected, selected)
end

return ItemFriend
