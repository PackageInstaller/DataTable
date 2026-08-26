-- chunkname: @modules/logic/partygame/view/common/CommonSceneUIComp.lua

module("modules.logic.partygame.view.common.CommonSceneUIComp", package.seeall)

local CommonSceneUIComp = class("CommonSceneUIComp", LuaCompBase)

function CommonSceneUIComp:init(go)
	self._item = gohelper.findChild(go, "commpn_playerinfo_scene")

	gohelper.setActive(self._item, false)

	self._isInit = false
end

function CommonSceneUIComp:initPlayer()
	if self._isInit then
		return
	end

	self._allItem = self:getUserDataTb_()

	local playerList = PartyGameModel.instance:getCurGamePlayerList()
	local mainCharacterGo

	for i = 1, #playerList do
		local cloneGo = gohelper.cloneInPlace(self._item)

		gohelper.setActive(cloneGo, true)

		local item = MonoHelper.addLuaComOnceToGo(cloneGo, CommonPlayerInfoComp)
		local data = playerList[i]

		item:initPlayerMo(data)

		self._allItem[data.uid] = item

		if data:isMainPlayer() then
			mainCharacterGo = cloneGo
		end
	end

	self._isInit = true

	if mainCharacterGo then
		gohelper.setAsLastSibling(mainCharacterGo)
	end
end

function CommonSceneUIComp:showScoreDiff(uid, scoreDiff)
	if self._allItem == nil or self._allItem[uid] == nil then
		return
	end

	self._allItem[uid]:showScoreDiff(scoreDiff)
end

function CommonSceneUIComp:onDestroy()
	return
end

return CommonSceneUIComp
