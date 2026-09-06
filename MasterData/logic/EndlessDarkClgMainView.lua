-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/endlessdark/view/EndlessDarkClgMainView.lua

module("logic.extensions.endlessdark.view.EndlessDarkClgMainView", package.seeall)

local EndlessDarkClgMainView = class("EndlessDarkClgMainView", ViewComponent)

function EndlessDarkClgMainView:ctor()
	EndlessDarkClgMainView.super.ctor(self)
end

function EndlessDarkClgMainView:unbindEvents()
	EndlessDarkClgMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnRank)
	GameUtil.rmClickHandler(self._btnTree)
	GameUtil.rmClickHandler(self._btnChallenge)
	GameUtil.rmClickHandler(self._btnBuff)
end

function EndlessDarkClgMainView:bindEvents()
	EndlessDarkClgMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnRank, self._onClickBtnRank, self)
	GameUtil.addClickHandler(self._btnTree, self._onClickBtnTree, self)
	GameUtil.addClickHandler(self._btnChallenge, self._onClickBtnChallenge, self)
	GameUtil.addClickHandler(self._btnBuff, self._onClickBtnBuff, self)
end

function EndlessDarkClgMainView:buildUI()
	EndlessDarkClgMainView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._btnRank = self:getGo("btnRank")
	self._btnTree = self:getGo("btnTree")
	self._btnChallenge = self:getGo("btnChallenge")
	self._btnBuff = self:getGo("btnBuff")
	self._txtOpenTime = self:getTxt("time/txt")
	self._txtProgress = self:getTxt("total/txtProgress")
	self._progressSlider = self:getSlider("scorollReward/tableview/viewport/content/progressSlider")
	self._tableview = self:getGo("scorollReward/tableview")
	self._rewardcell = self:getGo("scorollReward/rewardcell")
	self._tableviewViewport = self:getGo("scorollReward/tableview/viewport")
	self._scrollList = ScrollerList.create(self._tableview, self._rewardcell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._conGo = self:getGo("con")
end

function EndlessDarkClgMainView:onExit()
	EndlessDarkClgMainView.super.onExit(self)
	self._scrollList:dispose()

	if self._roleObj then
		RoleObjectPool.instance:removeRole(self._roleObj)

		self._roleObj = nil
	end
end

function EndlessDarkClgMainView:onEnter()
	EndlessDarkClgMainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_EndlessDarkClgGetInfoRes, self._onUpdate, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = 555001
	end

	self._txtOpenTime.text = TimeGateController.instance:getActTimeShow(self._activityId)
	self._actCfg = EndlessDarkClgConfig.instance:getActCfg(self._activityId)
	self._waveCfg = EndlessDarkClgConfig.instance:getWaveCfg(self._activityId)
	self._prizeCfg = EndlessDarkClgConfig.instance:getPrizeCfgs(self._activityId)

	EndlessDarkClgController.instance:sendPM_EndlessDarkClgGetInfoReq(self._activityId)

	self._roleObj = RoleObjectPool.instance:addRoleToParent(self._roleObj, 13025, self._conGo, 1, nil, true)
end

function EndlessDarkClgMainView:_onUpdate()
	self._info = EndlessDarkClgModel.instance:getInfo(self._activityId)

	local waveCfgs = EndlessDarkClgConfig.instance:getWaveCfg(self._activityId)

	if self._info then
		if not self._info.curWaveId then
			local curWaveId = 1

			curWaveId = math.min(#waveCfgs, self._info.curWaveId)

			local waveStageCfgs = EndlessDarkClgConfig.instance:getWaveCfgsByWaveId(self._activityId, curWaveId)
			local scoreList = {}

			for i, cfgs in ipairs(waveStageCfgs) do
				table.insert(scoreList, i)
			end

			local finishIds = EndlessDarkClgController.instance:getCurFinishPrizeId(self._activityId)

			self._txtProgress.text = string.format("当前第%d波次\n总共%d波次", curWaveId, #waveCfgs)

			self._scrollList:updateUnderSlider(self._progressSlider, finishIds, scoreList)
			self._scrollList:reloadData(waveStageCfgs)
			self._scrollList:MoveCellToCenter(finishIds)
		end
	end
end

function EndlessDarkClgMainView:_updateCell(view, cell, data)
	local item = goutil.findChild(cell, "item")
	local geted = goutil.findChild(cell, "geted")
	local effect = goutil.findChild(cell, "effect")
	local txtScore = goutil.findChildTextComponent(cell, "txtScore")

	txtScore.text = string.format("第%d场", data.stageId)

	MaterialMgr.setCellByCfg(data.prize, item)

	if self._info then
		local finishIds = self._info.stageId
		local canGet = finishIds >= data.stageId

		GameUtil.SetActive(geted, canGet)
	end
end

function EndlessDarkClgMainView:_clearCell(cell)
	local item = goutil.findChild(cell, "item")
	local effect = goutil.findChild(cell, "effect")

	MaterialMgr.resetAll(item)
end

function EndlessDarkClgMainView:_onClickBtnTip()
	local key = self._actCfg.ruleKey

	TipsFacade.instance:openRulesView(key)
end

function EndlessDarkClgMainView:_onClickBtnRank()
	UIStateManager.instance:push(ViewName.EndlessDarkClgRankView, self._activityId)
end

function EndlessDarkClgMainView:_onClickBtnTree()
	local jumpStr = self._actCfg.jumpTo[1]

	GotoMgr.gotoByString(jumpStr)
end

function EndlessDarkClgMainView:_onClickBtnChallenge()
	local stageId = self._info.stageId + 1
	local stageCfg = EndlessDarkClgConfig.instance:getWaveCfgsByStageId(self._activityId, self._info.curWaveId, stageId)

	if stageCfg then
		EndlessDarkClgController.instance:enterBattleClg(self._activityId, self._info.curWaveId, self._info.stageId + 1)
	else
		TipsFacade.instance:openCommonTips("挑战已全部完成")
	end
end

function EndlessDarkClgMainView:_onClickBtnBuff()
	UIStateManager.instance:push(ViewName.EndlessDarkClgLevelUpView, self._activityId)
end

return EndlessDarkClgMainView
