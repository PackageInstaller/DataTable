-- chunkname: @modules/logic/versionactivity1_5/dungeon/view/dispatch/VersionActivity1_5DispatchView.lua

module("modules.logic.versionactivity1_5.dungeon.view.dispatch.VersionActivity1_5DispatchView", package.seeall)

local VersionActivity1_5DispatchView = class("VersionActivity1_5DispatchView", BaseView)

function VersionActivity1_5DispatchView:onInitView()
	self._goback = gohelper.findChild(self.viewGO, "#go_back")
	self._gomapcontainer = gohelper.findChild(self.viewGO, "container/left/#go_mapcontainer")
	self._simagemap = gohelper.findChildSingleImage(self.viewGO, "container/left/#go_mapcontainer/#simage_map")
	self._goherocontainer = gohelper.findChild(self.viewGO, "container/left/#go_herocontainer")
	self._goclosehero = gohelper.findChild(self.viewGO, "container/left/#go_herocontainer/header/#go_closehero")
	self._goclose = gohelper.findChild(self.viewGO, "container/right/#go_close")
	self._txttitle = gohelper.findChildText(self.viewGO, "container/right/#txt_title")
	self._txtdesc = gohelper.findChildText(self.viewGO, "container/right/Scroll View/Viewport/Content/#txt_desc")
	self._txtcosttime = gohelper.findChildText(self.viewGO, "container/right/#txt_costtime")
	self._gotimelock = gohelper.findChild(self.viewGO, "container/right/#txt_costtime/locked")
	self._btnstartdispatch = gohelper.findChildButtonWithAudio(self.viewGO, "container/right/#btn_startdispatch")
	self._btninterruptdispatch = gohelper.findChildButtonWithAudio(self.viewGO, "container/right/#btn_interruptdispatch")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity1_5DispatchView:addEvents()
	self._btnstartdispatch:AddClickListener(self._btnstartdispatchOnClick, self)
	self._btninterruptdispatch:AddClickListener(self._btninterruptdispatchOnClick, self)
end

function VersionActivity1_5DispatchView:removeEvents()
	self._btnstartdispatch:RemoveClickListener()
	self._btninterruptdispatch:RemoveClickListener()
end

VersionActivity1_5DispatchView.DarkColor = "#3d5a4a"
VersionActivity1_5DispatchView.LightColor = "#287B4D"

function VersionActivity1_5DispatchView:_btnstartdispatchOnClick()
	if self.status ~= VersionActivity1_5DungeonEnum.DispatchStatus.NotDispatch then
		return
	end

	local selectedCount = VersionActivity1_5HeroListModel.instance:getSelectedHeroCount()

	if selectedCount < self.dispatchCo.minCount then
		GameFacade.showToast(ToastEnum.V1a5_DungeonDispatchLessMinHero)

		return
	end

	VersionActivity1_5DungeonRpc.instance:sendAct139DispatchRequest(self.dispatchId, VersionActivity1_5HeroListModel.instance:getSelectedHeroIdList(), self.onDispatchSuccess, self)
end

function VersionActivity1_5DispatchView:onDispatchSuccess()
	GameFacade.showToast(ToastEnum.V1a5_DungeonDispatchSuccess)
end

function VersionActivity1_5DispatchView:_btninterruptdispatchOnClick()
	if self.status ~= VersionActivity1_5DungeonEnum.DispatchStatus.Dispatching then
		return
	end

	if self.dispatchMo:isFinish() then
		return
	end

	VersionActivity1_5DungeonRpc.instance:sendAct139InterruptDispatchRequest(self.dispatchId)
end

function VersionActivity1_5DispatchView:onClickHeroClose()
	VersionActivity1_5DungeonController.instance:dispatchEvent(VersionActivity1_5DungeonEvent.ChangeDispatchHeroContainerEvent, false)
end

function VersionActivity1_5DispatchView:_editableInitView()
	self.backClick = gohelper.getClick(self._goback)

	self.backClick:AddClickListener(self.closeThis, self)

	self.closeClick = gohelper.getClick(self._goclose)

	self.closeClick:AddClickListener(self.closeThis, self)

	self.heroCloseClick = gohelper.getClick(self._goclosehero)

	self.heroCloseClick:AddClickListener(self.onClickHeroClose, self)

	self.simagebg = gohelper.findChildSingleImage(self.viewGO, "container/bg02")

	self.simagebg:LoadImage(ResUrl.getV1a5DungeonSingleBg("paiqian/v1a5_dungeon_bg_paiqian02"))
	self:changeHeroContainerVisible(false)

	self.checkShortedTimeFuncDict = {
		[VersionActivity1_5DungeonEnum.DispatchShortedType.Career] = self.checkCareer,
		[VersionActivity1_5DungeonEnum.DispatchShortedType.HeroId] = self.checkHeroID
	}

	self.addEventCb(self, VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.ChangeDispatchHeroContainerEvent, self.changeHeroContainerVisible, self)
	self.addEventCb(self, VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.AddDispatchInfo, self.onAddDispatchInfo, self)
	self.addEventCb(self, VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.RemoveDispatchInfo, self.onRemoveDispatchInfo, self)
	self.addEventCb(self, VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.OnDispatchFinish, self.onDispatchFinish, self)
	self.addEventCb(self, VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.ChangeSelectedHero, self.onSelectHeroMoChange, self)
	TaskDispatcher.runRepeat(self.everySecondCall, self, 1)
