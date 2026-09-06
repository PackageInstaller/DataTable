-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/heatprogress/view/HeatProgressView.lua

module("logic.extensions.heatprogress.view.HeatProgressView", package.seeall)

local HeatProgressView = class("HeatProgressView", ViewComponent)

function HeatProgressView:ctor()
	HeatProgressView.super.ctor(self)
end

function HeatProgressView:buildUI()
	HeatProgressView.super.buildUI(self)

	self._bubble = goutil.findChild(self.mainGO, "bubble")
	self._closeBub = goutil.findChild(self.mainGO, "bubble/btnClose")
	self._txtBub = goutil.findChildTextComponent(self.mainGO, "bubble/txtDesc")
	self._scorollReward = goutil.findChild(self.mainGO, "scorollReward")
	self._total = goutil.findChild(self._scorollReward, "total")
	self._txtNum = goutil.findChildTextComponent(self._total, "txtNum")
	self._btnTip = goutil.findChild(self._total, "btnTip")
	self._ScrollRect = goutil.findChild(self._scorollReward, "ScrollRect")
	self._content = goutil.findChild(self._scorollReward, "ScrollRect/ViewPort/Content")
	self._progressBar = goutil.findChild(self._scorollReward, "ScrollRect/ViewPort/Content/progressBar")
	self._gridLayout = goutil.findChild(self._scorollReward, "ScrollRect/ViewPort/Content/grids"):GetComponent(typeof(UnityEngine.UI.GridLayoutGroup))
	self.gridList = {}
	self._gridEffList = {}
end

function HeatProgressView:bindEvents()
	HeatProgressView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnTip, self._popBubble, self)
	GameUtil.addClickHandler(self._closeBub, self._closeBubble, self)
end

function HeatProgressView:unbindEvents()
	HeatProgressView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._closeBub)
end

function HeatProgressView:destroyUI()
	HeatProgressView.super.destroyUI(self)
end

function HeatProgressView:onEnter()
	HeatProgressView.super.onEnter(self)

	local params = self:getOpenParam()

	self._activityId = checknumber(params[1])
	self._id = checknumber(params[2]) or 1

	if self._activityId == 0 or self._id == 0 then
		printError("缺失或错误两个传入参数'进度方案'和'编号'")
		self:close()
	end

	GlobalDispatcher:addListener(GlobalNotify.HeatProgressOnUpdatePlanCfg, self.onUpdatePlanCfg, self)
	GlobalDispatcher:addListener(GlobalNotify.HeatProgressGainPrize, self._onPlayStory, self)
	GlobalDispatcher:addListener(GlobalNotify.EndStory, self._onEndStory, self)
	HeatProgressController.instance:onSendProgressGetInfoReq(self._activityId)
end

function HeatProgressView:onExit()
	HeatProgressView.super.onExit(self)
	removetimer(self._closeBubble, self)
	GlobalDispatcher:removeListener(GlobalNotify.HeatProgressOnUpdatePlanCfg, self.onUpdatePlanCfg, self)
	GlobalDispatcher:removeListener(GlobalNotify.HeatProgressGainPrize, self._onPlayStory, self)
	GlobalDispatcher:removeListener(GlobalNotify.EndStory, self._onEndStory, self)

	for _, mainGo in ipairs(self.gridList) do
		MaterialMgr.resetAll(goutil.findChild(mainGo, "item/itemcell"))
		GameUtil.rmClickHandler(goutil.findChild(mainGo, "btn"))
		UIEffectManager.instance:stopEffect(self._gridEffList[mainGo])
	end
end

function HeatProgressView:onUpdatePlanCfg(id)
	id = checknumber(id)

	if id == 0 then
		id = self._id
	end

	self._id = id
	self._progressCfg = HeatProgressConfig.instance:getProgressCfgById(self._activityId, self._id)
	self._progressPrizeCfgs = HeatProgressConfig.instance:getProgressPrizeCfgsById(self._activityId, self._id)

	local isHasData = HeatProgressModel.instance._isHasData

	if not isHasData then
		return
	end

	local actCfg = ActivityDefineConfig.instance:getCfgById(GameEnum.ActivityType.HeatProgress, self._activityId)
	local curActTimeType = GameUtil.getTimePeriodType(actCfg.startTime, actCfg.endTime)

	if curActTimeType == GameUtil.beforeTimePeriod then
		return
	elseif curActTimeType == GameUtil.afterTimePeriod then
		return
	end

	self:_updateUI()
end

function HeatProgressView:_updateUI()
	self:_onUpdateTotal()
	self:_onUpdateProgressSlider()
	self:_onUpdateProgressGrids()
end

function HeatProgressView:_popBubble()
	if self._txtBub then
		self._txtBub.text = lang("全服每消耗1800点体力，即可增加1点进度点")
	end

	if self._bubble then
		GameUtil.SetActive(self._bubble, true)
		removetimer(self._closeBubble, self)
		settimer(3, self._closeBubble, self, true)
	end
end

function HeatProgressView:_closeBubble()
	removetimer(self._closeBubble, self)
	GameUtil.SetActive(self._bubble, false)
end

