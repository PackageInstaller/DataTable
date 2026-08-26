-- chunkname: @modules/logic/weekwalk/view/WeekWalkSelectTarotView.lua

module("modules.logic.weekwalk.view.WeekWalkSelectTarotView", package.seeall)

local WeekWalkSelectTarotView = class("WeekWalkSelectTarotView", BaseView)

WeekWalkSelectTarotView.delaySwitchViewTime = 0.33

function WeekWalkSelectTarotView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._gocontainer = gohelper.findChild(self.viewGO, "#go_container")
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
	self._simageline = gohelper.findChildSingleImage(self.viewGO, "#simage_line")
	self._btnok = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_ok")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function WeekWalkSelectTarotView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btnok:AddClickListener(self._btnokOnClick, self)
end

function WeekWalkSelectTarotView:removeEvents()
	self._btnclose:RemoveClickListener()
	self._btnok:RemoveClickListener()
end

function WeekWalkSelectTarotView:_btncloseOnClick()
	WeekwalkRpc.instance:sendMarkShowBuffRequest()
	self:closeThis()
end

function WeekWalkSelectTarotView:_btnokOnClick()
	self:_confirmSelect()
end

function WeekWalkSelectTarotView:_editableInitView()
	self._itemList = self:getUserDataTb_()

	self._simagebg:LoadImage(ResUrl.getWeekWalkBg("full/bg_beibao00.png"))
	self._simageline:LoadImage(ResUrl.getWeekWalkBg("btn_01.png"))

	self._gotarotitems = self:getUserDataTb_()

	for i = 1, 3 do
		local tarotItem = gohelper.findChild(self.viewGO, "#go_container/weekwalktarotitem" .. i)

		table.insert(self._gotarotitems, tarotItem)
		gohelper.setActive(tarotItem, i == 1)
	end

	gohelper.addUIClickAudio(self._btnok.gameObject, AudioEnum.WeekWalk.play_artificial_ui_carddisappear)
	WeekWalkController.instance:registerCallback(WeekWalkEvent.OnConfirmBindingBuff, self._updateViewSwithTime, self)
end

function WeekWalkSelectTarotView:onUpdateParam()
	return
end

function WeekWalkSelectTarotView:onOpen()
	self._buffId = self.viewParam.buffId

	self:_refreshUI({
		self._buffId
	})
	self.addEventCb(self, WeekWalkController.instance, WeekWalkEvent.TarotReply, self._onTarotReply, self)
	AudioMgr.instance:trigger(AudioEnum.WeekWalk.play_artificial_ui_cardappear)
end

function WeekWalkSelectTarotView:_refreshUI(buffIds)
	for i, configId in ipairs(buffIds) do
		if self._gotarotitems then
			local tarotItemGO = self._gotarotitems[i]
			local tarotitem = tarotItemGO and MonoHelper.addNoUpdateLuaComOnceToGo(tarotItemGO, WeekWalkTarotItem)
			local mo = {}

			mo.tarotId = configId
			mo.config = lua_weekwalk_buff.configDict[configId]

			tarotitem:onUpdateMO(mo, true)
			tarotitem:setClickCallback(self._onTarotSelect, self)
			table.insert(self._itemList, tarotitem)
		end
	end
end

function WeekWalkSelectTarotView:_onTarotSelect(item)
	return
end

function WeekWalkSelectTarotView:_doOnTarotSelect(item)
	if self._selectItem then
		transformhelper.setLocalScale(self._selectItem.viewGO.transform, 1, 1, 1)
	end

	self._selectTarotInfo = item.info
	self._selectItem = item

	transformhelper.setLocalScale(self._selectItem.viewGO.transform, 1.2, 1.2, 1)
end

function WeekWalkSelectTarotView:_confirmSelect()
	if not self._selectTarotInfo then
		return
	end

	if self._selectTarotInfo.config.type == WeekWalkEnum.BuffType.Pray then
		if WeekWalkCardListModel.instance:verifyCondition(self._selectTarotInfo.tarotId) then
			WeekWalkController.instance:dispatchEvent(WeekWalkEvent.OnClickTarot, self._selectItem.viewGO)
			TaskDispatcher.runDelay(self._delayToSwitchView, self, WeekWalkSelectTarotView.delaySwitchViewTime)
		end

		return
	end

	WeekWalkController.instance:dispatchEvent(WeekWalkEvent.OnClickTarot, self._selectItem.viewGO)
	WeekwalkRpc.instance:sendWeekwalkBuffRequest(self._selectTarotInfo.tarotId, 0, 0)
end

function WeekWalkSelectTarotView:_delayToSwitchView()
	WeekWalkController.instance:openWeekWalkBuffBindingView(self._selectTarotInfo)
end

function WeekWalkSelectTarotView:_onTarotReply(msg)
	WeekWalkModel.instance:setBuffReward(nil)
	TaskDispatcher.runDelay(self._delayToCloseThis, self, WeekWalkSelectTarotView.delaySwitchViewTime)
end

function WeekWalkSelectTarotView:_delayToCloseThis()
	self:closeThis()
end

function WeekWalkSelectTarotView:onClose()
	TaskDispatcher.cancelTask(self._delayToSwitchView, self)
	TaskDispatcher.cancelTask(self._delayToCloseThis, self)
end

function WeekWalkSelectTarotView:_updateViewSwithTime(delaySwithTime)
	WeekWalkSelectTarotView.delaySwitchViewTime = delaySwithTime or 0
end

function WeekWalkSelectTarotView:onDestroyView()
	self._simagebg:UnLoadImage()
	self._simageline:UnLoadImage()
	WeekWalkController.instance:unregisterCallback(WeekWalkEvent.OnConfirmBindingBuff, self._updateViewSwithTime, self)
end

return WeekWalkSelectTarotView