end

function VersionActivity1_5DispatchView:changeHeroContainerVisible(isShow)
	if self.preIsShow == isShow then
		return
	end

	self.preIsShow = isShow

	if self.preIsShow then
		AudioMgr.instance:trigger(AudioEnum.Meilanni.play_ui_mln_unlock)
	end

	gohelper.setActive(self._goherocontainer, isShow)
	gohelper.setActive(self._gomapcontainer, not isShow)
end

function VersionActivity1_5DispatchView:onDispatchFinish()
	self:refreshHeroContainer()
end

function VersionActivity1_5DispatchView:onRemoveDispatchInfo(dispatchId)
	if dispatchId ~= self.dispatchId then
		return
	end

	VersionActivity1_5HeroListModel.instance:resetSelectHeroList()
	self:onDispatchInfoChange()
end

function VersionActivity1_5DispatchView:onAddDispatchInfo(dispatchId)
	if dispatchId ~= self.dispatchId then
		return
	end

	self:changeHeroContainerVisible(false)
	self:onDispatchInfoChange()
end

function VersionActivity1_5DispatchView:onDispatchInfoChange()
	self:changeDispatchStatus()

	if self.status == VersionActivity1_5DungeonEnum.DispatchStatus.Finished then
		self:closeThis()

		return
	end

	self:refreshHeroContainer()
	self:refreshSelectedHero()
	self:refreshCostTime()
	self:refreshBtn()
end

function VersionActivity1_5DispatchView:onSelectHeroMoChange()
	self:refreshStartBtnGray()
	self:refreshCostTime()
end

function VersionActivity1_5DispatchView:onOpen()
	self.dispatchId = self.viewParam.dispatchId
	self.dispatchCo = VersionActivity1_5DungeonConfig.instance:getDispatchCo(self.dispatchId)

	self:changeDispatchStatus()

	if self.status == VersionActivity1_5DungeonEnum.DispatchStatus.Finished then
		self:closeThis()

		return
	end

	VersionActivity1_5HeroListModel.instance:onOpenDispatchView(self.dispatchCo)
	self:initSelectedHeroItem()
	self:refreshUI()
end

function VersionActivity1_5DispatchView:initSelectedHeroItem()
	self.selectedHeroItemList = {}

	for i = 1, 4 do
		local go = gohelper.findChild(self.viewGO, "container/right/selectedherocontainer/herocontainer/go_selectheroitem" .. i)

		if i <= self.dispatchCo.maxCount then
			table.insert(self.selectedHeroItemList, VersionActivity1_5DispatchSelectHeroItem.createItem(go, i))
		else
			gohelper.setActive(go, false)
		end
	end
end

function VersionActivity1_5DispatchView:refreshUI()
	self:refreshLeft()
	self:refreshRight()
end

function VersionActivity1_5DispatchView:refreshLeft()
	self:refreshMap()
	self:refreshHeroContainer()
end

function VersionActivity1_5DispatchView:refreshRight()
	self._txttitle.text = self.dispatchCo.title
	self._txtdesc.text = self.dispatchCo.desc

	self:refreshSelectedHero()
	self:refreshCostTime()
	self:refreshBtn()
end

function VersionActivity1_5DispatchView:refreshMap()
	self._simagemap:LoadImage(ResUrl.getV1a5DungeonSingleBg("paiqian/v1a5_dungeon_img_chahua_" .. self.dispatchCo.image))
end

function VersionActivity1_5DispatchView:refreshHeroContainer()
	VersionActivity1_5HeroListModel.instance:refreshHero()
end

function VersionActivity1_5DispatchView:refreshSelectedHero()
	for _, selectedHeroItem in ipairs(self.selectedHeroItemList) do
		selectedHeroItem:refreshUI()
	end
end

