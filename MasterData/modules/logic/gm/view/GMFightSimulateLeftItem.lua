-- chunkname: @modules/logic/gm/view/GMFightSimulateLeftItem.lua

module("modules.logic.gm.view.GMFightSimulateLeftItem", package.seeall)

local GMFightSimulateLeftItem = class("GMFightSimulateLeftItem", ListScrollCell)
local SelectColor = Color.New(1, 0.8, 0.8, 1)
local NotSelectColor = Color.white
local PrevSelectId

function GMFightSimulateLeftItem:init(go)
	self._btn = gohelper.findChildButtonWithAudio(go, "btn")

	self._btn:AddClickListener(self._onClickItem, self)

	self._imgBtn = gohelper.findChildImage(go, "btn")
	self._txtName = gohelper.findChildText(go, "btn/Text")
end

function GMFightSimulateLeftItem:onUpdateMO(mo)
	self._chapterCO = mo
	self._txtName.text = self._chapterCO.name

	if self._chapterCO.id == PrevSelectId then
		self._imgBtn.color = SelectColor or NotSelectColor
	end

	if PrevSelectId then
		if self._chapterCO.id == PrevSelectId then
			GMFightSimulateRightModel.instance:setChapterId(self._chapterCO.id)
		end
	elseif self._index == 1 then
		PrevSelectId = self._chapterCO.id

		self._view:setSelect(self._chapterCO)
		GMFightSimulateRightModel.instance:setChapterId(self._chapterCO.id)
	end
end

function GMFightSimulateLeftItem:_onClickItem()
	PrevSelectId = self._chapterCO.id
	self._imgBtn.color = SelectColor

	self._view:setSelect(self._chapterCO)
	GMFightSimulateRightModel.instance:setChapterId(self._chapterCO.id)
end

function GMFightSimulateLeftItem:onSelect(isSelect)
	if self._chapterCO.id == PrevSelectId then
		self._imgBtn.color = SelectColor or NotSelectColor
	end
end

function GMFightSimulateLeftItem:onDestroy()
	if self._btn then
		self._btn:RemoveClickListener()

		self._btn = nil
	end
end

return GMFightSimulateLeftItem
