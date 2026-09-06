-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mahjongbattle/view/MahjongBattleSummonView.lua

module("logic.extensions.mahjongbattle.view.MahjongBattleSummonView", package.seeall)

local MahjongBattleSummonView = class("MahjongBattleSummonView", ViewComponent)

function MahjongBattleSummonView:ctor()
	MahjongBattleSummonView.super.ctor(self)
end

function MahjongBattleSummonView:unbindEvents()
	MahjongBattleSummonView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnMatch)
	GameUtil.rmClickHandler(self._btnDel)
	GameUtil.rmClickHandler(self._btnTip)
end

function MahjongBattleSummonView:bindEvents()
	MahjongBattleSummonView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnMatch, self._onClickBtnMatch, self)
	GameUtil.addClickHandler(self._btnDel, self._onClickBtnDel, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
end

function MahjongBattleSummonView:buildUI()
	MahjongBattleSummonView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnMatch = self:getGo("btnMatch")
	self._btnDel = self:getGo("btnDel")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._txtSummonNumTips = self:getTxt("summonpet/title/txtNumTips")
	self._txtPetNumTips = self:getTxt("pet/titlebg/txtNumTips")
	self._txtTitle = self:getTxt("bg/txtTitle")

	local goTabPet = self:getGo("pet/tableviewpet")
	local goCellPet = self:getGo("pet/tablecellpet")

	self._tableviewPet = ScrollerList.create(goTabPet, goCellPet, GameUtil.handler(self._updateCellPet, self), GameUtil.handler(self._clearCellPet, self))

	local goTabSummon = self:getGo("summonpet/tableviewpet")
	local goCellSummon = self:getGo("summonpet/tablecellpet")

	self._tableviewSummon = ScrollerList.create(goTabSummon, goCellSummon, GameUtil.handler(self._updateCellSummon, self), GameUtil.handler(self._clearCellSummon, self))
	self._cardcell = self:getGo("bg/cardlist/cardcell")
	self._conCardlist = self:getGo("bg/cardlist")
	self._cardCellList = {}

	goutil.setActive(self._cardcell, false)
end

function MahjongBattleSummonView:onExit()
	MahjongBattleSummonView.super.onExit(self)
	self._tableviewPet:dispose()
	self._tableviewSummon:dispose()
end

function MahjongBattleSummonView:onEnter()
	MahjongBattleSummonView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_MahjongBattleSelectSummonPetRes, self._handleSelectSummonPet, self)
	self.addGEvent(self, GlobalNotify.PM_MahjongBattleDropPetRes, self._handleDropSummonPet, self)
	self.addGEvent(self, GlobalNotify.MahjongBattleTeachDataChange, self._handleChangeTeachStage, self)

	self._activityId = checknumber(self:getFirstParam())

	if self._activityId <= 0 then
		self._activityId = 571001
	end

	self._actCfg = MahjongBattleConfig.instance:getActivityCfg(self._activityId)
	self._curState = MahjongBattleModel.instance:getCurStateByActId(self._activityId)

	if self._curState ~= MahjongBattleModel.PLAYER_STATE.WAITING_SELECT_SUMMON_PET then
		self:close()
		MahjongBattleController.instance:continueGame(self._activityId)

		return
	end

	local curSummonTypeId = MahjongBattleModel.instance:getCurSummonTypeByActId(self._activityId)
	local summonCfg = MahjongBattleConfig.instance:getSummonTypeCfgById(self._activityId, curSummonTypeId)

	self._curSelectPetMo = nil

	if summonCfg then
		self._canSummonPetNum = summonCfg.canSelectNum or 0
	end

	if summonCfg then
		self._summonName = summonCfg.name or ""
	end

	self._txtTitle.text = langPara("召唤牌型：%s", self._summonName)
	self._backpackPetNumLimit = MahjongBattleConfig.instance:getCommonValueToNumber("REPORT_NUM_LIMIT")
	self._curSelectSummonDataMap = {}

	self:_updateSummonListData()
	self:_updatePetListData()
	self:_updatePetTempData()
	self._tableviewSummon:reloadData(self._curSummonPetMoList)
	self._tableviewSummon:setCenterMode(true)
	self._tableviewPet:reloadData(self._tempDataList)
	self._tableviewPet:MoveCellToBegin(0)
	self:_updateTips()
	self:_updateCurCardList()
