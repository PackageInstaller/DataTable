-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/origininfinitefutureclg/view/OriginInfiniteFutureClgLevelView.lua

module("logic.extensions.origininfinitefutureclg.view.OriginInfiniteFutureClgLevelView", package.seeall)

local OriginInfiniteFutureClgLevelView = class("OriginInfiniteFutureClgLevelView", ViewComponent)

function OriginInfiniteFutureClgLevelView:ctor()
	OriginInfiniteFutureClgLevelView.super.ctor(self)

	self._powerPetMo = FightingPowerPetMo.New()
end

function OriginInfiniteFutureClgLevelView:unbindEvents()
	OriginInfiniteFutureClgLevelView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnChallenge)

	for _, stageGo in ipairs(self._stageCells or {}) do
		GameUtil.rmClickHandler(stageGo)
	end
end

function OriginInfiniteFutureClgLevelView:bindEvents()
	OriginInfiniteFutureClgLevelView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnChallenge, self._onClickBtnChallenge, self)
end

function OriginInfiniteFutureClgLevelView:buildUI()
	OriginInfiniteFutureClgLevelView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/txtTitle/btnTip")
	self._itemCellsGo = self:getGo("itemCells")
	self._itemcellGo = self:getGo("itemcell")

	GameUtil.SetActive(self._itemcellGo, false)

	self._stageCells = {}
	self._stageFmt = self:getGo("right/stageFmt/fmt")
	self._stageFmtPass = self:getGo("right/stageFmt/pass")
	self._txtTotalMove = self:getTxt("right/txtTotalMove")
	self._btnChallenge = self:getGo("right/btnChallenge")
	self._txtChallenge = self:getTxt("right/btnChallenge/txtChallenge")
	self._emptyPet = self:getGo("right/emptyPet")
	self._tableviewBan = self:getGo("right/tableviewBan")
	self._tablecellBan = self:getGo("right/tableviewBan/tablecellBan")
	self._scrollListBan = ScrollerList.create(self._tableviewBan, self._tablecellBan, GameUtil.handler(self._updateBanCell, self), GameUtil.handler(self._clearBanCell, self))
	self._tableviewAttr = self:getGo("right/attr/tableview")
	self._tablecellAttr = self:getGo("right/attr/tableview/tablecell")
	self._scrollListAttr = ScrollerList.create(self._tableviewAttr, self._tablecellAttr, GameUtil.handler(self._updateAttrCell, self), GameUtil.handler(self._clearAttrCell, self))
end

function OriginInfiniteFutureClgLevelView:onExit()
	OriginInfiniteFutureClgLevelView.super.onExit(self)
	self._scrollListBan:dispose()
	self._scrollListAttr:dispose()
	self:_clearStageCells()
	self:_clearFmt(self._stageFmt)
end

function OriginInfiniteFutureClgLevelView:onEnter()
	OriginInfiniteFutureClgLevelView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_OriginInfiniteFutureClgGetInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.PM_OriginInfiniteFutureClgResetRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.PM_OriginInfiniteFutureClgNotifyFightRes, self._onUpdate, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = 619001
	end

	self._actCfg = OriginInfiniteFutureClgConfig.instance:getActivityCfg(self._activityId) or {}
	self._stageCfgs = OriginInfiniteFutureClgConfig.instance:getStageCfgs(self._activityId) or {}
	self._curSelectIdx = OriginInfiniteFutureClgModel.instance:getSelectStage(self._activityId)

	if self._curSelectIdx <= 0 then
		self._curSelectIdx = 1
	end

	self:_onSetUI()
	OriginInfiniteFutureClgController.instance:sendPM_OriginInfiniteFutureClgGetInfoReq(self._activityId)
end

function OriginInfiniteFutureClgLevelView:_onSetUI()
	self:_updateStageCells()
end

function OriginInfiniteFutureClgLevelView:_onUpdate()
	self._info = OriginInfiniteFutureClgModel.instance:getInfo(self._activityId)
	self._stageInfoMap = OriginInfiniteFutureClgModel.instance:getStageInfoMap(self._activityId) or {}

	self:_updateStageCells()
	self:_updateRight()

	local changeSetId = OriginInfiniteFutureClgModel.instance:popChangeSetId(self._activityId)

	if checknumber(changeSetId) > 0 then
		MaterialController.instance:showChangeSetInTemp(changeSetId)
	end
end

function OriginInfiniteFutureClgLevelView:_updateStageCells()
	for index, stageCfg in ipairs(self._stageCfgs) do
		local stageGo = self._stageCells[index]

		if not stageGo then
			stageGo = goutil.cloneAndSetParent(self._itemcellGo, self._itemCellsGo.transform)

			table.insert(self._stageCells, stageGo)
		end

		GameUtil.SetActive(stageGo, true)
		self:_updateStageCell(stageGo, stageCfg)
	end

	for index = #self._stageCfgs + 1, #self._stageCells do
		local stageGo = self._stageCells[index]

		self:_clearStageCell(stageGo)
		GameUtil.SetActive(stageGo, false)
	end
