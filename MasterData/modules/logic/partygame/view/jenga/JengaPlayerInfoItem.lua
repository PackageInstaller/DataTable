-- chunkname: @modules/logic/partygame/view/jenga/JengaPlayerInfoItem.lua

module("modules.logic.partygame.view.jenga.JengaPlayerInfoItem", package.seeall)

local JengaPlayerInfoItem = class("JengaPlayerInfoItem", PlayerInfoItem)

function JengaPlayerInfoItem:onInitView()
	JengaPlayerInfoItem.super.onInitView(self)
	transformhelper.setLocalScale(self._gonormal.transform, 0.78, 0.78, 1)
	transformhelper.setLocalScale(self._goself.transform, 0.78, 0.78, 1)
end

function JengaPlayerInfoItem:Init(mo)
	JengaPlayerInfoItem.super.Init(self, mo)

	self._anim.enabled = false

	local game = PartyGameController.instance:getCurPartyGame()
	local gameCs = game:getGameBase()
	local MainPlayerChangeIndex = gameCs.MainPlayerChangeIndex
	local MainPlayerIndex = gameCs.MainPlayerIndex
	local co = game:getGameConfig()
	local dict = GameUtil.splitString2(co.playerPos, true)
	local index = mo.index

	if mo.index == MainPlayerChangeIndex then
		index = MainPlayerIndex
	elseif mo.index == MainPlayerIndex then
		index = MainPlayerChangeIndex
	end

	self._followGo = self._followGo or gohelper.create2d()

	if not dict[index] then
		return
	end

	self._followGo.transform.position = Vector3.New(unpack(dict[index]))

	local mainCamera = CameraMgr.instance:getMainCamera()
	local uiCamera = CameraMgr.instance:getUICamera()
	local plane = ViewMgr.instance:getUIRoot().transform

	self._uiFollower = gohelper.onceAddComponent(self.viewGO, typeof(ZProj.UIFollower))

	self._uiFollower:Set(mainCamera, uiCamera, plane, self._followGo.transform, 0, 0, -1, 10, -80)
	self._uiFollower:SetEnable(true)
end

function JengaPlayerInfoItem:updateIndex()
	return
end

function JengaPlayerInfoItem:onDestroyView()
	gohelper.destroy(self._followGo)

	self._followGo = nil

	JengaPlayerInfoItem.super.onDestroyView(self)
end

return JengaPlayerInfoItem
