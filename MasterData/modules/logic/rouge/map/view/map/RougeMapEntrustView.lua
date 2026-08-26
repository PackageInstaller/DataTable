-- chunkname: @modules/logic/rouge/map/view/map/RougeMapEntrustView.lua

module("modules.logic.rouge.map.view.map.RougeMapEntrustView", package.seeall)

local RougeMapEntrustView = class("RougeMapEntrustView", BaseView)

function RougeMapEntrustView:onInitView()
	self._btnEntrust = gohelper.findChildButtonWithAudio(self.viewGO, "Left/#btn_entrust")
	self._goEntrustContainer = gohelper.findChild(self.viewGO, "Left/#go_entrustcontainer")
	self._txtEntrustDesc = gohelper.findChildText(self.viewGO, "Left/#go_entrustcontainer/#txt_entrustdesc")
	self._btnHideEntrust = gohelper.findChildButtonWithAudio(self.viewGO, "Left/#go_entrustcontainer/#btn_hideentrust")
	self._gocangeteffect = gohelper.findChild(self.viewGO, "Left/#btn_entrust/#effect_canget")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RougeMapEntrustView:addEvents()
	self._btnEntrust:AddClickListener(self._btnEntrustOnClick, self)
	self._btnHideEntrust:AddClickListener(self._btnHideEntrustOnClick, self)
end

function RougeMapEntrustView:removeEvents()
	self._btnEntrust:RemoveClickListener()
	self._btnHideEntrust:RemoveClickListener()
end

function RougeMapEntrustView:_btnEntrustOnClick()
	if not self.hadEntrust then
		return
	end

	self.status = RougeMapEnum.EntrustStatus.Detail

	self:refreshStatus()
end

function RougeMapEntrustView:_btnHideEntrustOnClick()
	if not self.hadEntrust then
		return
	end

	self:closeEntrust()
end

function RougeMapEntrustView:_editableInitView()
	self.goEntrustBtn = self._btnEntrust.gameObject
	self.animatorPlayer = ZProj.ProjAnimatorPlayer.Get(self._goEntrustContainer)

	self.addEventCb(self, RougeMapController.instance, RougeMapEvent.onEntrustChange, self.onEntrustChange, self)
end

function RougeMapEntrustView:onEntrustChange()
	self:tryShowEntrust()
end

function RougeMapEntrustView:onOpen()
	self:tryShowEntrust()
end

function RougeMapEntrustView:tryShowEntrust()
	self.status = RougeMapEnum.EntrustStatus.Detail

	self:updateHadEntrust()
	self:refreshEntrust()

	if self.hadEntrust then
		TaskDispatcher.cancelTask(self.closeEntrust, self)
		TaskDispatcher.runDelay(self.closeEntrust, self, RougeMapEnum.ChangeEntrustTime)
	end
end

function RougeMapEntrustView:closeEntrust()
	if self.closing then
		return
	end

	self.closing = true

	self.animatorPlayer:Play("close", self.onCloseAnimDone, self)
end

function RougeMapEntrustView:onCloseAnimDone()
	self.closing = nil
	self.status = RougeMapEnum.EntrustStatus.Brief

	self:refreshStatus()
	self:refreshEffect()
end

function RougeMapEntrustView:updateHadEntrust()
	local entrustId = RougeMapModel.instance:getEntrustId()

	self.entrustId = entrustId
	self.hadEntrust = entrustId ~= nil
	self.entrustProgress = RougeMapModel.instance:getEntrustProgress()
	self.isFinished = self.entrustProgress and self.entrustProgress >= 1
end

function RougeMapEntrustView:refreshEntrust()
	if not self.hadEntrust then
		self:hideEntrust()

		return
	end

	local entrustCo = lua_rouge_entrust.configDict[self.entrustId]
	local entrustDescCo = lua_rouge_entrust_desc.configDict[entrustCo.type]

	self:refreshStatus()
	self:initEntrustDescHandle()
	self:refreshEffect()

	local handle = self.entrustTypeHandleDict[entrustCo.type]

	self._txtEntrustDesc.text = handle and handle(self, entrustCo, entrustDescCo) or ""
end

function RougeMapEntrustView:refreshStatus()
	gohelper.setActive(self.goEntrustBtn, self.status == RougeMapEnum.EntrustStatus.Brief)
	gohelper.setActive(self._goEntrustContainer, self.status == RougeMapEnum.EntrustStatus.Detail)
end

function RougeMapEntrustView:refreshEffect()
	local canShow = false

	gohelper.setActive(self._gocangeteffect, canShow)

	if canShow then
		TaskDispatcher.cancelTask(self.hideCangetEffect, self)
		TaskDispatcher.runDelay(self.hideCangetEffect, self, RougeMapEnum.FinishEntrustEffect)
	end
end

function RougeMapEntrustView:hideCangetEffect()
	gohelper.setActive(self._gocangeteffect, false)
end

