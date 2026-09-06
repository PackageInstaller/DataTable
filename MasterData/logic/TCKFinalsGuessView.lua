-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/teenchampionking/view/TCKFinalsGuessView.lua

module("logic.extensions.teenchampionking.view.TCKFinalsGuessView", package.seeall)

local TCKFinalsGuessView = class("TCKFinalsGuessView", ViewComponent)

function TCKFinalsGuessView:ctor()
	TCKFinalsGuessView.super.ctor(self)
end

function TCKFinalsGuessView:unbindEvents()
	TCKFinalsGuessView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSure)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnAdd)
	GameUtil.rmClickHandler(self._btnMinus)
	GameUtil.rmClickHandler(self._btnMax)
	GameUtil.rmClickHandler(self._btnMin)
	GameUtil.rmClickHandler(self._btnBubble)
	GameUtil.rmClickHandler(self._btnHideBubble)
	self._input:RemoveOnValueChanged()

	for i, cell in ipairs(self._infoCellList) do
		GameUtil.rmClickHandler(cell.btn)
	end
end

function TCKFinalsGuessView:bindEvents()
	TCKFinalsGuessView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSure, self._onClickbtnSure, self)
	GameUtil.addClickHandler(self._btnClose, self._onClickbtnClose, self)
	GameUtil.addClickHandler(self._btnAdd, self._onClickbtnAdd, self)
	GameUtil.addClickHandler(self._btnMinus, self._onClickbtnMinus, self)
	GameUtil.addClickHandler(self._btnMax, self._onClickbtnMax, self)
	GameUtil.addClickHandler(self._btnMin, self._onClickbtnMin, self)
	GameUtil.addClickHandler(self._btnBubble, self._onClickbtnBubble, self)
	GameUtil.addClickHandler(self._btnHideBubble, self._onClickbtnHideBubble, self)
	self._input:AddOnValueChanged(self._buyCountChanged, self)

	for i, cell in ipairs(self._infoCellList) do
		GameUtil.addClickHandler(cell.btn, GameUtil.handler(self._onClickChange, self, i))
	end
end

function TCKFinalsGuessView:buildUI()
	TCKFinalsGuessView.super.buildUI(self)

	self._txtSupportLimit = self:getTxt("txtSupportLimit")
	self._txtNum = self:getTxt("bgNum/txtNum")
	self._btnSure = self:getGo("btnSure")
	self._btnClose = self:getGo("btnClose")
	self._btnAdd = self:getGo("bgNum/btnAdd")
	self._btnMinus = self:getGo("bgNum/btnMinus")
	self._btnMax = self:getGo("bgNum/btnMax")
	self._btnMin = self:getGo("bgNum/btnMin")
	self._input = self:getInput("bgNum")
	self._txtFinishGo = self:getGo("txtFinish")
	self._txtFinish = self:getTxt("txtFinish/txtFinish")
	self._txtTips = self:getTxt("txtTips")
	self._bgNumGo = self:getGo("bgNum")
	self._infoCellList = {}

	for i = 1, 8 do
		local cell = {}

		cell.go = self:getGo("infos/info_" .. i)
		cell.playerinfo = goutil.findChild(cell.go, "playerinfo")
		cell.icon = goutil.findChild(cell.go, "playerinfo/icon")
		cell.txtName = goutil.findChildTextComponent(cell.go, "playerinfo/name/txt")
		cell.empty = goutil.findChild(cell.go, "empty")
		cell.btn = goutil.findChild(cell.go, "btn")
		cell.txtRank = goutil.findChildTextComponent(cell.go, "rank/txtRank")
		cell.info = nil

		table.insert(self._infoCellList, cell)
	end

	self._btnBubble = self:getGo("btnBubble")
	self._btnHideBubble = self:getGo("btnHideBubble")
end

function TCKFinalsGuessView:onExit()
	TCKFinalsGuessView.super.onExit(self)

	for i, cell in ipairs(self._infoCellList) do
		HeadItemController.instance:resetHeadCell(cell.icon)
	end
end

function TCKFinalsGuessView:onEnter()
	TCKFinalsGuessView.super.onEnter(self)

	local params = self:getOpenParam()

	self._activityId = params and params[1]

	if params then
		self._playerInfos = params[2] or {}
	end

	self.addGEvent(self, GlobalNotify.PM_TCKChangeChampionshipGuess, self._updateUIByInfo, self)
	self.addGEvent(self, GlobalNotify.PM_TCKChangeChampionshipGuess, self._updateUIByInfo, self)
	self.addGEvent(self, GlobalNotify.PM_TCKGetChampionshipGuessRecord, self._updateUIByInfo, self)
	self.addGEvent(self, GlobalNotify.PM_TCKStepChange, self._updateUIByInfo, self)
	self:_updateUIByCfg()
	TeenChampionKingController.instance:getChampionshipGuessRecord(self._activityId)
	self:_updateUIByInfo()
	goutil.setActive(self._btnHideBubble, false)
end

function TCKFinalsGuessView:_updateUIByCfg()
	self._actCfg = TeenChampionKingConfig.instance:getActCfg(self._activityId)
	self._limitMax = self._actCfg.maxGuessScore
	self._maxOneTime = self._actCfg.maxGuessScore
	self._hasCount = MaterialMgr.getMatCount(self._actCfg.guessItem)
