-- chunkname: @modules/logic/rouge/map/view/choice/RougeMapNodeChoiceItem.lua

module("modules.logic.rouge.map.view.choice.RougeMapNodeChoiceItem", package.seeall)

local RougeMapNodeChoiceItem = class("RougeMapNodeChoiceItem", RougeMapChoiceBaseItem)

function RougeMapNodeChoiceItem:_editableInitView()
	RougeMapNodeChoiceItem.super._editableInitView(self)

	self._btnlockdetail = gohelper.findChildButtonWithAudio(self.go, "#go_locked/#btn_lockdetail")
	self._btnnormaldetail = gohelper.findChildButtonWithAudio(self.go, "#go_normal/#btn_normaldetail")
	self._btnselectdetail = gohelper.findChildButtonWithAudio(self.go, "#go_select/#btn_selectdetail")

	self._btnlockdetail:AddClickListener(self.onClickDetail, self)
	self._btnnormaldetail:AddClickListener(self.onClickDetail, self)
	self._btnselectdetail:AddClickListener(self.onClickDetail, self)
end

function RougeMapNodeChoiceItem:onClickDetail()
	if not self.hadCollection then
		return
	end

	RougeMapController.instance:dispatchEvent(RougeMapEvent.onClickChoiceDetail, self.collectionIdList)
end

function RougeMapNodeChoiceItem:onClickSelf()
	if RougeMapModel.instance:isInteractiving() then
		return
	end

	if RougeMapModel.instance:isPlayingDialogue() then
		return
	end

	if self.status == RougeMapEnum.ChoiceStatus.Lock then
		return
	end

	if self.status == RougeMapEnum.ChoiceStatus.Select then
		self.animator:Play("select", 0, 0)
		TaskDispatcher.cancelTask(self.onSelectAnimDone, self)
		TaskDispatcher.runDelay(self.onSelectAnimDone, self, RougeMapEnum.ChoiceSelectAnimDuration)
		UIBlockMgr.instance:startBlock(RougeMapEnum.WaitChoiceItemAnimBlock)
	else
		RougeMapController.instance:dispatchEvent(RougeMapEvent.onChoiceItemStatusChange, self.choiceId)
	end
end

function RougeMapNodeChoiceItem:onSelectAnimDone()
	RougeMapModel.instance:recordCurChoiceEventSelectId(self.choiceId)
	RougeRpc.instance:sendRougeChoiceEventRequest(self.choiceId)
	UIBlockMgr.instance:endBlock(RougeMapEnum.WaitChoiceItemAnimBlock)
end

function RougeMapNodeChoiceItem:onStatusChange(choiceId)
	if self.status == RougeMapEnum.ChoiceStatus.Lock then
		return
	end

	local status = choiceId and (choiceId == self.choiceId and RougeMapEnum.ChoiceStatus.Select or RougeMapEnum.ChoiceStatus.UnSelect) or RougeMapEnum.ChoiceStatus.Normal

	if status == self.status then
		return
	end

	self.status = status

	self:refreshUI()
end

function RougeMapNodeChoiceItem:update(choiceId, pos, nodeMo)
	RougeMapNodeChoiceItem.super.update(self, pos)

	self.choiceId = choiceId
	self.choiceCo = lua_rouge_choice.configDict[choiceId]
	self.nodeMo = nodeMo

	self:buildCollectionIdList()

	self.title = self.choiceCo.title
	self.desc = self.choiceCo.desc

	self:initStatus()

	self.tip = self.status == RougeMapEnum.ChoiceStatus.Lock and RougeMapUnlockHelper.getLockTips(self.choiceCo.unlockType, self.choiceCo.unlockParam) or ""

	self:refreshUI()
	self:playUnlockAnim()
end

function RougeMapNodeChoiceItem:buildCollectionIdList()
	local display = self.choiceCo.display

	if not string.nilorempty(display) then
		self.hadCollection = true
		self.collectionIdList = string.splitToNumber(display, "|")

		return
	end

	local interactive = self.choiceCo.interactive

	if string.nilorempty(interactive) then
		self.hadCollection = false
		self.collectionIdList = nil

		return
	end

	local type = string.splitToNumber(interactive, "#")[1]

	if type == RougeMapEnum.InteractType.LossNotUniqueCollection then
		local collectionId = self.nodeMo.interactive9drop

		if collectionId == 0 then
			self.hadCollection = false
			self.collectionIdList = nil
		else
			self.hadCollection = true
			self.collectionIdList = {
				collectionId
			}
		end
	elseif type == RougeMapEnum.InteractType.StorageCollection then
		local collectionId = self.nodeMo.interactive10drop

		if collectionId == 0 then
			self.hadCollection = false
			self.collectionIdList = nil
		else
			self.hadCollection = true
			self.collectionIdList = {
				collectionId
			}
		end
	elseif type == RougeMapEnum.InteractType.LossSpCollection then
		local collectionId = self.nodeMo.interactive14drop

		if collectionId == 0 then
			self.hadCollection = false
			self.collectionIdList = nil
		else
			self.hadCollection = true
			self.collectionIdList = {
				collectionId
			}
		end
	else
		self.hadCollection = false
		self.collectionIdList = nil
	end
end

function RougeMapNodeChoiceItem:initStatus()
	local isUnLock = RougeMapUnlockHelper.checkIsUnlock(self.choiceCo.unlockType, self.choiceCo.unlockParam)

	self.status = isUnLock and RougeMapEnum.ChoiceStatus.Normal or RougeMapEnum.ChoiceStatus.Lock
end

function RougeMapNodeChoiceItem:refreshLockUI()
	RougeMapNodeChoiceItem.super.refreshLockUI(self)
	gohelper.setActive(self._golockdetail, self.hadCollection)
end

function RougeMapNodeChoiceItem:refreshNormalUI()
	RougeMapNodeChoiceItem.super.refreshNormalUI(self)
	gohelper.setActive(self._gonormaldetail, self.hadCollection)
end

function RougeMapNodeChoiceItem:refreshSelectUI()
	RougeMapNodeChoiceItem.super.refreshSelectUI(self)
	gohelper.setActive(self._goselectdetail, self.hadCollection)
end

function RougeMapNodeChoiceItem:playUnlockAnim()
	local unlocktype = self.choiceCo.unlockType

	if RougeMapUnlockHelper.UnlockType.ActiveOutGenius ~= unlocktype then
		return
	end

	if RougeMapController.instance:checkEventChoicePlayedUnlockAnim(self.choiceId) then
		return
	end

	if RougeMapUnlockHelper.checkIsUnlock(unlocktype, self.choiceCo.unlockParam) then
		self.animator:Play("unlock", 0, 0)
		RougeMapController.instance:playedEventChoiceEvent(self.choiceId)
	end
end

function RougeMapNodeChoiceItem:destroy()
	TaskDispatcher.cancelTask(self.onSelectAnimDone, self)
	self._btnlockdetail:RemoveClickListener()
	self._btnnormaldetail:RemoveClickListener()
	self._btnselectdetail:RemoveClickListener()
	RougeMapNodeChoiceItem.super.destroy(self)
end

return RougeMapNodeChoiceItem