end

function MahjongBattleSummonView:_onClickBtnMatch()
	if self._curSelectSummonPetNum > self._canSummonPetNum then
		FloatWordMgr.instance:show("选择的精灵数量超过上限了哦")

		return
	end

	if self._existRaceIdCount > self._backpackPetNumLimit then
		FloatWordMgr.instance:show("背包精灵数量加上新增精灵数量超过背包上限")

		return
	end

	local selectSummonIds = {}

	for k, v in pairs(self._curSelectSummonDataMap) do
		if v then
			table.insert(selectSummonIds, k.petId)
		end
	end

	if MahjongBattleController.instance:getIsTeachMode() then
		MahjongBattleController.instance:enterNextTeachStage(self._activityId)

		return
	end

	if #self._curSummonPetMoList == 0 then
		MahjongBattleController.instance:selectSummonPet(self._activityId, selectSummonIds)

		return
	end

	if #selectSummonIds < self._canSummonPetNum then
		local content = string.format("当前选择精灵少于可选上限\n是否完成此次选择,开始匹配？")

		TipsFacade.instance:openPopupWindow("提示", content, function()
			MahjongBattleController.instance:selectSummonPet(self._activityId, selectSummonIds)
		end, function()
			return
		end, "确定", "取消", UnityEngine.TextAnchor.MiddleCenter)

		return
	end

	MahjongBattleController.instance:selectSummonPet(self._activityId, selectSummonIds)
end

function MahjongBattleSummonView:_updateTips()
	self._curSelectSummonPetNum = 0

	for k, v in pairs(self._curSelectSummonDataMap) do
		if v then
			self._curSelectSummonPetNum = self._curSelectSummonPetNum + 1
		end
	end

	local addColorStr1 = self._curSelectSummonPetNum > self._canSummonPetNum and "#eb4642" or "#ffeaa0"

	self._txtSummonNumTips.text = string.format("请选择【%s】精灵：(<color=%s>%s</color>/%s)", self._summonName, addColorStr1, self._curSelectSummonPetNum, self._canSummonPetNum)

	local addColorStr2 = self._existRaceIdCount > self._backpackPetNumLimit and "#eb4642" or "#ffeaa0"

	self._txtPetNumTips.text = string.format("背包精灵：<color=%s>%s</color>/%s", addColorStr2, self._existRaceIdCount, self._backpackPetNumLimit)
end

function MahjongBattleSummonView:_updateCellPet(view, cell, data)
	local go = cell.gameObject
	local pet = goutil.findChild(go, "pet")
	local tagNew = goutil.findChild(go, "tagNew")
	local tagOwn = goutil.findChild(go, "tagOwn")

	goutil.setActive(tagNew, false)
	goutil.setActive(tagOwn, false)

	if data.isTemp then
		goutil.setActive(tagNew, self._petCreepIdMap[data.petId] ~= true)
		goutil.setActive(tagOwn, self._petCreepIdMap[data.petId] == true)
	end

	local petMo = data.petMo
	local proxy = MaterialMgr.setCellByMo(petMo, pet)

	if proxy then
		if petMo.awakenLv and petMo.awakenLv > 0 then
			proxy.binder:showStarByCustom(petMo.awakenLv)
		end

		proxy.binder:setSelected(data == self._curSelectPetMo)
		proxy:setCallBack(function()
			self:_onClickPetCell(data)
		end)
	end
end

function MahjongBattleSummonView:_clearCellPet(cell)
	local go = cell.gameObject
	local pet = goutil.findChild(go, "pet")

	MaterialMgr.resetAll(pet)
