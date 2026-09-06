-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/funarena/view/FunArenaHallView.lua

module("logic.extensions.funarena.view.FunArenaHallView", package.seeall)

local FunArenaHallView = class("FunArenaHallView", ViewComponent)

function FunArenaHallView:ctor()
	FunArenaHallView.super.ctor(self)
end

function FunArenaHallView:buildUI()
	FunArenaHallView.super.buildUI(self)

	self._leftTop = goutil.findChild(self.mainGO, "leftTop")
	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._btnTip = goutil.findChild(self.mainGO, "leftTop/btnTip")
	self._txtTitle = goutil.findChildTextComponent(self.mainGO, "leftTop/txtTitle")
	self._openTime = goutil.findChild(self.mainGO, "openTime")
	self._txtOpenTime = goutil.findChildTextComponent(self.mainGO, "openTime/txt")
	self._txtSession = goutil.findChildTextComponent(self.mainGO, "leftColumn/information/txtSession")
	self._empty = goutil.findChild(self.mainGO, "leftColumn/empty")
	self._btnEntryChallenge = goutil.findChild(self.mainGO, "btnEntryChallenge")
	self._buffScrollerGo = goutil.findChild(self.mainGO, "leftColumn/buffview")

	local cellGo = goutil.findChild(self.mainGO, "leftColumn/buffcell")
	local updateCell = GameUtil.handler(self._updateBuffCell, self)
	local clearCell = GameUtil.handler(self._clearBuffCell, self)

	self._buffScrollList = ScrollerList.create(self._buffScrollerGo, cellGo, updateCell, clearCell)
	self._playerScrollerGo = goutil.findChild(self.mainGO, "playerview")

	local cellGo = goutil.findChild(self.mainGO, "playercell")
	local updateCell = GameUtil.handler(self._updatePlayerCell, self)
	local clearCell = GameUtil.handler(self._clearPlayerCell, self)

	self._playerScrollList = ScrollerList.create(self._playerScrollerGo, cellGo, updateCell, clearCell)
end

function FunArenaHallView:bindEvents()
	FunArenaHallView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickBtnClose, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnEntryChallenge, self._onClickBtnEntryChallenge, self)
	GameUtil.addClickHandler(self._btnRankingList, self._onClickBtnRankingList, self)
	GameUtil.addClickHandler(self._btnLottery, self._onClickBtnLottery, self)
end

function FunArenaHallView:unbindEvents()
	FunArenaHallView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnEntryChallenge)
	GameUtil.rmClickHandler(self._btnRankingList)
	GameUtil.rmClickHandler(self._btnLottery)
end

function FunArenaHallView:onEnter()
	FunArenaHallView.super.onEnter(self)

	self._activityId = FunArenaModel.instance.activityId
	self._challengeCfg = FunArenaConfig.instance:getChallengeCfgById(self._activityId)
	self._buffCfgs = FunArenaConfig.instance:getBuffCfgs()

	if self._activityId == 0 or #self._challengeCfg == 0 then
		self:_onClickBtnClose()

		return
	end

	GlobalDispatcher:addListener(GlobalNotify.FunArenaGetInfo, self._onUpdateUI, self)
	self:_onUpdateUI()
end

function FunArenaHallView:onExit()
	FunArenaHallView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.FunArenaGetInfo, self._onUpdateUI, self)
	self._buffScrollList:dispose()
	self._playerScrollList:dispose()
end

function FunArenaHallView:_onUpdateUI()
	self:_onUpdatePlaneUI()
	self:_onUpdateBuffScroller()
	self:_onUpdatePlayerScroller()
end

function FunArenaHallView:_onUpdatePlaneUI()
	local funCfg = FuncOpenConfig.instance:getFunctionOpenById(442)
	local openTimeStr = funCfg.openTime
	local arr = string.split(openTimeStr, "#")
	local startTime, endTime = GameUtil.string2time(arr[1]), GameUtil.string2time(arr[2])
	local startDate, endDate = os.date("*t", startTime), os.date("*t", endTime)

	if self._txtOpenTime then
		self._txtOpenTime.text = langPara("FunArena_HallView_Tips_1", startDate.month, startDate.day, startDate.hour, startDate.min, endDate.month, endDate.day, endDate.hour, endDate.min)
	end

	if self._txtSession then
		local paramsCfg = FunArenaConfig.instance:getChallengeParamsCfgs("CANDIDATE_RANK")
		local session = paramsCfg.value

		self._txtSession.text = langPara("FunArena_HallView_Tips_2", "#FFF15FFF", session)
	end
