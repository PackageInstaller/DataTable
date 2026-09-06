-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/finalecho/view/FinalEchoMainView.lua

module("logic.extensions.finalecho.view.FinalEchoMainView", package.seeall)

local FinalEchoMainView = class("FinalEchoMainView", ViewComponent)

function FinalEchoMainView:ctor()
	FinalEchoMainView.super.ctor(self)
end

function FinalEchoMainView:unbindEvents()
	FinalEchoMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnJumpRank)
	GameUtil.rmClickHandler(self._btnJumpTask)
	GameUtil.rmClickHandler(self._btnReset)

	for i, cell in ipairs(self._enterCellList) do
		GameUtil.rmClickHandler(cell.go)
		GameUtil.rmClickHandler(cell.btnRule)
	end
end

function FinalEchoMainView:bindEvents()
	FinalEchoMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnJumpRank, self._onClickBtnRank, self)
	GameUtil.addClickHandler(self._btnJumpTask, self._onClickBtnTask, self)
	GameUtil.addClickHandler(self._btnReset, self._onClickBtnReset, self)

	for i, cell in ipairs(self._enterCellList) do
		GameUtil.addClickHandler(cell.go, GameUtil.handler(self._enterFight, self, i))
		GameUtil.addClickHandler(cell.btnRule, GameUtil.handler(self._onClickBtnSubTips, self, i))
	end
end

function FinalEchoMainView:buildUI()
	FinalEchoMainView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._btnJumpRank = self:getGo("btnJumpRank")
	self._btnJumpTask = self:getGo("btnJumpTask")
	self._rdJumpTask = self:getGo("btnJumpTask/redPoint")
	self._btnReset = self:getGo("btnReset")
	self._txtOpenTime = self:getTxt("txtOpenTime/txt")
	self._enterCellList = {}

	for i = 1, 4 do
		local cell = {}

		cell.go = self:getGo("enterList/enterCell" .. i)
		cell.btnRule = goutil.findChild(cell.go, "btnRule")
		cell.txtBuffDesc = goutil.findChildTextComponent(cell.go, "buff/txtDesc")
		cell.txtCurDamage = goutil.findChildTextComponent(cell.go, "curDamage/txt")
		self._enterCellList[i] = cell
	end

	self._symlolList = {}

	for i = 1, #self._enterCellList - 1 do
		local cell = {}

		cell.go = self:getGo("symlolList/cell" .. i)
		cell.stateList = {}

		for k = 1, 2 do
			local statecell = {}

			statecell.go = goutil.findChild(cell.go, "state" .. k)
			statecell.match = goutil.findChild(statecell.go, "match")
			statecell.notMatch = goutil.findChild(statecell.go, "notMatch")

			table.insert(cell.stateList, statecell)
		end

		cell.txtChange = goutil.findChildComponent(cell.go, "txtState", "UITextColorChange")
		cell.txtState = goutil.findChildTextComponent(cell.go, "txtState")
		self._symlolList[i] = cell
	end
end

function FinalEchoMainView:onExit()
	FinalEchoMainView.super.onExit(self)
	RedPointController.instance:unregRedPoint(self._rdJumpTask)
end

function FinalEchoMainView:onEnter()
	FinalEchoMainView.super.onEnter(self)

	self._activityId = checknumber(self:getFirstParam())

	if self._activityId <= 0 then
		self._activityId = 495001
	end

	if not ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._activityId) then
		local text = string.format("活动不在开启期限内( activityId = %d )", self._activityId)

		local function func()
			self:close()
		end

		TipsFacade.instance:openTipWindow("提示", text, func, "确定", UnityEngine.TextAnchor.MiddleCenter)

		return
	end

	self.addGEvent(self, GlobalNotify.FinalEchoGetInfo, self._updateUIByInfo, self)
	self.addGEvent(self, GlobalNotify.FinalEchoResetInfo, self._updateUIByInfo, self)
	self:_updateUIByCfg()
	FinalEchoController.instance:getInfo(self._activityId)
	RedPointController.instance:regRedPoint(self._rdJumpTask, 625)
end

