-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mainui/view/MainTopGoldItem.lua

module("logic.extensions.mainui.MainTopGoldItem", package.seeall)

local MainTopGoldItem = class("MainTopGoldItem")

function MainTopGoldItem.AddOnce(go)
	return GameUtil.AddLuaOnce(go, MainTopGoldItem)
end

function MainTopGoldItem.Remove(go)
	local obj = GameUtil.GetLua(go, MainTopGoldItem)

	if obj ~= nil then
		obj:dispose()
	end

	GameUtil.RemoveLua(go, MainTopGoldItem)
end

function MainTopGoldItem:ctor(go)
	self.mainGO = go.gameObject
	self.isGray = false

	self:buildUI()
end

function MainTopGoldItem:dispose()
	self:unbindEvent()
end

function MainTopGoldItem:unbindEvent()
	GameUtil.asBtn(self._Btn_Add):RemoveClickListener()
	self._addRaycast:RemoveClickListener()
	GameUtil.asBtn(self._Nego_Icon):RemoveClickListener()
end

function MainTopGoldItem:bindEvent()
	GameUtil.asBtn(self._Btn_Add):AddClickListener(self._OnClickBtnAdd, self)
	self._addRaycast:AddClickListener(self._OnClickBtnAdd, self)
	GameUtil.asBtn(self._Nego_Icon):AddClickListener(self._onClickBtnIcon, self)
end

function MainTopGoldItem:buildUI()
	self._coinGo = self.mainGO
	self._Nego_Icon = goutil.findChild(self.mainGO, "ImgC_Icon")
	self._TxtC_Num = goutil.findChild(self.mainGO, "TxtC_Num"):GetComponent("Text")
	self._Btn_Add = goutil.findChild(self.mainGO, "Btn_Add")
	self._addRaycast = GameUtil.asBtn(goutil.findChild(self.mainGO, "addRaycast"))
end

function MainTopGoldItem:setData(index, typeId, txt, spriteType, iconUrl, addBtnActive, callBack, callbackOnClickItemIcon)
	self.typeId = typeId

	self:unbindEvent()
	self:bindEvent()
	self:setItemText(txt)
	self:setItemIcon(spriteType, iconUrl)
	self:setAddBtnActive(addBtnActive)
	self:setClickCall(callBack)
	self:setClickItemIconCall(callbackOnClickItemIcon)
	self:setPosition(index)
end

function MainTopGoldItem:OnDestroy()
	self:dispose()
end

function MainTopGoldItem:_OnClickBtnAdd()
	if self.callBack then
		self.callBack()
	end
end

function MainTopGoldItem:_onClickBtnIcon()
	if self.callbackItemIcon then
		self.callbackItemIcon()
	end
end

function MainTopGoldItem:setItemText(str)
	self._TxtC_Num.text = str
end

function MainTopGoldItem:setItemIcon(spriteType, iconUrl)
	uGuiUtil.setSpriteToImage(self._Nego_Icon, spriteType, iconUrl)
end

function MainTopGoldItem:setAddBtnActive(bool)
	GameUtil.SetActive(self._Btn_Add, bool)
end

function MainTopGoldItem:setClickCall(callBack)
	self.callBack = callBack
end

function MainTopGoldItem:setClickItemIconCall(callback)
	self.callbackItemIcon = callback
end

function MainTopGoldItem:setPosition(index)
	GameUtil.setLocalPos(self.mainGO, -200 * (index - 1) + -89, 0, 0)
end

function MainTopGoldItem:setSkin(skinId)
	local change = self._coinGo:GetComponent("UIImageSpriteChange")

	change:SetState(skinId - 1)
end

return MainTopGoldItem
