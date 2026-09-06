-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/honourtower/view/HonourTowerSelectView.lua

module("logic.extensions.honourtower.view.HonourTowerSelectView", package.seeall)

local HonourTowerSelectView = class("HonourTowerSelectView", ViewComponent)

function HonourTowerSelectView:ctor()
	HonourTowerSelectView.super.ctor(self)
end

function HonourTowerSelectView:unbindEvents()
	HonourTowerSelectView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnSure:RemoveClickListener()
	self._btnTip:RemoveClickListener()
	self._btnRank:RemoveClickListener()
end

function HonourTowerSelectView:bindEvents()
	HonourTowerSelectView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
	self._btnSure:AddClickListener(self._sureOnClick, self)
	self._btnTip:AddClickListener(self._tipOnClick, self)
	self._btnRank:AddClickListener(self._gotoRankOnClick, self)
end

function HonourTowerSelectView:onExit()
	HonourTowerSelectView.super.onExit(self)
	self._foreverscrollerList:dispose()
	uGuiUtil.clearImage(self._petIcon)
	removetimer(self._tickTxt, self)

	self._txtTickList = {}
end

function HonourTowerSelectView:buildUI()
	HonourTowerSelectView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnSure = self:getBtn("pet/btnSure")
	self._btnTip = self:getBtn("txtTitle/btnTip")
	self._txtLevel = self:getTxt("pet/level/txtLevel")
	self._txtTime = self:getTxt("pet/time/txtTime")
	self._petIcon = self:getGo("pet/petCard/petIcon")
	self._btnRank = self:getBtn("btnRank")

	goutil.setActive(self._btnRank.gameObject, false)

	self._petEmptyGo = self:getGo("pet/empty")
	self._petEmptyList = {
		self:getGo("pet/time"),
		self:getGo("pet/btnSure"),
		self:getGo("pet/level"),
		self:getGo("pet/petCard")
	}
	self._forevertableviewGo = self:getGo("forevertableview")
	self._tabCell = self:getGo("cell")
	self._foreverscrollerList = ScrollerList.create(self._forevertableviewGo, self._tabCell, GameUtil.handler(self._updateTabCell, self), GameUtil.handler(self._clearTabCell, self))
	self._emptyGo = self:getGo("empty")
end

function HonourTowerSelectView:onEnter()
	HonourTowerSelectView.super.onEnter(self)
	self.addGEvent(self, HonorTowerAgent.HonorTowerInfoRes, self._refreshView, self)
	self.addGEvent(self, HonorTowerAgent.HonorTowerSelectRecallChallengeRes, self._refreshView, self)

	self._txtTickList = {}
	self._periodId = HonourTowerModel.instance:getPeriodId()

	if self._periodId == 0 then
		FloatWordMgr.instance:show("不在活动时间")
		self:close()

		return
	end

	self._selectId = 0

	RedPointController.instance:saveUserDayRedPoint(RedPointModel.ID_HONOUR_TOWER)
	HonorTowerAgent.instance:sendPM_HonorTowerInfoReq(self._periodId)
	settimer(1, self._tickTxt, self, true)
end

