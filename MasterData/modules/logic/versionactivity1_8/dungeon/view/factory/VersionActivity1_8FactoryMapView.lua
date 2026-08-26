-- chunkname: @modules/logic/versionactivity1_8/dungeon/view/factory/VersionActivity1_8FactoryMapView.lua

module("modules.logic.versionactivity1_8.dungeon.view.factory.VersionActivity1_8FactoryMapView", package.seeall)

local VersionActivity1_8FactoryMapView = class("VersionActivity1_8FactoryMapView", BaseView)
local DEFAULT_INDEX = 1
local VIEW_OPEN_TIME = 0.3
local NODE_OPEN_DELAY_TIME = 0.2

function VersionActivity1_8FactoryMapView:onInitView()
	self._goline = gohelper.findChild(self.viewGO, "Line")
	self._gonodecontainer = gohelper.findChild(self.viewGO, "#go_nodecontainer")
	self._gonodeitem = gohelper.findChild(self.viewGO, "#go_nodecontainer/#go_nodeitem")
	self._btnfactory = gohelper.findChildClickWithDefaultAudio(self.viewGO, "#btn_factory")
	self._btnfactoryAnimator = gohelper.findChildComponent(self.viewGO, "#btn_factory", typeof(UnityEngine.Animator))
	self._goFactoryBlueprintReddot = gohelper.findChild(self.viewGO, "#btn_factory/#go_reddot")
	self._golockedfactory = gohelper.findChild(self.viewGO, "#btn_factory/#go_locked")
	self._imageprogress = gohelper.findChildImage(self.viewGO, "#btn_factory/#go_progroess/circle")
	self._gocangetbubble = gohelper.findChild(self.viewGO, "#btn_factory/#go_canget")
	self._btncanget = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_factory/#go_canget", AudioEnum.UI.Act157GetBubbleReward)
	self._simagecangeticon = gohelper.findChildSingleImage(self.viewGO, "#btn_factory/#go_canget/icon")
	self._gocangetfull = gohelper.findChild(self.viewGO, "#btn_factory/#go_canget/#go_full")
	self._gofinished = gohelper.findChild(self.viewGO, "#btn_factory/#go_canget/finished")
	self._gocharging = gohelper.findChild(self.viewGO, "#btn_factory/#go_canget/finishing")
	self._gochargetime = gohelper.findChild(self.viewGO, "#btn_factory/#go_canget/finishing/time")
	self._txtnextchargetime = gohelper.findChildText(self.viewGO, "#btn_factory/#go_canget/finishing/time/#txt_time")
	self._gocangetnum = gohelper.findChild(self.viewGO, "#btn_factory/#go_canget/finishing/num")
	self._txtcangetnum = gohelper.findChildText(self.viewGO, "#btn_factory/#go_canget/finishing/num/#txt_num")
	self._gounlocknum = gohelper.findChild(self.viewGO, "#btn_factory/#go_num")
	self._imageunlockicon = gohelper.findChildImage(self.viewGO, "#btn_factory/#go_num/icon")
	self._txtunlocknum = gohelper.findChildText(self.viewGO, "#btn_factory/#go_num/#txt_num")
	self._imagefactory = gohelper.findChildImage(self.viewGO, "#btn_factory/#image_factory")
	self._mapswitchanimator = gohelper.findChildComponent(self.viewGO, "#go_mapswitch", typeof(UnityEngine.Animator))
	self._goswitchunlock = gohelper.findChild(self.viewGO, "#go_mapswitch/#unlock")
	self._switchanimator = gohelper.findChildComponent(self.viewGO, "#go_mapswitch/switch", typeof(UnityEngine.Animator))
	self._txtmapname = gohelper.findChildText(self.viewGO, "#go_mapswitch/normal/#txt_mapname")
	self._txtsidemissionmapname = gohelper.findChildText(self.viewGO, "#go_mapswitch/locked/layout/#txt_timelocked")
	self._golockedsidemissionicon = gohelper.findChild(self.viewGO, "#go_mapswitch/locked/layout/icon")
	self._goswitch = gohelper.findChild(self.viewGO, "#go_mapswitch/switch")
	self._btnleft = gohelper.findChildButtonWithAudio(self.viewGO, "#go_mapswitch/switch/#btn_left")
	self._btnright = gohelper.findChildButtonWithAudio(self.viewGO, "#go_mapswitch/switch/#btn_right")
	self._gopointparent = gohelper.findChild(self.viewGO, "#go_mapswitch/switch/pointbg/pointcontainer")
	self._goswitchpoint = gohelper.findChild(self.viewGO, "#go_mapswitch/switch/pointbg/pointcontainer/empty")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity1_8FactoryMapView:addEvents()
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
	self.addEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self._onCurrencyChange, self)
	self.addEventCb(self, VersionActivity1_8DungeonController.instance, VersionActivity1_8DungeonEvent.FocusElement, self.closeThis, self)
	self.addEventCb(self, VersionActivity1_8DungeonController.instance, VersionActivity1_8DungeonEvent.ManualClickElement, self.closeThis, self)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, self.dailyRefresh, self)
	self.addEventCb(self, Activity157Controller.instance, Activity157Event.Act157RepairComponent, self._onRepairComponent, self)
	self.addEventCb(self, Activity157Controller.instance, Activity157Event.Act157RefreshFactoryProduction, self.refreshFactoryCanGetBubble, self)
	self.addEventCb(self, Activity157Controller.instance, Activity157Event.Act157RefreshSideMission, self._onRefreshNode, self)
	self.addEventCb(self, Activity157Controller.instance, Activity157Event.Act157FinishMission, self._onRefreshNode, self)
	self._btnfactory:AddClickListener(self._btnfactoryOnClick, self)
	self._btncanget:AddClickListener(self._btncangetOnClick, self)
	self._btnleft:AddClickListener(self._btnleftOnClick, self)
	self._btnright:AddClickListener(self._btnrightOnCLick, self)
