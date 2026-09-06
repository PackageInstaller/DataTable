-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/gathertask/view/GathertaskView.lua

module("logic.extensions.gathertask.view.GathertaskView", package.seeall)

local GathertaskView = class("GathertaskView", ViewComponent)
local TOTAL_GET_ALL = 1
local TOTAL_HAS_LEFT = 2
local TODAY_HAS_LEFT = 3

function GathertaskView:ctor()
	GathertaskView.super.ctor(self)
end

function GathertaskView:unbindEvents()
	GathertaskView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self.btnClose)
	GameUtil.rmClickHandler(self.btnTip)
	GameUtil.rmClickHandler(self.btnTip2)
	GameUtil.rmClickHandler(self.btnGo)
end

function GathertaskView:bindEvents()
	GathertaskView.super.bindEvents(self)
	GameUtil.addClickHandler(self.btnClose, self.close, self)
	GameUtil.addClickHandler(self.btnTip, self._onClickRule, self)
	GameUtil.addClickHandler(self.btnTip2, self._onClickTip, self)
	GameUtil.addClickHandler(self.btnGo, self._onClickGo, self)
end

function GathertaskView:buildUI()
	GathertaskView.super.buildUI(self)

	self._slider = self:getGo("ScrollRect/ViewPort/Content/progressBar"):GetComponent(typeof(UnityEngine.UI.Slider))
	self._gridLayout = self:getGo("ScrollRect/ViewPort/Content/prizes"):GetComponent(typeof(UnityEngine.UI.GridLayoutGroup))
	self._content = self:getGo("ScrollRect/ViewPort/Content"):GetComponent(typeof(UnityEngine.RectTransform))
	self._viewPort = self:getGo("ScrollRect/ViewPort"):GetComponent(typeof(UnityEngine.RectTransform))
	self._scrollRect = self:getGo("ScrollRect"):GetComponent(typeof(UnityEngine.UI.ScrollRect))
	self._txtCurScore = self:getTxt("txtNum")
	self._bar = DiscreteProgressBar.New(self._slider, self._gridLayout)
	self.skinTip = self:getTxt("skinTip/txt")
	self.btnClose = self:getGo("btnClose")
	self.btnTip = self:getGo("btnTip")
	self.btnTip2 = self:getGo("btnTip2")
	self.btnGo = self:getGo("btnGo")
	self.txtGoto = self:getTxt("btnGo/Text")
	self.txtTime = self:getTxt("time/txtTime")
	self.bubble = self:getGo("bubble")
	self.txtBubble = self:getTxt("bubble/txtDesc")
	self.items = {}

	for i = 1, 6 do
		local btn = self:getGo("btn_" .. i)

		table.insert(self.items, btn)
	end
end

function GathertaskView:onExit()
	GathertaskView.super.onExit(self)

	local go = self:getGo("ScrollRect/ViewPort/Content")

	UnityTweens.TweenSequence.StopTween(go)
	GlobalDispatcher:removeListener(GlobalNotify.GatherTask_INFO, self.onRefreshUI, self)
	self:stopBubbleTime()
	UIEffectManager.instance:stopEffect(self._pmEff)
end

function GathertaskView:onEnter()
	GathertaskView.super.onEnter(self)

	self.isShowingBubble = false

	GlobalDispatcher:addListener(GlobalNotify.GatherTask_INFO, self.onRefreshUI, self)
	GatherTaskController.instance:getInfo()
	self:onRefreshUI()
	GameUtil.doCallbackWhenFirst("GathertaskView_20211125", function()
		self:_onClickTip(GameUtil.handler(self._tweenContent, self))
	end, function()
		self:_tweenContent()
	end)
	self:_updateActivityTime(self:getActivityId())

	self.skinTip.text = GatherTaskConfig.instance:getCommonValue("SKIN_TIP")

	local effPath = "20211217/shengdanpaotu/fx_ui_sdpt_daiji.prefab"

	self._pmEff = UIEffectManager.instance:playEffect(self, effPath, self.mainGO, 0, 0, true, nil, nil, nil, self)

	self._pmEff:setParent(self.mainGO.transform)
	self._pmEff:setScale(1)
end

function GathertaskView:getActivityId()
	return GatherTaskController.instance:getActivityId()
end