end

function TCKFinalsGuessView:_updateUIByInfo()
	local info = TeenChampionKingModel.instance:getGlobalInfo(self._activityId)
	local curStepCfg = TeenChampionKingConfig.instance:getStepCfgByStepId(self._activityId, (info or nil) and info.curStepId)

	self._isShowBtn = false
	self._isShowBtn = curStepCfg and curStepCfg.canGuss
	self._txtFinish.text = self._isShowBtn and "已达本轮上限" or "当前不能应援"
	self._roundGuessCount = 0

	local recordInfo = TeenChampionKingModel.instance:getChampionshipGuessRecordInfo(self._activityId)

	self._guessPlayerIds = {}

	if recordInfo then
		self._guessPlayerIds = recordInfo.guessRankPlayerIds or {}
		self._roundGuessCount = recordInfo.championshipGuessCount or 0
	end

	self._maxCount = math.min(self._limitMax - self._roundGuessCount, self._maxOneTime)
	self._minCount = 1
	self._supportCount = self._minCount

	self:_refreshBuyCount()

	self._rankInfoMap = {}

	for i, cell in ipairs(self._infoCellList) do
		local playerId = checknumber(self._guessPlayerIds[i])

		cell.info = nil

		for _, playerInfo in ipairs(self._playerInfos) do
			local checkPlayerId = checknumber(playerInfo.headInfo.headInfo.userId)

			if checkPlayerId == playerId then
				cell.info = playerInfo
				self._rankInfoMap[playerId] = i

				break
			end
		end

		cell.txtRank.text = i

		if cell.info then
			goutil.setActive(cell.empty, false)
			goutil.setActive(cell.playerinfo, true)
			HeadItemController.instance:resetHeadCell(cell.icon)
			HeadItemController.instance:setHeadCellByInfo(cell.icon, cell.info.headInfo.headInfo)

			cell.txtName.text = cell.info.headInfo.headInfo.userName
		else
			goutil.setActive(cell.empty, true)
			goutil.setActive(cell.playerinfo, false)
		end

		goutil.setActive(cell.btn, self._isShowBtn)
	end
end

function TCKFinalsGuessView:_checkEmptyList()
	self._guessPlayerIds = self._guessPlayerIds or {}

	for i, playerId in ipairs(self._guessPlayerIds) do
		if checknumber(playerId) > 0 then
			return false
		end
	end

	return true
end

function TCKFinalsGuessView:_onClickbtnClose()
	self:close()
end

function TCKFinalsGuessView:_onClickbtnSure()
	if not self._isShowBtn then
		self:close()

		return
	end

	if self._roundGuessCount >= self._limitMax then
		self:close()

		return
	end

	if self:_checkEmptyList() then
		FloatWordMgr.instance:show("请选择应援对象")

		return
	end

	local text = string.format("是否消耗%s应援棒进行应援?", self._supportCount)

	TipsFacade.instance:openPopupWindow("提示", text, function()
		TeenChampionKingController.instance:guessChampionship(self._activityId, self._supportCount)
		self:close()
	end)
end

function TCKFinalsGuessView:_onClickbtnAdd()
	self._supportCount = self._supportCount + 1

	self:_refreshBuyCount()
end

function TCKFinalsGuessView:_onClickbtnMinus()
	self._supportCount = self._supportCount - 1

	self:_refreshBuyCount()
end

function TCKFinalsGuessView:_onClickbtnMax()
	self._supportCount = math.min(self._maxCount, self._hasCount)

	self:_refreshBuyCount()
end

function TCKFinalsGuessView:_onClickbtnMin()
	self._supportCount = self._minCount

	self:_refreshBuyCount()
end

function TCKFinalsGuessView:_refreshBuyCount()
	if self._isShowBtn then
		goutil.setActive(self._bgNumGo, self._roundGuessCount < self._limitMax)
		goutil.setActive(self._txtFinishGo, self._roundGuessCount >= self._limitMax)
	else
		goutil.setActive(self._bgNumGo, false)
		goutil.setActive(self._txtFinishGo, true)
	end

	local str = tostring(self._supportCount)

	self._input:SetText(str)

	local curCount = self._roundGuessCount + self._supportCount

	curCount = math.min(curCount, self._limitMax)
	self._txtSupportLimit.text = string.format("%s/%s", curCount, self._limitMax)
end

function TCKFinalsGuessView:_buyCountChanged()
	self._supportCount = checknumber(self._input:GetText())

	local maxCount = math.min(self._maxCount, self._hasCount)

	self._supportCount = math.min(self._supportCount, maxCount)
	self._supportCount = math.max(self._supportCount, self._minCount)

	self:_refreshBuyCount()
end

function TCKFinalsGuessView:_onClickChange(id)
	UIStateManager.instance:open(ViewName.TCKFinalsSelectView, self._activityId, self._playerInfos, self._rankInfoMap, id)
end

function TCKFinalsGuessView:_onClickbtnBubble()
	goutil.setActive(self._btnHideBubble, true)
end

function TCKFinalsGuessView:_onClickbtnHideBubble()
	goutil.setActive(self._btnHideBubble, false)
end

return TCKFinalsGuessView