end

function MahjongBattleSummonView:_updateCellSummon(view, cell, data)
	local go = cell.gameObject
	local con = goutil.findChild(go, "con")
	local btn = goutil.findChild(con, "btn")
	local pet = goutil.findChild(con, "pet")
	local proxy = MaterialMgr.setCellByMo(data.petMo, pet)

	if proxy then
		proxy:setCallBack(function()
			CommonTipsMgr.instance:showPetTips(data.petMo)
			self:_onClickSummonCell(data)
		end)
	end

	local select = goutil.findChild(con, "select")

	goutil.setActive(select, self._curSelectSummonDataMap[data] == true)
	GameUtil.addClickHandler(btn, GameUtil.handler(self._onClickSummonCell, self, data))

	local tagOwn = goutil.findChild(con, "tagOwn")

	goutil.setActive(tagOwn, self._petCreepIdMap[data.petId] == true)

	if not data.sortId then
		local sortId = 0
		local isDown = sortId % 2 == 0

		go.name = "cell_" .. sortId

		GameUtil.setAnchoredPos(con, 0, isDown and 0 or -45)
	end
end

function MahjongBattleSummonView:_clearCellSummon(cell)
	local go = cell.gameObject
	local pet = goutil.findChild(go, "con/pet")

	MaterialMgr.resetAll(pet)

	local btn = goutil.findChild(go, "con/btn")

	GameUtil.rmClickHandler(btn)
end

function MahjongBattleSummonView:_onClickSummonCell(petData)
	if self._curSelectSummonDataMap[petData] then
		self._curSelectSummonDataMap[petData] = nil
	else
		self._curSelectSummonDataMap[petData] = true
	end

	self._tableviewSummon:reloadData(self._curSummonPetMoList)
	self._tableviewSummon:setCenterMode(true)
	self:_updatePetTempData()
	self._tableviewPet:reloadData(self._tempDataList)
	self._tableviewPet:MoveCellToBegin(0)
	self:_updateTips()
end

function MahjongBattleSummonView:_handleSelectSummonPet()
	self._curState = MahjongBattleModel.instance:getCurStateByActId(self._activityId)

	if self._curState ~= MahjongBattleModel.PLAYER_STATE.WAITING_SELECT_SUMMON_PET then
		self:close()
		MahjongBattleController.instance:continueGame(self._activityId)
	end
end

function MahjongBattleSummonView:_onClickPetCell(petData)
	if not petData then
		return
	end

	local petMo = petData.petMo

	if not petData.isTemp then
		CommonTipsMgr.instance:showPetTips(petMo)

		if not petData.isTemp then
			if self._curSelectPetMo == petData then
				self._curSelectPetMo = nil
			else
				self._curSelectPetMo = petData
			end

			self._tableviewPet:reloadData(self._tempDataList)
		end
	end
end

function MahjongBattleSummonView:_onClickBtnDel()
	if MahjongBattleController.instance:getIsTeachMode() then
		return
	end

	if not self._curSelectPetMo then
		FloatWordMgr.instance:show("请选择要删除的背包精灵")

		return
	end

	if self._curSelectPetMo.petMo.awakenLv and self._curSelectPetMo.petMo.awakenLv > 0 then
		FloatWordMgr.instance:show("不能删除已觉醒的精灵")

		return
	end

	if #self._petMoList <= 1 then
		FloatWordMgr.instance:show("背包精灵数量不可为零")

		return
	end

	local content = string.format("是否删除<color=#eb4642>[%s]</color>？\n删除操作不可撤销", self._curSelectPetMo.petMo.name or "")

	TipsFacade.instance:openPopupWindow("提示", content, function()
		MahjongBattleController.instance:dropPet(self._activityId, self._curSelectPetMo.petId)
	end, function()
		return
	end, "确定", "取消", UnityEngine.TextAnchor.MiddleCenter)
