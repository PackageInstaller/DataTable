-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinejiclg/view/DivineJiExtremeClgView.lua

module("logic.extensions.divinejiclg.view.DivineJiExtremeClgView", package.seeall)

local DivineJiExtremeClgView = class("DivineJiExtremeClgView", ViewComponent)

function DivineJiExtremeClgView:ctor()
	DivineJiExtremeClgView.super.ctor(self)
end

function DivineJiExtremeClgView:buildUI()
	DivineJiExtremeClgView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._txtTime = self:getTxt("txtTime/txt")
	self._stages = {}

	for i = 1, 6 do
		local cell = {}

		cell.btn = self:getGo("stageBtnCol/btn_" .. i)
		cell.name = self:getTxt("stageBtnCol/btn_" .. i .. "/content/txt")
		cell.select = self:getGo("stageBtnCol/btn_" .. i .. "/content/select")
		cell.score = self:getTxt("stageBtnCol/btn_" .. i .. "/content/score/txt")

		table.insert(self._stages, cell)
	end

	self._btnStart = self:getGo("infos/btnStart")
	self._btnReset = self:getGo("infos/btnReset")
	self._passBtnStart = self:getGo("infos/btnStart/pass")
	self._targets = {}

	for i = 1, 2 do
		local cell = {}

		cell.desc = self:getTxt("infos/targets/desc_" .. i .. "/txt")
		cell.state = self:getGo("infos/targets/desc_" .. i .. "/state"):GetComponent(ComponentType.UIImageSpriteChange)

		table.insert(self._targets, cell)
	end

	self._scoreDesc = self:getTxt("infos/score/desc/viewport/txt")
	self._btnScore = self:getGo("infos/score/btn")
	self._buffDesc = self:getTxt("infos/buff/desc/viewport/txt")
	self._btnBuff = self:getGo("infos/buff/btn")
	self._txtEmpty = self:getGo("infos/lockpets/empty")
	self._tableview = self:getGo("infos/lockpets/tableview")
	self._tablecell = self:getGo("infos/lockpets/tableview/tablecell")
	self._scrollerList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function DivineJiExtremeClgView:bindEvents()
	DivineJiExtremeClgView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTipBtn, self)
	GameUtil.addClickHandler(self._btnStart, self._onClickStartBtn, self)
	GameUtil.addClickHandler(self._btnReset, self._onClickResetBtn, self)
	GameUtil.addClickHandler(self._btnScore, self._onClickScoreBtn, self)
	GameUtil.addClickHandler(self._btnBuff, self._onClickBuffBtn, self)

	for i, cell in ipairs(self._stages) do
		GameUtil.addClickHandler(cell.btn, GameUtil.handler(self._onClickStageBtn, self, i), self)
	end
end

function DivineJiExtremeClgView:unbindEvents()
	DivineJiExtremeClgView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnStart)
	GameUtil.rmClickHandler(self._btnReset)
	GameUtil.rmClickHandler(self._btnScore)
	GameUtil.rmClickHandler(self._btnBuff)

	for i, cell in ipairs(self._stages) do
		GameUtil.rmClickHandler(cell.btn)
	end
end

function DivineJiExtremeClgView:onExit()
	DivineJiExtremeClgView.super.onExit(self)
	GameUtil.saveUserData(self._localUserDataKey .. "lastSelectId", self._selectId)
end

function DivineJiExtremeClgView:onEnter()
	DivineJiExtremeClgView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.DivineJiClgGetInfoRes, self._refresh, self)

	self._activityId = checknumber(self:getFirstParam())

	if self._activityId <= 0 then
		self:close()
		FloatWordMgr.instance:show("挑战未开启")

		return
	end

	self:_getViewConfig()

	self._localUserDataKey = "DivineJiExtremeClgView_"
	self._selectId = GameUtil.getUserData(self._localUserDataKey .. "lastSelectId") or 1
	self._curStageInfo = DivineJiClgModel.instance:getExtremeClSingleStageInfo(self._activityId, self._selectId)

	if not TableUtil.isTableEmpty(self._curStageInfo) then
		self._selectId = DivineJiClgModel.instance:getExtremeClgCurStageId(self._activityId)
	end

	DivineJiClgAgent.instance:sendPM_DivineJiClgGetInfoReq(self._activityId)
end

function DivineJiExtremeClgView:_onClickTipBtn()
	local challengeCfg = TimeLimitedConfig.instance:getCfgById(198)

	TipsFacade.instance:openRulesView(challengeCfg.ruleKey)
end

