-- chunkname: @modules/logic/rouge2/map/view/choice/Rouge2_MapNodeChoiceCheckItem.lua

module("modules.logic.rouge2.map.view.choice.Rouge2_MapNodeChoiceCheckItem", package.seeall)

local Rouge2_MapNodeChoiceCheckItem = class("Rouge2_MapNodeChoiceCheckItem", Rouge2_MapChoiceCheckBaseItem)

function Rouge2_MapNodeChoiceCheckItem.Get(go, itemType)
	return MonoHelper.addNoUpdateLuaComOnceToGo(go, Rouge2_MapNodeChoiceCheckItem, itemType)
end

function Rouge2_MapNodeChoiceCheckItem:updateInfo(eventMo, choiceCo, checkRate)
	self._eventMo = eventMo
	self._choiceCo = choiceCo
	self._choiceId = self._choiceCo and self._choiceCo.id
	self._checkId = self._choiceCo and self._choiceCo.checkId
	self._isCheck = self._checkId and self._checkId ~= 0
	self._checkCo = self._isCheck and Rouge2_CareerConfig.instance:getDiceCheckConfig(self._checkId, Rouge2_MapEnum.AttrCheckResult.Failure)

	if self._checkCo then
		local attrType = self._checkCo.attrType

		checkRate = checkRate or self._eventMo:getChoiceCheckRate(self._choiceId)
		checkRate = checkRate or 0

		Rouge2_MapNodeChoiceCheckItem.super.updateInfo(self, attrType, checkRate)
	end
end

return Rouge2_MapNodeChoiceCheckItem