end

function MahjongBattleSummonView:_handleDropSummonPet()
	self:_updatePetListData()
	self:_updatePetTempData()
	self._tableviewPet:reloadData(self._tempDataList)
	self._tableviewPet:MoveCellToBegin(0)
	self._tableviewSummon:reloadData(self._curSummonPetMoList)
	self._tableviewSummon:setCenterMode(true)
	self:_updateTips()
end

function MahjongBattleSummonView:_onClickBtnTip()
	local key = self._actCfg.ruleKey

	TipsFacade.instance:openRulesView(key)
end

function MahjongBattleSummonView:_updateCurCardList()
	local cardIds = MahjongBattleModel.instance:getCurSummonOperaMahjongIds(self._activityId) or {}

	for _, cell in pairs(self._cardCellList) do
		goutil.setActive(cell.go, false)
	end

	for index, cardId in ipairs(cardIds) do
		local cell = self._cardCellList[index]

		if not cell then
			cell = {
				go = goutil.cloneAndSetParent(self._cardcell, self._conCardlist.transform)
			}
			cell.picChanger = goutil.findChildComponent(cell.go, "card/showpic", "UIImageSpriteChange")
			self._cardCellList[index] = cell
		end

		local mahjongData = MahjongBattleController.instance:convertMahjongIdToData(self._activityId, cardId)

		if mahjongData then
			local showPic = mahjongData:getExtraParam("showPic") or ""

			if showPic ~= "" then
				cell.picChanger:ChangeSprite(showPic)
			end

			goutil.setActive(cell.go, true)
		else
			goutil.setActive(cell.go, false)
		end
	end

	local totalWidth = #cardIds * 70
	local handStartPosX = -totalWidth / 2 + 35

	GameUtil.setAnchoredPos(self._conCardlist, handStartPosX, 183)
end

function MahjongBattleSummonView:_updateSummonListData()
	self._curSummonPetMoList = {}

	local curSummonCreepsIds = MahjongBattleModel.instance:getCurSummonCreepIdsByActId(self._activityId)
	local sortId = 1

	for _, creepId in ipairs(curSummonCreepsIds or {}) do
		local petMo = MahjongBattleModel.instance:getPetMo(self._activityId, creepId, 0)

		if petMo then
			local petData = {}

			petData.petId = petMo.petId
			petData.sortId = sortId
			petData.isTemp = true
			petData.petMo = petMo

			table.insert(self._curSummonPetMoList, petData)

			sortId = sortId + 1
		end
	end
end

function MahjongBattleSummonView:_updatePetListData()
	self._petCreepIdMap = {}
	self._petMoList = {}

	local curPetMoList = MahjongBattleModel.instance:getCurPetMoListByActId(self._activityId) or {}

	for _, petMo in ipairs(curPetMoList) do
		local petData = {}

		petData.petId = petMo.petId
		petData.isTemp = false
		petData.petMo = petMo

		table.insert(self._petMoList, petData)

		self._petCreepIdMap[petData.petId] = true
	end
end

function MahjongBattleSummonView:_updatePetTempData()
	self._tempDataList = {}

	local existCreepIdMap = {}

	self._existRaceIdCount = 0

	for _, petData in ipairs(self._petMoList) do
		table.insert(self._tempDataList, petData)

		if not existCreepIdMap[petData.petId] then
			existCreepIdMap[petData.petId] = true
			self._existRaceIdCount = self._existRaceIdCount + 1
		end
	end

	for petData, isSelected in pairs(self._curSelectSummonDataMap) do
		if isSelected then
			table.insert(self._tempDataList, petData)

			if not existCreepIdMap[petData.petId] then
				existCreepIdMap[petData.petId] = true
				self._existRaceIdCount = self._existRaceIdCount + 1
			end
		end
	end
end

function MahjongBattleSummonView:_handleChangeTeachStage()
	self:_handleSelectSummonPet()
end

return MahjongBattleSummonView
