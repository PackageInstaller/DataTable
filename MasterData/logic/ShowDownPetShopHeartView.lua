-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/showdown/view/ShowDownPetShopHeartView.lua

module("logic.extensions.showdown.view.ShowDownPetShopHeartView", package.seeall)

local ShowDownPetShopHeartView = class("ShowDownPetShopHeartView", ViewComponent)

function ShowDownPetShopHeartView:buildUI()
	ShowDownPetShopHeartView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "btnClose")
	self._btnSure = goutil.findChild(self.mainGO, "btnSure")
	self._txtCount = goutil.findChildTextComponent(self.mainGO, "count/txt")
	self._txtTips = goutil.findChildTextComponent(self.mainGO, "tips/txt")
	self._tipsStr = self._txtTips.text

	local petScrView = goutil.findChild(self.mainGO, "petCol/scrView")
	local petScrCell = goutil.findChild(self.mainGO, "petCol/scrCell")

	self._petScrollList = ScrollerList.create(petScrView, petScrCell, GameUtil.handler(self._updatePetCell, self), GameUtil.handler(self._clearPetCell, self))
end

function ShowDownPetShopHeartView:bindEvents()
	ShowDownPetShopHeartView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickBtnSure, self)
end

function ShowDownPetShopHeartView:unbindEvents()
	ShowDownPetShopHeartView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSure)
end

function ShowDownPetShopHeartView:onEnter()
	ShowDownPetShopHeartView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._roundId = checknumber(params[2])
	self._creepsIdOfWish = checknumber(params[3])
	self._activityType = ShowDownController.instance:getActivityType()

	local isInTime = ShowDownController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._actData = ShowDownConfig.instance:getActData(self._activityId)
	self._maxWishPetCount = ShowDownController.instance:getMaxWishPetCountInPetShop(self._activityId, self._roundId)
	self._wishPetList = ShowDownController.instance:getWishPetListInPetShop(self._activityId, self._roundId)

	local shopPetList = ShowDownController.instance:getShopPetListInPetShop(self._activityId, self._roundId)

	self._shopPetList = {}

	table.insertto(self._shopPetList, shopPetList)

	self._txtTips.text = string.format(self._tipsStr, self._maxWishPetCount)

	self.addGEvent(self, GlobalNotify.ShowDownStepChange, self._handleShowDownStepChange, self)
	self.addGEvent(self, GlobalNotify.HandlePM_ShowDown_SetWishListRes, self._handlePM_ShowDown_SetWishListRes, self)
	self:_onUpdate()
end

function ShowDownPetShopHeartView:onExit()
	ShowDownPetShopHeartView.super.onExit(self)
	self:_onClear()
end

function ShowDownPetShopHeartView:_handleShowDownStepChange()
	if self._roundId == ShowDownEnum.Round_Func then
		return
	end

	local curStepId = ShowDownController.instance:getCurStepId(self._activityId)
	local curRoundId = ShowDownController.instance:getRoundIdByStep(self._activityId, curStepId)

	if curRoundId == self._roundId then
		self:_onUpdate()
	else
		self:close()
	end
end

function ShowDownPetShopHeartView:_handlePM_ShowDown_SetWishListRes()
	FloatWordMgr.instance:show("心愿精灵设置成功")
	self:close()
end

function ShowDownPetShopHeartView:_onUpdate()
	local valueA, valueB = 0, 0

	table.sort(self._shopPetList, function(a, b)
		valueA = self:isHasSelectThePet(a) and 1 or 0
		valueB = self:isHasSelectThePet(b) and 1 or 0

		return valueA > valueB
	end)
	self:_onUpdatePetColUI()
end

function ShowDownPetShopHeartView:_onClear()
	self:_onClearPetColUI()
end

function ShowDownPetShopHeartView:setWishPetToList(creepsId, isAdd)
	if isAdd then
		if self._maxWishPetCount == 1 then
			table.clear(self._wishPetList)
			table.insert(self._wishPetList, creepsId)
		else
			local isHave = self:isHasSelectThePet(creepsId)
			local isFull = self:isFullOfTheList()

			if not isHave and not isFull then
				table.insert(self._wishPetList, creepsId)
			end
		end
	else
		table.removebyvalue(self._wishPetList, creepsId)
	end
end

function ShowDownPetShopHeartView:isHasSelectThePet(creepsId)
	return table.indexof(self._wishPetList, creepsId) ~= false
end

function ShowDownPetShopHeartView:isFullOfTheList()
	return #self._wishPetList >= self._maxWishPetCount
end

function ShowDownPetShopHeartView:_onUpdatePetColUI()
	local cur = #self._wishPetList
	local max = self._maxWishPetCount

	self._txtCount.text = cur < max and string.format("<color=#2ff5a3>%s</color>/%s", #self._wishPetList, self._maxWishPetCount) or string.format("%s/%s", #self._wishPetList, self._maxWishPetCount)

	self._petScrollList:reloadData(self._shopPetList)
end

function ShowDownPetShopHeartView:_onClearPetColUI()
	self._petScrollList:dispose()
end

function ShowDownPetShopHeartView:_updatePetCell(view, cell, creepsId, tag)
	local isSelected = self:isHasSelectThePet(creepsId)
	local data = ShowDownConfig.instance:getSystemPetData(creepsId)
	local raceId = data.raceId
	local skinId = checknumber(data.faceId)

	if skinId <= 0 then
		skinId = raceId
	end

	local mainGo = cell.gameObject
	local pet = goutil.findChild(mainGo, "pet")
	local con = goutil.findChild(mainGo, "pet/mask/con")
	local imgSelected = goutil.findChild(mainGo, "imgSelected")
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local imgHave = goutil.findChild(mainGo, "imgHave")

	GameUtil.SetActive(imgSelected, isSelected)

	txtName.text = string.format("%s", data.creepsName)

	MaterialMgr.setIcon(con, MatType.Pet, skinId, nil, nil)

	local function callBack()
		local level = data.lv
		local awakenLv = data.awakenLv
		local tmpMo = FightingPowerPetMo.createPetByLevel(raceId, level, awakenLv, skinId)

		CommonTipsMgr.instance:showPetTips(tmpMo, true)
	end

	GameUtil.addClickHandler(pet, callBack)
	GameUtil.addClickHandler(mainGo, GameUtil.handler(self._clickPetCell, self, creepsId))
end

function ShowDownPetShopHeartView:_clearPetCell(cell)
	local mainGo = cell.gameObject
	local pet = goutil.findChild(mainGo, "pet")
	local con = goutil.findChild(mainGo, "pet/mask/con")

	MaterialMgr.clearIcon(con)
	GameUtil.rmClickHandler(pet)
	GameUtil.rmClickHandler(mainGo)
end

function ShowDownPetShopHeartView:_clickPetCell(creepsId)
	local isSelected = self:isHasSelectThePet(creepsId)

	self:setWishPetToList(creepsId, not isSelected)
	self:_onUpdatePetColUI()
end

function ShowDownPetShopHeartView:_onClickBtnSure()
	if #self._wishPetList < self._maxWishPetCount then
		FloatWordMgr.instance:show(string.format("所选精灵不足%s个", self._maxWishPetCount))

		return
	end

	local tipsContent = "是否确认保存心愿精灵，确认后将不可更改"

	local function okFunc()
		ShowDownController.instance:sendPM_ShowDown_SetWishListReq(self._activityId, self._roundId, self._wishPetList)
	end

	local function cencelFunc()
		return
	end

	TipsFacade.instance:openPopupWindow("提示", tipsContent, okFunc, cencelFunc, "确定", "取消")
end

return ShowDownPetShopHeartView
