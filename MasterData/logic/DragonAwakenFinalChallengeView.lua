-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonawaken/view/DragonAwakenFinalChallengeView.lua

module("logic.extensions.dragonawaken.view.DragonAwakenFinalChallengeView", package.seeall)

local DragonAwakenFinalChallengeView = class("DragonAwakenFinalChallengeView", ViewComponent)

function DragonAwakenFinalChallengeView:ctor()
	DragonAwakenFinalChallengeView.super.ctor(self)
end

function DragonAwakenFinalChallengeView:unbindEvents()
	DragonAwakenFinalChallengeView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnRank)
	GameUtil.rmClickHandler(self._btnChallenge)
	GameUtil.rmClickHandler(self._btnReturn)
end

function DragonAwakenFinalChallengeView:bindEvents()
	DragonAwakenFinalChallengeView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnRank, self._onClickBtnRank, self)
	GameUtil.addClickHandler(self._btnChallenge, self._onClickBtnChallenge, self)
	GameUtil.addClickHandler(self._btnReturn, self._onClickBtnReturn, self)
end

function DragonAwakenFinalChallengeView:buildUI()
	DragonAwakenFinalChallengeView.super.buildUI(self)

	self._txtTitle = self:getTxt("txtTitle")
	self._btnClose = self:getGo("btnClose")
	self._btnRank = self:getGo("Bottom/btnRank")
	self._btnChallenge = self:getGo("Bottom/btnChallenge")
	self._btnReturn = self:getGo("Bottom/btnReturn")

	local tableviewGo = self:getGo("Middle/tableview")
	local cellGo = self:getGo("Middle/cell")

	self._tableview = ScrollerList.create(tableviewGo, cellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._scrollrect = tableviewGo:GetComponent("ScrollRect")
	self._goldBar = self:getGo("goldBar")
	self._info = self:getGo("info")
	self._iconInfo = self:getGo("info/petHead/icon")
	self._txtInfo = self:getTxt("info/txt")
	self._txtTipsInfo = self:getTxt("info/txtTips")
end

function DragonAwakenFinalChallengeView:onExit()
	DragonAwakenFinalChallengeView.super.onExit(self)
	self._tableview:dispose()
	MaterialMgr.resetAll(self._iconInfo)
end

function DragonAwakenFinalChallengeView:onEnter()
	DragonAwakenFinalChallengeView.super.onEnter(self)

	local params = self:getOpenParam()

	self._activityId = checknumber(params[1])
	self._enterPhaseId = checknumber(params[2])

	self:_updateByCfg()
	self:_updateByInfo()

	if DragonAwakenController.instance:getIsNeedPupFmt() then
		DragonAwakenController.instance:openClgMissionView(self._activityId)
	end
end

function DragonAwakenFinalChallengeView:_updateByCfg()
	self._actCfg = DragonAwakenConfig.instance:getActivityCfg(self._activityId)
	self._phaseCfg = DragonAwakenConfig.instance:getPhaseCfgById(self._activityId, self._enterPhaseId)
	self._stageCfgs = DragonAwakenConfig.instance:getStageCfgs(self._phaseCfg.stagePlan)

	local btn_list = {
		{
			showAdd = false,
			id = self._actCfg.mainCost
		}
	}

	MainUIController.instance:showGlodBar(self._goldBar, self._viewPresentor, btn_list, false)

	local petCfg = DragonAwakenConfig.instance:getSupportCfgByPhaseId(self._activityId, self._enterPhaseId)

	if petCfg then
		local skinId = checknumber(petCfg.faceId)

		if skinId <= 0 then
			skinId = petCfg.raceId
		end

		MaterialMgr.setIcon(self._iconInfo, MatType.PET_SKIN, skinId)
	end

	self._txtInfo.text = self._phaseCfg.showDesc
	self._txtTipsInfo.text = self._phaseCfg and self._phaseCfg.curPowerStr
end

function DragonAwakenFinalChallengeView:_updateByInfo()
	local baseInfo = DragonAwakenModel.instance:getCurBaseInfo()

	self._curPhaseId = baseInfo.curPhaseId
	self._curStageId = baseInfo.curStageId

	self._tableview:reloadData(self._stageCfgs)
	self:_onClickBtnReturn()
	goutil.setActive(self._btnChallenge, self._curPhaseId == self._enterPhaseId)
end

function DragonAwakenFinalChallengeView:_updateCell(view, cell, data)
	local lockGo = goutil.findChild(cell.gameObject, "lock")
	local passGo = goutil.findChild(cell.gameObject, "pass")
	local txtName = goutil.findChildTextComponent(cell.gameObject, "level/txt")

	txtName.text = data.stageName

	goutil.setActive(lockGo, false)
	goutil.setActive(passGo, false)

	if self._curStageId > data.stageId then
		goutil.setActive(passGo, true)
	elseif self._curStageId < data.stageId then
		goutil.setActive(lockGo, true)
	end

	local tableviewGoPrize = goutil.findChild(cell.gameObject, "prizeCom/tableview")
	local cellGoPrize = goutil.findChild(cell.gameObject, "prizeCom/item")
	local dragPrize = Framework.UIDragTrigger.Get(tableviewGoPrize)

	dragPrize:RemoveDragListener()
	dragPrize:RemoveBeginDragListener()
	dragPrize:RemoveEndDragListener()
	dragPrize:AddDragListener(self._onDrag, self)
	dragPrize:AddBeginDragListener(self._onBeginDrag, self)
	dragPrize:AddEndDragListener(self._onEndDrag, self)

	local tableviewPrize = ScrollerList.create(tableviewGoPrize, cellGoPrize, GameUtil.handler(self._updatePrizeCell, self), GameUtil.handler(self._clearPrizeCell, self))

	tableviewPrize:setCenterMode(true)
	tableviewPrize:reloadData(self:_getPrizeDatalist(data.prize, self._curStageId > data.stageId))

	local tableviewGoPet = goutil.findChild(cell.gameObject, "petCom/tableview")
	local cellGoPet = goutil.findChild(cell.gameObject, "petCom/item")
	local dragPet = Framework.UIDragTrigger.Get(tableviewGoPet)

	dragPet:RemoveDragListener()
	dragPet:RemoveBeginDragListener()
	dragPet:RemoveEndDragListener()
	dragPet:AddDragListener(self._onDrag, self)
	dragPet:AddBeginDragListener(self._onBeginDrag, self)
	dragPet:AddEndDragListener(self._onEndDrag, self)

	local tableviewPet = ScrollerList.create(tableviewGoPet, cellGoPet, GameUtil.handler(self._updatePetCell, self), GameUtil.handler(self._clearPetCell, self))
	local cfgs = DragonAwakenConfig.instance:getCreepCfgs(data.creepsMasterId)

	tableviewPet:setCenterMode(true)
	tableviewPet:reloadData(cfgs)
end

function DragonAwakenFinalChallengeView:_clearCell(cell)
	local tableviewGoPrize = goutil.findChild(cell.gameObject, "prizeCom/tableview")
	local cellGoPrize = goutil.findChild(cell.gameObject, "prizeCom/item")
	local dragPrize = Framework.UIDragTrigger.Get(tableviewGoPrize)

	dragPrize:RemoveDragListener()
	dragPrize:RemoveBeginDragListener()
	dragPrize:RemoveEndDragListener()

	local tableviewPrize = ScrollerList.create(tableviewGoPrize, cellGoPrize, GameUtil.handler(self._updatePrizeCell, self), GameUtil.handler(self._clearPrizeCell, self))

	tableviewPrize:dispose()

	local tableviewGoPet = goutil.findChild(cell.gameObject, "petCom/tableview")
	local cellGoPet = goutil.findChild(cell.gameObject, "petCom/item")
	local dragPet = Framework.UIDragTrigger.Get(tableviewGoPet)

	dragPet:RemoveDragListener()
	dragPet:RemoveBeginDragListener()
	dragPet:RemoveEndDragListener()

	local tableviewPet = ScrollerList.create(tableviewGoPet, cellGoPet, GameUtil.handler(self._updatePetCell, self), GameUtil.handler(self._clearPetCell, self))

	tableviewPet:dispose()
end

function DragonAwakenFinalChallengeView:_getPrizeDatalist(str, isPass)
	local strArr = MaterialMgr.changeItemStrArr(str)
	local dataList = {}

	for i, str in ipairs(strArr) do
		local data = {
			prizestr = str,
			isPass = isPass
		}

		table.insert(dataList, data)
	end

	return dataList
end

function DragonAwakenFinalChallengeView:_updatePrizeCell(view, cell, data)
	local icon = goutil.findChild(cell.gameObject, "icon")
	local gain = goutil.findChild(cell.gameObject, "gain")

	MaterialMgr.setCellByCfg(data.prizestr, icon)
	goutil.setActive(gain, data.isPass)
end

function DragonAwakenFinalChallengeView:_clearPrizeCell(cell)
	local icon = goutil.findChild(cell.gameObject, "icon")

	MaterialMgr.resetAll(icon)
end

function DragonAwakenFinalChallengeView:_updatePetCell(view, cell, data)
	local icon = goutil.findChild(cell.gameObject, "petHead/icon")

	MaterialMgr.resetAll(icon)

	local skinId = checknumber(data.faceId)

	if skinId <= 0 then
		skinId = data.raceId
	end

	MaterialMgr.setIcon(icon, MatType.PET_SKIN, skinId)
end

function DragonAwakenFinalChallengeView:_clearPetCell(cell)
	local icon = goutil.findChild(cell.gameObject, "petHead/icon")

	MaterialMgr.resetAll(icon)
end

function DragonAwakenFinalChallengeView:_onClickBtnRank()
	UIStateManager.instance:push(ViewName.DragonAwakenRankView, self._activityId)
end

function DragonAwakenFinalChallengeView:_onClickBtnChallenge()
	if self._curPhaseId > self._enterPhaseId then
		TipsFacade.instance:openCommonTips("已全通关")
	else
		DragonAwakenController.instance:openClgMissionView(self._activityId)
	end
end

function DragonAwakenFinalChallengeView:_onClickBtnReturn()
	local moveIndex = self._curStageId

	if self._curPhaseId > self._enterPhaseId then
		self._curStageId = #self._stageCfgs + 1
		moveIndex = #self._stageCfgs
	end

	self._tableview:MoveCellInView(moveIndex - 1)
end

function DragonAwakenFinalChallengeView:_onDrag(eventData)
	self._scrollrect:OnDrag(eventData)
end

function DragonAwakenFinalChallengeView:_onBeginDrag(eventData)
	self._scrollrect:OnBeginDrag(eventData)
end

function DragonAwakenFinalChallengeView:_onEndDrag(eventData)
	self._scrollrect:OnEndDrag(eventData)
end

return DragonAwakenFinalChallengeView
