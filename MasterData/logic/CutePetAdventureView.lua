-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cutepet/view/adventure/CutePetAdventureView.lua

module("logic.extensions.cutepet.view.CutePetAdventureView", package.seeall)

local CutePetAdventureView = class("CutePetAdventureView", ViewComponent)

function CutePetAdventureView:ctor()
	CutePetAdventureView.super.ctor(self)
end

function CutePetAdventureView:unbindEvents()
	CutePetAdventureView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTips)
	GameUtil.rmClickHandler(self._btnOneKey)
end

function CutePetAdventureView:bindEvents()
	CutePetAdventureView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnTips, self._onClickTips, self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnOneKey, self._onClickOneKey, self)
end

function CutePetAdventureView:buildUI()
	CutePetAdventureView.super.buildUI(self)

	self._btnClose = self:getGo("static/btnClose")
	self._btnTips = self:getGo("static/btnTip")
	self._btnOneKey = self:getGo("btnOneKey")
	self._redPointOneKey = self:getGo("btnOneKey/redpoint")
	self._buildingRoot = self:getGo("building")
	self._recordPos = self._buildingRoot:GetComponent("TestRecordPos")
	self._buildingCell = self:getGo("building/buildingCell_1")
	self._bulidingListGo = {}

	for i = 1, self._buildingRoot.transform.childCount do
		table.insert(self._bulidingListGo, self:getGo("building/buildingCell_" .. i))
	end

	self._resTable = self:getGo("tableview")
	self._resCell = self:getGo("tablecell")
	self._timeTip = self:getGo("timeTip")
	self._txtTipTime = self:getTxt("timeTip/txtTipTime")
end

function CutePetAdventureView:onExit()
	CutePetAdventureView.super.onExit(self)
	RedPointController.instance:unregRedPoint(self._redPointOneKey)
	removetimer(self._onClockTime, self)
	removetimer(self._updateTimeTip, self)
end

function CutePetAdventureView:onEnter()
	CutePetAdventureView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.handlePM_LoadAdventureBuildingInfoResp, self._refreshView, self)
	self.addGEvent(self, GlobalNotify.handlePM_GainSingleBuildingOutputResResp, self._refreshView, self)
	self.addGEvent(self, GlobalNotify.handlePM_GainAllBuildingOutputResResp, self._refreshView, self)
	self.addGEvent(self, GlobalNotify.handlePM_TakeBackCutePetFromAdventureBuildingResp, self._refreshView, self)
	self.addGEvent(self, GlobalNotify.handlePM_PutCutePet2AdventureBuildingResp, self._refreshView, self)

	if FuncOpenController.instance:checkFuncIdOrShowLockTips(910) == false then
		self:close()

		return
	end

	settimer(1, self._onClockTime, self)

	self._buildingCount = #(CutePetConfig.instance:getAllAdventureBuilding() or {})

	if self._buildingCount <= 0 then
		FloatWordMgr.instance:show(lang("建筑不足"))
		self:close()
	end

	CutePetController:sendPM_LoadAdventureBuildingInfoReq(self._buildingCount)

	self._resTableList = ScrollerList.create(self._resTable, self._resCell, GameUtil.handler(self._updateResCell, self), GameUtil.handler(self._clearResCell, self))

	self:_updateTimeTip()
	settimer(10, self._updateTimeTip, self)
	RedPointController.instance:regRedPoint(self._redPointOneKey, RedPointModel.ID_CUTEPET_ADVENTURE_ONEKEY)
end