function GathertaskView:onRefreshUI()
	local activityId = self:getActivityId()
	local actCfg = GatherTaskConfig.instance:getActivityCfgById(activityId)
	local materialPlanId = actCfg.materialPlanId
	local allMax = true

	for i, v in ipairs(self.items) do
		local matCfg = GatherTaskConfig.instance:getMaterialCfgById(materialPlanId, i)

		self:updateItem(v, matCfg)

		local num = GatherTaskModel.instance:getMatNum(matCfg.id)

		if checknumber(num) < checknumber(matCfg.maxCount) then
			allMax = false
		end
	end

	self:stopBubbleTime()

	if allMax then
		GameUtil.SetActive(self.bubble, true)

		self.txtBubble.text = GatherTaskConfig.instance:getCommonValue("GET_ALL_TIPS")
		self.txtGoto.text = lang("去查看")
	else
		self.txtGoto.text = lang("去收集")

		self:startBubbleTime()
	end

	self:_updateProgressBar()
end

function GathertaskView:updateItem(cell, matCfg)
	local item = goutil.findChild(cell, "item")
	local lock = goutil.findChild(cell, "lock")
	local receive = goutil.findChild(cell, "receive")
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local txtTip = goutil.findChildTextComponent(cell, "tip/txtTip")

	GameUtil.SetActive(receive, false)
	GameUtil.SetActive(lock, false)
	MaterialMgr.updateItemByStr(item, matCfg.item)

	txtName.text = MaterialMgr.getMaterialsNameByCfg(matCfg.item)

	local nowTime = ServerTime.now()
	local activityId = self:getActivityId()
	local startTimestamp, endTimestamp = ActivityDefineController.instance:getStartTimeAndEndTime(GameEnum.ActivityType.GatherTask, activityId)
	local dayTimestamp = 86400
	local offsetDay = checknumber(matCfg.openDay) - 1
	local startTime = startTimestamp + dayTimestamp * offsetDay

	if startTime <= nowTime and nowTime < endTimestamp then
		local num = GatherTaskModel.instance:getMatNum(matCfg.id)

		txtTip.text = langPara("moyanmainview__4", " " .. num .. "/" .. matCfg.maxCount)

		GameUtil.SetActive(receive, checknumber(num) == checknumber(matCfg.maxCount))
	else
		GameUtil.SetActive(lock, true)

		local date = GameUtil.time2date(startTime)

		txtTip.text = langPara("%s.%s %02d:%02d可解锁", date.month, date.day, date.hour, date.min)
	end

	GameUtil.addClickHandler(cell, function()
		CommonTipsMgr.instance:openTipsByConfStr(cell, matCfg.item)
	end)
end

function GathertaskView:_onClickRule()
	UIStateManager.instance:open(ViewName.RulesView, GatherTaskConfig.instance:getCommonValue("RULES_KEY"))
end

function GathertaskView:_onClickTip(callBack)
	UIStateManager.instance:push(ViewName.GathertasktipsView, callBack)
end

function GathertaskView:stopBubbleTime()
	removetimer(self.onTimeRun, self)
end

function GathertaskView:startBubbleTime()
	if self:checkHasGetAllType() ~= TOTAL_GET_ALL then
		self:onTimeRun()
		settimer(3, self.onTimeRun, self, true)
	end
end

function GathertaskView:onTimeRun()
	self.isShowingBubble = not self.isShowingBubble

	GameUtil.SetActive(self.bubble, self.isShowingBubble)

	local num = checknumber(GatherTaskConfig.instance:getCommonValue("BUBBLE_COUNT"))
	local randomIdx = math.random(1, num)

	self.txtBubble.text = GatherTaskConfig.instance:getCommonValue("BUBBLE_TIPS_" .. randomIdx)
end

function GathertaskView:checkHasGetAllType()
	local activityId = self:getActivityId()
	local actCfg = GatherTaskConfig.instance:getActivityCfgById(activityId)
	local materialPlanId = actCfg.materialPlanId
	local isGetAll = TOTAL_GET_ALL
	local nowTime = ServerTime.now()
	local startTimestamp, endTimestamp = ActivityDefineController.instance:getStartTimeAndEndTime(GameEnum.ActivityType.GatherTask, activityId)
	local dayTimestamp = 86400

	for i, v in ipairs(self.items) do
		local matCfg = GatherTaskConfig.instance:getMaterialCfgById(materialPlanId, i)
		local offsetDay = checknumber(matCfg.openDay) - 1
		local startTime = startTimestamp + dayTimestamp * offsetDay

		if startTime <= nowTime and nowTime < endTimestamp then
			local num = GatherTaskModel.instance:getMatNum(matCfg.id)

			if checknumber(num) < checknumber(matCfg.maxCount) then
				isGetAll = TODAY_HAS_LEFT

				break
			end
		else
			isGetAll = TOTAL_HAS_LEFT
		end
	end

	return isGetAll
end

