-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/friend/view/ItemFriendAdd.lua

module("logic.extensions.friend.view.ItemFriendAdd", package.seeall)

local LuaComponentContainer = Framework.LuaComponentContainer
local ItemFriendAdd = class("ItemFriendAdd")

function ItemFriendAdd.AddOnce(go)
	local component = ItemFriendAdd.Get(go)

	component = component or LuaComponentContainer.Add(go, ItemFriendAdd)

	return component
end

function ItemFriendAdd.Remove(go)
	LuaComponentContainer.Remove(go, ItemFriendAdd)
end

function ItemFriendAdd.Get(go)
	return (LuaComponentContainer.Get(go, ItemFriendAdd))
end

function ItemFriendAdd:ctor(target)
	self._target = target.gameObject
	self._curAnimName = nil
	self._targetAnimName = nil
	self._ImgC_Icon = goutil.findChild(self._target, "ImgC_Icon")
	self._TxtC_Name = goutil.findChildTextComponent(self._target, "TxtC_Name")
	self._areaGo = goutil.findChild(self._target, "TxtC_Name/area")
	self._txtArea = goutil.findChildTextComponent(self._target, "TxtC_Name/area/txt")
	self._zdlTxt = goutil.findChildTextComponent(self._target, "ImgZdl/TxtZdl")
	self._Btn_No = Framework.ButtonAdapter.GetFrom(self._target, "Btn_No")
	self._Btn_Yes = Framework.ButtonAdapter.GetFrom(self._target, "Btn_Yes")
	self._Btn_Add = Framework.ButtonAdapter.GetFrom(self._target, "Btn_Add")
	self._txtLevel = goutil.findChildTextComponent(self._target, "txtLevel")
	self._btnIcon = Framework.ButtonAdapter.GetFrom(self._target, "btnIcon")
	self._txtAdd = goutil.findChildTextComponent(self._Btn_Add.gameObject, "Text")

	self:bindEvents()
end

function ItemFriendAdd:bindEvents()
	self._Btn_Yes:AddClickListener(self._onClickAgree, self)
	self._Btn_No:AddClickListener(self._onClickIgnore, self)
	self._Btn_Add:AddClickListener(self._onClickAdd, self)
	self._btnIcon:AddClickListener(self._onClickIcon, self)
end

function ItemFriendAdd:_onClickIcon()
	if self._mo then
		FriendController.instance:showInfoView(self._mo.headInfo.userId, self._btnIcon.gameObject, true)
	end
end

function ItemFriendAdd:onSetMo(mo, applyOrAdd)
	self._mo = mo

	GameUtil.SetActive(self._areaGo, false)

	self._TxtC_Name.text = mo.headInfo.userName

	if not string.nilorempty(mo.headInfo.areaName) then
		GameUtil.SetActive(self._areaGo, true)

		self._txtArea.text = mo.headInfo.areaName
	end

	HeadItemController.instance:setHeadCellByInfo(self._ImgC_Icon, mo.headInfo)

	self._zdlTxt.text = mo.maxZdl
	self._txtLevel.text = ""

	self:_updateState(applyOrAdd)

	if FriendController.instance:isApplyed(mo.headInfo.userId) then
		uGuiUtil.setGoGrayState(self._Btn_Add, true)

		self._txtAdd.text = "已申请"
	else
		uGuiUtil.setGoGrayState(self._Btn_Add, false)

		self._txtAdd.text = "添加"
	end
end

function ItemFriendAdd:_updateState(applyOrAdd)
	self._Btn_Yes.btn.gameObject:SetActive(applyOrAdd)
	self._Btn_No.btn.gameObject:SetActive(applyOrAdd)
	self._Btn_Add.btn.gameObject:SetActive(not applyOrAdd)
end

function ItemFriendAdd:_onClickAgree()
	FriendController.instance:handleBuddyRequest(self._mo.headInfo.userId, true)
end

function ItemFriendAdd:_onClickIgnore()
	FriendController.instance:handleBuddyRequest(self._mo.headInfo.userId, false)
end

function ItemFriendAdd:_onClickAdd()
	local mo = FriendModel.instance:getFriendMo(self._mo.headInfo.userId)

	if mo ~= nil then
		if mo:IsBlacklist() then
			TipsFacade.instance:openCommonTips(lang("不能申请添加黑名单好友"))

			return nil
		elseif mo:IsFriend() then
			TipsFacade.instance:openCommonTips(lang("对方已经是你的好友"))

			return nil
		end
	end

	if FriendController.instance:isApplyed(self._mo.headInfo.userId) then
		TipsFacade.instance:openCommonTips(lang("已经申请过了"))
	else
		FriendController.instance:addFriend(self._mo.headInfo.userId)
	end
end

return ItemFriendAdd