end

function VersionActivity1_8FactoryMapView:removeEvents()
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
	self.removeEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self._onCurrencyChange, self)
	self.removeEventCb(self, VersionActivity1_8DungeonController.instance, VersionActivity1_8DungeonEvent.FocusElement, self.closeThis, self)
	self.removeEventCb(self, VersionActivity1_8DungeonController.instance, VersionActivity1_8DungeonEvent.ManualClickElement, self.closeThis, self)
	TimeDispatcher.instance:unregisterCallback(TimeDispatcher.OnDailyRefresh, self.dailyRefresh, self)
	self.removeEventCb(self, Activity157Controller.instance, Activity157Event.Act157RepairComponent, self._onRepairComponent, self)
	self.removeEventCb(self, Activity157Controller.instance, Activity157Event.Act157RefreshFactoryProduction, self.refreshFactoryCanGetBubble, self)
	self.removeEventCb(self, Activity157Controller.instance, Activity157Event.Act157RefreshSideMission, self._onRefreshNode, self)
	self.removeEventCb(self, Activity157Controller.instance, Activity157Event.Act157FinishMission, self._onRefreshNode, self)
	self._btnfactory:RemoveClickListener()
	self._btncanget:RemoveClickListener()
	self._btnleft:RemoveClickListener()
	self._btnright:RemoveClickListener()
end

function VersionActivity1_8FactoryMapView:_onCloseView(viewName)
	if viewName ~= ViewName.VersionActivity1_8FactoryBlueprintView then
		return
	end

	if self._waitRefreshUnlockAnim then
		for _, nodeItem in pairs(self.missionId2NodeItemDict) do
			nodeItem:refreshUnlockAnim()
		end

		self:refreshIsShowSwitchPoint()

		self._waitRefreshUnlockAnim = nil
	end
end

function VersionActivity1_8FactoryMapView:_onCurrencyChange(changeIds)
	local rawMatId = CurrencyEnum.CurrencyType.V1a8FactoryPart

	if not changeIds[rawMatId] then
		return
	end

	self:refreshFactoryEntrance()
end

