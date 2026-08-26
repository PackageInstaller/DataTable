-- chunkname: @modules/logic/sp01/act205/view/card/Act205CardResultView.lua

module("modules.logic.sp01.act205.view.card.Act205CardResultView", package.seeall)

local Act205CardResultView = class("Act205CardResultView", BaseView)

function Act205CardResultView:onInitView()
	self._txtDescr = gohelper.findChildText(self.viewGO, "Right/#txt_Descr")
	self._goreward = gohelper.findChild(self.viewGO, "Right/#go_reward")
	self._gorewardItem = gohelper.findChild(self.viewGO, "Right/#go_reward/#go_rewardItem")
	self._btnFinished = gohelper.findChildButtonWithAudio(self.viewGO, "Right/LayoutGroup/#btn_Finished")
	self._btnNew = gohelper.findChildButtonWithAudio(self.viewGO, "Right/LayoutGroup/#btn_New")
	self._txtGameTimes = gohelper.findChildText(self.viewGO, "Right/LayoutGroup/#btn_New/#txt_GameTimes")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Act205CardResultView:addEvents()
	self._btnFinished:AddClickListener(self._btnFinishedOnClick, self)
	self._btnNew:AddClickListener(self._btnNewOnClick, self)
	self.addEventCb(self, Act205Controller.instance, Act205Event.OnInfoUpdate, self.refreshTimesInfo, self)
	NavigateMgr.instance:addEscape(self.viewName, self._btnFinishedOnClick, self)
end

function Act205CardResultView:removeEvents()
	self._btnFinished:RemoveClickListener()
	self._btnNew:RemoveClickListener()
	self.removeEventCb(self, Act205Controller.instance, Act205Event.OnInfoUpdate, self.refreshTimesInfo, self)
end

function Act205CardResultView:_btnFinishedOnClick()
	local gameCount = Act205CardModel.instance:getGameCount()

	if gameCount > 0 then
		Act205CardController.instance:openCardEnterView()
	end

	ViewMgr.instance:closeView(ViewName.Act205CardShowView)
	self:closeThis()
end

function Act205CardResultView:_btnNewOnClick()
	Act205CardController.instance:beginNewCardGame()
end

function Act205CardResultView:_editableInitView()
	self._pointResultGoDict = self:getUserDataTb_()

	local pointList = Act205Config.instance:getPointList()

	for _, point in ipairs(pointList) do
		local pointResultGo = gohelper.findChild(self.viewGO, string.format("pointResult/%s", point))

		if not gohelper.isNil(pointResultGo) then
			self._pointResultGoDict[point] = pointResultGo
		end
	end
end

function Act205CardResultView:onUpdateParam()
	self._point = self.viewParam.point
	self._rewardId = self.viewParam.rewardId
	self._point = self._point or Act205Config.instance:getPointByReward(self._rewardId) or Act205Config.instance:getMaxPoint()
end

function Act205CardResultView:onOpen()
	self:onUpdateParam()

	local rewardConfig = Act205Config.instance:getGameRewardConfig(Act205Enum.GameStageId.Card, self._rewardId)

	self._txtDescr.text = rewardConfig.rewardDesc

	self:refreshPointResult()
	self:refreshTimesInfo()
	self:createRewardItem(rewardConfig)
	TaskDispatcher.runDelay(self.showRewardItemGet, self, 1)
end

function Act205CardResultView:refreshPointResult()
	local tmpPoint = self._point
	local go = self._pointResultGoDict[tmpPoint]

	if gohelper.isNil(go) then
		tmpPoint = 0
	end

	for point, pointResultGo in pairs(self._pointResultGoDict) do
		gohelper.setActive(pointResultGo, point == tmpPoint)
	end

	AudioMgr.instance:trigger((tmpPoint <= 0 or nil) and (AudioEnum2_9.Activity205.play_ui_s01_yunying_fail or AudioEnum2_9.Activity205.play_ui_s01_yunying_win))
end

function Act205CardResultView:refreshTimesInfo()
	local actId = Act205Model.instance:getAct205Id()
	local stageConfig = Act205Config.instance:getStageConfig(actId, Act205Enum.GameStageId.Card)
	local totalGameTimes = stageConfig.times
	local gameCount = Act205CardModel.instance:getGameCount()

	self._txtGameTimes.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("act205_remainGameTimes"), gameCount, totalGameTimes)

	local hasGameTimes = gameCount > 0

	gohelper.setActive(self._btnNew.gameObject, hasGameTimes)
end

function Act205CardResultView:createRewardItem(rewardConfig)
	self.rewardItemList = {}

	local rewardList = GameUtil.splitString2(rewardConfig.bonus, true)

	gohelper.CreateObjList(self, self._onCreateRewardItem, rewardList, self._goreward, self._gorewardItem)
end

function Act205CardResultView:_onCreateRewardItem(obj, data, index)
	local rewardItem = self:getUserDataTb_()

	rewardItem.go = obj

	local goRewardPos = gohelper.findChild(rewardItem.go, "go_rewardPos")

	rewardItem.itemIcon = IconMgr.instance:getCommonPropItemIcon(goRewardPos)

	rewardItem.itemIcon:setMOValue(data[1], data[2], data[3])
	rewardItem.itemIcon:isShowCount(true)
	rewardItem.itemIcon:setCountFontSize(40)
	rewardItem.itemIcon:showStackableNum2()
	rewardItem.itemIcon:setHideLvAndBreakFlag(true)
	rewardItem.itemIcon:hideEquipLvAndBreak(true)

	rewardItem.goRewardGet = gohelper.findChild(rewardItem.go, "go_rewardGet")

	gohelper.setActive(rewardItem.goRewardGet, false)

	self.rewardItemList[index] = rewardItem
end

function Act205CardResultView:showRewardItemGet()
	for _, rewardItem in ipairs(self.rewardItemList) do
		gohelper.setActive(rewardItem.goRewardGet, true)
	end
end

function Act205CardResultView:onClose()
	TaskDispatcher.cancelTask(self.showRewardItemGet, self)
end

function Act205CardResultView:onDestroyView()
	return
end

return Act205CardResultView
