-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/parallelkingdragon/view/ParallelkingdragonstageView.lua

module("logic.extensions.parallelkingdragon.view.ParallelkingdragonstageView", package.seeall)

local ParallelkingdragonstageView = class("ParallelkingdragonstageView", ViewComponent)

function ParallelkingdragonstageView:ctor()
	ParallelkingdragonstageView.super.ctor(self)
end

function ParallelkingdragonstageView:unbindEvents()
	ParallelkingdragonstageView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnShow)
end

function ParallelkingdragonstageView:bindEvents()
	ParallelkingdragonstageView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickHelp, self)
	GameUtil.addClickHandler(self._btnShow, self._onClickShow, self)
end

function ParallelkingdragonstageView:buildUI()
	ParallelkingdragonstageView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnTip = self:getGo("btnTip")
	self._changeBg = self:getGo("changeBg")
	self._noPass = self:getGo("noPass")
	self._txtTitle = self:getTxt("txtTitle")
	self._firstPass = self:getGo("firstPass")
	self._btnShow = self:getGo("firstPass/btnShow")
	self._txtArea = self:getTxt("firstPass/txtArea")
	self._txtName = self:getTxt("firstPass/txtName")
	self._head = self:getGo("firstPass/head")
	self._progressBar = self:getSlider("progressReward/tableview/Viewport/Content/progressBar")
	self._tableview = self:getGo("progressReward/tableview")
	self._rewardCell = self:getGo("progressReward/rewardCell")
	self._total = self:getGo("progressReward/total")
	self._txtCount = self:getTxt("progressReward/total/txt")
	self._txtRuleDesc = self:getTxt("rule/tableview/viewport/content")
	self._rewardScrollList = ScrollerList.create(self._tableview, self._rewardCell, GameUtil.handler(self._updateRewardCell, self), GameUtil.handler(self._clearRewardCell, self))
	self._tablecell2 = self:getGo("tablecell")
	self._tableview2 = self:getGo("tableview")
	self._scrollList = ScrollerList.create(self._tableview2, self._tablecell2, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function ParallelkingdragonstageView:destroyUI()
	if self._tempMat then
		goutil.destroy(self._tempMat)

		self._tempMat = nil
	end
end

function ParallelkingdragonstageView:onExit()
	ParallelkingdragonstageView.super.onExit(self)
	self._scrollList:dispose()
	self._rewardScrollList:dispose()
	uGuiUtil.clearImage(self._changeBg)
end

function ParallelkingdragonstageView:onEnter()
	ParallelkingdragonstageView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	self:_onRefershUI()
end

function ParallelkingdragonstageView:_onRefershUI()
	local actCfg = ParallelkingdragonConfig.instance:getActCfg(self._activityId)

	self._txtRuleDesc.text = actCfg.ruleDesc
	self._info = ParallelkingdragonModel.instance:getInfo(self._activityId)
	self._maxPassStageId = self._info.maxPassStageId
	self._stageProgress = self._maxPassStageId

	local stageCfgs = ParallelkingdragonConfig.instance:getStageCfgs(self._activityId)

	self._scrollList:reloadData(stageCfgs)
	self._scrollList:MoveCellToCenter(self._maxPassStageId)

	local prizeList = ParallelkingdragonConfig.instance:getPrizeCfgs(self._activityId)
	local idx = -1
	local scoreArr = {}

	for i, v in ipairs(prizeList) do
		table.insert(scoreArr, v.stageId)

		local isGainPrize = self._maxPassStageId >= v.stageId

		if not isGainPrize and idx == -1 then
			idx = i - 1
		end
	end

	self._rewardScrollList:reloadData(prizeList)
	self._rewardScrollList:updateUnderSlider(self._progressBar, self._stageProgress, scoreArr)
	self._rewardScrollList:MoveCellToCenter(idx == -1 and 0 or idx)

	self._txtCount.text = self._stageProgress .. "/" .. #stageCfgs
end

function ParallelkingdragonstageView:_updateCell(view, cell, stageCfg, tag)
	local btn = goutil.findChild(cell, "root")
	local icon = goutil.findChild(cell, "root/icon")
	local pass = goutil.findChild(cell, "root/pass")
	local lock = goutil.findChild(cell, "root/lock")
	local txtName = goutil.findChildTextComponent(cell, "root/txtName")

	GameUtil.SetActive(emptyIcon, false)

	local firstPosCfg = ParallelkingdragonConfig.instance:getFirstPosCreepsCfg(self._activityId, stageCfg.stageId)
	local skinId = checknumber(firstPosCfg.faceId)

	if skinId <= 0 then
		skinId = checknumber(firstPosCfg.raceId)
	end

	MaterialMgr.setIcon(icon, MatType.Pet, skinId)

	txtName.text = string.format("第%s关", stageCfg.stageId)

	goutil.setActive(lock, stageCfg.stageId > self._maxPassStageId + 1)
	goutil.setActive(pass, stageCfg.stageId <= self._maxPassStageId)

	local posy = cell.data % 2 == 0 and 127 or -30

	Framework.TransformUtil.SetAnchoredPos(btn.transform, 0, posy)
	GameUtil.addClickHandler(btn, GameUtil.handler(self._onClickStage, self, stageCfg))
end

function ParallelkingdragonstageView:_onClickShow()
	return
end

function ParallelkingdragonstageView:_onClickHelp()
	local challengeCfg = ParallelkingdragonController.instance:getChallengeCfg()

	TipsFacade.instance:openRulesView(challengeCfg.ruleKey)
end

function ParallelkingdragonstageView:_clearCell(cell)
	return
end

function ParallelkingdragonstageView:_onClickStage(stageCfg)
	if stageCfg.stageId > self._maxPassStageId + 1 then
		TipsFacade.instance:openCommonTips("请通关前置关卡")

		return
	end

	local mo = ParallelkingdragonModel.instance:getFmtMo()

	mo:initParams(self._activityId, stageCfg.stageId)
	CustomFmtController.instance:showMissionView(mo)
end

function ParallelkingdragonstageView:_updateRewardCell(view, cell, stageCfg, tag)
	local item = goutil.findChild(cell, "item")
	local received = goutil.findChild(cell, "received")
	local txtScore = goutil.findChildTextComponent(cell, "txtScore")

	MaterialMgr.setCellByCfg(stageCfg.prize, item)

	txtScore.text = stageCfg.stageId

	local isGainPrize = self._maxPassStageId >= stageCfg.stageId

	GameUtil.SetActive(received, isGainPrize)
end

function ParallelkingdragonstageView:_clearRewardCell(cell)
	local item = goutil.findChild(cell, "item")

	MaterialMgr.resetAll(item)
end

return ParallelkingdragonstageView