function HeatProgressView:_onUpdateTotal()
	local curProgress = HeatProgressModel.instance:getCurProgress(self._id)

	if self._txtNum then
		local maxProgress = self._progressPrizeCfgs[#self._progressPrizeCfgs].progress

		self._txtNum.text = maxProgress <= curProgress and "进度已满" or curProgress
	end
end

function HeatProgressView:_onUpdateProgressSlider()
	local curProgress = HeatProgressModel.instance:getCurProgress(self._id)
	local maxProgress = 0

	for _, data in ipairs(self._progressPrizeCfgs) do
		maxProgress = math.max(maxProgress, data.progress)
	end

	self._progressBar:GetComponent(ComponentType.Slider).value = curProgress / maxProgress
end

function HeatProgressView:_onUpdateProgressGrids()
	local gridNum = #self._progressPrizeCfgs
	local gridWidth = self._gridLayout.cellSize.x
	local gridSpacingWidth = self._gridLayout.spacing.x
	local sliderLength = gridNum * (gridSpacingWidth + gridWidth)
	local contentLength = sliderLength + gridWidth

	GameUtil.setWidth(self._content, contentLength)
	GameUtil.setWidth(self._progressBar, sliderLength)

	self.gridList = GameUtil.updateCellsWithCreate(self._gridLayout, self._progressPrizeCfgs, self._updateProgressGrid, self)

	local prizeStatus = HeatProgressModel.instance:getCurPrizeStatus(self._id)
	local curProgress = HeatProgressModel.instance:getCurProgress(self._id)
	local pos = 0

	for k, data in ipairs(self._progressPrizeCfgs) do
		local isHasGain = prizeStatus[data.id] == true
		local isEnough = curProgress >= data.progress
		local isCanGet = isEnough and not isHasGain

		if isCanGet then
			local totalNum = #self._progressPrizeCfgs
			local nowNum = data.id

			pos = nowNum / totalNum
			pos = math.max(0, nowNum / totalNum)
			pos = math.min(nowNum / totalNum, 1)
		end
	end

	if pos == 0 then
		local maxProgress = self._progressPrizeCfgs[#self._progressPrizeCfgs].progress

		pos = curProgress / maxProgress
		pos = curProgress / maxProgress - 0.3
		pos = math.max(0, curProgress / maxProgress - 0.3)
		pos = math.min(curProgress / maxProgress - 0.3, 1)
	end

	self._ScrollRect:GetComponent(ComponentType.ScrollRect).horizontalNormalizedPosition = pos
end

function HeatProgressView:_updateProgressGrid(cellGo, data)
	local mainGo = cellGo
	local item = goutil.findChild(mainGo, "item/itemcell")
	local received = goutil.findChild(mainGo, "item/received")
	local btn = goutil.findChild(mainGo, "btn")
	local txtNum = goutil.findChildTextComponent(mainGo, "txtNum")

	if not string.nilorempty(data.prize) then
		MaterialMgr.setCellByCfg(data.prize, item, urlOrGo, luaCls, isOne)
	end

	if txtNum then
		txtNum.text = data.progress
	end

	local prizeStatus = HeatProgressModel.instance:getCurPrizeStatus(self._id)
	local isHasGain = prizeStatus[data.id] == true

	GameUtil.SetActive(received, isHasGain)

	local curProgress = HeatProgressModel.instance:getCurProgress(self._id)
	local isEnough = curProgress >= data.progress
	local isCanGet = isEnough and not isHasGain

	GameUtil.SetActive(btn, isCanGet)
	GameUtil.addClickHandler(btn, GameUtil.handler(self._onClickGridCell, self, data.id))
	UIEffectManager.instance:stopEffect(self._gridEffList[mainGo])

	if isCanGet == true then
		local effPath = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"

		local function func(_, eff)
			eff:setScrollRectClipping(self._ScrollRect:GetComponent(ComponentType.ScrollRect))
			eff:setParent(item.transform)
			eff:setLocalPos(0, 0, 0)
			eff:setScale(1, 1, 1)
		end

		self._gridEffList[mainGo] = UIEffectManager.instance:playEffect(self, effPath, item, 0, 0, true, false, nil, func, nil)
	end
end

function HeatProgressView:_onClickGridCell(id)
	self._curStoryId = self._progressPrizeCfgs[id].storyId

	HeatProgressController.instance:onSendProgressGainPrizeReq(self._activityId, self._id, id)
end

function HeatProgressView:_onPlayStory()
	local storyId = self._curStoryId

	if checknumber(storyId) ~= 0 then
		GlobalDispatcher:dispatch(GlobalNotify.PushStory, storyId, StoryModel.StoryType.SCCopy)
	else
		HeatProgressController.instance:onSendProgressGetInfoReq(self._activityId)
	end
end

function HeatProgressView:_onEndStory(storyId)
	if storyId ~= self._curStoryId then
		return
	end

	local changeSetId = HeatProgressModel.instance._prizeRes.changeSetId

	MaterialController.instance:showChangeSetInTemp(changeSetId)
	HeatProgressController.instance:onSendProgressGetInfoReq(self._activityId)
end

return HeatProgressView
