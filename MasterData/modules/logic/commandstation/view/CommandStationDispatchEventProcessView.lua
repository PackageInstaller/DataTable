-- chunkname: @modules/logic/commandstation/view/CommandStationDispatchEventProcessView.lua

module("modules.logic.commandstation.view.CommandStationDispatchEventProcessView", package.seeall)

local CommandStationDispatchEventProcessView = class("CommandStationDispatchEventProcessView", BaseView)

function CommandStationDispatchEventProcessView:onInitView()
	self._goDispatchEvent = gohelper.findChild(self.viewGO, "#go_DispatchEvent")
	self._goDispatchPanel = gohelper.findChild(self.viewGO, "#go_DispatchEvent/#go_DispatchPanel")
	self._txttitle = gohelper.findChildText(self.viewGO, "#go_DispatchEvent/#go_DispatchPanel/Layout/right/#txt_title")
	self._txtDescr = gohelper.findChildText(self.viewGO, "#go_DispatchEvent/#go_DispatchPanel/Layout/right/Scroll DecView/Viewport/#txt_Descr")
	self._goHerocontainer = gohelper.findChild(self.viewGO, "#go_DispatchEvent/#go_DispatchPanel/Layout/right/#go_Herocontainer")
	self._txtspecialtip = gohelper.findChildText(self.viewGO, "#go_DispatchEvent/#go_DispatchPanel/Layout/right/#go_Herocontainer/#txt_specialtip")
	self._goselectheroitem = gohelper.findChild(self.viewGO, "#go_DispatchEvent/#go_DispatchPanel/Layout/right/#go_Herocontainer/herocontainer/#go_selectheroitem")
	self._goItem = gohelper.findChild(self.viewGO, "#go_DispatchEvent/#go_DispatchPanel/Layout/right/Bottom/Reward/#go_Item")
	self._godispatch = gohelper.findChild(self.viewGO, "#go_DispatchEvent/#go_DispatchPanel/Layout/right/Bottom/Btn/#go_dispatch")
	self._txtcosttime2 = gohelper.findChildText(self.viewGO, "#go_DispatchEvent/#go_DispatchPanel/Layout/right/Bottom/Btn/#go_dispatch/#txt_costtime2")
	self._btndispatch = gohelper.findChildButtonWithAudio(self.viewGO, "#go_DispatchEvent/#go_DispatchPanel/Layout/right/Bottom/Btn/#go_dispatch/#btn_dispatch")
	self._going = gohelper.findChild(self.viewGO, "#go_DispatchEvent/#go_DispatchPanel/Layout/right/Bottom/Btn/#go_ing")
	self._txttime = gohelper.findChildText(self.viewGO, "#go_DispatchEvent/#go_DispatchPanel/Layout/right/Bottom/Btn/#go_ing/#txt_time")
	self._sliderprogress = gohelper.findChildSlider(self.viewGO, "#go_DispatchEvent/#go_DispatchPanel/Layout/right/Bottom/Btn/#go_ing/#slider_progress")
	self._goherocontainer = gohelper.findChild(self.viewGO, "#go_DispatchEvent/#go_DispatchPanel/Layout/left/#go_herocontainer")
	self._btnclose2 = gohelper.findChildButtonWithAudio(self.viewGO, "#go_DispatchEvent/#go_DispatchPanel/Layout/left/#go_herocontainer/header/#btn_close2")
	self._scrollhero = gohelper.findChildScrollRect(self.viewGO, "#go_DispatchEvent/#go_DispatchPanel/Layout/left/#go_herocontainer/Mask/#scroll_hero")
	self._gotopright = gohelper.findChild(self.viewGO, "#go_DispatchEvent/#go_DispatchPanel/#go_topright")
	self._golefttop = gohelper.findChild(self.viewGO, "#go_lefttop")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CommandStationDispatchEventProcessView:addEvents()
	self._btndispatch:AddClickListener(self._btndispatchOnClick, self)
	self._btnclose2:AddClickListener(self._btnclose2OnClick, self)
end

function CommandStationDispatchEventProcessView:removeEvents()
	self._btndispatch:RemoveClickListener()
	self._btnclose2:RemoveClickListener()
end

function CommandStationDispatchEventProcessView:_btnclose2OnClick()
	self:_changeHeroContainerVisible(false)
end

function CommandStationDispatchEventProcessView:_btndispatchOnClick()
	local eventConfig = self:_getEventConfig()

	if not eventConfig then
		return
	end

	self:_changeHeroContainerVisible(false)

	local num = CommandStationHeroListModel.instance:getSelectedHeroNum()

	if num ~= eventConfig.chaNum then
		GameFacade.showToast(ToastEnum.V1a5_DungeonDispatchLessMinHero)

		return
	end

	local heroList = CommandStationHeroListModel.instance:getSelectedHeroIdList()

	CommandStationRpc.instance:sendCommandPostDispatchRequest(eventConfig.id, heroList, self._onDispatchSuccess, self)