function VersionActivity1_5DispatchView:refreshCostTime()
	if self.status == VersionActivity1_5DungeonEnum.DispatchStatus.Finished then
		logError("dispatch finished")

		return
	end

	if self.status == VersionActivity1_5DungeonEnum.DispatchStatus.Dispatching then
		if self.dispatchMo:isFinish() then
			self:closeThis()

			return
		end

		gohelper.setActive(self._gotimelock, false)

		self._txtcosttime.text = self.dispatchMo:getRemainTimeStr()

		return
	end

	local timeArray = string.splitToNumber(self.dispatchCo.time, "|")
	local costTime = timeArray[1]
	local color = VersionActivity1_5DispatchView.DarkColor
	local checkShortFunc = self.checkShortedTimeFuncDict[self.dispatchCo.shortType]

	if checkShortFunc and checkShortFunc(self) then
		costTime = costTime - timeArray[2]
		color = VersionActivity1_5DispatchView.LightColor

		gohelper.setActive(self._gotimelock, false)
	else
		gohelper.setActive(self._gotimelock, true)
	end

	local hour = Mathf.Floor(costTime / TimeUtil.OneHourSecond)
	local minuteSeconds = costTime % TimeUtil.OneHourSecond
	local minute = Mathf.Floor(minuteSeconds / TimeUtil.OneMinuteSecond)
	local second = minuteSeconds % TimeUtil.OneMinuteSecond
	local text = string.format("%s%s%s%s%s%s%s", luaLang("dispatch_cost_time"), hour, luaLang("time_hour"), minute, luaLang("time_minute"), second, luaLang("time_second"))

	self._txtcosttime.text = string.format("<color=%s>%s</color>", color, text)
end

function VersionActivity1_5DispatchView:checkCareer()
	local heroList = VersionActivity1_5HeroListModel.instance:getSelectedHeroList()

	if not heroList or #heroList == 0 then
		return false
	end

	local paramList = string.splitToNumber(self.dispatchCo.extraParam, "|")
	local count = paramList[1]
	local career = paramList[2]
	local careerCount = 0

	for _, heroMo in ipairs(heroList) do
		if heroMo.config.career == career then
			careerCount = careerCount + 1
		end
	end

	return count <= careerCount
end

function VersionActivity1_5DispatchView:checkHeroID()
	local heroList = VersionActivity1_5HeroListModel.instance:getSelectedHeroList()

	if not heroList then
		return false
	end

	local paramList = string.split(self.dispatchCo.extraParam, "|")
	local count = tonumber(paramList[1])
	local heroIdList = string.splitToNumber(paramList[2], "#")
	local heroCount = 0

	for _, heroMo in ipairs(heroList) do
		if tabletool.indexOf(heroIdList, heroMo.heroId) then
			heroCount = heroCount + 1
		end
	end

	return count <= heroCount
end

function VersionActivity1_5DispatchView:refreshBtn()
	gohelper.setActive(self._btnstartdispatch.gameObject, self.status == VersionActivity1_5DungeonEnum.DispatchStatus.NotDispatch)
	gohelper.setActive(self._btninterruptdispatch.gameObject, self.status == VersionActivity1_5DungeonEnum.DispatchStatus.Dispatching)
	self:refreshStartBtnGray()
end

function VersionActivity1_5DispatchView:refreshStartBtnGray()
	if self.status == VersionActivity1_5DungeonEnum.DispatchStatus.NotDispatch then
		local selectedCount = VersionActivity1_5HeroListModel.instance:getSelectedHeroCount()

		ZProj.UGUIHelper.SetGrayscale(self._btnstartdispatch.gameObject, selectedCount < self.dispatchCo.minCount)
	end
end

function VersionActivity1_5DispatchView:changeDispatchStatus()
	self.status = VersionActivity1_5DungeonModel.instance:getDispatchStatus(self.dispatchId)
	self.dispatchMo = VersionActivity1_5DungeonModel.instance:getDispatchMo(self.dispatchId)

	VersionActivity1_5HeroListModel.instance:setDispatchViewStatus(self.status)
end

function VersionActivity1_5DispatchView:everySecondCall()
	if self.status == VersionActivity1_5DungeonEnum.DispatchStatus.Dispatching then
		self:refreshCostTime()
	end
end

function VersionActivity1_5DispatchView:onClose()
	self.removeEventCb(self, VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.ChangeDispatchHeroContainerEvent, self.changeHeroContainerVisible, self)
	self.removeEventCb(self, VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.AddDispatchInfo, self.onAddDispatchInfo, self)
	self.removeEventCb(self, VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.RemoveDispatchInfo, self.onRemoveDispatchInfo, self)
	self.removeEventCb(self, VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.OnDispatchFinish, self.onDispatchFinish, self)
	self.removeEventCb(self, VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.ChangeSelectedHero, self.onSelectHeroMoChange, self)
	VersionActivity1_5HeroListModel.instance:onCloseDispatchView()
	TaskDispatcher.cancelTask(self.everySecondCall, self)
end

function VersionActivity1_5DispatchView:onDestroyView()
	self.backClick:RemoveClickListener()
	self.closeClick:RemoveClickListener()
	self.heroCloseClick:RemoveClickListener()
	self.simagebg:UnLoadImage()
	self._simagemap:UnLoadImage()

	for _, selectedItem in ipairs(self.selectedHeroItemList) do
		selectedItem:destroy()
	end

	self.selectedHeroItemList = nil
end

return VersionActivity1_5DispatchView
