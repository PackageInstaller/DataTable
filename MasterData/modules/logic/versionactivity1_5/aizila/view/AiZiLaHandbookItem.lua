-- chunkname: @modules/logic/versionactivity1_5/aizila/view/AiZiLaHandbookItem.lua

module("modules.logic.versionactivity1_5.aizila.view.AiZiLaHandbookItem", package.seeall)

local AiZiLaHandbookItem = class("AiZiLaHandbookItem", AiZiLaGoodsItem)

function AiZiLaHandbookItem:_btnclickOnClick()
	if self._mo then
		AiZiLaHandbookListModel.instance:setSelect(self._mo.itemId)
		AiZiLaController.instance:dispatchEvent(AiZiLaEvent.SelectItem)
	end
end

function AiZiLaHandbookItem:_editableInitView()
	self._canvasGroup = gohelper.onceAddComponent(self.viewGO, gohelper.Type_CanvasGroup)
	self._goimagerare = self._imagerare.gameObject
	self._goimageicon = self._imageicon.gameObject
	self._goimagecountBG = self._imagecountBG.gameObject
	self._lastGray = false
end

function AiZiLaHandbookItem:_editableAddEvents()
	return
end

function AiZiLaHandbookItem:_editableRemoveEvents()
	return
end

function AiZiLaHandbookItem:onUpdateMO(mo)
	self._mo = mo
	self._txtcount.text = mo:getQuantity()

	self:_refreshIcon(mo.itemId)
	self:_refreshGray(not AiZiLaModel.instance:isCollectItemId(mo.itemId))
end

function AiZiLaHandbookItem:_refreshGray(isGray)
	local tempGray = not not isGray

	if self._lastGray ~= tempGray then
		self._lastGray = tempGray
		self._canvasGroup.alpha = tempGray and 0.75 or 1

		self:_setGrayMode(self._goimagerare, tempGray)
		self:_setGrayMode(self._goimageicon, tempGray)
		self:_setGrayMode(self._goimagecountBG, tempGray)
	end
end

function AiZiLaHandbookItem:_setGrayMode(go, isGray)
	if isGray then
		ZProj.UGUIHelper.SetGrayFactor(go, 0.8)
	else
		ZProj.UGUIHelper.SetGrayscale(go, false)
	end
end

function AiZiLaHandbookItem:onDestroyView()
	return
end

return AiZiLaHandbookItem