function FinalEchoMainView:_updateUIByCfg()
	self._actCfg = FinalEchoConfig.instance:getActCfgById(self._activityId)
	self._bossCfgs = FinalEchoConfig.instance:getBossCfgsById(self._activityId)
	self._buffCfgs = FinalEchoConfig.instance:getBuffCfgsById(self._activityId)
	self._txtOpenTime.text = TimeGateController.instance:getActTimeShow(self._activityId)
end

function FinalEchoMainView:_updateUIByInfo()
	local info = FinalEchoModel.instance:getBaseInfo(self._activityId)

	self._isAllPass = false

	if info then
		local bossInfoMap = {}

		if not info.boss then
			local bossInfos = {}
			local maxKillOrder = 0

			for _, bossInfo in ipairs(bossInfos) do
				bossInfoMap[bossInfo.bossId] = bossInfo

				if maxKillOrder <= bossInfo.killOrder then
					maxKillOrder = bossInfo.killOrder
				end
			end

			self._isAllPass = #bossInfos >= #self._bossCfgs

			for bossId, cfg in ipairs(self._bossCfgs) do
				local cell = self._enterCellList[bossId]

				if cell then
					local bossInfo = bossInfoMap[bossId]

					if bossInfo then
						cell.txtCurDamage.text = checknumber(bossInfo.damage)
						cell.txtBuffDesc.text = self._buffCfgs[bossInfo.killOrder].buffDesc
					else
						cell.txtCurDamage.text = "未挑战"
						cell.txtBuffDesc.text = self._buffCfgs[maxKillOrder + 1].buffDesc
					end
				end
			end

			if not self._actCfg.formula then
				for i, str in ipairs(self._actCfg.formula) do
					local cell = self._symlolList[i]

					if cell then
						local beforeInfo = bossInfoMap[i]
						local afterInfo = bossInfoMap[i + 1]
						local stateId = 0
						local isExist = false
						local isMatch = false

						if beforeInfo and afterInfo then
							isExist = true
						end

						if str == GameEnum.GREATER_THAN then
							stateId = 1

							if isExist and checknumber(beforeInfo.damage) > checknumber(afterInfo.damage) then
								isMatch = true
							end
						elseif str == GameEnum.LESS_THAN then
							stateId = 2

							if isExist and checknumber(beforeInfo.damage) < checknumber(afterInfo.damage) then
								isMatch = true
							end
						else
							printError("未处理的公式:" .. str)
						end

						for k, statecell in ipairs(cell.stateList) do
							if stateId == k then
								goutil.setActive(statecell.go, true)
								goutil.setActive(statecell.match, isMatch)
								goutil.setActive(statecell.notMatch, not isMatch)
							else
								goutil.setActive(statecell.go, false)
							end
						end

						cell.txtState.text = isMatch and "已达成" or "未达成"

						cell.txtChange:SetState(isMatch and 0 or 1)
					end
				end
			end
		end
	end
end

function FinalEchoMainView:_onClickBtnTip()
	local key = self._actCfg.ruleKey

	TipsFacade.instance:openRulesView(key)
end

function FinalEchoMainView:_onClickBtnRank()
	UIStateManager.instance:push(ViewName.FinalEchoRankMainView, 3)
end

function FinalEchoMainView:_onClickBtnTask()
	UIStateManager.instance:push(ViewName.WishTreeBottleTaskFrameView, self._activityId)
end

function FinalEchoMainView:_onClickBtnReset()
	TipsFacade.instance:openPopupWindow("提示", "是否重置挑战?", function()
		FinalEchoController.instance:resetInfo(self._activityId)
	end)
end

function FinalEchoMainView:_enterFight(bossId)
	if self._isAllPass then
		TipsFacade.instance:openPopupWindow("提示", "需要重置全部关卡后，方可重新挑战", function()
			FinalEchoController.instance:resetInfo(self._activityId)
		end, nil, "重置")
	else
		FinalEchoController.instance:openMissionview(self._activityId, bossId)
	end
end

function FinalEchoMainView:_onClickBtnSubTips(bossId)
	local bossCfg = self._bossCfgs[bossId]

	if bossCfg then
		TipsFacade.instance:openTipWindowNoX("挑战规则", bossCfg.ruleDesc)
	end
end

return FinalEchoMainView