function DivineJiExtremeClgView:_onClickStartBtn()
	if self._isAoqiGodProcessType then
		local result = AoqiGodController.instance:getTryClgResultAndTipsByAct(true, GameEnum.ActivityType.DivineJiClg, self._activityId)

		if result ~= GameEnum.ResultCode.Success then
			return
		end
	end

	DivineJiClgController.instance:openExtremeClgFmtView(self._activityId, self._selectId)
end

function DivineJiExtremeClgView:_onClickResetBtn()
	if TableUtil.isTableEmpty(self._curStageInfo) then
		return
	end

	local title = "重置本关卡"
	local txt = "是否将本关卡重置为未挑战，积分清空，解除精灵封印"

	local function okFunc()
		DivineJiClgAgent.instance:sendPM_DivineJiResetExtremeClgStageReq(self._activityId, self._selectId)
	end

	TipsFacade.instance:openPopupWindowWithX(title, txt, okFunc)
end

function DivineJiExtremeClgView:_onClickScoreBtn()
	UIStateManager.instance:push(ViewName.DivineJiScoreDescView, self._activityId, self._selectId)
end

function DivineJiExtremeClgView:_onClickBuffBtn()
	UIStateManager.instance:push(ViewName.DivineJiBuffDescView, self._activityId, self._selectId)
end

function DivineJiExtremeClgView:_onClickStageBtn(stageId)
	self._selectId = stageId

	self:_refreshInfosUI()
end

function DivineJiExtremeClgView:_getViewConfig()
	self._activityCfg = DivineJiClgConfig.instance:getActivityCfgByActId(self._activityId)
	self._stageCfg = DivineJiClgConfig.instance:getExtremeStageCfgByActId(self._activityId)
end

function DivineJiExtremeClgView:_refresh()
	for i, v in ipairs(self._stageCfg) do
		local stageInfo = DivineJiClgModel.instance:getExtremeClSingleStageInfo(self._activityId, v.stageId)

		if stageInfo then
			if not stageInfo.score then
				local score = 0
				local cell = self._stages[i]

				cell.name.text = v.attrType
				cell.score.text = string.format("%s积分：%d", v.attrType, score)
			end
		end
	end

	self:_refreshInfosUI()
end

function DivineJiExtremeClgView:_refreshInfosUI()
	for i, v in ipairs(self._stages) do
		goutil.setActive(v.select, i == self._selectId)
	end

	local passNum, score = DivineJiClgModel.instance:getExtremeClgStageTargetsInfo(self._activityId)
	local targetNum = #self._stageCfg
	local targetScore = self._activityCfg.extremeClgTargetScore
	local isFinishTg1 = targetNum <= passNum
	local isFinishTg2 = targetScore <= score
	local color1 = isFinishTg1 and "#3cb44b" or "#ff3c3d"
	local color2 = isFinishTg2 and "#3cb44b" or "#ff3c3d"

	self._targets[1].desc.text = string.format("1. 全部关卡破阵（<color=%s>%d</color>/%d）", color1, passNum, targetNum)

	self._targets[1].state:SetState(isFinishTg1 and 1 or 0)

	self._targets[2].desc.text = string.format("2. 全部关卡总积分 ≥ %d （<color=%s>%d</color>/%d）", targetScore, color2, score, targetScore)

	self._targets[2].state:SetState(isFinishTg2 and 1 or 0)

	if self._activityCfg then
		if not self._activityCfg.extremeClgScoreDetails then
			local extremeClgScoreDetails = ""

			if self._stageCfg[self._selectId] then
				if not self._stageCfg[self._selectId].buffDetails then
					self._scoreDesc.text = extremeClgScoreDetails
					self._buffDesc.text = ""
					self._curStageInfo = DivineJiClgModel.instance:getExtremeClSingleStageInfo(self._activityId, self._selectId)

					if self._curStageInfo then
						if not self._curStageInfo.lockedRace then
							local lockedRace = {}
							local canPlay = TableUtil.isTableEmpty(self._curStageInfo)

							self._scrollerList:reloadData(lockedRace)
							goutil.setActive(self._txtEmpty, canPlay)
							goutil.setActive(self._btnStart, canPlay)
							goutil.setActive(self._btnReset, not canPlay)
						end
					end
				end
			end
		end
	end
end

function DivineJiExtremeClgView:_updateCell(view, cell, data)
	local con = goutil.findChild(cell, "con")

	MaterialMgr.setCell(MatType.Pet, data, con)
end

function DivineJiExtremeClgView:_clearCell(cell)
	local con = goutil.findChild(cell, "con")

	MaterialMgr.resetAll(con)
end

return DivineJiExtremeClgView