function VersionActivity1_8FactoryMapView:dailyRefresh()
	Activity157Controller.instance:getAct157ActInfo()
end

function VersionActivity1_8FactoryMapView:_onRepairComponent()
	self:refreshFactoryEntrance()
	self:refreshFactoryCanGetBubble()

	local isOpenFactoryBlueprint = ViewMgr.instance:isOpen(ViewName.VersionActivity1_8FactoryBlueprintView)

	if isOpenFactoryBlueprint then
		self._waitRefreshUnlockAnim = true
	else
		for _, nodeItem in pairs(self.missionId2NodeItemDict) do
			nodeItem:refreshUnlockAnim()
		end
	end
end

function VersionActivity1_8FactoryMapView:_onRefreshNode()
	self:refreshNode()
	self:refreshNodeLines()
end

function VersionActivity1_8FactoryMapView:_btnfactoryOnClick()
	Activity157Controller.instance:openFactoryBlueprintView()
end

function VersionActivity1_8FactoryMapView:_btncangetOnClick()
	Activity157Controller.instance:getFactoryProduction()
end

function VersionActivity1_8FactoryMapView:_btnleftOnClick()
	if not self.curIndex then
		return
	end

	self:switchMap(self.curIndex - 1)
end

function VersionActivity1_8FactoryMapView:_btnrightOnCLick()
	if not self.curIndex then
		return
	end

	self:switchMap(self.curIndex + 1)
end

function VersionActivity1_8FactoryMapView:switchMap(index, isOnOpen)
	if not index then
		if isOnOpen then
			local inProgressMissionGroup = Activity157Model.instance:getInProgressMissionGroup()

			for i, pointItem in ipairs(self.switchPointItemList) do
				if pointItem.missionGroupId == inProgressMissionGroup then
					index = i

					break
				end
			end
		else
			index = self.curIndex
		end
	end

	index = index or DEFAULT_INDEX

	local totalIndex = #self.switchPointItemList

	if totalIndex < index then
		index = DEFAULT_INDEX
	elseif index < DEFAULT_INDEX then
		index = totalIndex
	end

	local newPointItem = index and self.switchPointItemList[index]

	if not newPointItem then
		return
	end

	local isPlaySwitch = false

	if self.curIndex then
		local lastPointItem = self.switchPointItemList[self.curIndex]
		local lastMissionGroupId = lastPointItem and lastPointItem.missionGroupId
		local newMissionGroupId = newPointItem.missionGroupId
		local isSideMissionGroup = Activity157Config.instance:isSideMissionGroup(self.actId, newMissionGroupId)

		if lastMissionGroupId then
			local lastIsSideMission = Activity157Config.instance:isSideMissionGroup(self.actId, lastMissionGroupId)

			if lastIsSideMission ~= isSideMissionGroup then
				isPlaySwitch = true
			end
		end

		if isPlaySwitch then
			self._mapswitchanimator:Play(isSideMissionGroup and "switch_locked" or "switch_nomal", 0, 0)
		else
			self._mapswitchanimator:Play(isSideMissionGroup and "locked" or "nomal", 0, 0)
		end

		self:recycleAllNodeItem()

		self.curIndex = index

		self:setNodeGroup(newMissionGroupId, isOnOpen)
		self:refreshSwitchPoint()
		self:refreshMapName()
	end
end

