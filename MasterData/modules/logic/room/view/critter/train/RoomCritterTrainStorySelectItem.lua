-- chunkname: @modules/logic/room/view/critter/train/RoomCritterTrainStorySelectItem.lua

module("modules.logic.room.view.critter.train.RoomCritterTrainStorySelectItem", package.seeall)

local RoomCritterTrainStorySelectItem = class("RoomCritterTrainStorySelectItem")

function RoomCritterTrainStorySelectItem:init(go, index)
	self.go = gohelper.cloneInPlace(go, string.format("selectItem%s", index))

	gohelper.setActive(self.go, false)

	self._btnselect = gohelper.findChildButtonWithAudio(self.go, "btnselect")
	self._goselectlight = gohelper.findChild(self.go, "btnselect/light")
	self._gobgdark = gohelper.findChild(self.go, "bgdark")
	self._imageicon = gohelper.findChildImage(self.go, "bgdark/icon")
	self._txtcontentdark = gohelper.findChildText(self.go, "bgdark/txtcontentdark")
	self._txtnum = gohelper.findChildText(self.go, "bgdark/#txt_num")
	self._golvup = gohelper.findChild(self.go, "go_lvup")
	self._txtlvup = gohelper.findChildText(self.go, "go_lvup/txt_lvup")
	self._goup = gohelper.findChild(self.go, "go_up")
	self._gonum = gohelper.findChild(self.go, "go_num")
	self._txtcountnum = gohelper.findChildText(self.go, "go_num/#txt_num")
	self._btncancel = gohelper.findChildButtonWithAudio(self.go, "btncancel")
	self._goselecteff = gohelper.findChild(self.go, "#selecteff")

	gohelper.setActive(self._golvup, false)
	gohelper.setActive(self._goselecteff, false)
	self:_addEvents()
end

function RoomCritterTrainStorySelectItem:_addEvents()
	self._btnselect:AddClickListener(self._btnselectOnClick, self)
	self._btncancel:AddClickListener(self._btncancelOnClick, self)
end

function RoomCritterTrainStorySelectItem:_removeEvents()
	self._btnselect:RemoveClickListener()
	self._btncancel:RemoveClickListener()
end

function RoomCritterTrainStorySelectItem:show(optionId, critterMo, eventId, count)
	self._optionId = optionId
	self._count = count
	self._attributeMO = critterMo.trainInfo:getEventOptionMOByOptionId(eventId, optionId).addAttriButes[1]
	self._attributeInfo = critterMo:getAttributeInfoByType(self._attributeMO.attributeId)
	self._addAttributeValue = critterMo.trainInfo:getAddAttributeValue(self._attributeMO.attributeId)
	self._attributeCo = CritterConfig.instance:getCritterAttributeCfg(self._attributeMO.attributeId)
	self._critterMo = critterMo
	self._eventId = eventId

	self:_refreshItem()
end

function RoomCritterTrainStorySelectItem:_btncancelOnClick()
	local count = RoomTrainCritterModel.instance:getSelectOptionCount(self._optionId)

	if count <= 0 then
		return
	end

	RoomController.instance:dispatchEvent(RoomEvent.CritterTrainAttributeCancel, self._attributeCo.id, self._optionId)
end

function RoomCritterTrainStorySelectItem:_btnselectOnClick()
	gohelper.setActive(self._goselecteff, false)
	TaskDispatcher.cancelTask(self._playSelectFinished, self)

	local limitCount = RoomTrainCritterModel.instance:getSelectOptionLimitCount()

	if limitCount <= 0 then
		return
	end

	if self._count and self._count < 1 then
		gohelper.setActive(self._goselecteff, true)
		TaskDispatcher.runDelay(self._playSelectFinished, self, 0.34)
	end

	RoomController.instance:dispatchEvent(RoomEvent.CritterTrainAttributeSelected, self._attributeCo.id, self._optionId)
end

function RoomCritterTrainStorySelectItem:_playSelectFinished()
	gohelper.setActive(self._goselecteff, false)
end

function RoomCritterTrainStorySelectItem:_refreshItem()
	gohelper.setActive(self._goselectlight, self._count and self._count > 0)
	gohelper.setActive(self._btncancel.gameObject, self._count and self._count > 0)
	ZProj.TweenHelper.KillByObj(self.go)

	if not self.go.activeSelf then
		gohelper.setActive(self.go, true)
		ZProj.TweenHelper.DOFadeCanvasGroup(self.go, 0, 1, 0.6)
	end

	self._txtcontentdark.text = self._attributeCo.name

	UISpriteSetMgr.instance:setCritterSprite(self._imageicon, self._attributeCo.icon)

	self._txtnum.text = string.format("+%.02f", self._attributeMO.value)

	gohelper.setActive(self._gonum, self._count and self._count > 0)

	self._txtcountnum.text = self._count or 0

	local heroPreferenceCo = CritterConfig.instance:getCritterHeroPreferenceCfg(self._critterMo.trainInfo.heroId)

	gohelper.setActive(self._goup, (heroPreferenceCo.effectAttribute == self._attributeMO.attributeId or nil) and true)

	local baseValue = self._attributeInfo.value + self._addAttributeValue
	local initLevel = CritterConfig.instance:getCritterAttributeLevelCfgByValue(baseValue).level
	local count = RoomTrainCritterModel.instance:getSelectOptionCount(self._optionId)
	local addLevel = CritterConfig.instance:getCritterAttributeLevelCfgByValue(count * self._attributeMO.value + baseValue).level
	local maxLvConfig = CritterConfig.instance:getMaxCritterAttributeLevelCfg()

	if initLevel == maxLvConfig.level then
		self._txtnum.text = string.format("+%.02f(MAX)", self._attributeMO.value)
	end

	gohelper.setActive(self._golvup, initLevel < addLevel)
end

function RoomCritterTrainStorySelectItem:destroy()
	self:_removeEvents()
	TaskDispatcher.cancelTask(self._playSelectFinished, self)
	ZProj.TweenHelper.KillByObj(self.go)
end

return RoomCritterTrainStorySelectItem