function HonourTowerSelectView:_refreshView()
	local list = {}
	local info = HonourTowerModel.instance:getChallengeInfos()
	local foreverList = {}

	for k, v in pairs(info) do
		local stageLengh = HonourTowerConfig.instance:getStageCfgLenghByChallengeId(v.challengeId)
		local cfg = HonourTowerConfig.instance:getChallengeCfg(v.challengeId)
		local isNotOpen = GameUtil.getTimePeriod(nil, cfg.startTime) == GameUtil.inTimePeriod
		local data = {
			state = 0,
			isEmpty = false,
			isPass = false,
			cfg = cfg,
			challengeId = v.challengeId,
			isNotOpen = isNotOpen
		}
		local state = 0
		local info = HonourTowerModel.instance:getChallengeInfo(v.challengeId)

		if isNotOpen or not info then
			state = 3
		else
			local isPass = HonourTowerController.instance:isChallengePass(v.challengeId)

			data.isPass = isPass
			state = isPass and 2 or 1
		end

		data.state = state

		if not isNotOpen then
			if cfg.isForever then
				table.insert(foreverList, data)
			else
				table.insert(list, data)
			end
		end
	end

	table.sort(list, function(a, b)
		if a.state == b.state then
			return a.challengeId < b.challengeId
		end

		return a.state < b.state
	end)
	table.sort(foreverList, function(a, b)
		if a.state == b.state then
			return a.challengeId < b.challengeId
		end

		return a.state < b.state
	end)
	self:_addExtCell(list)

	local isNotData = false

	if #list == 1 then
		isNotData = list[1].isEmpty
	end

	goutil.setActive(self._petEmptyGo, isNotData)

	for k, v in pairs(self._petEmptyList) do
		goutil.setActive(v, not isNotData)
	end

	self._foreverscrollerList:reloadData(foreverList)
	goutil.setActive(self._emptyGo, not list or #list <= 0)
end

function HonourTowerSelectView:_addExtCell(list)
	local ids = HonourTowerConfig.instance:getRegressChallengeIds(self._periodId)

	if #ids <= 0 then
		return
	end

	local challengeIds = HonourTowerModel.instance:getRegressChallengeIds()
	local challengeNum = HonourTowerConfig.instance:getRecallChallengeNum(self._periodId)

	if challengeNum <= #challengeIds then
		return
	end

	local data = {
		challengeId = 0,
		isEmpty = true,
		state = 4
	}

	table.insert(list, data)
end

function HonourTowerSelectView:_updateEmptyTabCell(cell, data)
	local btnAdd = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btnAdd")
	local redpointGo = goutil.findChild(cell, "redpoint")
	local red = HonourTowerController.instance:getRedpoint(nil, nil, true)

	goutil.setActive(redpointGo, red)
	btnAdd:AddClickListener(function()
		UIStateManager.instance:push(ViewName.HonourtowerregressView)

		if red then
			HonourTowerController.instance:onClickRegressCell(self._periodId)
		end
	end)
end

function HonourTowerSelectView:_updateTabCell(view, cell, data)
	if data.isEmpty then
		self:_updateEmptyTabCell(cell, data)

		return
	end

	local cfg = data.cfg
	local pet = goutil.findChild(cell, "pet")
	local selectGo = goutil.findChild(cell, "select")
	local bg = goutil.findChild(cell, "bg")
	local txtTitle = goutil.findChildTextComponent(cell, "txtTitle")
	local txtDesc = goutil.findChildTextComponent(cell, "txtDesc")
	local txtMode = goutil.findChildTextComponent(cell, "txtMode")
	local colorDesc = goutil.findChild(cell, "txtDesc"):GetComponent("UITextColorChange")
	local redpointGo = goutil.findChild(cell, "redpoint")
	local red = HonourTowerController.instance:getRedpoint(cfg.periodId, cfg.challengeId, false)

	goutil.setActive(redpointGo, red)

	local isNotOpen = data.isNotOpen
	local modelName = "挑战模式"
	local stageState = ""
	local title = cfg.name
	local skinId = cfg.skinId

	self:_releaseTickTxt(txtDesc)

	if data.isPass then
		stageState = "已通关"

		colorDesc:SetState(1)
	else
		local info = HonourTowerModel.instance:getChallengeInfo(cfg.challengeId)
		local stageCfgs = HonourTowerConfig.instance:getStageCfgs(cfg.challengeId)

		stageState = string.format("%s/%s", info.curStageId, #stageCfgs)

		colorDesc:SetState(0)
	end

	txtTitle.text = title
	txtMode.text = modelName
	txtDesc.text = stageState

	MaterialMgr.resetAll(pet)
	MaterialMgr.setIcon(pet, MatType.PET_SKIN, skinId)
	GameUtil.rmClickHandler(bg)
	GameUtil.addClickHandler(bg, function()
		self:_setPetUi(data, isNotOpen, red)
		self._foreverscrollerList:refresh()
	end)

	if self._selectId == 0 then
		self:_setPetUi(data, isNotOpen, red)
		self._foreverscrollerList:refresh()
	end

	goutil.setActive(selectGo, self._selectId == data.challengeId)
end

function HonourTowerSelectView:_clearTabCell(cell)
	local pet = goutil.findChild(cell, "pet")
	local bg = goutil.findChild(cell, "bg")

	MaterialMgr.resetAll(pet)
	GameUtil.rmClickHandler(bg)
end

function HonourTowerSelectView:_setPetUi(data, isNotOpen, isRed)
	self._data = data
	self._selectId = data.challengeId
	self._isNotOpen = isNotOpen

	local cfg = data.cfg
	local time = ""
	local endTime = self:_getEndTime(cfg.challengeId)

	if endTime > ServerTime.now() then
		local day, hour, min, sec = GameUtil.getTimeDDHHMMSS(endTime - ServerTime.now())

		time = string.format("剩余时间:%d天%d小时", day, hour)
	else
		time = "已过期"
	end

	local level = data.cfg.name
	local skinId = cfg.skinId
	local modelCo = CharacterConfig.instance:getModelCo(checknumber(skinId))

	if not modelCo then
		printError("lbc---- HonourTowerView:_updateTabCell()   精灵图片为空 skinId = ", skinId)

		return
	end

	uGuiUtil.setSpriteToImage(self._petIcon, uGuiUtil.SpriteType.BigBg, GameUrl.getPetImgUrl(modelCo.cardName))

	if isRed then
		HonourTowerController.instance:onClickTabCell(cfg.periodId, cfg.challengeId)
	end

	self._txtLevel.text = level
	self._txtTime.text = time

	local challengeIds = HonourTowerModel.instance:getRegressChallengeIds()
	local regressIdx = table.indexof(challengeIds, data.challengeId) or 0

	goutil.setActive(self._btnRank.gameObject, false)
end

function HonourTowerSelectView:_sureOnClick()
	if self._isNotOpen then
		FloatWordMgr.instance:show("未到开放时间")

		return
	end

	UIStateManager.instance:push(ViewName.HonourTowerView, self._data.challengeId)
end

function HonourTowerSelectView:_tipOnClick()
	UIStateManager.instance:push(ViewName.RulesView, "honourtowerview_1")
end

function HonourTowerSelectView:_addTickTxt(txtDesc, openTime)
	self._txtTickList[txtDesc] = openTime
end

function HonourTowerSelectView:_releaseTickTxt(txtDesc)
	self._txtTickList[txtDesc] = nil
end

function HonourTowerSelectView:_tickTxt()
	local day, hour, min, sec
	local nowTime = ServerTime.now()

	for txtDesc, openTime in pairs(self._txtTickList) do
		if openTime < nowTime then
			self:_refreshView()

			return
		end

		txtDesc.text = self:_getDesc(openTime)
	end
end

function HonourTowerSelectView:_getDesc(openTime)
	local leftTime = openTime - ServerTime.now()
	local day, hour, min, sec = GameUtil.getTimeDDHHMMSS(leftTime)

	return day > 0 and string.format("%s天后开放", day) or string.format("%02d:%02d:%02d后开放", hour, min, sec)
end

function HonourTowerSelectView:_getEndTime(challengeId)
	local regressIds = HonourTowerModel.instance:getRegressChallengeIds()

	if table.indexof(regressIds, challengeId) then
		local cfg = HonourTowerConfig.instance:getPeriodCfgById(self._periodId)

		return GameUtil.string2time(cfg.endTime)
	else
		local cfg = HonourTowerConfig.instance:getChallengeCfg(challengeId)

		return GameUtil.string2time(cfg.endTime)
	end
end

function HonourTowerSelectView:_gotoRankOnClick()
	FuncOpenController.instance:openFunc(34, GameEnum.RankType.GloryTowerRank, 1)
end

return HonourTowerSelectView