function CutePetAdventureView:_refreshView()
	self._canInAdv = false

	for k, v in pairs(CutePetModel.instance:getAllCutePet() or {}) do
		if v:getState(CutePetMo.STATE_IN_ADVENTURE) == false then
			self._canInAdv = true

			break
		end
	end

	self._buildingInfo = CutePetModel.instance:getAdvAllBuildingInfo()

	for i = 1, #self._bulidingListGo do
		if self._buildingInfo[i] then
			self:_updateBuilding(self._bulidingListGo[i], self._buildingInfo[i], i)
		end
	end

	local outPutMap = {}

	for i, v in ipairs(self._buildingInfo) do
		if v.buildingLvl > 0 and v.cutePetId > 0 then
			local buildingCfg = CutePetConfig.instance:getAdventureBuildingCfg(v.buildingId, v.buildingLvl)
			local matType, matId, num = MaterialMgr.getMatParams(buildingCfg.unitTimeOutputResource)
			local petMo = CutePetModel.instance:getCutePeMo(v.cutePetId)
			local levelCfg = CutePetConfig.instance:getLevelUpCfg(petMo.config.lvlUpPlan, petMo.curLvl)
			local resultNum = math.ceil(num * levelCfg.adventureRate)
			local str = string.format("%d:%d", matType, matId)

			outPutMap[str] = 3600 / buildingCfg.outputUnitSecd * resultNum + checknumber(outPutMap[str])
		else
			local buildingCfg = CutePetConfig.instance:getAdventureBuildingCfg(v.buildingId, 1)
			local matType, matId, num = MaterialMgr.getMatParams(buildingCfg.unitTimeOutputResource)
			local resultNum = 0
			local str = string.format("%d:%d", matType, matId)

			outPutMap[str] = resultNum + checknumber(outPutMap[str])
		end
	end

	local outPutList = {}

	for i, v in pairs(outPutMap) do
		table.insert(outPutList, {
			str = i,
			num = v
		})
	end

	self._resTableList:reloadData(outPutList)
end

function CutePetAdventureView:_updateBuilding(item, data, i)
	local go = item
	local buildingIcon = goutil.findChild(go, "img")
	local lock = goutil.findChild(go, "lock")
	local txtLockDesc = goutil.findChildTextComponent(go, "lock/txtDesc")
	local btnGetPrize = goutil.findChild(go, "getPrize")
	local prizeIcon = goutil.findChild(go, "getPrize/prizeIcon")
	local txtBuildingName = goutil.findChildTextComponent(go, "node/txtName")
	local slider = Framework.SliderAdapter:GetFrom("getPrize/progress")
	local sliderBg = Framework.SliderAdapter:GetFrom("getPrize/progressBg")
	local empty = goutil.findChild(go, "getPrize/imgEmpty")
	local redPoint = goutil.findChild(go, "redpoint")
	local storeMax = goutil.findChild(go, "storeMax")
	local storeNum = goutil.findChild(go, "storeNum")
	local txtStoreNum = goutil.findChildTextComponent(go, "storeNum/txt")
	local cfg = CutePetConfig.instance:getAdventureBuildingCfg(data.buildingId, data.buildingLvl)

	GameUtil.SetActive(redPoint, false)
	GameUtil.SetActive(storeNum, false)
	GameUtil.SetActive(storeMax, false)

	if data.buildingLvl <= 0 then
		cfg = CutePetConfig.instance:getAdventureBuildingCfg(data.buildingId, 1)

		GameUtil.SetActive(lock, true)
		GameUtil.SetActive(empty, true)
		GameUtil.SetActive(prizeIcon, false)
		GameUtil.SetActive(slider, false)
		GameUtil.SetActive(sliderBg, false)

		txtLockDesc.text = langPara("萌宠园%d级解锁", cfg.gardenMinLvlLimit)
	else
		GameUtil.SetActive(lock, false)

		if checknumber(data.cutePetId) > 0 then
			GameUtil.SetActive(empty, false)
			GameUtil.SetActive(prizeIcon, true)
			GameUtil.SetActive(slider, true)
			GameUtil.SetActive(sliderBg, true)

			local matType, cfgId, num = MaterialMgr.getMatParams(cfg.unitTimeOutputResource)

			slider:SetValue(data.stashNum / (cfg.buildCapacityFen * num))
			GameUtil.SetActive(storeNum, true)

			txtStoreNum.text = string.format("%d/%d", data.stashNum, cfg.buildCapacityFen * num)

			GameUtil.SetActive(storeMax, data.stashNum >= cfg.buildCapacityFen * num)

			if data.stashNum > 0 then
				sliderBg:SetValue(data.stashNum / (cfg.buildCapacityFen * num) + 0.02)
			else
				sliderBg:SetValue(data.stashNum / (cfg.buildCapacityFen * num))
			end

			MaterialMgr.setIcon(prizeIcon, matType, cfgId)
		else
			GameUtil.SetActive(empty, true)
			GameUtil.SetActive(prizeIcon, false)
			GameUtil.SetActive(slider, false)
			GameUtil.SetActive(sliderBg, false)
			GameUtil.SetActive(redPoint, self._canInAdv)
		end
	end

	txtBuildingName.text = cfg.name

	GameUtil.addClickHandler(btnGetPrize, function()
		if self._buildingInfo[data.buildingId].stashNum > 0 then
			CutePetGardenAgent.instance:sendPM_GainSingleBuildingOutputRespReq(data.buildingId)
		elseif data.buildingLvl <= 0 then
			FloatWordMgr.instance:show(langPara("萌宠园%d级解锁", cfg.gardenMinLvlLimit))
		else
			UIStateManager.instance:push(ViewName.CutePetAdventureBuildingView, data.buildingId)
		end
	end, self)
	GameUtil.addClickHandler(buildingIcon, function()
		if data.buildingLvl <= 0 then
			FloatWordMgr.instance:show(langPara("萌宠园%d级解锁", cfg.gardenMinLvlLimit))
		else
			UIStateManager.instance:push(ViewName.CutePetAdventureBuildingView, data.buildingId)
		end
	end, self)