end

function CommandStationDispatchEventProcessView:_onDispatchSuccess(cmd, resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local eventConfig = self:_getEventConfig()

	if not eventConfig then
		return
	end

	GameFacade.showToast(ToastEnum.V1a5_DungeonDispatchSuccess)
	self:_updateEventState(eventConfig)
	self:_updateBtnState(eventConfig)
	self:_updateEventInfo(eventConfig)
	CommandStationController.instance:dispatchEvent(CommandStationEvent.DispatchStart)
end

function CommandStationDispatchEventProcessView:_btnreturnOnClick()
	return
end

function CommandStationDispatchEventProcessView:_editableInitView()
	self._animator = self.viewGO:GetComponent("Animator")

	gohelper.setActive(self._goherocontainer, false)
	self.addEventCb(self, CommandStationController.instance, CommandStationEvent.DispatchHeroListChange, self._onDispatchHeroListChange, self)
end

function CommandStationDispatchEventProcessView:_onDispatchHeroListChange()
	local eventConfig = self:_getEventConfig()

	if not eventConfig then
		return
	end

	self:_updateHeroList(eventConfig)
end

function CommandStationDispatchEventProcessView:onUpdateParam()
	return
end

function CommandStationDispatchEventProcessView:onOpen()
	self.addEventCb(self, CommandStationController.instance, CommandStationEvent.DispatchChangeTab, self._onDispatchChangeTab, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._OnCloseViewFinish, self)
	self:_initHeroList()
end

function CommandStationDispatchEventProcessView:_OnCloseViewFinish()
	self:_sendFinishEventRequest()
end

function CommandStationDispatchEventProcessView:_onDispatchChangeTab(isChange, isToLeft)
	if self._isShow and not isChange and isToLeft ~= nil then
		if not self._oldEventConfig then
			return
		end

		self._isPlaySwitchAnim = true

		self:_updateAllInfo(self._oldEventConfig)
		self._animator:Play(isToLeft and "switchleft" or "switchright", 0, 0)
		TaskDispatcher.cancelTask(self._afterSwitchUpdateEventInfo, self)
		TaskDispatcher.runDelay(self._afterSwitchUpdateEventInfo, self, 0.167)
	end
end

function CommandStationDispatchEventProcessView:_afterSwitchUpdateEventInfo()
	self._isPlaySwitchAnim = false

	self:_updateAllInfo(self._eventConfig)
end

function CommandStationDispatchEventProcessView:onTabSwitchOpen()
	if not self._isShow then
		self._animator:Play("open", 0, 0)
	end

	self._heroContainerVisible = false
	self._isShow = true
	self._oldEventConfig = self._eventConfig
	self._eventConfig = self.viewContainer:getCurrentEventConfig()

	self:_updateAllInfo(self._eventConfig)
end

function CommandStationDispatchEventProcessView:_getEventConfig()
	if self._isPlaySwitchAnim then
		return nil
	end

	return self._eventConfig
end

function CommandStationDispatchEventProcessView:_updateAllInfo(eventConfig)
	CommandStationHeroListModel.instance:initAllEventSelectedHeroList()
	CommandStationHeroListModel.instance:setSpecialHeroList(eventConfig.chaId)
	CommandStationHeroListModel.instance:setSelectedHeroNum(eventConfig.chaNum)
	self:_updateEventState(eventConfig)
	self:_updateEventInfo(eventConfig)
	self:_updateHeroList(eventConfig)
	self:_updateBtnState(eventConfig)
	self:_showReward(eventConfig)
end

function CommandStationDispatchEventProcessView:onTabSwitchClose()
	self._isShow = false

	CommandStationHeroListModel.instance:clearHeroList()
	CommandStationHeroListModel.instance:clearSelectedHeroList()
	self:_killTween()
	gohelper.setActive(self._goherocontainer, false)
end

function CommandStationDispatchEventProcessView:_updateHeroList(eventConfig)
	self._specialHeroNum = 0

	if self._eventState == CommandStationEnum.DispatchState.NotStart then
		self:_updateNotStartHeroList(eventConfig)
	else
		self:_updateStartedHeroList(eventConfig)
	end
end

function CommandStationDispatchEventProcessView:_updateNotStartHeroList(eventConfig)
	local showNum = eventConfig.chaNum

	for i, v in ipairs(self._heroList) do
		local show = i <= showNum

		gohelper.setActive(v.item, show)

		local mo = CommandStationHeroListModel.instance:getHeroByIndex(i)

		show = show and mo

		gohelper.setActive(v.container, show)

		if show then
			local heroConfig = mo.config
			local skinId = heroConfig.skinId
			local skinConfig = SkinConfig.instance:getSkinCo(skinId)

			v.icon:LoadImage(ResUrl.getHeadIconSmall(skinConfig.headIcon))
			UISpriteSetMgr.instance:setCommonSprite(v.career, "lssx_" .. heroConfig.career)

			if CommandStationHeroListModel.instance:heroIsSpecial(mo.heroId) then
				self._specialHeroNum = self._specialHeroNum + 1
			end
		end
	end

	if self._specialHeroNum > 0 then
		if not (eventConfig.allTime - eventConfig.reduceTime) then
			local time = eventConfig.allTime

			self:_updateCostTime(time)
		end
	end
end

function CommandStationDispatchEventProcessView:_updateStartedHeroList()
	local list = self._eventInfo.heroIds

	for i, v in ipairs(self._heroList) do
		local heroId = list[i]
		local mo = HeroModel.instance:getByHeroId(heroId)

		if mo then
			gohelper.setActive(v.container, true)

			local heroConfig = mo.config
			local skinId = heroConfig.skinId
			local skinConfig = SkinConfig.instance:getSkinCo(skinId)

			v.icon:LoadImage(ResUrl.getHeadIconSmall(skinConfig.headIcon))
			UISpriteSetMgr.instance:setCommonSprite(v.career, "lssx_" .. heroConfig.career)
		end

		if CommandStationHeroListModel.instance:heroIsSpecial(heroId) then
			self._specialHeroNum = self._specialHeroNum + 1
		end
	end
end

function CommandStationDispatchEventProcessView:_updateCostTime(time)
	local timeStr = tostring(time) .. "s"

	self._txtcosttime2.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("commandstation_dispatch_event_forecast_time"), timeStr)
