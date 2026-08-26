-- chunkname: @modules/logic/partygame/view/pedalingplaid/PedalingPlaidSceneUIComp.lua

module("modules.logic.partygame.view.pedalingplaid.PedalingPlaidSceneUIComp", package.seeall)

local PedalingPlaidSceneUIComp = class("PedalingPlaidSceneUIComp", LuaCompBase)

function PedalingPlaidSceneUIComp:init(go)
	self._item = gohelper.findChild(go, "item")

	gohelper.setActive(self._item, false)

	self._isInit = false
end

function PedalingPlaidSceneUIComp:initView()
	if self._isInit then
		return
	end

	self._items = {}

	local playerList = PartyGameModel.instance:getCurGamePlayerList()

	for i = 1, #playerList do
		local cloneGo = gohelper.cloneInPlace(self._item)

		gohelper.setActive(cloneGo, true)

		self._items[i] = MonoHelper.addNoUpdateLuaComOnceToGo(cloneGo, PedalingPlaidPlayerBuffComp, playerList[i])
	end

	self._isInit = true
end

function PedalingPlaidSceneUIComp:updateView()
	if not self._isInit then
		return
	end

	for k, v in pairs(self._items) do
		v:onUpdate()
	end
end

function PedalingPlaidSceneUIComp:onDestroy()
	return
end

return PedalingPlaidSceneUIComp
