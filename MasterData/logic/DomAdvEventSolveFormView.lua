-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/domainadventure/view/DomAdvEventSolveFormView.lua

module("logic.extensions.domainadventure.view.DomAdvEventSolveFormView", package.seeall)

local DomAdvEventSolveFormView = class("DomAdvEventSolveFormView", ViewComponent)

function DomAdvEventSolveFormView:ctor()
	DomAdvEventSolveFormView.super.ctor(self)
end

function DomAdvEventSolveFormView:buildUI()
	DomAdvEventSolveFormView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._btnTip = goutil.findChild(self.mainGO, "leftTop/btnTip")
	self._con = goutil.findChild(self.mainGO, "con")
	self._pointRare = goutil.findChild(self.mainGO, "petInfo/pointRare")
	self._btnSkill = goutil.findChild(self.mainGO, "petInfo/btnSkill")
	self._btnIntroduce = goutil.findChild(self.mainGO, "petInfo/btnIntroduce")
	self._txtPetNameInInfo = goutil.findChildTextComponent(self.mainGO, "petInfo/txtName")

	local prizeScrView = goutil.findChild(self.mainGO, "infoCol/prizeScrView")
	local prizeScrCell = goutil.findChild(self.mainGO, "infoCol/prizeScrCell")

	self._prizeScrollerList = ScrollerList.create(prizeScrView, prizeScrCell, GameUtil.handler(self._updatePrizeCell, self), GameUtil.handler(self._clearPrizeCell, self))
	self._btnClg = goutil.findChild(self.mainGO, "btnClg/btn")
	self._slider = self:getSlider("slider")
	self._txtSlider = goutil.findChildTextComponent(self.mainGO, "slider/txtSlider")
	self._btnRank = goutil.findChild(self.mainGO, "btnRank")
	self._btnPort = goutil.findChild(self.mainGO, "btnPort")
	self._redBtnPort = goutil.findChild(self.mainGO, "btnPort/redPoint")
end

function DomAdvEventSolveFormView:bindEvents()
	DomAdvEventSolveFormView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnSkill, self._onClickBtnSkill, self)
	GameUtil.addClickHandler(self._btnIntroduce, self._onClickBtnIntroduce, self)
	GameUtil.addClickHandler(self._btnClg, self._onClickBtnClg, self)
	GameUtil.addClickHandler(self._btnRank, self._onClickBtnRank, self)
	GameUtil.addClickHandler(self._btnPort, self._onClickBtnPort, self)
end

function DomAdvEventSolveFormView:unbindEvents()
	DomAdvEventSolveFormView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnSkill)
	GameUtil.rmClickHandler(self._btnIntroduce)
	GameUtil.rmClickHandler(self._btnRank)
	GameUtil.rmClickHandler(self._btnPort)
end

function DomAdvEventSolveFormView:onEnter()
	DomAdvEventSolveFormView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._blockId = checknumber(params[2])

	local isInTime = DomainAdventureController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._scene = SceneMgr.instance:getCurScene()
	self._domAdvMo = DomainAdventureController.instance:getDomAdvMo(self._activityId)
	self._actData = DomainAdventureConfig.instance:getActData(self._activityId)
	self._mapData = DomainAdventureConfig.instance:getMapData(self._activityId, self._blockId)
	self._eventId = DomainAdventureConfig.instance:getEventId(self._activityId, self._blockId)
	self._eventData = DomainAdventureConfig.instance:getSolveFormData(self._activityId, self._eventId)
	self._skinId = self._eventData.skinId
	self._raceId = PetSkinConfig.instance:getPetSkinRaceId(self._skinId)

	self.addGEvent(self, GlobalNotify.DomainAdventureSceneMapDataUpdate, self._onUpdate, self)
	self:_onSetUI()
	self:_onUpdate()
end

function DomAdvEventSolveFormView:onExit()
	DomAdvEventSolveFormView.super.onExit(self)
	MaterialMgr.resetAll(self._pointRare)
	self._prizeScrollerList:dispose()

	self._role = RoleObjectPool.instance:removeRole(self._role)
end

function DomAdvEventSolveFormView:_onSetUI()
	local skinId = self._skinId
	local displayBagOffset = CharacterConfig.instance:getModelUIPosAndScale("display", skinId)
	local x, y, scale = 0, 0, 1

	if displayBagOffset then
		x = checknumber(displayBagOffset[1])
		y = checknumber(displayBagOffset[2])
		scale = displayBagOffset[3] or 1
	end

	self._role = RoleObjectPool.instance:addRoleToParent(self._role, skinId, self._con, scale, nil, true, x, y)

	if skinId > 0 then
		MaterialMgr.setCell(MatType.Rare, skinId, self._pointRare)
	end

	self._txtPetNameInInfo.text = PetSkinConfig.instance:getPetSkinName(skinId)

	local list = string.split(self._eventData.prize, "#")

	self._prizeScrollerList:reloadData(list)
end

function DomAdvEventSolveFormView:_onUpdate()
	local result, _ = self._scene:getTryStartGridEventResultAndTips(self._activityId, self._blockId)

	GameUtil.SetGray(self._btnClg, result ~= GameEnum.ResultCode.Success)

	local percentage = self._domAdvMo:getCurPercentageInBlock(self._blockId)

	percentage = Mathf.Clamp(1 - percentage, 0, 1)

	self._slider:SetValue(percentage)

	self._txtSlider.text = string.format("%.2f%%", percentage * 100)
end

function DomAdvEventSolveFormView:_updatePrizeCell(view, cell, prizeStr, tag)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")

	MaterialMgr.setCellByCfg(prizeStr, item)
end

function DomAdvEventSolveFormView:_clearPrizeCell(cell)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")

	MaterialMgr.resetAll(item)
end

function DomAdvEventSolveFormView:_onClickBtnTip()
	TipsFacade.instance:openRulesView(key)
end

function DomAdvEventSolveFormView:_onClickBtnSkill()
	local raceId = self._raceId
	local skinId = self._skinId

	if raceId > 0 and skinId > 0 then
		PetbookController.instance:previewBattle(raceId, skinId)
	elseif raceId > 0 then
		PetbookController.instance:previewBattle(raceId)
	end
end

function DomAdvEventSolveFormView:_onClickBtnIntroduce()
	PetbookController.instance:openPetinfoView(self._raceId)
end

function DomAdvEventSolveFormView:_onClickBtnRank()
	UIStateManager.instance:push(ViewName.DomAdvRankTabFrameView, self._activityId, 1)
end

function DomAdvEventSolveFormView:_onClickBtnPort()
	UIStateManager.instance:push(ViewName.PassportDomAdvView, self._activityId)
end

function DomAdvEventSolveFormView:_onClickBtnClg()
	local result, tips = self._scene:getTryStartGridEventResultAndTips(self._activityId, self._blockId)

	FloatWordMgr.instance:show(tips)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	DomainAdventureController.instance:enterBattleWithSystem(self._activityId, self._blockId)
end

return DomAdvEventSolveFormView