end

function CommandStationDispatchEventProcessView:_formatTime(sec)
	local hour, minute, second = TimeUtil.secondToHMS(sec)

	return string.format("%s:%s:%s", self:_formatNum(hour), self:_formatNum(minute), self:_formatNum(second))
end

function CommandStationDispatchEventProcessView:_formatNum(num)
	if num >= 10 then
		return num
	end

	return "0" .. num
end

function CommandStationDispatchEventProcessView:_initHeroList()
	if self._addBtnList then
		return
	end

	self._addBtnList = self:getUserDataTb_()
	self._heroList = self:getUserDataTb_()

	for i = 2, CommandStationEnum.DispatchCharacterNum do
		local heroItem = gohelper.cloneInPlace(self._goselectheroitem)

		self:_initHeroItem(heroItem, i)
	end

	self:_initHeroItem(self._goselectheroitem, 1)
end

function CommandStationDispatchEventProcessView:_initHeroItem(heroItem, index)
	local btnAdd = gohelper.findChildButtonWithAudio(heroItem, "add")

	btnAdd:AddClickListener(self._btnAddOnClick, self)

	self._addBtnList[index] = btnAdd

	local container = gohelper.findChild(heroItem, "go_hero")
	local icon = gohelper.findChildSingleImage(heroItem, "go_hero/simage_heroicon")
	local career = gohelper.findChildImage(heroItem, "go_hero/image_career")

	gohelper.setActive(container, false)

	self._heroList[index] = {
		item = heroItem,
		container = container,
		icon = icon,
		career = career
	}
end

function CommandStationDispatchEventProcessView:_btnAddOnClick()
	if self._eventState ~= CommandStationEnum.DispatchState.NotStart then
		return
	end

	self:_changeHeroContainerVisible(true)
	CommandStationHeroListModel.instance:initHeroList()
end

function CommandStationDispatchEventProcessView:_changeHeroContainerVisible(visible)
	if self._heroContainerVisible == visible then
		return
	end

	self._heroContainerVisible = visible

	gohelper.setActive(self._goherocontainer, true)
	self._animator:Play(visible and "leftin" or "leftout", 0, 0)
end

function CommandStationDispatchEventProcessView:_updateEventInfo(eventConfig)
	local textList = string.splitToNumber(eventConfig.eventTextId, "#")

	if self._eventState == CommandStationEnum.DispatchState.GetReward then
		if not textList[2] then
			local eventTextId = textList[1]
			local eventTxtConfig = eventTextId and lua_copost_event_text.configDict[eventTextId]

			self._txtDescr.text = eventTxtConfig and eventTxtConfig.text

			ZProj.UGUIHelper.RebuildLayout(self._txtDescr.transform)

			self._txtspecialtip.text = eventConfig.needchaText

			local showTip = not string.nilorempty(eventConfig.needchaText)

			gohelper.setActive(self._txtspecialtip, showTip)
		end
	end
