-- chunkname: @modules/logic/rouge2/map/view/choice/Rouge2_MapNodeChoiceItem.lua

module("modules.logic.rouge2.map.view.choice.Rouge2_MapNodeChoiceItem", package.seeall)

local Rouge2_MapNodeChoiceItem = class("Rouge2_MapNodeChoiceItem", Rouge2_MapChoiceBaseItem)

function Rouge2_MapNodeChoiceItem:_editableInitView()
	Rouge2_MapNodeChoiceItem.super._editableInitView(self)

	self._checkItem1 = Rouge2_MapNodeChoiceCheckItem.Get(self._gocheck1)
	self._checkItem2 = Rouge2_MapNodeChoiceCheckItem.Get(self._gocheck2)

	self._checkItem1:onSelect(false)
	self._checkItem2:onSelect(true)
end

function Rouge2_MapNodeChoiceItem:onClickSelf()
	if Rouge2_MapModel.instance:isInteractiving() then
		return
	end

	if Rouge2_MapModel.instance:isPlayingDialogue() then
		return
	end

	if self.status == Rouge2_MapEnum.ChoiceStatus.Lock then
		return
	end

	if self.status == Rouge2_MapEnum.ChoiceStatus.Select then
		AudioMgr.instance:trigger(AudioEnum.Rouge2.SelectChoice)
		self.animator:Play("select", 0, 0)
		Rouge2_Controller.instance:dispatchEvent(Rouge2_Event.onLightAttr)
		TaskDispatcher.cancelTask(self.onSelectAnimDone, self)
		TaskDispatcher.runDelay(self.onSelectAnimDone, self, Rouge2_MapEnum.ChoiceSelectAnimDuration)
		UIBlockMgr.instance:startBlock(Rouge2_MapEnum.WaitChoiceItemAnimBlock)
	else
		self:dispatchAttrLightEvent()
		Rouge2_MapController.instance:dispatchEvent(Rouge2_MapEvent.onChoiceItemStatusChange, self.choiceId)
	end
end

function Rouge2_MapNodeChoiceItem:onSelectAnimDone()
	Rouge2_MapModel.instance:recordCurChoiceEventSelectId(self.choiceId, self._index)

	local layerId = Rouge2_MapModel.instance:getLayerId()

	Rouge2_Rpc.instance:sendRouge2ChoiceEventRequest(layerId, self.nodeMo.nodeId, self.nodeMo.eventId, self.choiceId)
	UIBlockMgr.instance:endBlock(Rouge2_MapEnum.WaitChoiceItemAnimBlock)
end

function Rouge2_MapNodeChoiceItem:onStatusChange(choiceId)
	if self.status == Rouge2_MapEnum.ChoiceStatus.Lock then
		return
	end

	local status = choiceId and (choiceId == self.choiceId and Rouge2_MapEnum.ChoiceStatus.Select or Rouge2_MapEnum.ChoiceStatus.UnSelect) or Rouge2_MapEnum.ChoiceStatus.Normal

	if status == self.status then
		return
	end

	self.status = status

	self:refreshUI()
end

function Rouge2_MapNodeChoiceItem:update(choiceId, nodeMo, index, checkRate)
	Rouge2_MapNodeChoiceItem.super.update(self, index)

	self.choiceId = choiceId
	self.choiceCo = lua_rouge2_choice.configDict[choiceId]
	self.selectType = self.choiceCo.selectType
	self.nodeMo = nodeMo

	self:updateCheckInfo(checkRate)

	self.display = tonumber(self.choiceCo.display)
	self.title = self.choiceCo.title
	self.desc = Rouge2_MapHelper.buildChoiceDesc(self.choiceCo.desc)
	self.attrList = string.splitToNumber(self.choiceCo.attribute, "#")

	self:initStatus()

	self.tip = self.status == Rouge2_MapEnum.ChoiceStatus.Lock and Rouge2_MapUnlockHelper.getLockTips(self.choiceCo.unlock) or ""

	self:refreshUI()
	self:playUnlockAnim()
end

function Rouge2_MapNodeChoiceItem:refreshBg()
	local lockBg = Rouge2_MapEnum.StoryChoiceLockBg[self.selectType]
	local normalBg = Rouge2_MapEnum.StoryChoiceNormalBg[self.selectType]
	local selectBg = Rouge2_MapEnum.StoryChoiceSelectBg[self.selectType]

	UISpriteSetMgr.instance:setRouge7Sprite(self._imagelockbg, lockBg)
	UISpriteSetMgr.instance:setRouge7Sprite(self._imagenormalbg, normalBg)
	UISpriteSetMgr.instance:setRouge7Sprite(self._imageselectbg, selectBg)
end

function Rouge2_MapNodeChoiceItem:updateCheckInfo(checkRate)
	self._checkItem1:updateInfo(self.nodeMo.eventMo, self.choiceCo, checkRate)
	self._checkItem2:updateInfo(self.nodeMo.eventMo, self.choiceCo, checkRate)
end

function Rouge2_MapNodeChoiceItem:initStatus()
	local isUnLock = Rouge2_MapUnlockHelper.checkIsUnlock(self.choiceCo.unlock)

	self.status = isUnLock and Rouge2_MapEnum.ChoiceStatus.Normal or Rouge2_MapEnum.ChoiceStatus.Lock
end

function Rouge2_MapNodeChoiceItem:playUnlockAnim()
	local unlocktype = Rouge2_MapUnlockHelper.getUnlockTypeAndParam(self.choiceCo.unlock)

	if Rouge2_MapUnlockHelper.UnlockType.ActiveOutGenius ~= unlocktype then
		return
	end

	if Rouge2_MapController.instance:checkEventChoicePlayedUnlockAnim(self.choiceId) then
		return
	end

	if Rouge2_MapUnlockHelper.checkIsUnlock(self.choiceCo.unlock) then
		self.animator:Play("unlock", 0, 0)
		Rouge2_MapController.instance:playedEventChoiceEvent(self.choiceId)
	end
end

function Rouge2_MapNodeChoiceItem:destroy()
	TaskDispatcher.cancelTask(self.onSelectAnimDone, self)
	Rouge2_MapNodeChoiceItem.super.destroy(self)
end

return Rouge2_MapNodeChoiceItem
