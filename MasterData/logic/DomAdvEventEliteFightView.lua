-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/domainadventure/view/DomAdvEventEliteFightView.lua

module("logic.extensions.domainadventure.view.DomAdvEventEliteFightView", package.seeall)

local DomAdvEventEliteFightView = class("DomAdvEventEliteFightView", ViewComponent)
local _curSelectMode = DomAdvEnum.EventFightMode_HAND

function DomAdvEventEliteFightView:ctor()
	DomAdvEventEliteFightView.super.ctor(self)
end

function DomAdvEventEliteFightView:buildUI()
	DomAdvEventEliteFightView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._btnTip = goutil.findChild(self.mainGO, "leftTop/btnTip")
	self._goldBarCon = goutil.findChild(self.mainGO, "goldBarCon")
	self._con = goutil.findChild(self.mainGO, "con")
	self._pointRare = goutil.findChild(self.mainGO, "petInfo/pointRare")
	self._btnSkill = goutil.findChild(self.mainGO, "petInfo/btnSkill")
	self._btnIntroduce = goutil.findChild(self.mainGO, "petInfo/btnIntroduce")
	self._txtPetNameInInfo = goutil.findChildTextComponent(self.mainGO, "petInfo/txtName")
	self._btnPrizeDetail = goutil.findChild(self.mainGO, "infoCol/btnPrizeDetail")

	local prizeScrView = goutil.findChild(self.mainGO, "infoCol/prizeScrView")
	local prizeScrCell = goutil.findChild(self.mainGO, "infoCol/prizeScrCell")

	self._prizeScrollerList = ScrollerList.create(prizeScrView, prizeScrCell, GameUtil.handler(self._updatePrizeCell, self), GameUtil.handler(self._clearPrizeCell, self))
	self._btnClg = goutil.findChild(self.mainGO, "btnClg/btn")
	self._descIcon = goutil.findChild(self.mainGO, "btnClg/desc/icon")
	self._txtDesc = goutil.findChildTextComponent(self.mainGO, "btnClg/desc/txt")
	self._btnHand = goutil.findChild(self.mainGO, "btnHand")
	self._btnHandSelect = goutil.findChild(self.mainGO, "btnHand/imgSelect")
	self._btnSweet = goutil.findChild(self.mainGO, "btnSweet")
	self._btnSweetSelect = goutil.findChild(self.mainGO, "btnSweet/imgSelect")
	self._btnPort = goutil.findChild(self.mainGO, "btnPort")
	self._redBtnPort = goutil.findChild(self.mainGO, "btnPort/redPoint")
	self._selectGosInMode = {
		[DomAdvEnum.EventFightMode_HAND] = self._btnHandSelect,
		[DomAdvEnum.EventFightMode_Sweet] = self._btnSweetSelect
	}
	self._slider = self:getSlider("slider")
	self._txtSlider = goutil.findChildTextComponent(self.mainGO, "slider/txtSlider")
end

function DomAdvEventEliteFightView:bindEvents()
	DomAdvEventEliteFightView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnSkill, self._onClickBtnSkill, self)
	GameUtil.addClickHandler(self._btnIntroduce, self._onClickBtnIntroduce, self)
	GameUtil.addClickHandler(self._btnClg, self._onClickBtnClg, self)
	GameUtil.addClickHandler(self._btnHand, GameUtil.handler(self._onSwitchMode, self, DomAdvEnum.EventFightMode_HAND))
	GameUtil.addClickHandler(self._btnSweet, GameUtil.handler(self._onSwitchMode, self, DomAdvEnum.EventFightMode_Sweet))
	GameUtil.addClickHandler(self._btnPort, self._onClickBtnPort, self)
	GameUtil.addClickHandler(self._btnPrizeDetail, function()
		UIStateManager.instance:push(ViewName.DomAdvNormalEventPrizeView, self._activityId, self._blockId)
	end, self)
end

function DomAdvEventEliteFightView:unbindEvents()
	DomAdvEventEliteFightView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnSkill)
	GameUtil.rmClickHandler(self._btnIntroduce)
	GameUtil.rmClickHandler(self._btnClg)
	GameUtil.rmClickHandler(self._btnHand)
	GameUtil.rmClickHandler(self._btnSweet)
	GameUtil.rmClickHandler(self._btnPort)
	GameUtil.rmClickHandler(self._btnPrizeDetail)
end

function DomAdvEventEliteFightView:onEnter()
	DomAdvEventEliteFightView.super.onEnter(self)

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
	self._eventData = DomainAdventureConfig.instance:getClgEventData(self._activityId, self._eventId)
	self._prizePlanId = self._eventData.prizePlanId
	self._prizeCfg = DomainAdventureConfig.instance:getValuePrizeCfg(self._prizePlanId)
	self._buffId = DomainAdventureConfig.instance:getBuffIdInGrid(self._activityId, self._blockId)
	self._buffData = DomainAdventureConfig.instance:getBuffData(self._activityId, self._buffId)
	self._skinId = self._eventData.skinId
	self._raceId = PetSkinConfig.instance:getPetSkinRaceId(self._skinId)

	self.addGEvent(self, GlobalNotify.DomainAdventureSceneMapDataUpdate, self._onUpdate, self)
	self:_onSetUI()
	self:_onUpdate()
