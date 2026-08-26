-- chunkname: @modules/logic/versionactivity3_4/chg/view/V3a4_Chg_GameView_VertItemList.lua

module("modules.logic.versionactivity3_4.chg.view.V3a4_Chg_GameView_VertItemList", package.seeall)

local V3a4_Chg_GameView_VertItemList = class("V3a4_Chg_GameView_VertItemList", V3a4_Chg_GameView_ObjItemListImpl)

function V3a4_Chg_GameView_VertItemList:ctor(ctorParam)
	self:__onInit()
	V3a4_Chg_GameView_VertItemList.super.ctor(self, ctorParam)
end

function V3a4_Chg_GameView_VertItemList:_editableInitView()
	V3a4_Chg_GameView_VertItemList.super._editableInitView(self)
end

function V3a4_Chg_GameView_VertItemList:onMapSizeChange()
	local row, col = self:vertexRowCol()

	self._key2Index = {}
	self._index2Key = {}

	local maxCount = self:count()
	local keyX = 0
	local keyY = row

	for i, tr in ipairs(self._containerList) do
		keyX = keyX + 1

		if col < keyX then
			keyX = 1
			keyY = keyY - 1
		end

		local isActive = i <= maxCount
		local objContainerGo = tr.gameObject

		if isActive then
			local keyName = PuzzleMazeHelper.getPosKey(keyX, keyY)

			objContainerGo.name = keyName
			self._key2Index[keyName] = i
			self._index2Key[i] = keyName
		else
			objContainerGo.name = "Unused"
		end

		gohelper.setActive(objContainerGo, isActive)
	end
end

function V3a4_Chg_GameView_VertItemList:onDestroyView()
	V3a4_Chg_GameView_VertItemList.super.onDestroyView(self)
	self:__onDispose()
end

return V3a4_Chg_GameView_VertItemList
