-- chunkname: @modules/logic/versionactivity1_8/dungeon/view/factory/VersionActivity1_8FactoryBlueprintView.lua

module("modules.logic.versionactivity1_8.dungeon.view.factory.VersionActivity1_8FactoryBlueprintView", package.seeall)

local VersionActivity1_8FactoryBlueprintView = class("VersionActivity1_8FactoryBlueprintView", BaseView)
local REWARD_HAS_GET_ANIM_TIME = 1

function VersionActivity1_8FactoryBlueprintView:onInitView()
	self._factoryAnimator = gohelper.findChildComponent(self.viewGO, "factory", typeof(UnityEngine.Animator))

	local goFactory = gohelper.findChild(self.viewGO, "factory")

	self._factoryAnimatorPlayer = ZProj.ProjAnimatorPlayer.Get(goFactory)
	self._gocomposite = gohelper.findChild(self.viewGO, "factory/#go_composite")
	self._btncomposite = gohelper.findChildClickWithDefaultAudio(self.viewGO, "factory/#go_composite")
	self._btnbubble = gohelper.findChildButtonWithAudio(self.viewGO, "factory/#btn_bubble", AudioEnum.UI.Act157GetBubbleReward)
	self._gobubble = gohelper.findChild(self.viewGO, "factory/#btn_bubble")
	self._simagecangeticon = gohelper.findChildSingleImage(self.viewGO, "factory/#btn_bubble/icon")
	self._gobubbletime = gohelper.findChild(self.viewGO, "factory/#btn_bubble/finishing/time")
	self._txtbubbletime = gohelper.findChildText(self.viewGO, "factory/#btn_bubble/finishing/time/#txt_time")
	self._gobubblenum = gohelper.findChild(self.viewGO, "factory/#btn_bubble/finishing/num")
	self._txtbubblenum = gohelper.findChildText(self.viewGO, "factory/#btn_bubble/finishing/num/#txt_num")
	self._gobubblecanget = gohelper.findChild(self.viewGO, "factory/#btn_bubble/canget")
	self._gorewardwindow = gohelper.findChild(self.viewGO, "#go_rewardwindow")
	self._rewardwindowAnimatorPlayer = ZProj.ProjAnimatorPlayer.Get(self._gorewardwindow)
	self._btnclosereward = gohelper.findChildClickWithDefaultAudio(self.viewGO, "#go_rewardwindow")
	self._sliderreward = gohelper.findChildSlider(self.viewGO, "#go_rewardwindow/#go_progress/slider")
	self._btnreward = gohelper.findChildClickWithDefaultAudio(self.viewGO, "#btn_reward")
	self._btnrewardAnimator = gohelper.findChildComponent(self.viewGO, "#btn_reward", typeof(UnityEngine.Animator))
	self._goRewardReddot = gohelper.findChild(self.viewGO, "#btn_reward/#go_reddot")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity1_8FactoryBlueprintView:addEvents()
	self._btnbubble:AddClickListener(self._btnbubbleOnClick, self)
	self._btncomposite:AddClickListener(self._btncompositeOnClick, self)
	self._btnreward:AddClickListener(self._btnrewardOnClick, self)
	self._btnclosereward:AddClickListener(self._btncloserewardOnClick, self)
	self.addEventCb(self, Activity157Controller.instance, Activity157Event.Act157RepairComponent, self.onRepairComponent, self)
	self.addEventCb(self, Activity157Controller.instance, Activity157Event.Act157RefreshFactoryProduction, self.refreshBubble, self)
	self.addEventCb(self, Activity157Controller.instance, Activity157Event.Act157OnGetComponentReward, self.onGetRepairReward, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
end

function VersionActivity1_8FactoryBlueprintView:removeEvents()
	self._btnbubble:RemoveClickListener()
	self._btncomposite:RemoveClickListener()
	self._btnreward:RemoveClickListener()
	self._btnclosereward:RemoveClickListener()
	self.removeEventCb(self, Activity157Controller.instance, Activity157Event.Act157RepairComponent, self.onRepairComponent, self)
	self.removeEventCb(self, Activity157Controller.instance, Activity157Event.Act157RefreshFactoryProduction, self.refreshBubble, self)
	self.removeEventCb(self, Activity157Controller.instance, Activity157Event.Act157OnGetComponentReward, self.onGetRepairReward, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
end

function VersionActivity1_8FactoryBlueprintView:_btnbubbleOnClick()
	Activity157Controller.instance:getFactoryProduction()
end

function VersionActivity1_8FactoryBlueprintView:_btncompositeOnClick()
	local isFirstComponentRepair = Activity157Model.instance:getIsFirstComponentRepair()

	if isFirstComponentRepair then
		Activity157Controller.instance:openCompositeView()
	else
		GameFacade.showToast(ToastEnum.V1a8Activity157NotUnlockFactoryBlueprint)
	end
end

function VersionActivity1_8FactoryBlueprintView:_btnrewardOnClick()
	self:refreshRewardProgress()
	gohelper.setActive(self._gorewardwindow, true)
	self._rewardwindowAnimatorPlayer:Play("open")

	local lastArchiveRewardComponent = Activity157Model.instance:getLastArchiveRewardComponent()

	if lastArchiveRewardComponent then
		Activity157Rpc.instance:sendAct157GainMilestoneRewardRequest(self.actId, lastArchiveRewardComponent, self.refreshRewardProgress, self)
	end
end

function VersionActivity1_8FactoryBlueprintView:_btncloserewardOnClick()
	self._rewardwindowAnimatorPlayer:Play("close", self.hideRewardWindow, self)
end

function VersionActivity1_8FactoryBlueprintView:hideRewardWindow()
	gohelper.setActive(self._gorewardwindow, false)
end

function VersionActivity1_8FactoryBlueprintView:onRepairComponent()
	local viewNameList = ViewMgr.instance:getOpenViewNameList()
	local topView = viewNameList[#viewNameList]

	if topView ~= self.viewName then
		self._waitOnRepairComponent = true
	else
		self._waitOnRepairComponent = false

		self:checkFactoryAnim()
		self:refresh()
	end
end

function VersionActivity1_8FactoryBlueprintView:onGetRepairReward(materials)
	self._rewardsMaterials = materials

	self:refreshRepairReward(true)
end

function VersionActivity1_8FactoryBlueprintView:_onCloseView(viewName)
	if not self._waitOnRepairComponent then
		return
	end

	local viewNameList = ViewMgr.instance:getOpenViewNameList()
	local topView = viewNameList[#viewNameList]

	if topView ~= self.viewName then
		return
	end

	self:onRepairComponent()

	local isFirstComponentRepair = Activity157Model.instance:getIsFirstComponentRepair()

	if isFirstComponentRepair then
		Activity157Controller.instance:dispatchEvent(Activity157Event.GuideHasRepairFirstComponent)
	end

	self._waitOnRepairComponent = false
end

function VersionActivity1_8FactoryBlueprintView:_editableInitView()
	self.actId = Activity157Model.instance:getActId()

	local componentIdList = Activity157Config.instance:getComponentIdList(self.actId)
	local partCount = #componentIdList

	self.partItemList = {}
	self.rewardWindowItemList = {}

	for i = 1, partCount do
		local componentId = componentIdList[i]
		local partGo = gohelper.findChild(self.viewGO, "factory/part_" .. i)

		if partGo then
			local partItem = MonoHelper.addNoUpdateLuaComOnceToGo(partGo, VersionActivity1_8FactoryBlueprintPartItem, componentId)

			table.insert(self.partItemList, partItem)
		end

		local progressPointGo = gohelper.findChild(self.viewGO, "#go_rewardwindow/#go_progress/point/" .. i)
		local rewardItemGo = gohelper.findChild(self.viewGO, "#go_rewardwindow/layout/item" .. i)

		if rewardItemGo then
			local rewardItem = VersionActivity1_8FactoryBlueprintRewardItem.New(rewardItemGo, componentId, progressPointGo)

			table.insert(self.rewardWindowItemList, rewardItem)
		end
	end

	local strProductionItem = Activity157Config.instance:getAct157Const(self.actId, Activity157Enum.ConstId.FactoryCompositeCost)
	local productionParam = strProductionItem and string.splitToNumber(strProductionItem, "#")

	if productionParam then
		local _, icon = ItemModel.instance:getItemConfigAndIcon(productionParam[1], productionParam[2])

		if icon then
			self._simagecangeticon:LoadImage(icon)
		end
	end

	self:hideRewardWindow()
	RedDotController.instance:addRedDot(self._goRewardReddot, RedDotEnum.DotNode.V1a8DungeonFactoryRepairReward, self.actId, self.checkRewardReddot, self)
end

function VersionActivity1_8FactoryBlueprintView:checkRewardReddot(redDotIcon)
	redDotIcon:defaultRefreshDot()

	if redDotIcon.show then
		self._btnrewardAnimator:Play("receive", 0, 0)
	else
		self._btnrewardAnimator:Play("open", 0, 1)
	end
end

function VersionActivity1_8FactoryBlueprintView:onUpdateParam()
	return
end

function VersionActivity1_8FactoryBlueprintView:onOpen()
	self:checkFactoryAnim()
	self:refresh()
	self:everySecondCall()
	TaskDispatcher.runRepeat(self.everySecondCall, self, 1)
	AudioMgr.instance:trigger(AudioEnum.UI.Act157OpenBlueprintView)

	local isFirstComponentRepair = Activity157Model.instance:getIsFirstComponentRepair()

	if isFirstComponentRepair then
		Activity157Controller.instance:dispatchEvent(Activity157Event.GuideHasRepairFirstComponent)
	end
end

function VersionActivity1_8FactoryBlueprintView:checkFactoryAnim()
	local isAllComponentRepair = Activity157Model.instance:isAllComponentRepair()

	if not isAllComponentRepair then
		return
	end

	local prefsKey = VersionActivity1_8DungeonEnum.PlayerPrefsKey.IsPlayedBlueprintAllFinish
	local hasPlayed = Activity157Model.instance:getHasPlayedAnim(prefsKey)

	if hasPlayed then
		self._factoryAnimator:Play("loop")
	else
		self._factoryAnimator:Play("finish", 0, 0)
		Activity157Model.instance:setHasPlayedAnim(prefsKey)
	end
end

function VersionActivity1_8FactoryBlueprintView:refreshRewardProgress()
	local progress = 0
	local lastGotRewardComponent = Activity157Model.instance:getLastHasGotRewardComponent()

	if lastGotRewardComponent then
		local componentIdList = Activity157Config.instance:getComponentIdList(self.actId)
		local allComponentCount = #componentIdList

		for i, componentId in ipairs(componentIdList) do
			if lastGotRewardComponent == componentId then
				progress = (i - 1) / (allComponentCount - 1)

				break
			end
		end
	end

	self._sliderreward:SetValue(math.max(progress, 0))
end

function VersionActivity1_8FactoryBlueprintView:refresh()
	local isFirstComponentRepair = Activity157Model.instance:getIsFirstComponentRepair()

	if isFirstComponentRepair then
		local isAllComponentRepair = Activity157Model.instance:isAllComponentRepair()

		gohelper.setActive(self._gocomposite, not isAllComponentRepair)
		self.viewContainer:setCurrencyType({
			CurrencyEnum.CurrencyType.V1a8FactoryPart,
			CurrencyEnum.CurrencyType.V1a8FactoryRawMat
		})
	else
		gohelper.setActive(self._gocomposite, false)
		self.viewContainer:setCurrencyType({
			CurrencyEnum.CurrencyType.V1a8FactoryPart
		})
	end

	self:refreshPartItem()
	self:refreshBubble()
	self:refreshRepairReward()
end

function VersionActivity1_8FactoryBlueprintView:refreshPartItem()
	for _, partItem in ipairs(self.partItemList) do
		partItem:refresh()
	end
end

function VersionActivity1_8FactoryBlueprintView:refreshBubble()
	local nextRecoverTime = Activity157Model.instance:getFactoryNextRecoverCountdown()
	local isLastDay = string.nilorempty(nextRecoverTime)
	local canGetNum = Activity157Model.instance:getFactoryProductionNum()
	local isCanGet = canGetNum > 0
	local isFinished = not isCanGet and isLastDay

	gohelper.setActive(self._gobubble, not isFinished)

	if isFinished then
		return
	end

	self:refreshBubbleTime()

	local fullCapacity = Activity157Config.instance:getAct157FactoryProductCapacity(self.actId, Activity157Enum.ConstId.FactoryProductCapacity)
	local isFull = fullCapacity <= canGetNum

	gohelper.setActive(self._gobubblecanget, isFull)
	gohelper.setActive(self._gobubblenum, not isFull)

	if isFull then
		return
	end

	self._txtbubblenum.text = string.format("<color=%s>%s</color>/%s", (isCanGet or nil) and "#88CB7F", canGetNum, fullCapacity)
end

function VersionActivity1_8FactoryBlueprintView:refreshBubbleTime()
	local nextRecoverTime = Activity157Model.instance:getFactoryNextRecoverCountdown()
	local isLastDay = string.nilorempty(nextRecoverTime)
	local canGetNum = Activity157Model.instance:getFactoryProductionNum()
	local fullCapacity = Activity157Config.instance:getAct157FactoryProductCapacity(self.actId, Activity157Enum.ConstId.FactoryProductCapacity)
	local isFull = fullCapacity <= canGetNum
	local isShowTime = not isLastDay and not isFull

	gohelper.setActive(self._gobubbletime, isShowTime)

	if isLastDay then
		return
	end

	self._txtbubbletime.text = nextRecoverTime
end

function VersionActivity1_8FactoryBlueprintView:refreshRepairReward(isPlayAnim)
	for _, rewardItem in ipairs(self.rewardWindowItemList) do
		rewardItem:refresh(isPlayAnim)
	end

	if self._rewardsMaterials then
		AudioMgr.instance:trigger(AudioEnum.RewardPoint.play_ui_track_achievement_single)
		TaskDispatcher.cancelTask(self._showMaterials, self)
		UIBlockMgr.instance:startBlock(VersionActivity1_8DungeonEnum.BlockKey.GetComponentRepairReward)
		TaskDispatcher.runDelay(self._showMaterials, self, REWARD_HAS_GET_ANIM_TIME)
	end
end

function VersionActivity1_8FactoryBlueprintView:_showMaterials()
	RoomController.instance:popUpRoomBlockPackageView(self._rewardsMaterials)
	PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.CommonPropView, self._rewardsMaterials)

	self._rewardsMaterials = nil

	UIBlockMgr.instance:endBlock(VersionActivity1_8DungeonEnum.BlockKey.GetComponentRepairReward)
end

function VersionActivity1_8FactoryBlueprintView:everySecondCall()
	self:refreshBubbleTime()
end

function VersionActivity1_8FactoryBlueprintView:onClose()
	TaskDispatcher.cancelTask(self.everySecondCall, self)

	self._waitOnRepairComponent = false

	UIBlockMgr.instance:endBlock(VersionActivity1_8DungeonEnum.BlockKey.GetComponentRepairReward)
end

function VersionActivity1_8FactoryBlueprintView:onDestroyView()
	for _, partItem in ipairs(self.partItemList) do
		partItem:destroy()
	end

	for _, rewardItem in ipairs(self.rewardWindowItemList) do
		rewardItem:destroy()
	end

	self._simagecangeticon:UnLoadImage()
end

return VersionActivity1_8FactoryBlueprintView