function VersionActivity1_8FactoryMapView:_editableInitView()
	self.actId = Activity157Model.instance:getActId()
	self.nodeItemPool = {}
	self.missionId2NodeItemDict = {}
	self.curIndex = nil
	self.lineTemplateDict = self:getUserDataTb_()
	self.switchPointItemList = {}
	self._waitRefreshUnlockAnim = nil

	gohelper.setActive(self._gonodeitem, false)
	gohelper.setActive(self._goswitchpoint, false)

	self.mapAreaAnimatorDict = self:getUserDataTb_()

	local mapAreaGo = gohelper.findChild(self.viewGO, "Map")
	local mapAreaTrans = mapAreaGo.transform
	local areaCount = mapAreaTrans.childCount

	for i = 1, areaCount do
		local child = mapAreaTrans:GetChild(i - 1)
		local animator = child:GetComponent(typeof(UnityEngine.Animator))

		animator:Play("lock_idle", 0, 0)

		self.mapAreaAnimatorDict[tostring(child.name)] = animator
	end

	local strProduction = Activity157Config.instance:getAct157Const(self.actId, Activity157Enum.ConstId.FactoryCompositeCost)
	local productionParam = strProduction and string.splitToNumber(strProduction, "#")

	if productionParam then
		local _, icon = ItemModel.instance:getItemConfigAndIcon(productionParam[1], productionParam[2])

		if icon then
			self._simagecangeticon:LoadImage(icon)
		end
	end

	local strPartItem = Activity157Config.instance:getAct157Const(self.actId, Activity157Enum.ConstId.FactoryRepairPartItem)
	local partItemParam = strPartItem and string.splitToNumber(strPartItem, "#")

	if partItemParam then
		local currencyCfg = CurrencyConfig.instance:getCurrencyCo(partItemParam[2])
		local currencyIcon = currencyCfg and currencyCfg.icon

		if currencyIcon then
			UISpriteSetMgr.instance:setCurrencyItemSprite(self._imageunlockicon, currencyIcon .. "_1", true)
		end
	end

	local viewSetting = self.viewContainer:getSetting()
	local lineTemplatePath = viewSetting.otherRes[1]

	self.goLineTemplate = self.viewContainer:getResInst(lineTemplatePath, self._goline)

	gohelper.setActive(self.goLineTemplate, false)
	RedDotController.instance:addRedDot(self._goFactoryBlueprintReddot, RedDotEnum.DotNode.V1a8DungeonFactoryBlueprint)
end

function VersionActivity1_8FactoryMapView:onUpdateParam()
	Activity157Controller.instance:onFactoryMapViewOpen()
end

function VersionActivity1_8FactoryMapView:onOpen()
	self:refresh(true)
	self:everySecondCall()
	TaskDispatcher.runRepeat(self.everySecondCall, self, 1)
	Activity157Controller.instance:onFactoryMapViewOpen()
end

function VersionActivity1_8FactoryMapView:everySecondCall()
	for _, nodeItem in pairs(self.missionId2NodeItemDict) do
		nodeItem:everySecondCall()
	end

	self:refreshFactoryCanGetBubbleTime()
	self:refreshMapName()
end

function VersionActivity1_8FactoryMapView:refresh(isOnOpen)
	self:refreshNode(isOnOpen)
	self:refreshNodeLines()
	self:refreshFactoryEntrance()
	self:refreshFactoryCanGetBubble()
end

function VersionActivity1_8FactoryMapView:refreshNode(isOnOpen)
	self:refreshIsShowSwitchPoint()
	self:switchMap(nil, isOnOpen)
	self:refreshSwitchPoint()
end

