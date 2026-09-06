-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/treasureraider/view/TreasureraideattackView.lua

module("logic.extensions.treasureraider.view.TreasureraideattackView", package.seeall)

local TreasureraideattackView = class("TreasureraideattackView", ViewComponent)

function TreasureraideattackView:ctor()
	TreasureraideattackView.super.ctor(self)
end

function TreasureraideattackView:unbindEvents()
	TreasureraideattackView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSure)
end

function TreasureraideattackView:bindEvents()
	TreasureraideattackView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)
end

function TreasureraideattackView:buildUI()
	TreasureraideattackView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnSure = self:getGo("btnSure")
	self._txtName = self:getTxt("txtName")
	self._txtLevel = self:getTxt("txtLevel")
	self._txtPower = self:getTxt("txtPower")
	self._buildingChange = goutil.findChildComponent(self.mainGO, "building", "UIImageSpriteChange")

	local formationCell = self:getGo("enemy/cell")
	local formationTableView = self:getGo("enemy/tableview")

	self._formationList = ScrollerList.create(formationTableView, formationCell, GameUtil.handler(self._updateFormationCell, self), GameUtil.handler(self._clearFormationCell, self))

	local rewardCell = self:getGo("reward/item")
	local rewardTableView = self:getGo("reward/tableview")

	self._rewardList = ScrollerList.create(rewardTableView, rewardCell, GameUtil.handler(self._updateRewardCell, self), GameUtil.handler(self._clearRewardCell, self))
end

function TreasureraideattackView:onExit()
	TreasureraideattackView.super.onExit(self)
	self._formationList:dispose()
	self._rewardList:dispose()
	removetimer(self._invalidateReward, self)
end

function TreasureraideattackView:onEnter()
	TreasureraideattackView.super.onEnter(self)

	local params = self:getFirstParam()

	self._curGridId = params.id
	self._activityId = params.activityId
	self._curMapBuildingMo = params.buildingMo
	self._curSceneMo = params.sceneMo
	self._buildingConfig = TreasureRaiderConfig.instance:getBuildingConfig(self._curMapBuildingMo.buildingId)
	self._txtName.text = self._buildingConfig.name
	self._txtLevel.text = langPara("Lv.%s", self._curMapBuildingMo.buildingLevel)

	self._buildingChange:ChangeSprite(self._buildingConfig.viewPath)

	local formationData = self._curSceneMo:getFormationByBuildingId(self._curMapBuildingMo.buildingId)
	local formationMo = FormationMO.New(function(petId)
		return self._curSceneMo:getPetFromOwnerPetMoMap(petId)
	end)

	formationMo:SetData(formationData)

	local team, _, _ = formationMo:getTeamAndFormation()
	local power, _ = formationMo:getPowerAndSpeed()
	local teamDataList = {}

	if #team > 0 then
		for _, v in ipairs(team) do
			local data = {}

			data.mo = v

			table.insert(teamDataList, data)
		end
	else
		for i = 1, 6 do
			local data = {}

			data.mo = nil

			table.insert(teamDataList, data)
		end
	end

	self._formationList:reloadData(teamDataList)

	local itemKeyArray = {}

	if not string.nilorempty(self._buildingConfig.itemKey) then
		itemKeyArray = string.split(self._buildingConfig.itemKey, "#")
	end

	self._rewardArray = {}

	for i, v in ipairs(itemKeyArray) do
		table.insert(self._rewardArray, string.format("%s:%s", v, 1))
	end

	self:_invalidateReward()

	self._txtPower.text = langPara("战力：%s", power)

	GameUtil.SetActive(self._btnSure, params.isViewBuilding ~= true)

	if not self._curSceneMo:isMyScene() then
		settimer(1, self._invalidateReward, self)
	end
end

function TreasureraideattackView:_invalidateReward()
	self._rewardList:reloadData(self._rewardArray)
end

function TreasureraideattackView:_updateFormationCell(view, cell, data, tag)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")
	local empty = goutil.findChild(mainGo, "empty")
	local isHasPet = data.mo ~= nil

	if isHasPet then
		local proxy = MaterialMgr.setCellByMo(data.mo, item)

		if proxy then
			proxy.binder:setCallBack(function()
				CommonTipsMgr.instance:showPetTips(data.mo)
			end)
		end
	else
		MaterialMgr.resetAll(item)
	end

	GameUtil.SetActive(item, isHasPet)
	GameUtil.SetActive(empty, not isHasPet)
end

function TreasureraideattackView:_clearFormationCell(cell)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")

	MaterialMgr.resetAll(item)
end

function TreasureraideattackView:_updateRewardCell(view, cell, data, tag)
	MaterialMgr.resetAll(cell.gameObject)

	local proxy = MaterialMgr.setCellByCfg(data, cell.gameObject)

	if proxy then
		if self._curSceneMo:isMyScene() then
			local produce = self._curMapBuildingMo:getProduceCount()

			proxy:setNumStr(StringUtil.numberToString(produce))
		else
			local attackAddition = self._curSceneMo.myPlayerMo:getBuffValue(TreasureRaiderConst.BuffType_AttackPercent)
			local opMainCampLevel = self._curSceneMo.opPlayerMo.mainCampLevel
			local minProduce, maxProduce = self._curMapBuildingMo:getRobProduceRange(self._curSceneMo.isRevenge, attackAddition, opMainCampLevel)

			if minProduce == -1 or maxProduce == -1 then
				proxy:setNumStr("")
			elseif minProduce == maxProduce then
				proxy:setNumStr(string.format("%s", StringUtil.numberToString(minProduce)))
			else
				proxy:setNumStr(string.format("%s-%s", StringUtil.numberToString(minProduce), StringUtil.numberToString(maxProduce)))
			end
		end
	end
end

function TreasureraideattackView:_clearRewardCell(cell)
	MaterialMgr.resetAll(cell.gameObject)
end

function TreasureraideattackView:_onClickSure()
	local formationData = TreasureRaiderModel.instance.myPlayerMo:getAttackFormationData()

	if self._curSceneMo:isFormationEmpty(self._curMapBuildingMo.buildingId) then
		local formationMo = FormationMO.New()

		formationMo:SetData(formationData)

		local formationPb = CustomFmtController.instance:createFormPb(formationMo)

		TreasureRaiderController.instance:reqAttack(formationPb, self._curGridId)
	else
		local customFmtMo = TRAttackInsideFmtMo.New()

		customFmtMo:initParams(self._curGridId, formationData, self._curMapBuildingMo, self._curSceneMo)
		CustomFmtController.instance:showMissionView(customFmtMo)
	end

	self:close()
end

return TreasureraideattackView
