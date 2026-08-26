-- chunkname: @modules/logic/partygame/view/collatingsort/CollatingSortGameBoxItem.lua

module("modules.logic.partygame.view.collatingsort.CollatingSortGameBoxItem", package.seeall)

local CollatingSortGameBoxItem = class("CollatingSortGameBoxItem", ListScrollCellExtend)

function CollatingSortGameBoxItem:onInitView()
	self._image = gohelper.findChildImage(self.viewGO, "#image_bucket")
	self._golight = gohelper.findChild(self.viewGO, "light")
	self._golightSuccess = gohelper.findChild(self.viewGO, "light/success")
	self._golightFail = gohelper.findChild(self.viewGO, "light/fail")
	self._txtaddscore = gohelper.findChildText(self.viewGO, "light/success/#txt_addscore")
	self._txtsubscore = gohelper.findChildText(self.viewGO, "light/fail/#txt_subscore")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CollatingSortGameBoxItem:addEvents()
	return
end

function CollatingSortGameBoxItem:removeEvents()
	return
end

function CollatingSortGameBoxItem:_editableInitView()
	gohelper.setActive(self._golight, false)
end

function CollatingSortGameBoxItem:_editableAddEvents()
	return
end

function CollatingSortGameBoxItem:_editableRemoveEvents()
	return
end

function CollatingSortGameBoxItem:onUpdateMO(dropType)
	UISpriteSetMgr.instance:setV3a4LaplaceSprite(self._image, "v3a4_party_game12_bucket" .. dropType)
end

function CollatingSortGameBoxItem:onCollectBall(score)
	TaskDispatcher.cancelTask(self._delayHideEffect, self)
	TaskDispatcher.runDelay(self._delayHideEffect, self, 1)

	local isAddScore = score > 0

	gohelper.setActive(self._golight, false)
	gohelper.setActive(self._golight, true)
	gohelper.setActive(self._golightSuccess, isAddScore)
	gohelper.setActive(self._golightFail, not isAddScore)

	if isAddScore then
		if not ("+" .. score) then
			local sorceStr = score

			self._txtaddscore.text = sorceStr
			self._txtsubscore.text = sorceStr
		end
	end
end

function CollatingSortGameBoxItem:_delayHideEffect()
	gohelper.setActive(self._golight, false)
end

function CollatingSortGameBoxItem:onDestroyView()
	TaskDispatcher.cancelTask(self._delayHideEffect, self)
end

return CollatingSortGameBoxItem
