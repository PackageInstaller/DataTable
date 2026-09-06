-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cutepet/view/adventure/CutePetAdventureBuildingView.lua

module("logic.extensions.cutepet.view.CutePetAdventureBuildingView", package.seeall)

local CutePetAdventureBuildingView = class("CutePetAdventureBuildingView", ViewComponent)

function CutePetAdventureBuildingView:ctor()
	CutePetAdventureBuildingView.super.ctor(self)
end

function CutePetAdventureBuildingView:unbindEvents()
	CutePetAdventureBuildingView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnLevelUp)
	GameUtil.rmClickHandler(self._btnWorkPet)
	GameUtil.rmClickHandler(self._btnRule)
	GameUtil.rmClickHandler(self._btnFillter)
	GameUtil.rmClickHandler(self._btnHide)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSure)
	self._customInput:RemoveListener()
end

function CutePetAdventureBuildingView:bindEvents()
	CutePetAdventureBuildingView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnLevelUp, self._onClickLevelUp, self)
	GameUtil.addClickHandler(self._btnWorkPet, self._onClickWorkPet, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)
	GameUtil.addClickHandler(self._btnRule, self._onClickRule, self)
	GameUtil.addClickHandler(self._btnFillter, self._onClickFillter, self)
	GameUtil.addClickHandler(self._btnHide, self._onClickHide, self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	self._customInput:AddListener(self._onCustomInputCallback, self)
end

function CutePetAdventureBuildingView:buildUI()
	CutePetAdventureBuildingView.super.buildUI(self)

	self._txtName = self:getTxt("info/txtName")
	self._txtLevel = self:getTxt("info/txtLevel")
	self._txtMaxCount = self:getTxt("info/txtMaxCount/txtNum")
	self._txtBasicOutPut = self:getTxt("info/txtBasicOutPut/txtNum")
	self._txtAdventureRate = self:getTxt("info/txtAdventureRate/txtNum")
	self._txtOutPutTitle = self:getTxt("info/txtOutPut")
	self._txtOutPut = self:getTxt("info/txtOutPutNum")
	self._outPutCon = self:getGo("info/txtOutPut/icon")
	self._costInfo = self:getGo("info/cost")
	self._txtMgrLevel = self:getTxt("info/cost/txtNeedLevel")
	self._txtCost = self:getTxt("info/cost/txtCost")
	self._iconCost = self:getGo("info/cost/iconCost")
	self._btnLevelUp = self:getGo("btnLevelUp")
	self._btnSure = self:getGo("petSelect/btnSure")
	self._btnClose = self:getGo("static/btnClose")
	self._btnRule = self:getGo("static/btnTip")
	self._petSelect = self:getGo("petSelect")
	self._tableView = self:getGo("petSelect/tableview")
	self._tableCell = self:getGo("tablecell")
	self._btnFillter = self:getGo("petSelect/btnFillter")
	self._btnHide = self:getGo("petSelect/btnHide")
	self._btnWorkPet = self:getGo("workPet")
	self._customInput = UICustomInput.Get(self._petSelect)
	self._petInfo = self:getGo("pet/info")
	self._petName = self:getTxt("pet/info/txtName")
	self._petLevel = self:getTxt("pet/info/txtLevel")
	self._petQuality = goutil.findChildComponent(self.mainGO, "pet/info/imgQuality", "UIImageSpriteChange")
	self._petType = goutil.findChildComponent(self.mainGO, "pet/info/imgType", "UIImageSpriteChange")
	self._petCon = self:getGo("pet/petcon")
	self._redPoint = self:getGo("workPet/redpoint")
	self._goldBarCon = self:getGo("goldBarCon")
	self._bg = self:getGo("static/bg")
end

function CutePetAdventureBuildingView:onExit()
	CutePetAdventureBuildingView.super.onExit(self)
	uGuiUtil.clearImage(self._bg)
	CutePetModelMgr.instance:popViewWithModel(self._viewPresentor.viewName)
	CutePetFilterMgr.instance:resetDataByType(self._filterType)
end

function CutePetAdventureBuildingView:onEnter()
	CutePetAdventureBuildingView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.handlePM_LvlUpAdventureBuildingResp, self._refreshView, self)
	self.addGEvent(self, GlobalNotify.handlePM_TakeBackCutePetFromAdventureBuildingResp, self._PM_TakeBackCutePetFromAdventureBuildingResp, self)
	self.addGEvent(self, GlobalNotify.handlePM_PutCutePet2AdventureBuildingResp, self._refreshView, self)

	self._filterType = CutePetFilterMgr.TYPE_TRAVEL

	CutePetModelMgr.instance:pushViewWithModel(self._petCon, self._viewPresentor.viewName, 1, 1, 180)

	self._buildingId = self:getFirstParam()

	GameUtil.SetActive(self._petSelect, false)
	GameUtil.SetActive(self._tableView, false)
	GameUtil.SetActive(self._btnSure, false)

	self._petAllList = CutePetModel.instance:getAllCutePetsList()
	self._petList = ScrollerList.create(self._tableView, self._tableCell, GameUtil.handler(self._updatePetCell, self), GameUtil.handler(self._clearPetCell, self))
	self._exchangeId = 0

	self:_refreshView()