end

function OriginInfiniteFutureClgLevelView:_updateStageCell(stageGo, stageCfg)
	local imgHead = goutil.findChild(stageGo, "head/imgHead")
	local txtDesc = goutil.findChildTextComponent(stageGo, "txtDesc")
	local imgSelect = goutil.findChild(stageGo, "imgSelect")
	local pass = goutil.findChild(stageGo, "pass")
	local stageId = checknumber(stageCfg.stageId)
	local totalValue = OriginInfiniteFutureClgController.instance:getStageTotalValueWanPercent(self._activityId, stageId)
	local targetPercent = self:_getPercentText(stageCfg.passValuePercent)
	local curTotalPercent = self:_getPercentText(totalValue)
	local stageHasPass = OriginInfiniteFutureClgController.instance:stageHasPass(self._activityId, stageId)
	local firstCreepCfg = self:_getFirstCreepCfg(stageCfg.creepsMasterId)
	local skinId = self:_getCreepSkinId(firstCreepCfg)

	if not stageCfg.pos then
		local pos = {}

		txtDesc.text = langPara("%s%%/%s%%", curTotalPercent, targetPercent)

		GameUtil.SetActive(imgSelect, self._curSelectIdx == stageId)
		GameUtil.SetActive(pass, stageHasPass)
		MaterialMgr.clearIcon(imgHead)

		if skinId > 0 then
			MaterialMgr.setIcon(imgHead, MatType.PET_SKIN, skinId)
		end

		GameUtil.setAnchoredPos(stageGo, checknumber(pos[1]), checknumber(pos[2]))
		GameUtil.addClickHandler(stageGo, function()
			self._curSelectIdx = stageId

			self:_updateStageCells()
			self:_updateRight()
		end, self)
	end
end

function OriginInfiniteFutureClgLevelView:_clearStageCell(stageGo)
	local imgHead = goutil.findChild(stageGo, "head/imgHead")

	GameUtil.rmClickHandler(stageGo)
	MaterialMgr.clearIcon(imgHead)
end

function OriginInfiniteFutureClgLevelView:_clearStageCells()
	for _, stageGo in ipairs(self._stageCells or {}) do
		self:_clearStageCell(stageGo)
	end
end

