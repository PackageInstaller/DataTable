-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineaojiu/view/DivineAoJiuNormalStageView.lua

module("logic.extensions.divineaojiu.view.DivineAoJiuNormalStageView", package.seeall)

local DivineAoJiuNormalStageView = class("DivineAoJiuNormalStageView", ViewComponent)

function DivineAoJiuNormalStageView:ctor()
	DivineAoJiuNormalStageView.super.ctor(self)
end

function DivineAoJiuNormalStageView:unbindEvents()
	DivineAoJiuNormalStageView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnOneKey)
end

function DivineAoJiuNormalStageView:bindEvents()
	DivineAoJiuNormalStageView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnOneKey, self._onClickOneKey, self)
end

function DivineAoJiuNormalStageView:buildUI()
	DivineAoJiuNormalStageView.super.buildUI(self)

	self._rewardTableCell = self:getGo("rewardTableCell")
	self._rewardTableView = self:getGo("rewardTableView")
	self._rewardTableList = ScrollerList.create(self._rewardTableView, self._rewardTableCell, GameUtil.handler(self._updateRewardCell, self), GameUtil.handler(self._clearRewardCell, self))
	self._rewardSilder = self:getSlider("rewardTableView/viewport/content/progressBar")
	self._stageTableView = self:getGo("stageTableView")
	self._stageTableCell = self:getGo("stageTableView/stageTableCell")
	self._recordPos = self._stageTableView:GetComponent(ComponentType.TestRecordPos)
	self._btnClose = self:getGo("btnClose")
	self._btnTip = self:getGo("btnTip")
	self._btnOneKey = self:getGo("btnOneKey")
	self._txtTotalScore = self:getTxt("txtTotalScore")
	self._txtPassTime = self:getTxt("txtPassTime")
end

function DivineAoJiuNormalStageView:onExit()
	DivineAoJiuNormalStageView.super.onExit(self)
end

function DivineAoJiuNormalStageView:onEnter()
	DivineAoJiuNormalStageView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.DivineAoJiuClgGetInfo, self._refreshView, self)

	self._activityId = checknumber(self:getFirstParam())
	self._activityCfg = DivineAoJiuConfig.instance:getActivityCfg(self._activityId)

	self:_refreshView()
end

function DivineAoJiuNormalStageView:_refreshView()
	local prizeCfgs = DivineAoJiuConfig.instance:getNormalPrizeCfgs(self._activityId)

	self._rewardTableList:reloadData(prizeCfgs)

	local passCount = DivineAoJiuModel.instance:getPassNormalStage(self._activityId)
	local scoreList = {}

	if prizeCfgs then
		for i, v in ipairs(prizeCfgs) do
			table.insert(scoreList, v.passStageCount)
		end
	end

	self._rewardTableList:updateUnderSlider(self._rewardSilder, passCount, scoreList)

	self._txtTotalScore.text = langPara("关卡进度：%d", passCount)

	local stageCfgs = DivineAoJiuConfig.instance:getNormalStageCfgs(self._activityId)

	GameUtil.updateCellsList(self._stageTableView, self._stageTableCell, stageCfgs, self._updateStageCell, self)
	self._recordPos:LoadPlan(0)

	local leftPassTime = DivineAoJiuModel.instance:getLeftPassTime(self._activityId)

	self._txtPassTime.text = langPara("通关次数：%d/%d", leftPassTime, self._activityCfg.normalClgTimesLimit)
end

function DivineAoJiuNormalStageView:_updateRewardCell(view, cell, data, tag)
	local go = cell.gameObject
	local txtScore = goutil.findChildTextComponent(go, "txtScore")
	local itemCon = goutil.findChild(go, "item")
	local receive = goutil.findChild(go, "receive")
	local passCount = DivineAoJiuModel.instance:getPassNormalStage(self._activityId)

	txtScore.text = data.passStageCount

	GameUtil.SetActive(receive, passCount >= data.passStageCount)
	MaterialMgr.resetAll(itemCon)
	MaterialMgr.setCellByCfg(data.prize, itemCon)
end

function DivineAoJiuNormalStageView:_clearRewardCell(cell)
	local go = cell.gameObject
	local itemCon = goutil.findChild(go, "item")

	MaterialMgr.resetAll(itemCon)
end

function DivineAoJiuNormalStageView:_updateStageCell(cell, data, index)
	local go = cell.gameObject
	local btn = goutil.findChild(go, "btn")
	local passGo = goutil.findChild(go, "pass")
	local lock = goutil.findChild(go, "lock")
	local passCount = DivineAoJiuModel.instance:getPassNormalStage(self._activityId)

	GameUtil.SetActive(lock, data.stageId > passCount + 1)
	GameUtil.SetActive(passGo, passCount >= data.stageId)
	GameUtil.rmClickHandler(btn)
	GameUtil.addClickHandler(btn, function()
		self:_onClickStage(data.stageId)
	end)
end

function DivineAoJiuNormalStageView:_clearStageCell(cell)
	local go = cell.gameObject
	local btn = goutil.findChild(go, "btn")

	GameUtil.rmClickHandler(btn)
end

function DivineAoJiuNormalStageView:_onClickStage(stageId)
	local passCount = DivineAoJiuModel.instance:getPassNormalStage(self._activityId)
	local leftPassTime = DivineAoJiuModel.instance:getLeftPassTime(self._activityId)

	if stageId <= passCount then
		FloatWordMgr.instance:show(lang("已通关"))
	elseif leftPassTime <= 0 then
		FloatWordMgr.instance:show(lang("您已暂无次数 请明日再来"))
	elseif stageId > passCount + 1 then
		FloatWordMgr.instance:show(lang("请通关前置关卡"))
	else
		DivineAoJiuController.instance:openNormalMissionView(self._activityId, stageId)
	end
end

function DivineAoJiuNormalStageView:_onClickOneKey()
	local passCount = DivineAoJiuModel.instance:getPassNormalStage(self._activityId)
	local leftPassTime = DivineAoJiuModel.instance:getLeftPassTime(self._activityId)
	local stageCfgs = DivineAoJiuConfig.instance:getNormalStageCfgs(self._activityId)
	local matType, matId, matNum = MaterialMgr.getMatParams(self._activityCfg.buyNormalStagePassCost)

	if leftPassTime <= 0 then
		FloatWordMgr.instance:show(lang("已无通关次数"))
	elseif passCount >= #stageCfgs then
		FloatWordMgr.instance:show(lang("已通关"))
	elseif MaterialModel.instance:IsEnough(matType, matId, matNum) == false then
		MaterialMgr.openGetSource(matType, matId)
	else
		local myMatNum = MaterialModel.instance:getMaterialsNumber(matType, matId)
		local matName = MaterialMgr.getMaterialsName(matType, matId)
		local maxCount = math.floor(myMatNum / matNum)
		local buyPassCount = math.min(leftPassTime, maxCount)

		if buyPassCount + passCount > #stageCfgs then
			buyPassCount = #stageCfgs - passCount
		end

		local content = langPara("是否确认消耗[%s*%d]通关%d个关卡？\nps：价格根据当前关卡的数量换算\n购买通关关卡数量越少，价格越低哦！", matName, buyPassCount * matNum, buyPassCount)

		TipsFacade.instance:openPopupWindow(lang("提示"), content, function()
			DivineAoJiuClgAgent.instance:sendPM_DivineAoJiuClgBuyPassReq(self._activityId, buyPassCount)
		end)
	end
end

function DivineAoJiuNormalStageView:_onClickTip()
	TipsFacade.instance:openRulesView("divine_ao_jiu_clg_rule")
end

return DivineAoJiuNormalStageView
