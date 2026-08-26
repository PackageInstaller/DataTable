-- chunkname: @modules/logic/rouge2/map/view/piecechoice/Rouge2_MapPieceChoiceCheckItem.lua

module("modules.logic.rouge2.map.view.piecechoice.Rouge2_MapPieceChoiceCheckItem", package.seeall)

local Rouge2_MapPieceChoiceCheckItem = class("Rouge2_MapPieceChoiceCheckItem", Rouge2_MapChoiceCheckBaseItem)

function Rouge2_MapPieceChoiceCheckItem.Get(go, itemType)
	return MonoHelper.addNoUpdateLuaComOnceToGo(go, Rouge2_MapPieceChoiceCheckItem, itemType)
end

function Rouge2_MapPieceChoiceCheckItem:updateInfo(pieceMo, selectCo)
	self._pieceMo = pieceMo
	self._selectCo = selectCo
	self._selectId = self._selectCo.id
	self._checkId = self._selectCo.checkId
	self._isCheck = self._checkId and self._checkId ~= 0
	self._checkCo = self._isCheck and Rouge2_CareerConfig.instance:getDiceCheckConfig(self._checkId, Rouge2_MapEnum.AttrCheckResult.Failure)

	if self._checkCo then
		local attrType = self._checkCo.attrType
		local checkRate = self._pieceMo:getSelectCheckRate(self._selectId) or 0

		Rouge2_MapPieceChoiceCheckItem.super.updateInfo(self, attrType, checkRate)
	end
end

return Rouge2_MapPieceChoiceCheckItem