function VersionActivity1_8FactoryMapView:refreshIsShowSwitchPoint()
	local allActiveNodeGroupList = Activity157Model.instance:getAllActiveNodeGroupList()

	gohelper.CreateObjList(self, self.onSwitchPointCreate, allActiveNodeGroupList, self._gopointparent, self._goswitchpoint)
	gohelper.setActive(self._goswitch, #allActiveNodeGroupList > 1)

	if #allActiveNodeGroupList > 1 then
		local prefsKey = VersionActivity1_8DungeonEnum.PlayerPrefsKey.IsPlayedFactoryMapSwitchUnlockAnim
		local hasPlayed = Activity157Model.instance:getHasPlayedAnim(prefsKey)

		if not hasPlayed then
			self._switchanimator:Play("unlock", 0, 0)
			Activity157Model.instance:setHasPlayedAnim(prefsKey)
		end
	end

	self:refreshSwitchPoint()
end

function VersionActivity1_8FactoryMapView:onSwitchPointCreate(obj, data, index)
	local pointItem = self:getUserDataTb_()

	pointItem.go = obj
	pointItem.missionGroupId = data
	pointItem.goSelect = gohelper.findChild(obj, "select")
	pointItem.goRed = gohelper.findChild(obj, "#red")
	pointItem.click = gohelper.getClickWithDefaultAudio(obj)

	pointItem.click:AddClickListener(self.onSwitchPointClick, self, index)
	gohelper.setActive(pointItem.goSelect, false)

	self.switchPointItemList[index] = pointItem
end

function VersionActivity1_8FactoryMapView:onSwitchPointClick(index)
	self:switchMap(index)
end

function VersionActivity1_8FactoryMapView:setNodeGroup(missionGroupId, isOnOpen)
	self.missionId2NodeItemDict = self.missionId2NodeItemDict or {}

	local showMissionIdList = Activity157Model.instance:getShowMissionIdList(missionGroupId)

	for _, missionId in ipairs(showMissionIdList) do
		local nodeItem = self:getNodeItem()

		nodeItem:setMissionData(missionGroupId, missionId, isOnOpen)

		if self.missionId2NodeItemDict[missionId] then
			logError(string.format("VersionActivity1_8FactoryMapView:setNodeGroup error, missionId:%s repeat", missionId))
		end

		self.missionId2NodeItemDict[missionId] = nodeItem
	end

	local delayTime = NODE_OPEN_DELAY_TIME

	if isOnOpen then
		delayTime = VIEW_OPEN_TIME
	end

	TaskDispatcher.cancelTask(self.playNodeShowAudio, self)
	TaskDispatcher.runDelay(self.playNodeShowAudio, self, delayTime)
end

function VersionActivity1_8FactoryMapView:playNodeShowAudio()
	AudioMgr.instance:trigger(AudioEnum.UI.Act157FactoryNodeShow)
end

function VersionActivity1_8FactoryMapView:refreshNodeLines()
	for _, nodeItem in pairs(self.missionId2NodeItemDict) do
		nodeItem:refreshLine()
	end
end

function VersionActivity1_8FactoryMapView:refreshFactoryEntrance()
	local isUnlockFactoryBlueprint = Activity157Model.instance:getIsUnlockFactoryBlueprint()

	gohelper.setActive(self._golockedfactory, not isUnlockFactoryBlueprint)
	gohelper.setActive(self._gounlocknum, not isUnlockFactoryBlueprint)

	if isUnlockFactoryBlueprint then
		self:checkFactoryBlueprintEntranceUnlockAnim()
	else
		self:refreshFactoryEntranceUnlockNum()
	end

	self:refreshFactoryEntranceRepairProgress()
end

function VersionActivity1_8FactoryMapView:refreshFactoryEntranceUnlockNum()
	local firstComponentId = Activity157Config.instance:getAct157Const(self.actId, Activity157Enum.ConstId.FirstFactoryComponent)
	local type, id, quantity = Activity157Config.instance:getComponentUnlockCondition(self.actId, firstComponentId)
	local curQuantity = ItemModel.instance:getItemQuantity(type, id)

	self._txtunlocknum.text = string.format("<color=%s>%s</color>/%s", (quantity and quantity <= curQuantity or nil) and "#88CB7F", curQuantity, quantity or 0)
end

function VersionActivity1_8FactoryMapView:checkFactoryBlueprintEntranceUnlockAnim()
	local prefsKey = VersionActivity1_8DungeonEnum.PlayerPrefsKey.IsPlayedBlueprintUnlockAnim
	local hasPlayed = Activity157Model.instance:getHasPlayedAnim(prefsKey)

	if hasPlayed then
		return
	end

	gohelper.setActive(self._golockedfactory, true)
	gohelper.setActive(self._gounlocknum, true)
	self._btnfactoryAnimator:Play("unlock", 0, 0)
	Activity157Model.instance:setHasPlayedAnim(prefsKey)
end

function VersionActivity1_8FactoryMapView:refreshFactoryEntranceRepairProgress()
	local isUnlockFactoryBlueprint = Activity157Model.instance:getIsUnlockFactoryBlueprint()

	if isUnlockFactoryBlueprint then
		self._imageprogress.fillAmount = Activity157Model.instance:getComponentRepairProgress()
	end
end

function VersionActivity1_8FactoryMapView:refreshFactoryCanGetBubble()
	local isUnlockFactoryBlueprint = Activity157Model.instance:getIsUnlockFactoryBlueprint()
	local isRepairedFirstComponent = Activity157Model.instance:getIsFirstComponentRepair()
	local isShowBubble = isUnlockFactoryBlueprint and isRepairedFirstComponent

	gohelper.setActive(self._gocangetbubble, isShowBubble)

	if not isShowBubble then
		return
	end

	local canGetNum = Activity157Model.instance:getFactoryProductionNum()
	local fullCapacity = Activity157Config.instance:getAct157FactoryProductCapacity(self.actId, Activity157Enum.ConstId.FactoryProductCapacity)
	local isFull = fullCapacity <= canGetNum

	if isFull then
		gohelper.setActive(self._gocangetfull, true)
		gohelper.setActive(self._gochargetime, false)
		gohelper.setActive(self._gocangetnum, false)
		gohelper.setActive(self._gofinished, false)

		return
	end

	gohelper.setActive(self._gocangetfull, false)

	local nextRecoverTime = Activity157Model.instance:getFactoryNextRecoverCountdown()
	local isLastDay = string.nilorempty(nextRecoverTime)

	gohelper.setActive(self._gochargetime, not isLastDay)
	self:refreshFactoryCanGetBubbleTime()

	local isCanGet = canGetNum > 0
	local isFinished = not isCanGet and isLastDay

	if isFinished then
		gohelper.setActive(self._gofinished, true)
		gohelper.setActive(self._gocangetnum, false)
	else
		self._txtcangetnum.text = string.format("<color=%s>%s</color>/%s", (isCanGet or nil) and "#88CB7F", canGetNum, fullCapacity)

		gohelper.setActive(self._gofinished, false)
		gohelper.setActive(self._gocangetnum, true)
	end
end

function VersionActivity1_8FactoryMapView:refreshFactoryCanGetBubbleTime()
	local isUnlockFactoryBlueprint = Activity157Model.instance:getIsUnlockFactoryBlueprint()

	if not isUnlockFactoryBlueprint then
		return
	end

	local canGetNum = Activity157Model.instance:getFactoryProductionNum()
	local fullCapacity = Activity157Config.instance:getAct157FactoryProductCapacity(self.actId, Activity157Enum.ConstId.FactoryProductCapacity)
	local isFull = fullCapacity <= canGetNum

	if isFull then
		return
	end

	local nextRecoverTime = Activity157Model.instance:getFactoryNextRecoverCountdown()
	local isLastDay = string.nilorempty(nextRecoverTime)

	if not isLastDay then
		self._txtnextchargetime.text = nextRecoverTime
	end
end

function VersionActivity1_8FactoryMapView:refreshMapName()
	local curSelectMissionGroup = self:getCurSelectMissionGroupId()

	if not curSelectMissionGroup then
		self._txtmapname.text = ""
		self._txtsidemissionmapname.text = ""

		return
	end

	local mapName = Activity157Config.instance:getMapName(self.actId, curSelectMissionGroup)
	local isSideMissionGroup = Activity157Config.instance:isSideMissionGroup(self.actId, curSelectMissionGroup)

	if isSideMissionGroup then
		local isUnlockedSideMission = Activity157Model.instance:getIsSideMissionUnlocked()

		if isUnlockedSideMission then
			self._txtsidemissionmapname.text = mapName

			gohelper.setActive(self._golockedsidemissionicon, false)
		else
			local time, isTimeEnd = Activity157Model.instance:getSideMissionUnlockTime()

			self._txtsidemissionmapname.text = formatLuaLang("test_task_unlock_time", time)

			if isTimeEnd then
				gohelper.setActive(self._goswitchunlock, true)
			end

			gohelper.setActive(self._golockedsidemissionicon, not isTimeEnd)
		end
	else
		self._txtmapname.text = mapName
	end
end

function VersionActivity1_8FactoryMapView:refreshSwitchPoint()
	if not self.switchPointItemList then
		return
	end

	local isUnlockedSideMission = Activity157Model.instance:getIsSideMissionUnlocked()

	for index, pointItem in ipairs(self.switchPointItemList) do
		gohelper.setActive(pointItem.goSelect, index == self.curIndex)

		if isUnlockedSideMission then
			local missionGroupId = pointItem.missionGroupId
			local isSideMissionGroup = Activity157Config.instance:isSideMissionGroup(self.actId, missionGroupId)

			if isSideMissionGroup then
				local isProgressOther = Activity157Model.instance:isInProgressOtherMissionGroup(missionGroupId)
				local isFinishedAll = Activity157Model.instance:isFinishAllMission(missionGroupId)
				local curSelectMissionGroup = self:getCurSelectMissionGroupId()
				local isCurSelect = curSelectMissionGroup == missionGroupId

				gohelper.setActive(pointItem.goRed, not isProgressOther and not isFinishedAll and not isCurSelect)
			else
				gohelper.setActive(pointItem.goRed, false)
			end
		end
	end
end

function VersionActivity1_8FactoryMapView:getNodeItem()
	if next(self.nodeItemPool) then
		return table.remove(self.nodeItemPool)
	else
		return self:createNodeItem()
	end
end

function VersionActivity1_8FactoryMapView:createNodeItem()
	local nodeItemGo = gohelper.clone(self._gonodeitem, self._gonodecontainer, "nodeitem")
	local nodeItem = VersionActivity1_8FactoryMapNodeItem.New()

	nodeItem:init(nodeItemGo, self.getLineTemplate, self._goline, self)

	return nodeItem
end

function VersionActivity1_8FactoryMapView:recycleAllNodeItem()
	if not self.missionId2NodeItemDict then
		return
	end

	for _, nodeItem in pairs(self.missionId2NodeItemDict) do
		nodeItem:reset(true)
		table.insert(self.nodeItemPool, nodeItem)
	end

	self.missionId2NodeItemDict = {}
end

function VersionActivity1_8FactoryMapView:getCurSelectMissionGroupId()
	local result

	if self.switchPointItemList then
		if self.curIndex then
			if self.curIndex then
				result = self.curIndex.missionGroupId
			end
		end
	end

	return result
end

function VersionActivity1_8FactoryMapView:getLineTemplate(lineName)
	local result

	if string.nilorempty(lineName) then
		return result
	end

	self.lineTemplateDict = self.lineTemplateDict or self:getUserDataTb_()

	if not self.lineTemplateDict[lineName] and self.goLineTemplate then
		self.lineTemplateDict[lineName] = gohelper.findChild(self.goLineTemplate, lineName)
	end

	result = self.lineTemplateDict[lineName]

	return self.lineTemplateDict[lineName]
end

function VersionActivity1_8FactoryMapView:playAreaAnim(areaName, animName)
	local animator

	if animName then
		animator = areaName and self.mapAreaAnimatorDict[areaName]
	end

	if animator then
		animator:Play(animName, 0, 0)
	end
end

function VersionActivity1_8FactoryMapView:onClose()
	TaskDispatcher.cancelTask(self.playNodeShowAudio, self)
	TaskDispatcher.cancelTask(self.everySecondCall, self)
end

function VersionActivity1_8FactoryMapView:onDestroyView()
	for _, nodeItem in ipairs(self.nodeItemPool) do
		nodeItem:destroy()
	end

	self.nodeItemPool = {}

	for _, nodeItem in pairs(self.missionId2NodeItemDict) do
		nodeItem:destroy()
	end

	self.missionId2NodeItemDict = nil

	for _, pointItem in ipairs(self.switchPointItemList) do
		pointItem.click:RemoveClickListener()
	end

	self.switchPointItemList = nil

	self._simagecangeticon:UnLoadImage()

	self.curIndex = nil
	self._waitRefreshUnlockAnim = nil
end

return VersionActivity1_8FactoryMapView
