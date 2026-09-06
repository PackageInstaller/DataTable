-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonpsychicclg/view/DragonPsychicClgNormalInitialShopView.lua

module("logic.extensions.dragonpsychicclg.view.DragonPsychicClgNormalInitialShopView", package.seeall)

local DragonPsychicClgNormalInitialShopView = class("DragonPsychicClgNormalInitialShopView", ViewComponent)

function DragonPsychicClgNormalInitialShopView:buildUI()
	DragonPsychicClgNormalInitialShopView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "btnClose")
	self._btnSure = goutil.findChild(self.mainGO, "btnSure")

	local petScrView = goutil.findChild(self.mainGO, "petCol/scrView")
	local petScrCell = goutil.findChild(self.mainGO, "petCol/scrCell")

	self._petScrollList = ScrollerList.create(petScrView, petScrCell, GameUtil.handler(self._updatePetCell, self), GameUtil.handler(self._clearPetCell, self))
	self._txtCount = goutil.findChildTextComponent(self.mainGO, "txtCount")
	self._txtTips = goutil.findChildTextComponent(self.mainGO, "tips/txt")
	self._txtTips_tipStr = self._txtTips.text
end

function DragonPsychicClgNormalInitialShopView:bindEvents()
	DragonPsychicClgNormalInitialShopView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickBtnSure, self)
end

function DragonPsychicClgNormalInitialShopView:unbindEvents()
	DragonPsychicClgNormalInitialShopView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSure)
end

function DragonPsychicClgNormalInitialShopView:onEnter()
	DragonPsychicClgNormalInitialShopView.super.onEnter(self)

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

	self.addGEvent(self, GlobalNotify.handlePM_DPClgSelectPetRes, self._handlePM_DPClgSelectPetRes, self)
	self.addGEvent(self, GlobalNotify.handlePM_DPClgGetUniversalInfoRes, self._onUpdate, self)

	self._txtTips.text = string.format(self._txtTips_tipStr, self._actData.initSystemPetCount)

	self:_onUpdate()
end

function DragonPsychicClgNormalInitialShopView:onExit()
	DragonPsychicClgNormalInitialShopView.super.onExit(self)
	self:_onClear()
end

function DragonPsychicClgNormalInitialShopView:_handlePM_DPClgSelectPetRes()
	FloatWordMgr.instance:show("领取成功")
	self:close()
end

function DragonPsychicClgNormalInitialShopView:_onUpdate()
	self:_onUpdatePetColUI()
end

function DragonPsychicClgNormalInitialShopView:_onClear()
	self:_onClearPetColUI()
end

function DragonPsychicClgNormalInitialShopView:_onUpdatePetColUI()
	local petCfg = DragonPsychicClgConfig.instance:getDpcSystemPetCfg(self._activityId) or {}
	local petList = {}

	for k, v in pairs(petCfg) do
		if string.nilorempty(v.summonMasterId) then
			table.insert(petList, v)
		end
	end

	self._petScrollList:reloadData(petList)

	local curCount = #self._selectCreepsIdList
	local needCount = self._actData.initSystemPetCount
	local isFit = needCount <= curCount

	GameUtil.SetGray(self._btnSure, not isFit)

	self._txtCount.text = string.format("%s/%s", curCount, needCount)
end

function DragonPsychicClgNormalInitialShopView:_onClearPetColUI()
	self._petScrollList:dispose()
end

function DragonPsychicClgNormalInitialShopView:_updatePetCell(view, cell, data, tag)
	local creepsId = data.creepsId
	local raceId = data.raceId
	local isSelected = table.indexof(self._selectCreepsIdList, creepsId)
	local mainGo = cell.gameObject
	local pet = goutil.findChild(mainGo, "pet")
	local con = goutil.findChild(mainGo, "pet/mask/con")
	local imgSelected = goutil.findChild(mainGo, "imgSelected")
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local imgHave = goutil.findChild(mainGo, "imgHave")

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

function DragonPsychicClgNormalInitialShopView:_clearPetCell(cell)
	local mainGo = cell.gameObject
	local pet = goutil.findChild(mainGo, "pet")
	local con = goutil.findChild(mainGo, "pet/mask/con")

	MaterialMgr.clearIcon(con)
	GameUtil.rmClickHandler(pet)
	GameUtil.rmClickHandler(mainGo)
end

function DragonPsychicClgNormalInitialShopView:_clickPetCell(creepsId)
	if table.indexof(self._selectCreepsIdList, creepsId) ~= false then
		table.removebyvalue(self._selectCreepsIdList, creepsId)
		self:_onUpdatePetColUI()
	else
		local curCount = #self._selectCreepsIdList
		local needCount = self._actData.initSystemPetCount

		if curCount < needCount then
			table.insert(self._selectCreepsIdList, creepsId)
			self:_onUpdatePetColUI()
		end
	end
end

function DragonPsychicClgNormalInitialShopView:_onClickBtnSure()
	local curCount = #self._selectCreepsIdList
	local needCount = self._actData.initSystemPetCount

	if curCount < needCount then
		FloatWordMgr.instance:show(string.format("当前已选精灵不足%s只", needCount))
	else
		DragonPsychicClgController.instance:sendPM_DPClgSelectPetReq(self._activityId, self._selectCreepsIdList)
	end
end

return DragonPsychicClgNormalInitialShopView