function RougeMapEntrustView:hideEntrust()
	gohelper.setActive(self.goEntrustBtn, false)
	gohelper.setActive(self._goEntrustContainer, false)
end

function RougeMapEntrustView:initEntrustDescHandle()
	if self.entrustTypeHandleDict then
		return
	end

	self.entrustTypeHandleDict = {
		[RougeMapEnum.EntrustEventType.MakeMoney] = self.makeMoneyHandle,
		[RougeMapEnum.EntrustEventType.CostMoney] = self.costMoneyHandle,
		[RougeMapEnum.EntrustEventType.Event] = self.eventHandle,
		[RougeMapEnum.EntrustEventType.Curse] = self.curseHandle,
		[RougeMapEnum.EntrustEventType.CostPower] = self.costPowerHandle,
		[RougeMapEnum.EntrustEventType.MakePower] = self.makePowerHandle,
		[RougeMapEnum.EntrustEventType.FinishEvent] = self.finishEventHandle,
		[RougeMapEnum.EntrustEventType.GetCollection] = self.getCollectionHandle,
		[RougeMapEnum.EntrustEventType.LevelUpSpCollection] = self.levelupSpCollectionHandle
	}
end

function RougeMapEntrustView:makeMoneyHandle(entrustCo, entrustDescCo)
	local cost = tonumber(entrustCo.param)
	local progress = RougeMapModel.instance:getEntrustProgress()
	local desc = self:getDesc(entrustDescCo, cost <= progress)

	return GameUtil.getSubPlaceholderLuaLangTwoParam(desc, cost, progress)
end

function RougeMapEntrustView:costMoneyHandle(entrustCo, entrustDescCo)
	local cost = tonumber(entrustCo.param)
	local progress = RougeMapModel.instance:getEntrustProgress()
	local desc = self:getDesc(entrustDescCo, cost <= progress)

	return GameUtil.getSubPlaceholderLuaLangTwoParam(desc, cost, progress)
end

function RougeMapEntrustView:eventHandle(entrustCo, entrustDescCo)
	local progress = RougeMapModel.instance:getEntrustProgress()
	local param = string.split(entrustCo.param, "|")
	local typeList = string.splitToNumber(param[1], "#")

	for i = 1, #typeList do
		typeList[i] = lua_rouge_event_type.configDict[typeList[i]].name
	end

	local total = tonumber(param[2])
	local desc = self:getDesc(entrustDescCo, total <= progress)

	return GameUtil.getSubPlaceholderLuaLangThreeParam(desc, total, table.concat(typeList, "_"), progress)
end

function RougeMapEntrustView:curseHandle(entrustCo, entrustDescCo)
	return entrustDescCo.desc
end

function RougeMapEntrustView:costPowerHandle(entrustCo, entrustDescCo)
	local cost = tonumber(entrustCo.param)
	local progress = RougeMapModel.instance:getEntrustProgress()
	local desc = self:getDesc(entrustDescCo, cost <= progress)

	return GameUtil.getSubPlaceholderLuaLangTwoParam(desc, cost, progress)
end

function RougeMapEntrustView:makePowerHandle(entrustCo, entrustDescCo)
	local cost = tonumber(entrustCo.param)
	local progress = RougeMapModel.instance:getEntrustProgress()
	local desc = self:getDesc(entrustDescCo, cost <= progress)

	return GameUtil.getSubPlaceholderLuaLangTwoParam(desc, cost, progress)
end

function RougeMapEntrustView:finishEventHandle(entrustCo, entrustDescCo)
	local progress = RougeMapModel.instance:getEntrustProgress()
	local desc = self:getDesc(entrustDescCo, progress >= 1)
	local eventId = tonumber(entrustCo.param)
	local eventCo = RougeMapConfig.instance:getRougeEvent(eventId)

	return GameUtil.getSubPlaceholderLuaLangOneParam(desc, eventCo.name)
end

function RougeMapEntrustView:getCollectionHandle(entrustCo, entrustDescCo)
	local count = tonumber(entrustCo.param)
	local progress = RougeMapModel.instance:getEntrustProgress()
	local desc = self:getDesc(entrustDescCo, count <= progress)

	return GameUtil.getSubPlaceholderLuaLangTwoParam(desc, count, progress)
end

function RougeMapEntrustView:levelupSpCollectionHandle(entrustCo, entrustDescCo)
	local count = tonumber(entrustCo.param)
	local progress = RougeMapModel.instance:getEntrustProgress()
	local desc = self:getDesc(entrustDescCo, count <= progress)

	return GameUtil.getSubPlaceholderLuaLangTwoParam(desc, count, progress)
end

function RougeMapEntrustView:getDesc(co, finish)
	return (finish or nil) and (co.finishDesc or co.desc)
end

function RougeMapEntrustView:onClose()
	self.closing = nil

	TaskDispatcher.cancelTask(self.closeEntrust, self)
	TaskDispatcher.cancelTask(self.hideCangetEffect, self)
end

return RougeMapEntrustView
