-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/knowledgeanswer/view/KnowledgeAnswerMainView.lua

module("logic.extensions.knowledgeanswer.view.KnowledgeAnswerMainView", package.seeall)

local KnowledgeAnswerMainView = class("KnowledgeAnswerMainView", ViewComponent)

function KnowledgeAnswerMainView:ctor()
	KnowledgeAnswerMainView.super.ctor(self)
end

function KnowledgeAnswerMainView:unbindEvents()
	KnowledgeAnswerMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnShowInfo)
	GameUtil.rmClickHandler(self._btnStart)
end

function KnowledgeAnswerMainView:bindEvents()
	KnowledgeAnswerMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTips, self)
	GameUtil.addClickHandler(self._btnShowInfo, self._onClickBtnShowInfo, self)
	GameUtil.addClickHandler(self._btnStart, self._onClickBtnStart, self)
end

function KnowledgeAnswerMainView:buildUI()
	KnowledgeAnswerMainView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._txtProgress = self:getTxt("infoCol/progress/txtProgress")
	self._txtTrueNum = self:getTxt("infoCol/trueNum/txtTrueNum")
	self._txtRemainNum = self:getTxt("infoCol/remainNum/txtRemainNum")
	self._sliderProgress = self:getSlider("infoCol/progress/slider")
	self._btnShowInfo = self:getGo("btnShowInfo")
	self._btnStart = self:getGo("btnStart")
	self._txtOpenTime = self:getTxt("openTime/txt")
	self._txtCollectingNum = self:getTxt("collectingNum/txtNum")
	self._progressBar = self:getSlider("progress/tableview/Viewport/Content/progressBar")

	local cellProgress = self:getGo("progress/cell")
	local tabProgress = self:getGo("progress/tableview")

	self._tableviewProgress = ScrollerList.create(tabProgress, cellProgress, GameUtil.handler(self._updateProgressCell, self), GameUtil.handler(self._clearProgressCell, self))
end

function KnowledgeAnswerMainView:onExit()
	KnowledgeAnswerMainView.super.onExit(self)
	self._tableviewProgress:dispose()
end

function KnowledgeAnswerMainView:onEnter()
	KnowledgeAnswerMainView.super.onEnter(self)

	local params = self:getOpenParam()

	self._activityId = checknumber(params[1])

	self:_updateByCfg()
	KnowledgeAnswerController.instance:getInfo(self._activityId)
	self.addGEvent(self, GlobalNotify.KnowledgeAnswerUpdateInfo, self._updateByInfo, self)
end

function KnowledgeAnswerMainView:_updateByCfg()
	self._actCfg = KnowledgeAnswerConfig.instance:getActivityCfgById(self._activityId)
	self._prizeCfgs = KnowledgeAnswerConfig.instance:getPrizeCfgs(self._activityId)
	self._txtOpenTime.text = TimeGateController.instance:getActTimeShow(self._activityId)

	local storyId = self._actCfg.firstStoryId

	if checknumber(storyId) > 0 then
		local key = string.format("KnowledgeAnswerMainView_first_op_%s", self._activityId)

		local function firstCallback()
			GlobalDispatcher:dispatch(GlobalNotify.PushStory, storyId, StoryModel.StoryType.SCCopy)
		end

		GameUtil.doCallbackWhenFirst(key, firstCallback)
	end
end

function KnowledgeAnswerMainView:_updateByInfo()
	local baseInfo = KnowledgeAnswerModel.instance:getBaseInfoByActId(self._activityId)
	local report = baseInfo.report

	self._txtTrueNum.text = report.rightNum
	self._txtRemainNum.text = self._actCfg.dailyAnswerTimes - report.anwerTimes

	local curProgress = report.anwerTimes / self._actCfg.dailyAnswerTimes

	self._txtProgress.text = string.format("%.2f%%", curProgress * 100)

	self._sliderProgress:SetValue(curProgress)
	self:_updateProgress()
end

function KnowledgeAnswerMainView:_updateProgress()
	local baseInfo = KnowledgeAnswerModel.instance:getBaseInfoByActId(self._activityId)

	self._curSocre = baseInfo.report.score
	self._curGainedPrizeIds = baseInfo.gainedPrizeIds or {}
	self._txtCollectingNum.text = self._curSocre

	self._tableviewProgress:reloadData(self._prizeCfgs)

	local scoreList = {}

	for i, v in ipairs(self._prizeCfgs) do
		table.insert(scoreList, v.score)
	end

	self._tableviewProgress:updateUnderSlider(self._progressBar, self._curSocre, scoreList)
end

function KnowledgeAnswerMainView:_updateProgressCell(view, cellGo, data)
	local cell = self:_clearProgressCell(cellGo)

	cell.txtNum.text = data.score

	MaterialMgr.setCellByCfg(data.prize, cell.item)

	local isGain = table.keyof(self._curGainedPrizeIds, data.prizeId)
	local isMatchGain = not isGain and self._curSocre >= data.score

	goutil.setActive(cell.btnGet, isMatchGain)

	if isMatchGain then
		self:_playCellEffect(cell.effect)
		GameUtil.addClickHandler(cell.btnGet, GameUtil.handler(self._onClickGainPrize, self, data.prizeId))
	end

	goutil.setActive(cell.geted, isGain)
end

function KnowledgeAnswerMainView:_clearProgressCell(cellGo)
	local cell = {}

	cell.go = cellGo
	cell.item = goutil.findChild(cell.go, "item")

	MaterialMgr.resetAll(cell.item)

	cell.txtNum = goutil.findChildTextComponent(cell.go, "txtNum")
	cell.btnGet = goutil.findChild(cell.go, "btnGet")
	cell.effect = goutil.findChild(cell.go, "effect")
	cell.geted = goutil.findChild(cell.go, "geted")

	GameUtil.rmClickHandler(cell.btnGet)
	self:_clearCellEffect(cell.effect)

	return cell
end

function KnowledgeAnswerMainView:_playCellEffect(effGo)
	self:_clearCellEffect(effGo)

	local effPath = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"
	local uiEffect = UIEffectManager.instance:playEffect(self, effPath, effGo.transform, 0, 0, true, false, nil, function(target, eff)
		eff:setClipping(self:getGo("progress/tableview/Viewport").transform)
	end)

	uiEffect:setParent(effGo.transform)
	uiEffect:setLocalPos(0, 0, 0)
	uiEffect:setScaleXYZ(0.96, 1, 0.87)

	self._cellEffects = self._cellEffects or {}
	self._cellEffects[effGo] = uiEffect
end

function KnowledgeAnswerMainView:_clearCellEffect(effGo)
	if self._cellEffects and self._cellEffects[effGo] then
		UIEffectManager.instance:stopEffect(self._cellEffects[effGo])

		self._cellEffects[effGo] = nil
	end
end

function KnowledgeAnswerMainView:_onClickBtnTips()
	local ruleKey = self._actCfg.ruleKey

	TipsFacade.instance:openRulesView(ruleKey)
end

function KnowledgeAnswerMainView:_onClickGainPrize(prizeId)
	KnowledgeAnswerController.instance:gainPrize(self._activityId, prizeId)
end

function KnowledgeAnswerMainView:_onClickBtnShowInfo()
	UIStateManager.instance:push(ViewName.KnowledgeDisplayView)
end

function KnowledgeAnswerMainView:_onClickBtnStart()
	KnowledgeAnswerController.instance:joinRoom(self._activityId)
end

return KnowledgeAnswerMainView
