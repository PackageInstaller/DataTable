-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/ReturnChallengeView.lua

module("logic.extensions.timelimitedchallenge.view.ReturnChallengeView", package.seeall)

local ReturnChallengeView = class("ReturnChallengeView", ViewComponent)

function ReturnChallengeView:unbindEvents()
	ReturnChallengeView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnRule:RemoveClickListener()
end

function ReturnChallengeView:bindEvents()
	ReturnChallengeView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
	self._btnRule:AddClickListener(self._onClickBtnRule, self)
end

function ReturnChallengeView:onExit()
	ReturnChallengeView.super.onExit(self)
	self._tableView:dispose()

	for _, eff in pairs(self._effs) do
		if eff then
			UIEffectManager.instance:stopEffect(eff)
		end
	end

	self._effs = {}

	removetimer(self._updatePerSec, self)
	ClockMgr.instance:removeListener(ClockMgr.TickDailyRefresh, self._updateView, self)
end

function ReturnChallengeView:buildUI()
	ReturnChallengeView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnRule = self:getBtn("btnRule")
	self._goCell = self:getGo("cell")
	self._goTable = self:getGo("tableview")
	self._tableView = ScrollerList.create(self._goTable, self._goCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._txtTime = self:getTxt("time/txtTime")
end

function ReturnChallengeView:onEnter()
	ReturnChallengeView.super.onEnter(self)

	self._funcId = 357

	settimer(1, self._updatePerSec, self)

	self._effs = {}

	self:_initDataList()
	self:_updateView()
	ClockMgr.instance:addListener(ClockMgr.TickDailyRefresh, self._updateView, self)
end

function ReturnChallengeView:_initDataList()
	self._curCfgDataList = TimeLimitedConfig.instance:getReturnConfigs()
end

function ReturnChallengeView:_updateView()
	local nowTime = ServerTime.now()

	self._curDataList = {}

	local endDataList = {}

	for _, v in ipairs(self._curCfgDataList) do
		v._isOpen = FuncOpenModel.instance:getFuncIsOpen(v.openFuncId)

		local funcCfg = FuncOpenConfig.instance:getFunctionOpenById(checknumber(v.openFuncId))

		if GameUtil.isEmptyString(funcCfg.openTime) then
			printError(v.openFuncId .. "功能开启没有填开放时间段")

			return
		end

		local times = string.split(funcCfg.openTime, "#")

		v._startTime = GameUtil.string2time(times[1])
		v._endTime = GameUtil.string2time(times[2])

		if nowTime <= v._endTime then
			table.insert(self._curDataList, v)
		else
			table.insert(endDataList, v)
		end
	end

	table.insertto(self._curDataList, endDataList)
	self._tableView:reloadData(self._curDataList)

	local temIndex = 0

	for _, v in pairs(self._curDataList) do
		if v._isOpen then
			return self._tableView:MoveCellInView(temIndex)
		end

		temIndex = temIndex + 1
	end

	self._tableView:MoveCellInView(0)
end

function ReturnChallengeView:_updateCell(view, goCell, data)
	local cell = self:_clearCell(goCell)
	local modelCo = CharacterConfig.instance:getModelCo(checknumber(data.raceId))
	local petCo = CharacterConfig.instance:getPetCo(checknumber(data.raceId))

	uGuiUtil.setSpriteToImage(cell.con.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getPetImgUrl(modelCo.cardName))

	cell.txtname.text = petCo.name

	if data._isOpen then
		local redPointIds = TimeLimitedConfig.instance:getRedPointIds(data.challengeId)

		RedPointController.instance:regRedPoint(cell.redPoint, unpack(redPointIds))
	else
		goutil.setActive(cell.redPoint, false)
	end

	GameUtil.addClickHandler(cell.go, GameUtil.handler(self._onClickStartChallenge, self, data))

	local nowTime = ServerTime.now()

	if data._isOpen then
		GameUtil.SetGray(cell.tag, false)

		cell.txtTag.text = lang("开启中")

		cell.change:SetState(1)
	else
		cell.change:SetState(0)

		if nowTime <= data._endTime then
			GameUtil.SetGray(cell.tag, false)

			cell.txtTag.text = lang("未开启")
		else
			GameUtil.SetGray(cell.tag, true)

			cell.txtTag.text = lang("已结束")
		end
	end

	cell.txtTime.text = langPara("开启时间\n%s-%s", GameUtil.formatTimeStamp("%m/%d 05:00", data._startTime), GameUtil.formatTimeStamp("%m/%d 05:00", data._endTime))

	if GameUtil.isEmptyString(data.petDesc) then
		goutil.setActive(cell.desc, false)
	else
		goutil.setActive(cell.desc, true)

		cell.txtDesc.text = data.petDesc
	end
end

function ReturnChallengeView:_clearCell(goCell)
	local cell = {}

	cell.go = goCell
	cell.con = goutil.findChild(cell.go, "con")
	cell.txtname = goutil.findChildTextComponent(cell.go, "name/txtName")
	cell.txtTime = goutil.findChildTextComponent(cell.go, "txtTime")
	cell.redPoint = goutil.findChild(cell.go, "redPoint")
	cell.effPos = goutil.findChild(cell.go, "effPos")
	cell.tag = goutil.findChild(cell.go, "tag")
	cell.change = goutil.findChild(cell.tag, "img"):GetComponent("UIImageSpriteChange")
	cell.txtTag = goutil.findChildTextComponent(cell.tag, "txt")
	cell.desc = goutil.findChild(cell.go, "desc")
	cell.txtDesc = goutil.findChildTextComponent(cell.desc, "txtDesc")

	uGuiUtil.clearImage(cell.con)

	local eff = self._effs[cell.effPos]

	if eff then
		UIEffectManager.instance:stopEffect(eff)

		self._effs[cell.effPos] = nil
	end

	GameUtil.rmClickHandler(cell.go)
	RedPointController.instance:unregRedPoint(cell.redPoint)

	return cell
end

function ReturnChallengeView:_onClickStartChallenge(data)
	local cfg = FuncOpenConfig.instance:getFunctionOpenById(checknumber(data.openFuncId))
	local isOpen = FuncOpenModel.instance:getFuncIsOpen(cfg.funcId)

	if isOpen then
		UIStateManager.instance:push(cfg.view)
		SurveyController.instance:reportBehavior(200488, data.challengeId)
	else
		FloatWordMgr.instance:show(cfg.lockedTips)
	end
end

function ReturnChallengeView:_updatePerSec()
	local isOpen = FuncOpenModel.instance:getFuncIsOpen(self._funcId)

	if not isOpen then
		TipsFacade.instance:openCommonTips(lang("当前活动已经结束"))
		self:close()
	end

	local cfg = FuncOpenConfig.instance:getFunctionOpenById(checknumber(self._funcId))
	local times = string.split(cfg.openTime, "#")
	local timeEnd = GameUtil.string2time(times[2])
	local left = timeEnd - ServerTime.now()

	if left > 0 then
		self._txtTime.text = langPara("剩余：%s", GameUtil.FormatTimeSymbol(left))
	else
		TipsFacade.instance:openCommonTips(lang("当前活动已经结束"))
		self:close()
	end
end

function ReturnChallengeView:_onClickBtnRule()
	ViewMgr.instance:open(ViewName.RulesView, "returnchallengeview")
end

return ReturnChallengeView
