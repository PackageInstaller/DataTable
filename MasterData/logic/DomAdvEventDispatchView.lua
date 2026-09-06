-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/domainadventure/view/DomAdvEventDispatchView.lua

module("logic.extensions.domainadventure.view.DomAdvEventDispatchView", package.seeall)

local DomAdvEventDispatchView = class("DomAdvEventDispatchView", ViewComponent)

function DomAdvEventDispatchView:ctor()
	DomAdvEventDispatchView.super.ctor(self)
end

function DomAdvEventDispatchView:buildUI()
	DomAdvEventDispatchView.super.buildUI(self)

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
	self._slider = self:getSlider("slider")
	self._txtSlider = goutil.findChildTextComponent(self.mainGO, "slider/txtSlider")
end

function DomAdvEventDispatchView:bindEvents()
	DomAdvEventDispatchView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnSkill, self._onClickBtnSkill, self)
	GameUtil.addClickHandler(self._btnIntroduce, self._onClickBtnIntroduce, self)
	GameUtil.addClickHandler(self._btnClg, self._onClickBtnClg, self)
	GameUtil.addClickHandler(self._btnPrizeDetail, function()
		UIStateManager.instance:push(ViewName.DomAdvNormalEventPrizeView, self._activityId, self._blockId)
	end, self)
end

function DomAdvEventDispatchView:unbindEvents()
	DomAdvEventDispatchView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnSkill)
	GameUtil.rmClickHandler(self._btnIntroduce)
	GameUtil.rmClickHandler(self._btnPrizeDetail)
end

function DomAdvEventDispatchView:onEnter()
	DomAdvEventDispatchView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._blockId = checknumber(params[2])

	local isInTime = DomainAdventureController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._domAdvMo = DomainAdventureController.instance:getDomAdvMo(self._activityId)
	self._actData = DomainAdventureConfig.instance:getActData(self._activityId)
	self._mapData = DomainAdventureConfig.instance:getMapData(self._activityId, self._blockId)
	self._eventId = DomainAdventureConfig.instance:getEventId(self._activityId, self._blockId)
	self._eventData = DomainAdventureConfig.instance:getDispatchData(self._activityId, self._eventId)
	self._prizePlanId = self._eventData.prizePlanId
	self._prizeCfg = DomainAdventureConfig.instance:getValuePrizeCfg(self._prizePlanId)
	self._skinId = self._eventData.skinId
	self._raceId = PetSkinConfig.instance:getPetSkinRaceId(self._skinId)

	self.addGEvent(self, GlobalNotify.DomainAdventureSceneMapDataUpdate, self._onUpdate, self)
	self:_onSetUI()
	self:_onUpdate()
end

function DomAdvEventDispatchView:onExit()
	DomAdvEventDispatchView.super.onExit(self)
	MaterialMgr.clearIcon(self._descIcon)
	MaterialMgr.resetAll(self._pointRare)
	self._prizeScrollerList:dispose()

	self._role = RoleObjectPool.instance:removeRole(self._role)
end

function DomAdvEventDispatchView:_onSetUI()
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
end

function DomAdvEventDispatchView:_onUpdate()
	local result, _ = self:_getTryStartGridEventResultAndTips(self._activityId, self._blockId)

	GameUtil.SetGray(self._btnClg, result ~= GameEnum.ResultCode.Success)

	local percentage = self._domAdvMo:getCurPercentageInBlock(self._blockId)

	percentage = Mathf.Clamp(1 - percentage, 0, 1)

	self._slider:SetValue(percentage)

	self._txtSlider.text = string.format("%.2f%%", percentage * 100)
end

function DomAdvEventDispatchView:_updatePrizeCell(view, cell, prize, tag)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")

	MaterialMgr.setCellByCfg(prize, item)
end

function DomAdvEventDispatchView:_clearPrizeCell(cell)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")

	MaterialMgr.resetAll(item)
end

function DomAdvEventDispatchView:_getTryStartGridEventResultAndTips(activityId, blockId)
	local scene = SceneMgr.instance:getCurScene()

	return scene:getTryStartGridEventResultAndTips(activityId, blockId)
end

function DomAdvEventDispatchView:_onClickBtnTip()
	TipsFacade.instance:openRulesView(key)
end

function DomAdvEventDispatchView:_onClickBtnSkill()
	local raceId = self._raceId
	local skinId = self._skinId

	if raceId > 0 and skinId > 0 then
		PetbookController.instance:previewBattle(raceId, skinId)
	elseif raceId > 0 then
		PetbookController.instance:previewBattle(raceId)
	end
end

function DomAdvEventDispatchView:_onClickBtnIntroduce()
	PetbookController.instance:openPetinfoView(self._raceId)
end

function DomAdvEventDispatchView:_onClickBtnClg()
	local result, tips = self:_getTryStartGridEventResultAndTips(self._activityId, self._blockId)

	FloatWordMgr.instance:show(tips)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	UIStateManager.instance:push(ViewName.DomAdvEventDispatchShopView, self._activityId, self._blockId)
end

return DomAdvEventDispatchView