end

function DomAdvEventEliteFightView:onExit()
	DomAdvEventEliteFightView.super.onExit(self)
	MaterialMgr.clearIcon(self._descIcon)
	MaterialMgr.resetAll(self._pointRare)
	self._prizeScrollerList:dispose()
	RedPointController.instance:unregRedPoint(self._redBtnPort)

	self._role = RoleObjectPool.instance:removeRole(self._role)
end

function DomAdvEventEliteFightView:_onSetUI()
	local list = {}
	local tab = {
		showAdd = false,
		id = DomainAdventureConfig.instance:getCostItem(self._activityId)
	}

	table.insert(list, tab)
	MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, list)

	local costItem = DomainAdventureConfig.instance:getCostItem(self._activityId)
	local matType, matId, matNum = MaterialMgr.getMatParams(costItem)

	MaterialMgr.setIcon(self._descIcon, matType, matId)

	self._txtDesc.text = self._mapData.costStrength

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

	local maxPrizeData = DomainAdventureConfig.instance:getMaxValuePrizeData(self._prizePlanId)
	local prizeStrArr = string.split(maxPrizeData.prize, "#")

	self._prizeScrollerList:reloadData(prizeStrArr)
	RedPointController.instance:regRedPoint(self._redBtnPort, RedPointModel.ID_PASSPORT_DOMADV)
end

function DomAdvEventEliteFightView:_onUpdate()
	if not self:_isCanSweet(self._blockId) then
		_curSelectMode = DomAdvEnum.EventFightMode_HAND
	end

	local result, _ = self._scene:getTryStartEventFightResultAndTips(self._activityId, self._blockId, _curSelectMode)

	self:_onUpdateModeUI()
	GameUtil.SetGray(self._btnClg, result ~= GameEnum.ResultCode.Success)

	local percentage = self._domAdvMo:getCurPercentageInBlock(self._blockId)

	percentage = Mathf.Clamp(1 - percentage, 0, 1)

	self._slider:SetValue(percentage)

	self._txtSlider.text = string.format("%.2f%%", percentage * 100)
end

function DomAdvEventEliteFightView:_updatePrizeCell(view, cell, prize, tag)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")

	MaterialMgr.setCellByCfg(prize, item)
end

function DomAdvEventEliteFightView:_clearPrizeCell(cell)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")

	MaterialMgr.resetAll(item)
end

function DomAdvEventEliteFightView:_onUpdateModeUI()
	for mode, go in pairs(self._selectGosInMode) do
		GameUtil.SetActive(go, mode == _curSelectMode)
	end
end

function DomAdvEventEliteFightView:_onSwitchMode(mode)
	if mode == DomAdvEnum.EventFightMode_Sweet and not self:_isCanSweet(self._blockId) then
		local gridState = self._scene:getGridState(self._blockId)

		if gridState:isOccupied() then
			FloatWordMgr.instance:show("该地块已被占领")
		else
			FloatWordMgr.instance:show("请先通关后再尝试扫荡")
		end

		return
	end

	_curSelectMode = mode

	self:_onUpdateModeUI()
end

function DomAdvEventEliteFightView:_isCanSweet(blockId)
	return self._domAdvMo:isCanSweetInFight(blockId)
end

function DomAdvEventEliteFightView:_onClickBtnTip()
	TipsFacade.instance:openRulesView(key)
end

function DomAdvEventEliteFightView:_onClickBtnSkill()
	local raceId = self._raceId
	local skinId = self._skinId

	if raceId > 0 and skinId > 0 then
		PetbookController.instance:previewBattle(raceId, skinId)
	elseif raceId > 0 then
		PetbookController.instance:previewBattle(raceId)
	end
end

function DomAdvEventEliteFightView:_onClickBtnIntroduce()
	PetbookController.instance:openPetinfoView(self._raceId)
end

function DomAdvEventEliteFightView:_onClickBtnPort()
	UIStateManager.instance:push(ViewName.PassportDomAdvView, self._activityId)
end

function DomAdvEventEliteFightView:_onClickBtnClg()
	local result, tips = self._scene:getTryStartEventFightResultAndTips(self._activityId, self._blockId, _curSelectMode)

	FloatWordMgr.instance:show(tips)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	if _curSelectMode == DomAdvEnum.EventFightMode_HAND then
		DomainAdventureController.instance:enterBattle(self._activityId, self._blockId)
	elseif _curSelectMode == DomAdvEnum.EventFightMode_Sweet then
		local jsonTable = {}

		jsonTable.removeStash = self._blockId

		local extParam = GameUtil.jsonToString(jsonTable)

		DomainAdventureController.instance:sendPM_DomainAdventureActionReq(self._activityId, self._blockId, extParam, nil)
	end
end

return DomAdvEventEliteFightView
