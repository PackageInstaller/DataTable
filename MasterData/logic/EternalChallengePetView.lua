-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/eternalchallenge/view/shop/EternalChallengePetView.lua

module("logic.extensions.eternalchallenge.view.shop.EternalChallengePetView", package.seeall)

local EternalChallengePetView = class("EternalChallengePetView", ViewComponent)

function EternalChallengePetView:ctor()
	EternalChallengePetView.super.ctor(self)
end

function EternalChallengePetView:buildUI()
	EternalChallengePetView.super.buildUI(self)

	self._goldBarCon = goutil.findChild(self.mainGO, "goldBarCon")

	local petScrollerview = goutil.findChild(self.mainGO, "petCol/petScrollerview")
	local petScrollercell = goutil.findChild(self.mainGO, "petCol/petScrollercell")

	self._petScrollList = ScrollerList.create(petScrollerview, petScrollercell, GameUtil.handler(self._updatePetCell, self), GameUtil.handler(self._clearPetCell, self))
	self._btnFilter = goutil.findChild(self.mainGO, "btnFilter")
	self._btnSure = goutil.findChild(self.mainGO, "btnSure")
	self._txtBtnSure = goutil.findChildTextComponent(self.mainGO, "btnSure/txt")
end

function EternalChallengePetView:bindEvents()
	EternalChallengePetView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSure, self._onClickBtnSure, self)
	GameUtil.addClickHandler(self._btnFilter, self._onClickFilter, self)
end

function EternalChallengePetView:unbindEvents()
	EternalChallengePetView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSure)
	GameUtil.rmClickHandler(self._btnFilter)
end

function EternalChallengePetView:onEnter()
	EternalChallengePetView.super.onEnter(self)

	self._activityId = EternalChallengeController.instance:getActivityId()
	self._activityType = EternalChallengeController.instance:getActivityType()

	local isInTime = EternalChallengeController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._curSelectId = 0

	self.addGEvent(self, GlobalNotify.EternalChallengeInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.EternalChallengeBuyPetRes, self._onUpdate, self)
	self:_onSetUI()
	EternalChallengeController.instance:sendPM_EternalChallengeInfoReq(self._activityId)
end

function EternalChallengePetView:onExit()
	EternalChallengePetView.super.onExit(self)
	self:_onClearPetCol()
end

function EternalChallengePetView:_onSetUI()
	local matStrList = {}
	local dataLists = EternalChallengeConfig.instance:getEcPetDataLists(self._activityId)

	for raceId, dataList in pairs(dataLists) do
		for _, data in ipairs(dataList) do
			if not string.nilorempty(data.cost) then
				table.insert(matStrList, data.cost)
			end
		end
	end

	matStrList = MaterialMgr.mergeMatStrList(matStrList)

	local list = {}

	for _, matStr in ipairs(matStrList) do
		if not string.nilorempty(matStr) then
			local tab = {
				showAdd = false,
				id = matStr
			}

			table.insert(list, tab)
		end
	end

	if #list > 0 then
		MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, list)
	end
end

function EternalChallengePetView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function EternalChallengePetView:_onUpdateData()
	self:_onUpdatePetColData()
end

function EternalChallengePetView:_onUpdateUI()
	self:_onUpdatePlaneUI()
	self:_refreshPetList()
end

function EternalChallengePetView:_onUpdatePlaneUI()
	self._txtBtnSure.text = "招募"

	if self._curSelectId > 0 then
		local info = self._petInfoPool[self._curSelectId]

		if info and info.curLevel > 0 then
			self._txtBtnSure.text = "升级"
		end
	end

	GameUtil.SetGray(self._btnSure, self._curSelectId <= 0)
end