end

function FunArenaHallView:_onClickBtnClose()
	self:close()
end

function FunArenaHallView:_onClickBtnTip()
	local key = "winnermatch"

	TipsFacade.instance:openRulesView(key)
end

function FunArenaHallView:_onClickBtnEntryChallenge()
	local fightRound = FunArenaModel.instance._infoRes.fightRound
	local fightTimes = FunArenaModel.instance._infoRes.fightTimes
	local canGainBuffIds = FunArenaModel.instance._infoRes.canGainBuffIds
	local isHasOutLimitFail = FunArenaController.instance:isHasOutLimitFail()

	if isHasOutLimitFail then
		FloatWordMgr.instance:show(lang("FunArena_HallView_Tips_3"))

		return
	end

	local isHasOutLimitChallenge = FunArenaController.instance:isHasOutLimitChallenge()

	if isHasOutLimitChallenge then
		FloatWordMgr.instance:show(langPara("FunArena_HallView_Tips_4", fightTimes))

		return
	end

	if fightRound == 0 or FunArenaModel.instance.hasServerForm == false then
		UIStateManager.instance:push(ViewName.FunArenaFormationView)
	elseif #canGainBuffIds ~= 0 then
		UIStateManager.instance:push(ViewName.FunArenaBuffView)
	else
		FunArenaController.instance:onSendFightReq(self._activityId)
	end
end

function FunArenaHallView:_onUpdateBuffScroller()
	local dataList = {}
	local propsBuffIds = {}
	local temp = FunArenaModel.instance._infoRes.propsBuffIds

	if temp then
		for i = 1, #temp do
			local id = temp[i]

			table.insert(propsBuffIds, id)
		end

		table.sort(propsBuffIds, function(a, b)
			return checknumber(a) < checknumber(b)
		end)
	end

	local funcBuffIds = {}
	local temp = FunArenaModel.instance._infoRes.funcBuffIds

	if temp then
		for i = 1, #temp do
			local id = temp[i]

			table.insert(funcBuffIds, id)
		end

		table.sort(funcBuffIds, function(a, b)
			return checknumber(a) < checknumber(b)
		end)
	end

	for _, buffId in ipairs(propsBuffIds) do
		local data = self._buffCfgs[buffId]

		if data then
			table.insert(dataList, data)
		end
	end

	for _, buffId in ipairs(funcBuffIds) do
		local data = self._buffCfgs[buffId]

		if data then
			table.insert(dataList, data)
		end
	end

	self._buffScrollList:reloadData(dataList)
	self._buffScrollList:refresh()

	local isEmpty = #dataList == 0

	GameUtil.SetActive(self._empty, isEmpty)
	GameUtil.SetActive(self._buffScrollerGo, not isEmpty)
end

function FunArenaHallView:_updateBuffCell(view, cellGo, data, tag)
	local _mainGo = cellGo
	local _chang = _mainGo:GetComponent(ComponentType.UIImageColorChange)
	local _item = goutil.findChild(_mainGo, "item")
	local _btn = goutil.findChild(_mainGo, "btn")
	local _txtTip = goutil.findChildTextComponent(_mainGo, "txtTip")
	local _tag = goutil.findChild(_mainGo, "tag")

	if _chang then
		self.parity = self.parity or 0
		self.parity = self.parity == 0 and 1 or 0

		_chang:SetState(self.parity)
	end

	if _txtTip then
		_txtTip.text = data.desc
	end

	local isNeedSetIcon = not string.nilorempty(data.buffRes) and _item

	if isNeedSetIcon then
		local spriteType = uGuiUtil.SpriteType.BigBg
		local spriteName = string.format("ui/icon/expevents/%s.png", data.buffRes)

		local function func()
			return
		end

		uGuiUtil.setSpriteToImage(_item, spriteType, spriteName, func)
	end

	GameUtil.SetActive(_tag, data.type == 2)