end

function CutePetAdventureBuildingView:_refreshView()
	self._canInAdv = false

	for k, v in pairs(CutePetModel.instance:getAllCutePet() or {}) do
		if v:getState(CutePetMo.STATE_IN_ADVENTURE) == false then
			self._canInAdv = true

			break
		end
	end

	self._buildingInfo = CutePetModel.instance:getAdvBuildingInfo(self._buildingId)
	self._txtName.text = self._buildingInfo.cfg.name
	self._txtLevel.text = langPara("Lv.%d", self._buildingInfo.buildingLvl)

	local opMatType, opMatId, opNum = MaterialMgr.getMatParams(self._buildingInfo.cfg.unitTimeOutputResource)

	self:_setTopGoldBar(string.format("%d:%d", opMatType, opMatId))

	self._txtMaxCount.text = self._buildingInfo.cfg.buildCapacityFen * opNum
	self._txtBasicOutPut.text = langPara("%.0f /小时", opNum * (3600 / self._buildingInfo.cfg.outputUnitSecd))

	local adventureRate = 0

	if self._buildingInfo.cutePetId > 0 then
		local petMo = CutePetModel.instance:getCutePeMo(self._buildingInfo.cutePetId)
		local lvCfg = CutePetConfig.instance:getLevelUpCfg(petMo.config.lvlUpPlan, petMo.curLvl)

		adventureRate = lvCfg.adventureRate
		self._petName.text = petMo.name
		self._petLevel.text = petMo.curLvl

		self._petQuality:SetState(petMo.curQuality - 1)
		self._petType:SetState(petMo.config.type - 1)
		CutePetModelMgr.instance:resetModel(1, petMo.config.modelId)
		CutePetModelMgr.instance:setOffset(1, CutePetConfig.instance:getPetOffsetInDefaultView(petMo.config.raceId))
		CutePetModelMgr.instance:isShowAvatarPet(1, true)
		GameUtil.SetActive(self._petInfo, true)
		GameUtil.SetActive(self._redPoint, false)
	else
		GameUtil.SetActive(self._petInfo, false)
		GameUtil.SetActive(self._redPoint, self._canInAdv)
		CutePetModelMgr.instance:isShowAvatarPet(1, false)
	end

	self._txtAdventureRate.text = string.format("%.0f%%", adventureRate * 100)
	self._txtOutPutTitle.text = langPara("%s产量：", MaterialMgr.getMaterialsName(opMatType, opMatId))

	local outPutNum = math.ceil(opNum * adventureRate) * (3600 / self._buildingInfo.cfg.outputUnitSecd)

	self._txtOutPut.text = langPara("+%.0f /小时", outPutNum)

	local nextBuildingCfg = CutePetConfig.instance:getAdventureBuildingCfg(self._buildingInfo.buildingId, self._buildingInfo.buildingLvl + 1)

	if nextBuildingCfg then
		GameUtil.SetActive(self._costInfo, true)
		GameUtil.SetActive(self._btnLevelUp, true)

		self._txtMgrLevel.text = langPara("%d/%d", CutePetModel.instance:getBuildingLevel(CutePetBuildingType.Management), nextBuildingCfg.gardenMinLvlLimit)

		local costMatType, costMatId, costNum = MaterialMgr.getMatParams(nextBuildingCfg.lvlUpCost)

		self._txtCost.text = langPara("%d/%d", MaterialModel.instance:getMaterialsNumber(costMatType, costMatId), costNum)

		local proxy = MaterialMgr.setCellByCfg(nextBuildingCfg.lvlUpCost, self._iconCost)

		if proxy then
			proxy.binder:setNum(0)
		end
	else
		GameUtil.SetActive(self._btnLevelUp, false)
		GameUtil.SetActive(self._costInfo, false)
		MaterialMgr.resetAll(self._iconCost)
	end

	uGuiUtil.clearImage(self._bg)

	if not string.nilorempty(self._buildingInfo.cfg.bgRes) then
		uGuiUtil.setSpriteToImage(self._bg, uGuiUtil.SpriteType.BigBg, GameUrl.getBigbgPngUrl(self._buildingInfo.cfg.bgRes))
	else
		uGuiUtil.setSpriteToImage(self._bg, uGuiUtil.SpriteType.BigBg, GameUrl.getBigbgPngUrl("views/mengcongyuan/bg_mengchongyuan_05"))
	end
