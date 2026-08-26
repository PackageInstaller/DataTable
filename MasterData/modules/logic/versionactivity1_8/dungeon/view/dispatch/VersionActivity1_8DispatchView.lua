-- chunkname: @modules/logic/versionactivity1_8/dungeon/view/dispatch/VersionActivity1_8DispatchView.lua

module("modules.logic.versionactivity1_8.dungeon.view.dispatch.VersionActivity1_8DispatchView", package.seeall)

local VersionActivity1_8DispatchView = class("VersionActivity1_8DispatchView", BaseView)
local HERO_COL_NUM = 4
local DARK_COLOR = "#3d5a4a"
local LIGHT_COLOR = "#287B4D"

function VersionActivity1_8DispatchView:onInitView()
	self._goback = gohelper.findChild(self.viewGO, "#go_back")
	self.backClick = gohelper.getClick(self._goback)
	self._gomapcontainer = gohelper.findChild(self.viewGO, "container/left/#go_mapcontainer")
	self._simagemap = gohelper.findChildSingleImage(self.viewGO, "container/left/#go_mapcontainer/#simage_map")
	self._goherocontainer = gohelper.findChild(self.viewGO, "container/left/#go_herocontainer")
	self._goclosehero = gohelper.findChild(self.viewGO, "container/left/#go_herocontainer/header/#go_closehero")
	self.heroCloseClick = gohelper.getClickWithAudio(self._goclosehero, AudioEnum.UI.play_ui_rolesopen)
	self._goclose = gohelper.findChild(self.viewGO, "container/right/#go_close")
	self.closeClick = gohelper.getClickWithAudio(self._goclose, AudioEnum.UI.play_ui_rolesopen)
	self._txtdesc = gohelper.findChildText(self.viewGO, "container/right/Scroll View/Viewport/Content/#txt_desc")
	self._txttitle = gohelper.findChildText(self.viewGO, "container/right/#txt_title")
	self._txtcosttime = gohelper.findChildText(self.viewGO, "container/right/#txt_costtime")
	self._gotimelock = gohelper.findChild(self.viewGO, "container/right/#txt_costtime/locked")
	self._btninterruptdispatch = gohelper.findChildButtonWithAudio(self.viewGO, "container/right/#btn_interruptdispatch")
	self._btnstartdispatch = gohelper.findChildButtonWithAudio(self.viewGO, "container/right/#btn_startdispatch")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity1_8DispatchView:addEvents()
	self.backClick:AddClickListener(self.closeThis, self)
	self.closeClick:AddClickListener(self.closeThis, self)
	self.heroCloseClick:AddClickListener(self.onClickHeroClose, self)
	self._btnstartdispatch:AddClickListener(self._btnstartdispatchOnClick, self)
	self._btninterruptdispatch:AddClickListener(self._btninterruptdispatchOnClick, self)
	self.addEventCb(self, DispatchController.instance, DispatchEvent.ChangeDispatchHeroContainerEvent, self.changeHeroContainerVisible, self)
	self.addEventCb(self, DispatchController.instance, DispatchEvent.AddDispatchInfo, self.onAddDispatchInfo, self)
	self.addEventCb(self, DispatchController.instance, DispatchEvent.RemoveDispatchInfo, self.onRemoveDispatchInfo, self)
	self.addEventCb(self, DispatchController.instance, DispatchEvent.OnDispatchFinish, self.onDispatchFinish, self)
	self.addEventCb(self, DispatchController.instance, DispatchEvent.ChangeSelectedHero, self.onSelectHeroMoChange, self)
end

function VersionActivity1_8DispatchView:removeEvents()
	self.backClick:RemoveClickListener()
	self.closeClick:RemoveClickListener()
	self.heroCloseClick:RemoveClickListener()
	self._btnstartdispatch:RemoveClickListener()
	self._btninterruptdispatch:RemoveClickListener()
	self.removeEventCb(self, DispatchController.instance, DispatchEvent.ChangeDispatchHeroContainerEvent, self.changeHeroContainerVisible, self)
	self.removeEventCb(self, DispatchController.instance, DispatchEvent.AddDispatchInfo, self.onAddDispatchInfo, self)
	self.removeEventCb(self, DispatchController.instance, DispatchEvent.RemoveDispatchInfo, self.onRemoveDispatchInfo, self)
	self.removeEventCb(self, DispatchController.instance, DispatchEvent.OnDispatchFinish, self.onDispatchFinish, self)
	self.removeEventCb(self, DispatchController.instance, DispatchEvent.ChangeSelectedHero, self.onSelectHeroMoChange, self)
end

function VersionActivity1_8DispatchView:onClickHeroClose()
	DispatchController.instance:dispatchEvent(DispatchEvent.ChangeDispatchHeroContainerEvent, false)