function OriginInfiniteFutureClgLevelView:_updateRight()
	local stageCfg = OriginInfiniteFutureClgConfig.instance:getStageCfgById(self._activityId, self._curSelectIdx) or {}
	local creepsCfg = OriginInfiniteFutureClgConfig.instance:getCreepsCfg(stageCfg.creepsMasterId) or {}
	local stageHasPass = OriginInfiniteFutureClgController.instance:stageHasPass(self._activityId, self._curSelectIdx)
	local totalValue = OriginInfiniteFutureClgController.instance:getStageTotalValueWanPercent(self._activityId, self._curSelectIdx)
	local targetPercent = self:_getPercentText(stageCfg.passValuePercent)
	local totalPercent = self:_getPercentText(totalValue)

	self._txtTotalMove.text = langPara("共振率：%s%%/%s%%", totalPercent, targetPercent)
	self._txtChallenge.text = stageHasPass and lang("重置本关") or lang("进入挑战")

	GameUtil.SetActive(self._stageFmtPass, stageHasPass)
	self:_setFmt(self._stageFmt, creepsCfg)

	local banRaceIds = self:_getBanRaceIdList()

	GameUtil.SetActive(self._emptyPet, #banRaceIds <= 0)
	self._scrollListBan:setCenterMode(true)
	self._scrollListBan:reloadData(banRaceIds)
	self._scrollListAttr:reloadData(self:_buildAttrList(stageCfg, totalValue, stageHasPass))
end

function OriginInfiniteFutureClgLevelView:_setFmt(fmtView, cfg)
	local map = {}

	for _, data in ipairs(checktable(cfg)) do
		map[checknumber(data.posId)] = data
	end

	for posId = 1, 9 do
		local go = fmtView.transform:GetChild(posId - 1)
		local con = goutil.findChild(go, "con")
		local tag = goutil.findChild(go, "tag")
		local creepsData = map[posId]

		MaterialMgr.resetAll(con)
		GameUtil.SetActive(go, false)
		GameUtil.SetActive(tag, false)

		if creepsData then
			GameUtil.SetActive(go, true)
			self._powerPetMo:fromChallengeCreepCo(creepsData)

			local petMo = self._powerPetMo:toBaseBagPetMo()
			local proxy = MaterialMgr.setCellByMo(petMo, con)

			if proxy then
				proxy.binder:setAutoTips(false)
				proxy:setCallBack(function()
					CommonTipsMgr.instance:showPetTips(petMo)
				end)
			end
		end
	end
end

function OriginInfiniteFutureClgLevelView:_clearFmt(fmt)
	for posId = 1, 9 do
		local go = fmt.transform:GetChild(posId - 1)
		local con = goutil.findChild(go, "con")

		MaterialMgr.resetAll(con)
	end
end

function OriginInfiniteFutureClgLevelView:_updateBanCell(view, cell, data)
	local pet = goutil.findChild(cell, "pet")
	local petId = BagModel.instance:getMaxZdlPetIdByRaceId(data)
	local bagPetMo = BagPetsController.instance:getPet(petId)

	if bagPetMo then
		local proxy = MaterialMgr.setCellByMo(bagPetMo, pet)

		proxy.binder:setAutoTips(false)
		proxy:setCallBack(function()
			CommonTipsMgr.instance:showPetTips(bagPetMo)
		end)
	else
		MaterialMgr.setCell(MatType.Pet, data, pet)
	end
end

function OriginInfiniteFutureClgLevelView:_clearBanCell(cell)
	local pet = goutil.findChild(cell, "pet")

	MaterialMgr.resetAll(pet)
end

function OriginInfiniteFutureClgLevelView:_updateAttrCell(view, cell, data)
	local bg = goutil.findChild(cell, "bg")
	local txtType = goutil.findChildTextComponent(cell, "txtType")
	local txtBasic = goutil.findChildTextComponent(cell, "txtBasic")
	local txtFinal = goutil.findChildTextComponent(cell, "txtFinal")
	local index = cell.index

	txtType.text = data.name
	txtBasic.text = data.basic
	txtFinal.text = data.final

	GameUtil.SetActive(bg, index % 2 == 1)
end

function OriginInfiniteFutureClgLevelView:_clearAttrCell(cell)
	return
end

function OriginInfiniteFutureClgLevelView:_onClickBtnTip()
	TipsFacade.instance:openRulesView(self._actCfg.ruleKeyMain)
end

function OriginInfiniteFutureClgLevelView:_onClickBtnChallenge()
	local stageHasPass = OriginInfiniteFutureClgController.instance:stageHasPass(self._activityId, self._curSelectIdx)

	if stageHasPass then
		TipsFacade.instance:openPopupWindow(lang("提示"), lang("是否将本关重置为未挑战且解除精灵封印"), function()
			OriginInfiniteFutureClgController.instance:sendPM_OriginInfiniteFutureClgResetReq(self._activityId, self._curSelectIdx)
		end, nil, lang("确定"), lang("取消"))
	else
		OriginInfiniteFutureClgModel.instance:setSelectStage(self._activityId, self._curSelectIdx)
		OriginInfiniteFutureClgController.instance:enterBattleClg(self._activityId, self._curSelectIdx)
	end
end

function OriginInfiniteFutureClgLevelView:_getBanRaceIdList()
	local list = {}
	local lockRaceIdMap = OriginInfiniteFutureClgController.instance:getLockRaceIdMap(self._activityId)

	for raceId, _ in pairs(lockRaceIdMap) do
		table.insert(list, raceId)
	end

	return list
end

function OriginInfiniteFutureClgLevelView:_buildAttrList(stageCfg, valueWanPercent, stageHasPass)
	local list = {}

	if not stageCfg.extproperties then
		local propertyList = string.split(stageCfg.extproperties, "#") or {}

		for _, propertyText in ipairs(propertyList) do
			local name, basicValue = string.match(propertyText, "(.+)%+(%d+)")

			if name then
				local basic = checknumber(basicValue)
				local finalValue = stageHasPass and math.ceil(basic * valueWanPercent / 10000) or 0

				table.insert(list, {
					name = name,
					basic = basic,
					final = finalValue
				})
			end
		end

		return list
	end
end

function OriginInfiniteFutureClgLevelView:_getFirstCreepCfg(creepsMasterId)
	local creepsCfg = OriginInfiniteFutureClgConfig.instance:getCreepsCfg(creepsMasterId) or {}

	for _, creepsData in ipairs(creepsCfg) do
		if checknumber(creepsData.posId) > 0 then
			return creepsData
		end
	end
end

function OriginInfiniteFutureClgLevelView:_getCreepSkinId(creepsData)
	if not creepsData then
		return 0
	end

	local faceId = checknumber(creepsData.faceId)

	if faceId > 0 then
		return faceId
	end

	return checknumber(creepsData.raceId)
end

function OriginInfiniteFutureClgLevelView:_getPercentText(valueWanPercent)
	local percent = checknumber(valueWanPercent) / 100

	if percent == math.floor(percent) then
		return percent
	end

	return string.format("%.2f", percent)
end

return OriginInfiniteFutureClgLevelView
