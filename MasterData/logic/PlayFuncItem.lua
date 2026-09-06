-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/collection/view/PlayFuncItem.lua

module("logic.extensions.collection.view.PlayFuncItem", package.seeall)

local PlayFuncItem = class("PlayFuncItem")
local funcIdToRedpointID = {
	[19] = 10,
	[15] = 12,
	[14] = 11
}

function PlayFuncItem:ctor(go)
	self.mainGo = go
	self._imgIcon = goutil.findChildComponent(self.mainGo, "imgIcon", "UIImageSpriteChange")
	self._txtFuncName = goutil.findChildComponent(self.mainGo, "txtFuncName", "Text")
	self._txtOutPut = goutil.findChildComponent(self.mainGo, "txtOutPut", "Text")
	self._goLock = goutil.findChild(self.mainGo, "lock")
	self._txtLock = goutil.findChildComponent(self._goLock, "txtLock", "Text")
	self._btn = Framework.ButtonAdapter.Get(self.mainGo)

	self._btn:AddClickListener(self._onClickCell, self)

	self._redpoint = goutil.findChild(self.mainGo, "imgPoint")
	self._txtOutPut2 = goutil.findChildComponent(self.mainGo, "txtOutPut2", "Text")
end

function PlayFuncItem:onSetMo(data)
	self._funcId = checknumber(data)
	self._cfg = FuncOpenConfig.instance:getFunctionOpenById(self._funcId)

	if self._cfg ~= nil then
		self._imgIcon:ChangeSprite("icon_" .. self._funcId)

		self._txtFuncName.text = self._cfg.name
		self._txtOutPut.text = ""
		self._txtOutPut2.text = ""
		self._txtLock.text = not string.nilorempty(self._cfg.lockedTips) and self._cfg.lockedTips or string.format("达到%d级开启", self._cfg.openCondition[2])

		goutil.setActive(self._txtOutPut2.gameObject, self._funcId == 13)
		goutil.setActive(self._txtOutPut.gameObject, self._funcId ~= 13)
		self:_updateRedpoint()
	end
end

function PlayFuncItem:_updateRedpoint()
	local repointId = funcIdToRedpointID[self._funcId]

	if repointId then
		goutil.setActive(self._redpoint, RedPointModel.instance:isActive(repointId))
	else
		goutil.setActive(self._redpoint, false)
	end
end

function PlayFuncItem:setLocked()
	goutil.setActive(self._goLock, not FuncOpenModel.instance:getFuncIsOpen(self._funcId))
	self:_updateRedpoint()
end

function PlayFuncItem:_onClickCell()
	FuncOpenController.instance:onClickFunc(self._cfg)
end

return PlayFuncItem