end

function VersionActivity1_8DispatchView:_btnstartdispatchOnClick()
	if self.status ~= DispatchEnum.DispatchStatus.NotDispatch then
		return
	end

	local isEnoughHero = false

	if self.dispatchCo then
		local selectedCount = DispatchHeroListModel.instance:getSelectedHeroCount()

		isEnoughHero = selectedCount >= self.dispatchCo.minCount
	end

	if not isEnoughHero then
		GameFacade.showToast(ToastEnum.V1a5_DungeonDispatchLessMinHero)

		return
	end

	local selectHeroIds = DispatchHeroListModel.instance:getSelectedHeroIdList()

	DispatchRpc.instance:sendDispatchRequest(self.elementId, self.dispatchId, selectHeroIds, self.onDispatchSuccess, self)
end

function VersionActivity1_8DispatchView:onDispatchSuccess(cmd, resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	GameFacade.showToast(ToastEnum.V1a5_DungeonDispatchSuccess)
	self:updateAct157Info()
end

function VersionActivity1_8DispatchView:_btninterruptdispatchOnClick()
	if self.status ~= DispatchEnum.DispatchStatus.Dispatching then
		return
	end

	if self.dispatchMo then
		local isFinish = self.dispatchMo:isFinish()

		if isFinish then
			return
		end

		DispatchRpc.instance:sendInterruptDispatchRequest(self.elementId, self.dispatchId, self.updateAct157Info, self)
	end
end

function VersionActivity1_8DispatchView:updateAct157Info()
	Activity157Controller.instance:getAct157ActInfo()
end

function VersionActivity1_8DispatchView:onAddDispatchInfo(dispatchId)
	if dispatchId ~= self.dispatchId then
		return
	end

	self:changeHeroContainerVisible(false)
	self:onDispatchInfoChange()
end

function VersionActivity1_8DispatchView:onRemoveDispatchInfo(dispatchId)
	if dispatchId ~= self.dispatchId then
		return
	end

	DispatchHeroListModel.instance:resetSelectHeroList()
	self:onDispatchInfoChange()
end

function VersionActivity1_8DispatchView:onDispatchInfoChange()
	self:changeDispatchStatus()

	if self.status == DispatchEnum.DispatchStatus.Finished then
		self:closeThis()

		return
	end

	self:refreshHeroContainer()
	self:refreshSelectedHero()
	self:refreshCostTime()
	self:refreshBtn()
end

function VersionActivity1_8DispatchView:onDispatchFinish()
	self:refreshHeroContainer()
end

function VersionActivity1_8DispatchView:onSelectHeroMoChange()
	self:refreshStartBtnGray()
	self:refreshCostTime()
end

function VersionActivity1_8DispatchView:_editableInitView()
	self.checkShortedTimeFuncDict = {
		[DispatchEnum.DispatchShortedType.Career] = self.checkCareer,
		[DispatchEnum.DispatchShortedType.HeroId] = self.checkHeroID
	}

	self:changeHeroContainerVisible(false)
	TaskDispatcher.runRepeat(self.everySecondCall, self, 1)
end

function VersionActivity1_8DispatchView:changeHeroContainerVisible(isShow)
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

function VersionActivity1_8DispatchView:onUpdateParam()
	return
end

function VersionActivity1_8DispatchView:onOpen()
	self.elementId = self.viewParam.elementId
	self.dispatchId = self.viewParam.dispatchId
	self.dispatchCo = DungeonConfig.instance:getDispatchCfg(self.dispatchId)

	self:changeDispatchStatus()

	if self.status == DispatchEnum.DispatchStatus.Finished then
		self:closeThis()

		return
	end

	DispatchHeroListModel.instance:onOpenDispatchView(self.dispatchCo, self.elementId)
	self:initSelectedHeroItem()
	self:refreshUI()
end

function VersionActivity1_8DispatchView:changeDispatchStatus()
	self.status = DispatchModel.instance:getDispatchStatus(self.elementId, self.dispatchId)
	self.dispatchMo = DispatchModel.instance:getDispatchMo(self.elementId, self.dispatchId)

	DispatchHeroListModel.instance:setDispatchViewStatus(self.status)
end

function VersionActivity1_8DispatchView:initSelectedHeroItem()
	self.selectedHeroItemList = {}

	if self.dispatchCo then
		if not self.dispatchCo.maxCount then
			local maxCount = 0

			for i = 1, HERO_COL_NUM do
				local go = gohelper.findChild(self.viewGO, "container/right/selectedherocontainer/herocontainer/go_selectheroitem" .. i)

				if i <= maxCount then
					local dispatchSelectHeroItem = MonoHelper.addNoUpdateLuaComOnceToGo(go, VersionActivity1_8DispatchSelectHeroItem, i)

					table.insert(self.selectedHeroItemList, dispatchSelectHeroItem)
				else
					gohelper.setActive(go, false)
				end
			end
		end
	end
end

function VersionActivity1_8DispatchView:refreshUI()
	if self.dispatchCo then
		local imgName = string.format("paiqian/v1a8_dungeon_img_map%s", self.dispatchCo.image)
		local imgPath = ResUrl.getV1a8DungeonSingleBg(imgName)

		self._simagemap:LoadImage(imgPath)
	end

	self:refreshHeroContainer()

	if self.dispatchCo then
		self._txttitle.text = self.dispatchCo.title or ""
	end

	if self.dispatchCo then
		self._txtdesc.text = self.dispatchCo.desc or ""
	end

	self:refreshSelectedHero()
	self:refreshCostTime()
	self:refreshBtn()
end

function VersionActivity1_8DispatchView:refreshHeroContainer()
	DispatchHeroListModel.instance:refreshHero()
end

function VersionActivity1_8DispatchView:refreshSelectedHero()
	for _, selectedHeroItem in ipairs(self.selectedHeroItemList) do
		selectedHeroItem:refreshUI()
	end
end

function VersionActivity1_8DispatchView:refreshCostTime()
	if self.status == DispatchEnum.DispatchStatus.Finished then
		logError("dispatch finished")

		return
	end

	if self.status == DispatchEnum.DispatchStatus.Dispatching then
		if self.dispatchMo then
			do
				local isFinish = self.dispatchMo:isFinish()

				if isFinish then
					self:closeThis()

					return
				end

				gohelper.setActive(self._gotimelock, false)

				self._txtcosttime.text = self.dispatchMo:getRemainTimeStr()

				return
			end

			local color = DARK_COLOR
			local text = ""

			if self.dispatchCo then
				local timeArray = string.splitToNumber(self.dispatchCo.time, "|")
				local costTime = timeArray[1]
				local checkShortFunc = self.checkShortedTimeFuncDict[self.dispatchCo.shortType]

				if checkShortFunc and checkShortFunc(self) then
					color = LIGHT_COLOR
					costTime = costTime - timeArray[2]

					gohelper.setActive(self._gotimelock, false)
				else
					gohelper.setActive(self._gotimelock, true)
				end

				local hour = Mathf.Floor(costTime / TimeUtil.OneHourSecond)
				local minuteSeconds = costTime % TimeUtil.OneHourSecond
				local minute = Mathf.Floor(minuteSeconds / TimeUtil.OneMinuteSecond)
				local second = minuteSeconds % TimeUtil.OneMinuteSecond

				text = GameUtil.getSubPlaceholderLuaLang(luaLang("dispatch_total_cost_time"), {
					hour,
					minute,
					second
				})
			else
				gohelper.setActive(self._gotimelock, true)
			end

			self._txtcosttime.text = string.format("<color=%s>%s</color>", color, text)
		end
	end
end

function VersionActivity1_8DispatchView:checkCareer()
	local heroList = DispatchHeroListModel.instance:getSelectedHeroList()

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

function VersionActivity1_8DispatchView:checkHeroID()
	local heroList = DispatchHeroListModel.instance:getSelectedHeroList()

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

function VersionActivity1_8DispatchView:refreshBtn()
	gohelper.setActive(self._btnstartdispatch.gameObject, self.status == DispatchEnum.DispatchStatus.NotDispatch)
	gohelper.setActive(self._btninterruptdispatch.gameObject, self.status == DispatchEnum.DispatchStatus.Dispatching)
	self:refreshStartBtnGray()
end

function VersionActivity1_8DispatchView:refreshStartBtnGray()
	if self.status ~= DispatchEnum.DispatchStatus.NotDispatch then
		return
	end

	local isEnoughHero = false

	if self.dispatchCo then
		local selectedCount = DispatchHeroListModel.instance:getSelectedHeroCount()

		isEnoughHero = selectedCount >= self.dispatchCo.minCount
	end

	ZProj.UGUIHelper.SetGrayscale(self._btnstartdispatch.gameObject, not isEnoughHero)
end

function VersionActivity1_8DispatchView:everySecondCall()
	if self.status == DispatchEnum.DispatchStatus.Dispatching then
		self:refreshCostTime()
	end
end

function VersionActivity1_8DispatchView:onClose()
	TaskDispatcher.cancelTask(self.everySecondCall, self)
end

function VersionActivity1_8DispatchView:onDestroyView()
	self._simagemap:UnLoadImage()

	if self.selectedHeroItemList then
		for _, selectedItem in ipairs(self.selectedHeroItemList) do
			selectedItem:destroy()
		end

		self.selectedHeroItemList = nil
	end

	DispatchHeroListModel.instance:clear()
end

return VersionActivity1_8DispatchView
