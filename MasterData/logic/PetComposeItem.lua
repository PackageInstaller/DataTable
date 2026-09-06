-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petcompose/view/PetComposeItem.lua

module("logic.extensions.petcompose.view.PetComposeItem", package.seeall)

local PetComposeItem = class("PetComposeItem")
local LuaComponentContainer = Framework.LuaComponentContainer

function PetComposeItem:ctor(go)
	self.mainGO = go.gameObject

	self:buildUI()
end

function PetComposeItem.AddOnce(go)
	local component = LuaComponentContainer.Get(go, PetComposeItem)

	component = component or LuaComponentContainer.Add(go, PetComposeItem)

	return component
end

function PetComposeItem:buildUI()
	self._addGo = goutil.findChild(self.mainGO, "add")
	self._iconCon = goutil.findChild(self.mainGO, "icon")
	self._btn = GameUtil.asBtn(goutil.findChild(self.mainGO, "Button"))
	self._tween = self.mainGO:GetComponent(UnityTweensType.TweenPosition)

	self._tween:AddListener(self._tweenFinish, self)
end

function PetComposeItem:onExit()
	self._btn:RemoveClickListener()
	MaterialMgr.resetAll(self._iconCon)
end

function PetComposeItem:onEnter()
	self._btn:AddClickListener(self._onClick, self)
end

function PetComposeItem:_onClick()
	self._callBack(self._targetObj, (self._data or nil) and (self._data.petId or false))
end

function PetComposeItem:clear()
	self._data = false

	MaterialMgr.resetAll(self._iconCon)
	goutil.setActive(self._addGo, true)
	goutil.setActive(self._iconCon, false)
end

function PetComposeItem:setData(data, callBack, targetObj)
	self._callBack = callBack
	self._targetObj = targetObj
	self._data = data

	if not data then
		self:clear()
	else
		goutil.setActive(self._iconCon, true)
		MaterialMgr.setCellByMo(data, self._iconCon)
	end
end

function PetComposeItem:setVisible(bool)
	goutil.setActive(self.mainGO, bool)
end

function PetComposeItem:doTweenTo(target, finishCall)
	self.finishCall = finishCall
	self._tween.from = self.mainGO.transform.localPosition
	self._tween.to = target
	self._tween.time = 0.3

	self._tween:Begin()
end

function PetComposeItem:_tweenFinish()
	self.finishCall()
end

return PetComposeItem