end

function CutePetAdventureView:_clearBuilding(item)
	local go = item.mainGO
	local prizeIcon = goutil.findChild(go, "getPrize/prizeIcon")
	local btnGetPrize = goutil.findChild(go, "getPrize")

	MaterialMgr.resetAll(go)
	GameUtil.rmClickHandler(btnGetPrize)
end

function CutePetAdventureView:_updateResCell(view, cell, data, tag)
	local go = cell.gameObject
	local icon = goutil.findChild(go, "icon")
	local txtNum = goutil.findChildTextComponent(go, "txtNum")
	local matType, matId, _ = MaterialMgr.getMatParams(data.str)

	MaterialMgr.setIcon(icon, matType, matId)

	txtNum.text = langPara("+%.0f /时", data.num)
end

function CutePetAdventureView:_clearResCell(cell)
	local go = cell.gameObject
	local icon = goutil.findChild(go, "icon")

	MaterialMgr.resetAll(icon)
end

function CutePetAdventureView:_onClockTime()
	for i, v in ipairs(self._buildingInfo or {}) do
		if ServerTime.now() - v.balanceTime >= v.cfg.outputUnitSecd and v.cutePetId > 0 then
			local petMo = CutePetModel.instance:getCutePeMo(v.cutePetId)
			local levelCfg = CutePetConfig.instance:getLevelUpCfg(petMo.config.lvlUpPlan, petMo.curLvl)
			local matType, matId, num = MaterialMgr.getMatParams(v.cfg.unitTimeOutputResource)

			v.balanceTime = ServerTime.now()
			v.stashNum = math.min(buildCapacityFen, v.stashNum + math.ceil(num * levelCfg.adventureRate))

			self:_refreshView()
		end
	end
end

function CutePetAdventureView:_onClickOneKey()
	local canGet = false

	for i, v in ipairs(self._buildingInfo) do
		if checknumber(v.stashNum) > 0 then
			canGet = true

			break
		end
	end

	if canGet == true then
		CutePetGardenAgent.instance:sendPM_GainAllBuildingOutputResReq()
	else
		FloatWordMgr.instance:show(lang("无可领取资源"))
	end
end

function CutePetAdventureView:_onClickTips()
	UIStateManager.instance:open(ViewName.RulesView, "cute_pet_adv_rule")
end

function CutePetAdventureView:_updateTimeTip()
	local isInTime, txtTime = CutePetController.instance:updateTimeTip(CutePetConfig.instance:getPrivilegeCommonValue("PrivilegeTimePlan_AdventureBuildingResMultiply", false))

	goutil.setActive(self._timeTip, isInTime)

	self._txtTipTime.text = txtTime
end

return CutePetAdventureView