function EternalChallengePetView:_onUpdatePetColData()
	local petInfoList = {}
	local dataLists = EternalChallengeConfig.instance:getEcPetDataLists(self._activityId)
	local raceIdList = EternalChallengeController.instance:getRaceIdList(self._activityId)

	for id, raceId in ipairs(raceIdList) do
		local info = {}

		info.id = id
		info.raceId = raceId
		info.curLevel = EternalChallengeController.instance:getPetCurLevel(self._activityId, raceId)
		info.nextLevel = EternalChallengeController.instance:getPetNextLevel(self._activityId, raceId)
		info.isFullLevel = EternalChallengeController.instance:isPetFullLevel(self._activityId, raceId)
		info.isCanFmt = EternalChallengeController.instance:getPetCanFmt(self._activityId, raceId)
		info.petMo = EternalChallengeController.instance:getPetMo(self._activityId, raceId)

		table.insert(petInfoList, info)
	end

	table.sort(petInfoList, function(a, b)
		if a.curLevel == b.curLevel then
			return false
		end

		return a.curLevel > b.curLevel
	end)

	self._petInfoList = petInfoList
	self._petInfoPool = {}

	for _, info in ipairs(petInfoList) do
		self._petInfoPool[info.id] = info
	end

	self._petInfoViewList = {}

	table.insertto(self._petInfoViewList, petInfoList)

	self._curSelectId = Mathf.Clamp(self._curSelectId, 0, #self._petInfoList)
end

function EternalChallengePetView:_onUpdatePetColUI()
	self._petScrollList:reloadData(self._petInfoViewList)

	if self._curSelectId > 0 then
		local index = 1

		for idx, info in ipairs(self._petInfoViewList) do
			if info.id == self._curSelectId then
				index = idx

				break
			end
		end

		self._petScrollList:MoveCellInView(index - 1, true)
	end
end

function EternalChallengePetView:_onClearPetCol()
	self._petScrollList:dispose()
end

function EternalChallengePetView:_updatePetCell(view, cell, info, tag)
	local id = info.id
	local raceId = info.raceId
	local curLevel = info.curLevel
	local nextLevel = info.nextLevel
	local isFullLevel = info.isFullLevel
	local petMo = info.petMo
	local skinId = petMo.curFaceId
	local rare = petMo:getRare()
	local petLevel = petMo:getPetLv()
	local isNeedCost = not isFullLevel
	local costMatType, costMatId, costMatNum = 0, 0, 0

	if isNeedCost then
		local nextPetData = EternalChallengeConfig.instance:getEcPetData(self._activityId, raceId, nextLevel)

		if not string.nilorempty(nextPetData.cost) then
			costMatType, costMatId, costMatNum = MaterialMgr.getMatParams(nextPetData.cost)
		end
	end

	if costMatNum <= 0 then
		isNeedCost = false
	end

	local mainGo = cell.gameObject
	local container = goutil.findChild(mainGo, "container")
	local con = goutil.findChild(mainGo, "container/mask/con")
	local cost = goutil.findChild(mainGo, "container/cost")
	local txtCost = goutil.findChildTextComponent(mainGo, "container/cost/txtCost")
	local costIcon = goutil.findChild(mainGo, "container/cost/txtCost/icon")
	local imgLock = goutil.findChild(mainGo, "container/imgLock")
	local imgSelect = goutil.findChild(mainGo, "container/imgSelect")
	local qualitybg = goutil.findChild(mainGo, "container/info/qualitybg")
	local Img_attr = goutil.findChild(mainGo, "container/info/layout/Nego_Attr/Img_attr")
	local ImgC_Job = goutil.findChild(mainGo, "container/info/layout/Nego_Job/ImgC_Job")
	local ImgC_Job_1 = goutil.findChild(mainGo, "container/info/layout/Nego_Job1/ImgC_Job")
	local txtLvl = goutil.findChildTextComponent(mainGo, "container/info/txtLvl")
	local modelCo = CharacterConfig.instance:getModelCo(checknumber(skinId))

	if modelCo and not string.nilorempty(modelCo.cardName) then
		local imgUrl = GameUrl.getPetImgUrl(modelCo.cardName)

		uGuiUtil.setSpriteToImage(con, uGuiUtil.SpriteType.BigBg, imgUrl)
	end

	if isNeedCost then
		txtCost.text = costMatNum

		MaterialMgr.setIcon(costIcon, costMatType, costMatId, nil, nil)
	else
		MaterialMgr.resetAll(costIcon)
	end

	GameUtil.SetActive(cost, isNeedCost)
	GameUtil.SetActive(imgLock, curLevel <= 0)
	GameUtil.SetActive(imgSelect, self._curSelectId == id)
	GameUtil.setUIImageSpriteIdx(qualitybg, rare)
	GameUtil.setUIImageColorIdx(qualitybg, rare)

	local race = PetSkinConfig.instance:getFisrtEleAttrIdx(skinId)

	race = race % 10

	GameUtil.setUIImageSpriteIdx(Img_attr, race - 1)

	local firstJobIdx = PetSkinConfig.instance:getFirstJobIdx(skinId)

	GameUtil.setUIImageSpriteIdx(ImgC_Job, firstJobIdx - 1)

	local secondJobIdx = PetSkinConfig.instance:getSecondJobIdx(skinId)
	local isNeedJob1 = secondJobIdx > 20

	GameUtil.SetActive(Nego_Job1, isNeedJob1)

	if isNeedJob1 then
		GameUtil.setUIImageSpriteIdx(ImgC_Job_1, secondJobIdx - 1 - 20)
	end

	txtLvl.text = petLevel

	GameUtil.addClickHandler(container, GameUtil.handler(self._onClickPetCell, self, id))
end

function EternalChallengePetView:_clearPetCell(cell)
	local mainGo = cell.gameObject
	local container = goutil.findChild(mainGo, "container")
	local con = goutil.findChild(mainGo, "container/mask/con")
	local costIcon = goutil.findChild(mainGo, "cost/txtCost/icon")

	uGuiUtil.clearImage(con)
	MaterialMgr.resetAll(costIcon)
	GameUtil.rmClickHandler(container)
end

function EternalChallengePetView:_onClickPetCell(id)
	self._curSelectId = self._curSelectId == id and 0 or id

	self:_onUpdatePlaneUI()
	self:_onUpdatePetColUI()
end

function EternalChallengePetView:_refreshPetList()
	local curViewPetMos = {}
	local tagPool = {}

	for idx, info in ipairs(self._petInfoList) do
		if self:onFilter(info.petMo) then
			tagPool[info.petMo:getDefineId()] = idx

			table.insert(curViewPetMos, info.petMo)
		end
	end

	local names, opt = BagModel.instance:GetSortParms()

	ArraySort.sortOn(curViewPetMos, names, opt)

	curViewPetMos = self:_doCustomFilter(curViewPetMos)

	table.sort(curViewPetMos, function(moA, moB)
		return moA:getPetLv() > moB:getPetLv()
	end)
	table.clear(self._petInfoViewList)

	for _, petMo in ipairs(curViewPetMos) do
		local idx = tagPool[petMo:getDefineId()]
		local info = self._petInfoList[idx]

		table.insert(self._petInfoViewList, info)
	end

	self:_onUpdatePetColUI()
end

function EternalChallengePetView:onFilter(pet)
	local petCo = CharacterConfig.instance:getPetCo(pet.raceId)

	return (self:_isMatch(petCo, pet.rare, pet.curFaceId))
end

function EternalChallengePetView:_isMatch(cfg, rare, skinId)
	return PetFilterMgr.instance:checkIsMatch(PetFilterMgr.TYPE_PETVIEW, cfg, rare, skinId)
end

function EternalChallengePetView:_getPosAndSizeDelta(go)
	local rect = go.gameObject:GetComponent("RectTransform")
	local pos = go.gameObject.transform.position
	local uiCamera = CameraTargetMgr.instance:getUICameraTarget():getCamera()

	pos = uiCamera:WorldToScreenPoint(pos)

	return pos, (rect ~= nil or nil) and {
		rect.sizeDelta.x,
		rect.sizeDelta.y
	}
end

function EternalChallengePetView:_onClickFilter()
	local pos, sizeDelta = self:_getPosAndSizeDelta(self._btnFilter.gameObject)

	PetFilterMgr.instance:openFilterViewByType(self, PetFilterMgr.TYPE_PETVIEW, pos, sizeDelta, function()
		self._curSelectId = 0

		self:_refreshPetList()
	end)
end

function EternalChallengePetView:_doCustomFilter(petMoList)
	return petMoList
end

function EternalChallengePetView:_onClickBtnSure()
	if self._curSelectId <= 0 then
		FloatWordMgr.instance:show("未选中精灵")

		return
	end

	local info = self._petInfoPool[self._curSelectId]

	if info == nil then
		return
	end

	local raceId = info.raceId
	local result, tips = EternalChallengeController.instance:getTryPopUpdatePetWinResultAndTips(self._activityId, raceId)

	FloatWordMgr.instance:show(tips)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	local nextLevel = info.nextLevel
	local petMo = info.petMo
	local petName = petMo:getName()
	local costMatType, costMatId, costMatNum = 0, 0, 0
	local nextPetData = EternalChallengeConfig.instance:getEcPetData(self._activityId, raceId, nextLevel)

	if not string.nilorempty(nextPetData.cost) then
		costMatType, costMatId, costMatNum = MaterialMgr.getMatParams(nextPetData.cost)
	end

	if (costMatNum <= 0 or nil) and false then
		local matName = MaterialMgr.getMaterialsName(costMatType, costMatId)
		local creepsData = EternalChallengeConfig.instance:getEcPetCreepsData(nextPetData.creepId)
		local content = string.format("是否确认消耗[%s * %s]\n招募%s级精灵[%s]", matName, costMatNum, creepsData.lv, petName)

		local function successCallBack(state)
			return
		end

		local toggleFunc, togTxt
		local alignment = UnityEngine.TextAnchor.MiddleCenter

		local function otherCallBack(state)
			if state == TipsFacade.STATE_CANCEL then
				-- block empty
			elseif state == TipsFacade.STATE_OK then
				-- block empty
			elseif state == TipsFacade.STATE_FAIL then
				FloatWordMgr.instance:show(string.format("%s数量不足", matName))
			elseif state == TipsFacade.STATE_SUCCESS then
				EternalChallengeController.instance:sendPM_EternalChallengeBuyPetReq(self._activityId, raceId)
			end
		end

		local autoOpenSource

		TipsFacade.instance:openPopupCostMatViewNew(costMatType, costMatId, costMatNum, content, successCallBack, toggleFunc, togTxt, alignment, otherCallBack, autoOpenSource)
	else
		EternalChallengeController.instance:sendPM_EternalChallengeBuyPetReq(self._activityId, raceId)
	end
end

return EternalChallengePetView