function GathertaskView:_onClickGo()
	local type = self:checkHasGetAllType()

	if type == TOTAL_GET_ALL then
		GotoMgr.gotoByString(GatherTaskConfig.instance:getCommonValue("JUMP_TO"))
	elseif type == TOTAL_HAS_LEFT then
		TipsFacade.instance:openCommonTips(lang("当前暂无可收集材料哦~"))
	else
		self:close()
		GatherTaskController.instance:moveToNpc()
		GatherTaskController.instance:checkHasNpcAndSetRedpoint()
	end

	SurveyController.instance:reportBehavior(200645)
end

function GathertaskView:_updateActivityTime(activityId)
	local activityCfg = ActivityDefineConfig.instance:getCfgById(GameEnum.ActivityType.GatherTask, activityId)
	local startTime = GameUtil.string2date(activityCfg.startTime)
	local endTime = GameUtil.string2date(activityCfg.endTime)

	self.txtTime.text = langPara("活动时间:%s月%s日-%s月%s日", startTime.month, startTime.day, endTime.month, endTime.day)
end

function GathertaskView:clearEff()
	if self._canGainEffs then
		for _, v in ipairs(self._canGainEffs) do
			UIEffectManager.instance:stopEffect(v)
		end
	end

	self._canGainEffs = {}
end

function GathertaskView:_updateProgressBar(needSetOffset)
	local totalScore = GatherTaskModel.instance.score
	local scores = {}
	local planId = 1
	local prizeCfgs = GatherTaskConfig.instance:getPrizeList(planId)

	for _, v in ipairs(prizeCfgs) do
		table.insert(scores, v.collectionNum)
	end

	local x = self._bar:setValue(scores, totalScore)

	self._content.sizeDelta = Vector2.New(x + 70, 100)
	self._txtCurScore.text = langPara("moyanmainview__4", "\n" .. totalScore)

	self:clearEff()

	self._minGainedId = 0

	GameUtil.updateCellsWithCreate(self._gridLayout, prizeCfgs, self._updateOnePrize, self)

	if needSetOffset then
		local viewPortSize = self._viewPort.rect.size.x
		local contentSize = self._content.sizeDelta.x
		local maxOffset = contentSize - viewPortSize

		Framework.TransformUtil.SetAnchoredPos(self._content, 0, 0)

		local x, y, z = Framework.TransformUtil.GetLocalPos(self._content.transform, 0, 0, 0)
		local cellWidth = self._gridLayout.cellSize.x
		local spacingX = self._gridLayout.spacing.x

		x = x - math.min(maxOffset, cellWidth * self._minGainedId + spacingX * self._minGainedId)

		Framework.TransformUtil.SetLocalPos(self._content.transform, x, 0, 0)
	end
end

function GathertaskView:_updateOnePrize(go, cfg)
	local itemPoint = goutil.findChild(go, "item/itemcell")
	local txtNum = goutil.findChildTextComponent(go, "txtNum")
	local received = goutil.findChild(go, "item/received")

	MaterialMgr.setCellByCfg(cfg.prize, itemPoint)

	local btn = Framework.ButtonAdapter.GetFrom(go, "btn")

	txtNum.text = cfg.collectionNum

	if not GatherTaskModel.instance.gainedPrizeIds then
		local gainedPrizeIds = {}
		local gained = table.indexof(gainedPrizeIds, cfg.id) ~= false

		received:SetActive(gained)

		local canGain = cfg.collectionNum <= checknumber(GatherTaskModel.instance.score)

		if canGain and not gained then
			local url = "fx_ui_longchengmibao/fx_ui_longchengmibao.prefab"
			local eff = self:_playEffect(url, go, 0.62, true)

			table.insert(self._canGainEffs, eff)
			btn.gameObject:SetActive(true)
			btn:AddClickListener(function()
				self:_onClickPrize(cfg.id)
			end)

			self._minGainedId = self._minGainedId == 0 and cfg.id - 1 or math.min(self._minGainedId, cfg.id - 1)
		else
			btn.gameObject:SetActive(false)
		end
	end
end

function GathertaskView:_onClickPrize(prizeId)
	GatherTaskController.instance:sendGetPrize(prizeId)
end

function GathertaskView:_tweenContent()
	return
end

function GathertaskView:_playEffect(url, parent, scale, needSetClip)
	return (UIEffectManager.instance:playEffect(self, url, parent, 0, 0, true, nil, nil, function(self2, uiEffect)
		uiEffect:setClipping(self._viewPort)
		uiEffect:setParent(parent.transform)
		uiEffect:setScale(scale or 1)

		local rectTrans = uiEffect.effGo:GetComponent(typeof(UnityEngine.RectTransform))

		Framework.TransformUtil.SetAnchoredPos(rectTrans, 0, 0)
	end))
end

return GathertaskView
