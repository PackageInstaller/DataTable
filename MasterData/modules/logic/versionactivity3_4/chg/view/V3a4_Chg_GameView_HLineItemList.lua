-- chunkname: @modules/logic/versionactivity3_4/chg/view/V3a4_Chg_GameView_HLineItemList.lua

module("modules.logic.versionactivity3_4.chg.view.V3a4_Chg_GameView_HLineItemList", package.seeall)

local V3a4_Chg_GameView_HLineItemList = class("V3a4_Chg_GameView_HLineItemList", V3a4_Chg_GameView_LineItemBaseList)

function V3a4_Chg_GameView_HLineItemList:ctor(ctorParam)
	self:__onInit()
	V3a4_Chg_GameView_HLineItemList.super.ctor(self, ctorParam)
end

function V3a4_Chg_GameView_HLineItemList:_editableInitView()
	V3a4_Chg_GameView_HLineItemList.super._editableInitView(self)
end

function V3a4_Chg_GameView_HLineItemList:onDestroyView()
	V3a4_Chg_GameView_HLineItemList.super.onDestroyView(self)
	self:__onDispose()
end

function V3a4_Chg_GameView_HLineItemList:count()
	local row, col = self:vertexRowCol()

	return row * (col - 1)
end

function V3a4_Chg_GameView_HLineItemList:onMapSizeChange()
	local row, col = self:vertexRowCol()

	col = col - 1
	self._key2Index = {}
	self._index2Key = {}

	local maxCount = self:count()
	local keyX1 = 0
	local keyY1 = row
	local keyX2 = -1
	local keyY2 = -1

	for i, tr in ipairs(self._containerList) do
		keyX1 = keyX1 + 1

		if col < keyX1 then
			keyX1 = 1
			keyY1 = keyY1 - 1
		end

		keyX2 = keyX1 + 1
		keyY2 = keyY1

		local isActive = i <= maxCount
		local objContainerGo = tr.gameObject

		if isActive then
			local keyName = PuzzleMazeHelper.getLineKey(keyX1, keyY1, keyX2, keyY2)

			objContainerGo.name = keyName
			self._key2Index[keyName] = i
			self._index2Key[i] = keyName
		else
			objContainerGo.name = "Unused"
		end

		gohelper.setActive(objContainerGo, isActive)
	end
end

return V3a4_Chg_GameView_HLineItemList
