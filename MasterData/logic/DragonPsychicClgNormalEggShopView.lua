-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonpsychicclg/view/DragonPsychicClgNormalEggShopView.lua

module("logic.extensions.dragonpsychicclg.view.DragonPsychicClgNormalEggShopView", package.seeall)

local DragonPsychicClgNormalEggShopView = class("DragonPsychicClgNormalEggShopView", ViewComponent)

function DragonPsychicClgNormalEggShopView:buildUI()
	DragonPsychicClgNormalEggShopView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "btnClose")
	self._btnSure = goutil.findChild(self.mainGO, "btnSure")

	local petScrView = goutil.findChild(self.mainGO, "petCol/scrView")
	local petScrCell = goutil.findChild(self.mainGO, "petCol/scrCell")

	self._petScrollList = ScrollerList.create(petScrView, petScrCell, GameUtil.handler(self._updatePetCell, self), GameUtil.handler(self._clearPetCell, self))
	self._txtCount = goutil.findChildTextComponent(self.mainGO, "txtCount")
end

function DragonPsychicClgNormalEggShopView:bindEvents()
	DragonPsychicClgNormalEggShopView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickBtnSure, self)
end

function DragonPsychicClgNormalEggShopView:unbindEvents()
	DragonPsychicClgNormalEggShopView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSure)
end

function DragonPsychicClgNormalEggShopView:onEnter()
	DragonPsychicClgNormalEggShopView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._activityType = DragonPsychicClgController.instance:getActivityType()

	local isInTime = DragonPsychicClgController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		local text = string.format("活动不在开启期限内( activityId = %d )", self._activityId)

		local function func()
			self:close()
		end

		TipsFacade.instance:openTipWindow("提示", text, func, "确定", UnityEngine.TextAnchor.MiddleCenter)

		return
	end

	self._actData = DragonPsychicClgConfig.instance:getDpcData(self._activityId)
	self._selectCreepsIdList = {}
	self._needCount = 1

	self.addGEvent(self, GlobalNotify.handlePM_DPClgHatchRes, self._handlePM_DPClgHatchRes, self)
	self.addGEvent(self, GlobalNotify.handlePM_DPClgGetUniversalInfoRes, self._onUpdate, self)
	self:_onUpdate()
end

function DragonPsychicClgNormalEggShopView:onExit()
	DragonPsychicClgNormalEggShopView.super.onExit(self)
	self:_onClear()
end

function DragonPsychicClgNormalEggShopView:_handlePM_DPClgHatchRes()
	FloatWordMgr.instance:show("开始孵化")
	self:close()
end

function DragonPsychicClgNormalEggShopView:_onUpdate()
	self:_onUpdatePetColUI()
end

function DragonPsychicClgNormalEggShopView:_onClear()
	self:_onClearPetColUI()
end

function DragonPsychicClgNormalEggShopView:_onUpdatePetColUI()
	local petCfg = DragonPsychicClgConfig.instance:getDpcSystemPetCfg(self._activityId) or {}
	local petList = {}

	for k, v in pairs(petCfg) do
		local isWith = DragonPsychicClgController.instance:isWithThePetOfNor(self._activityId, v.creepsId)

		if string.nilorempty(v.summonMasterId) and not isWith then
			table.insert(petList, v)
		end
	end

	self._petScrollList:reloadData(petList)

	local curCount = #self._selectCreepsIdList
	local needCount = self._needCount
	local isFit = needCount <= curCount

	GameUtil.SetGray(self._btnSure, not isFit)

	self._txtCount.text = string.format("%s/%s", curCount, needCount)
end

function DragonPsychicClgNormalEggShopView:_onClearPetColUI()
	self._petScrollList:dispose()
end

function DragonPsychicClgNormalEggShopView:_updatePetCell(view, cell, data, tag)
	local creepsId = data.creepsId
	local raceId = data.raceId
	local isSelected = table.indexof(self._selectCreepsIdList, creepsId)
	local isWith = DragonPsychicClgController.instance:isWithThePetOfNor(self._activityId, creepsId)
	local mainGo = cell.gameObject
	local pet = goutil.findChild(mainGo, "pet")
	local con = goutil.findChild(mainGo, "pet/mask/con")
	local imgSelected = goutil.findChild(mainGo, "imgSelected")
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local imgHave = goutil.findChild(mainGo, "imgHave")

	GameUtil.SetActive(imgHave, isWith)
	GameUtil.SetActive(imgSelected, isSelected)

	txtName.text = string.format("%s", data.creepsName)

	MaterialMgr.setIcon(con, MatType.Pet, raceId, nil, nil)

	local function callBack()
		local level = data.lv
		local awakenLv = data.awakenLv
		local skinId = data.faceId
		local tmpMo = FightingPowerPetMo.createPetByLevel(raceId, level, awakenLv, skinId)

		CommonTipsMgr.instance:showPetTips(tmpMo, true)
	end

	GameUtil.addClickHandler(pet, callBack)
	GameUtil.addClickHandler(mainGo, GameUtil.handler(self._clickPetCell, self, creepsId))
end

function DragonPsychicClgNormalEggShopView:_clearPetCell(cell)
	local mainGo = cell.gameObject
	local pet = goutil.findChild(mainGo, "pet")
	local con = goutil.findChild(mainGo, "pet/mask/con")

	MaterialMgr.clearIcon(con)
	GameUtil.rmClickHandler(pet)
	GameUtil.rmClickHandler(mainGo)
end

function DragonPsychicClgNormalEggShopView:_clickPetCell(creepsId)
	local isWith = DragonPsychicClgController.instance:isWithThePetOfNor(self._activityId, creepsId)

	if isWith then
		return
	end

	if table.indexof(self._selectCreepsIdList, creepsId) ~= false then
		table.removebyvalue(self._selectCreepsIdList, creepsId)
		self:_onUpdatePetColUI()
	else
		local curCount = #self._selectCreepsIdList
		local needCount = self._needCount

		if curCount < needCount then
			table.insert(self._selectCreepsIdList, creepsId)
			self:_onUpdatePetColUI()
		end
	end
end

function DragonPsychicClgNormalEggShopView:_onClickBtnSure()
	local curCount = #self._selectCreepsIdList
	local needCount = self._needCount

	if curCount < needCount then
		FloatWordMgr.instance:show(string.format("当前已选精灵不足%s只", needCount))
	else
		DragonPsychicClgController.instance:sendPM_DPClgHatchReq(self._activityId, self._selectCreepsIdList[1])
	end
end

return DragonPsychicClgNormalEggShopView