end

function CutePetAdventureBuildingView:_refreshPetList()
	local selectMap = {}

	for i, v in pairs(CutePetModel.instance:getAdvAllBuildingInfo()) do
		selectMap[v.cutePetId] = v.buildingId
	end

	local resultList = {}

	for i, v in ipairs(self._petAllList) do
		local lvCfg = CutePetConfig.instance:getLevelUpCfg(v.config.lvlUpPlan, v.curLvl)

		if CutePetFilterMgr.instance:checkIsMatch(self._filterType, v.cfg, v.id) == true then
			table.insert(resultList, {
				mo = v,
				rate = lvCfg.adventureRate,
				canSelect = v.id == self._buildingInfo.cutePetId and 0 or checknumber(selectMap[v.id])
			})
		end
	end

	table.sort(resultList, function(a, b)
		if checknumber(selectMap[a.mo.id]) ~= checknumber(selectMap[b.mo.id]) then
			return checknumber(selectMap[a.mo.id]) < checknumber(selectMap[b.mo.id])
		end

		if a.rate ~= b.rate then
			return a.rate > b.rate
		end

		return a.mo.id < b.mo.id
	end)

	self._selectId = self._buildingInfo.cutePetId

	self._petList:reloadData(resultList)
end

function CutePetAdventureBuildingView:_updatePetCell(view, cell, data, tag)
	local go = cell.gameObject
	local con = goutil.findChild(go, "con")
	local imgSelect = goutil.findChild(go, "imgSelect")
	local txtRate = goutil.findChildTextComponent(go, "txtRate")
	local txtName = goutil.findChildTextComponent(go, "txtName")
	local txtLv = goutil.findChildTextComponent(go, "txtLv")
	local btnClick = goutil.findChild(go, "btnClick")
	local readyGo = goutil.findChild(go, "imgReady")
	local advGo = goutil.findChild(go, "adv")
	local txtAdv = goutil.findChildTextComponent(go, "adv/txt")
	local mo = data.mo
	local proxy = MaterialMgr.setCellByMo(mo, con)

	if proxy then
		proxy.binder:setAutoTips(false)
	end

	GameUtil.SetActive(imgSelect, mo.id == self._selectId)

	txtRate.text = langPara("%.1f%%", data.rate * 100)
	txtName.text = mo.name
	txtLv.text = langPara("Lv.%d", mo.curLvl)

	local maxStar = CutePetConfig.instance:getMaxStar(mo.config.starUpPlan, mo.curQuality)

	for i = 1, 6 do
		local star = goutil.findChild(go, "starLv/star_" .. i)
		local starChange = goutil.findChildComponent(go, "starLv/star_" .. i, "UIImageSpriteChange")

		GameUtil.SetActive(star, i <= maxStar)

		if i <= mo.curStar then
			starChange:SetState(0)
		else
			starChange:SetState(1)
		end
	end

	GameUtil.addClickHandler(btnClick, function()
		self:_onClickPet(mo.id)
	end, self)
	GameUtil.SetActive(readyGo, mo.id == self._buildingInfo.cutePetId)
	GameUtil.SetActive(advGo, data.canSelect > 0)

	if data.canSelect > 0 then
		local buildingCfg = CutePetConfig.instance:getAdventureBuildingCfg(data.canSelect, 1)

		txtAdv.text = langPara("%s冒险中", buildingCfg.name)
	end
end

function CutePetAdventureBuildingView:_clearPetCell(cell)
	local go = cell.gameObject
	local con = goutil.findChild(go, "con")
	local btnClick = goutil.findChild(go, "btnClick")

	GameUtil.rmClickHandler(btnClick)
end

function CutePetAdventureBuildingView:_setTopGoldBar(str)
	local btn_list = {}

	table.insert(btn_list, {
		showAdd = false,
		id = str
	})
	MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, btn_list, false)
end

function CutePetAdventureBuildingView:_onClickPet(petId)
	self._selectId = petId

	self._petList:refresh()
end