end

function FunArenaHallView:_clearBuffCell(cellGo)
	uGuiUtil.clearImage(goutil.findChild(cellGo, "item"))
end

function FunArenaHallView:_onClickBuff()
	return
end

function FunArenaHallView:_onUpdatePlayerScroller()
	local enemyList = FunArenaModel.instance._infoRes.enemyList
	local infoList = {}

	for i = 1, #enemyList do
		local info = {}

		info.data = enemyList[i]
		info.cfg = {
			index = i - 1
		}

		table.insert(infoList, info)
	end

	self._playerScrollList:reloadData(infoList)
	self._playerScrollList:refresh()

	if #infoList ~= 0 then
		local index = FunArenaModel.instance._infoRes.fightRound
		local maxIndex = self._playerScrollList:_numInView()

		index = math.min(index, maxIndex)

		self._playerScrollList:MoveCellToCenter(index)
	end
end

function FunArenaHallView:_updatePlayerCell(_, cellModel, info, tag)
	local data = info.data
	local cfg = info.cfg
	local cell = {}

	cell._mainGo = cellModel
	cell._con = goutil.findChild(cell._mainGo, "con")
	cell._select = goutil.findChild(cell._mainGo, "select")
	cell._result = goutil.findChild(cell._mainGo, "result")
	cell._resultUIChange = cell._result and cell._result:GetComponent(ComponentType.UIImageSpriteChange)
	cell._txtResult = goutil.findChildTextComponent(cell._mainGo, "result/txt")
	cell._txtResultColorUIChange = goutil.findChild(cell._mainGo, "result/txt"):GetComponent(ComponentType.UITextColorChange)
	cell._txtName = goutil.findChildTextComponent(cell._mainGo, "info/txtName")
	cell._txtPower = goutil.findChildTextComponent(cell._mainGo, "info/txtPower")
	cell._txtArea = goutil.findChildTextComponent(cell._mainGo, "info/rank/txtArea")
	cell._txtRank = goutil.findChildTextComponent(cell._mainGo, "info/rank/txtRanking")

	local isNeedSetCon = cell._con ~= nil

	if isNeedSetCon then
		local spriteType = uGuiUtil.SpriteType.BigBg
		local genderStr = ""

		genderStr = data.gender == 0 and "nv" or "nan"

		local index = 1 + data.userId % 4
		local resName = string.format("yyjjc_role_%s_%s", genderStr, index)
		local spriteName = string.format("ui/bigbg/funarena/%s.png", resName)

		local function func()
			return
		end

		uGuiUtil.setSpriteToImage(cell._con, spriteType, spriteName, func)
	end

	if cell._txtResult then
		local winState = FunArenaModel.instance._infoRes.winState
		local isWin = winState[cfg.index + 1]

		if isWin == true then
			cell._txtResult.text = lang("text_a_success")

			cell._resultUIChange:SetState(1)
			cell._txtResultColorUIChange:SetState(1)
		else
			cell._txtResult.text = lang("text_a_fail")

			cell._resultUIChange:SetState(0)
			cell._txtResultColorUIChange:SetState(0)
		end

		local fightRound = FunArenaModel.instance._infoRes.fightRound

		GameUtil.SetActive(cell._result, fightRound > cfg.index)
	end

	local fightRound = FunArenaModel.instance._infoRes.fightRound

	GameUtil.SetActive(cell._select, cfg.index == fightRound)

	if cell._txtArea then
		cell._txtArea.text = data.areaName
	end

	if cell._txtRank then
		cell._txtRank.text = data.rank
	end

	if cell._txtName then
		cell._txtName.text = data.userName
	end

	if cell._txtPower then
		cell._txtPower.text = data.totalZdl
	end

	local handler = GameUtil.handler(self._onClickPlayer, self, cell)
end

function FunArenaHallView:_clearPlayerCell(cellGo)
	uGuiUtil.clearImage(goutil.findChild(cellGo, "con"))
end

function FunArenaHallView:_onClickPlayer(cell)
	return
end

return FunArenaHallView