end

function CommandStationDispatchEventProcessView:_updateEventState(eventConfig)
	local eventId = eventConfig.id

	self._eventInfo = CommandStationModel.instance:getDispatchEventInfo(eventId)
	self._eventState = CommandStationModel.instance:getDispatchEventState(eventId)
end

function CommandStationDispatchEventProcessView:_updateBtnState(eventConfig)
	gohelper.setActive(self._godispatch, self._eventState == CommandStationEnum.DispatchState.NotStart)
	gohelper.setActive(self._going, self._eventState ~= CommandStationEnum.DispatchState.NotStart)

	if self._eventState == CommandStationEnum.DispatchState.NotStart then
		return
	end

	self:_updateProgress(eventConfig)
end

function CommandStationDispatchEventProcessView:_killTween()
	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)

		self._tweenId = nil
	end
end

function CommandStationDispatchEventProcessView:_startTween(from, to, time)
	self._tweenId = ZProj.TweenHelper.DOTweenFloat(from, to, time, self._onTweenUpdate, self._onTweenFinish, self)
end

function CommandStationDispatchEventProcessView:_onTweenUpdate(value)
	local remainTime = self._remainTime - (Time.realtimeSinceStartup - self._startTweenTime)

	remainTime = math.max(remainTime, 0)
	self._txttime.text = string.format("%ss", math.ceil(remainTime))

	self._sliderprogress:SetValue(remainTime / self._totalTime)
end

function CommandStationDispatchEventProcessView:_onTweenFinish()
	self._needFinishRequest = true

	self:_sendFinishEventRequest()
end

function CommandStationDispatchEventProcessView:_sendFinishEventRequest()
	local eventConfig = self:_getEventConfig()

	if not eventConfig then
		return
	end

	if self._isShow and self._needFinishRequest and ViewHelper.instance:checkViewOnTheTop(ViewName.CommandStationDispatchEventMainView) then
		self._needFinishRequest = false

		CommandStationRpc.instance:sendFinishCommandPostEventRequest(eventConfig.id, self._finishCommand, self)
	end
end

function CommandStationDispatchEventProcessView:_updateProgress(eventConfig)
	local remainTime, totalTime = self._eventInfo:getTimeInfo()

	self._remainTime = math.min(remainTime, totalTime)
	self._startTweenTime = Time.realtimeSinceStartup
	self._totalTime = totalTime

	self:_killTween()
	self:_startTween(remainTime / totalTime, 0, remainTime)
end

function CommandStationDispatchEventProcessView:_finishCommand(cmd, resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local eventConfig = self:_getEventConfig()

	if not eventConfig then
		return
	end

	self:_updateEventState(eventConfig)
	CommandStationController.instance:dispatchEvent(CommandStationEvent.DispatchFinish)
end

function CommandStationDispatchEventProcessView:_showReward(eventConfig)
	gohelper.setActive(self._goItem, false)

	self._itemList = self._itemList or self:getUserDataTb_()

	local rewards = string.split(eventConfig.bonus, "|")

	for i = 1, #rewards do
		local item = self._itemList[i]

		if not item then
			item = {
				parentGo = gohelper.cloneInPlace(self._goItem)
			}
			item.commonitemicon = gohelper.findChild(item.parentGo, "commonitemicon")
			item.itemIcon = IconMgr.instance:getCommonPropItemIcon(item.commonitemicon)
			self._itemList[i] = item
		end

		local itemCo = string.splitToNumber(rewards[i], "#")

		gohelper.setActive(item.parentGo, true)
		item.itemIcon:setMOValue(itemCo[1], itemCo[2], itemCo[3], nil, true)
		item.itemIcon:isShowCount(itemCo[1] ~= MaterialEnum.MaterialType.Hero)
		item.itemIcon:setCountFontSize(40)
		item.itemIcon:showStackableNum2()
		item.itemIcon:setHideLvAndBreakFlag(true)
		item.itemIcon:hideEquipLvAndBreak(true)
	end

	for i = #rewards + 1, #self._itemList do
		local item = self._itemList[i]

		if item then
			gohelper.setActive(item.parentGo, false)
		end
	end
end

function CommandStationDispatchEventProcessView:onClose()
	if self._addBtnList then
		for i, v in ipairs(self._addBtnList) do
			v:RemoveClickListener()
		end
	end

	self._animator:Play("close", 0, 0)
	TaskDispatcher.cancelTask(self._afterSwitchUpdateEventInfo, self)
end

function CommandStationDispatchEventProcessView:onDestroyView()
	return
end

return CommandStationDispatchEventProcessView