function CutePetAdventureBuildingView:_onClickLevelUp()
	local nextBuildingCfg = CutePetConfig.instance:getAdventureBuildingCfg(self._buildingInfo.buildingId, self._buildingInfo.buildingLvl + 1)

	if nextBuildingCfg then
		if CutePetModel.instance:getBuildingLevel(CutePetBuildingType.Management) < nextBuildingCfg.gardenMinLvlLimit then
			FloatWordMgr.instance:show(lang("宠物园等级不足"))

			return
		end

		local costMatType, costMatId, costNum = MaterialMgr.getMatParams(nextBuildingCfg.lvlUpCost)

		if MaterialModel.instance:IsEnough(costMatType, costMatId, costNum) == false then
			FloatWordMgr.instance:show(lang("所需材料不足"))

			return
		end

		CutePetGardenAgent.instance:sendPM_LvlUpAdventureBuildingReq(self._buildingInfo.buildingId)
	end
end

function CutePetAdventureBuildingView:_onClickWorkPet()
	GameUtil.SetActive(self._petSelect, true)
	GameUtil.SetActive(self._tableView, true)
	GameUtil.SetActive(self._btnSure, true)
	self:_refreshPetList()
end

function CutePetAdventureBuildingView:_onClickSure()
	if checknumber(self._selectId) <= 0 then
		FloatWordMgr.instance:show(lang("请选择一只宠物"))

		return
	end

	if self._selectId == self._buildingInfo.cutePetId then
		TipsFacade.instance:openPopupWindow(lang("提示"), lang("收回宠物后，资源点将停止产出"), function()
			GameUtil.SetActive(self._petSelect, false)
			GameUtil.SetActive(self._tableView, false)
			GameUtil.SetActive(self._btnSure, false)
			CutePetController.instance:sendPM_TakeBackCutePetFromAdventureBuildingReq(self._buildingInfo.buildingId)
		end)
	else
		local isRaplace = false
		local allBuildingInfo = CutePetModel.instance:getAdvAllBuildingInfo()

		for buildingId, v in pairs(allBuildingInfo) do
			if v.cutePetId == self._selectId then
				local buildingCfg = CutePetConfig.instance:getAdventureBuildingCfg(buildingId, 1)
				local mo = CutePetModel.instance:getCutePeMo(self._selectId)
				local lvCfg = CutePetConfig.instance:getLevelUpCfg(mo.config.lvlUpPlan, mo.curLvl)
				local content = langPara("是否将%s资源点的%s替换到%s", buildingCfg.name, mo.name, self._buildingInfo.cfg.name)
				local content2 = langPara("%s加成效率：", buildingCfg.name)
				local curRateText = self._txtAdventureRate.text
				local changeRateText = langPara("%.0f%%", lvCfg.adventureRate * 100)

				function sureHander(buildingId, cutePetId)
					GameUtil.SetActive(self._petSelect, false)
					GameUtil.SetActive(self._tableView, false)
					GameUtil.SetActive(self._btnSure, false)
					CutePetController.instance:sendPM_PutCutePet2AdventureBuildingReq(self._buildingInfo.buildingId, self._selectId)
				end

				local info = {
					content = content,
					oldValue = curRateText,
					newValue = changeRateText,
					sureCallBack = GameUtil.handler(sureHander, self._buildingId, mo.id),
					content2 = content2
				}

				UIStateManager.instance:push(ViewName.CutePetAdvExchangeView, info)

				isRaplace = true

				break
			end
		end

		if not isRaplace then
			GameUtil.SetActive(self._petSelect, false)
			GameUtil.SetActive(self._tableView, false)
			GameUtil.SetActive(self._btnSure, false)
			CutePetController.instance:sendPM_PutCutePet2AdventureBuildingReq(self._buildingInfo.buildingId, self._selectId)
		end
	end
end

function CutePetAdventureBuildingView:_onClickRule()
	UIStateManager.instance:open(ViewName.RulesView, "cute_pet_adv_building_rule")
end

function CutePetAdventureBuildingView:_onClickFillter()
	local pos, sizeDelta = GameUtil.getPosAndSizeDelta(self._btnFillter)

	CutePetFilterMgr.instance:openFilterViewByType(self._viewPresentor, self._filterType, pos, sizeDelta, GameUtil.handler(self._refreshPetList, self))
end

function CutePetAdventureBuildingView:_onClickHide()
	GameUtil.SetActive(self._petSelect, false)
	GameUtil.SetActive(self._tableView, false)
	GameUtil.SetActive(self._btnSure, false)
end

function CutePetAdventureBuildingView:_onCustomInputCallback(hover)
	if not hover then
		-- block empty
	end
end

function CutePetAdventureBuildingView:_PM_TakeBackCutePetFromAdventureBuildingResp()
	if checknumber(self._exchangeId) > 0 then
		CutePetController.instance:sendPM_PutCutePet2AdventureBuildingReq(self._buildingInfo.buildingId, self._exchangeId)

		self._exchangeId = 0
	else
		self:_refreshView()
	end
end

return CutePetAdventureBuildingView
