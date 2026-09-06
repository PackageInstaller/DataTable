-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originan/view/OriginAnExtremeStageView.lua

module("logic.extensions.originan.view.OriginAnExtremeStageView", package.seeall)

local OriginAnExtremeStageView = class("OriginAnExtremeStageView", ViewComponent)

function OriginAnExtremeStageView:buildUI()
	OriginAnExtremeStageView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._stageCell = self:getGo("stageCol/stageCell")
	self._stageView = self:getGo("stageCol/stageView")
	self._tagEmptyDizzy = self:getGo("infoCol/detailCol/tagEmpty")
	self._dizzyScrCell = self:getGo("infoCol/detailCol/scrCell")
	self._dizzyScrView = self:getGo("infoCol/detailCol/scrView")
	self._dizzyScrollerList = ScrollerList.create(self._dizzyScrView, self._dizzyScrCell, GameUtil.handler(self._updateDizzyCell, self), GameUtil.handler(self._clearDizzyCell, self))
	self._txtBuffDesc = self:getTxt("infoCol/buffDesc/txt")
	self._fmtView = self:getGo("infoCol/fmt/fmtView")
	self._tagEmptyFmt = self:getGo("infoCol/fmt/tagEmpty")
	self._petScrCell = self:getGo("infoCol/petCol/scrCell")
	self._petScrView = self:getGo("infoCol/petCol/scrView")
	self._petScrollerList = ScrollerList.create(self._petScrView, self._petScrCell, GameUtil.handler(self._updatePetCell, self), GameUtil.handler(self._clearPetCell, self))
	self._tagEmptyPet = self:getGo("infoCol/petCol/tagEmpty")
	self._btnEnter = self:getGo("infoCol/btnEnter")
	self._btnReset = self:getGo("infoCol/btnReset")
	self._btnBuff = self:getGo("infoCol/btnBuff")

	GameUtil.SetActive(self._stageCell, false)
end

function OriginAnExtremeStageView:bindEvents()
	OriginAnExtremeStageView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTips, self)
	GameUtil.addClickHandler(self._btnEnter, self._onClickBtnEnter, self)
	GameUtil.addClickHandler(self._btnReset, self._onClickBtnReset, self)
	GameUtil.addClickHandler(self._btnBuff, self._onClickBtnBuff, self)
end

function OriginAnExtremeStageView:unbindEvents()
	OriginAnExtremeStageView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnEnter)
	GameUtil.rmClickHandler(self._btnReset)
	GameUtil.rmClickHandler(self._btnBuff)
end

function OriginAnExtremeStageView:onEnter()
	OriginAnExtremeStageView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	local isInTime = ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._subMo = OriginAnController.instance:getSubMo(self._activityId)
	self._curStageId = self._curStageId or 0

	self.addGEvent(self, GlobalNotify.HandlePM_OriginAnInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_OriginAnResetExtremeRes, self._onUpdate, self)
	self:_onUpdate()

	local changeSetId = self._subMo:popExtremeChangeSetId()

	if changeSetId then
		MaterialController.instance:showChangeSetInTemp(changeSetId)
	end
end

function OriginAnExtremeStageView:onExit()
	OriginAnExtremeStageView.super.onExit(self)
	self:_onClearStageCol()
	self:_onClearInfoCol()
end

function OriginAnExtremeStageView:_onUpdate()
	if self._curStageId <= 0 then
		local datas = OriginAnConfig.instance:getExtremeStageDatas(self._activityId) or {}

		for _, data in ipairs(datas) do
			self._curStageId = data.stageId

			if not self._subMo:isExtremeStagePassed(data.stageId) then
				break
			end
		end
	end

	self:_onUpdateStageCol()
	self:_onUpdateInfoCol()
end

function OriginAnExtremeStageView:_onUpdateStageCol()
	local stageDatas = OriginAnConfig.instance:getExtremeStageDatas(self._activityId) or {}

	GameUtil.updateCellsList(self._stageView, self._stageCell, stageDatas, self._updateStageCell, self)
end

function OriginAnExtremeStageView:_onClearStageCol()
	GameUtil.clearCells(self._stageView, self._clearStageCell, self)
end

function OriginAnExtremeStageView:_updateStageCell(mainGo, data, index)
	local stageId = data.stageId
	local isPass = self._subMo:isExtremeStagePassed(stageId)
	local score = self._subMo:getExtremeStageBlockHealTimes(stageId)
	local btnGo = goutil.findChild(mainGo, "btn")
	local icon = goutil.findChild(mainGo, "btn/icon")
	local tagPass = goutil.findChild(mainGo, "btn/tagPass")
	local tagSelected = goutil.findChild(mainGo, "btn/tagSelected")
	local txtScore = goutil.findChildTextComponent(mainGo, "score/txt")

	if not data.pos then
		if not data.pos[3] then
			local x, y, scale = checknumber(data.pos[1]), checknumber(data.pos[2]), 1

			GameUtil.setLocalPos(mainGo, x, y, 0)
			GameUtil.setLocalScale(mainGo, data.pos[3], data.pos[3], data.pos[3])
			GameUtil.SetActive(tagPass, isPass)
			GameUtil.SetActive(tagSelected, self._curStageId == stageId)

			txtScore.text = string.format("禁疗：%s/%s", score, data.blockHealTimes)

			MaterialMgr.setIcon(icon, MatType.Pet, data.skinId)
			GameUtil.addClickHandler(btnGo, function()
				if self._curStageId == stageId then
					return
				end

				self._curStageId = stageId

				self:_onUpdate()
			end)
		end
	end
end

function OriginAnExtremeStageView:_clearStageCell(mainGo)
	local btnGo = goutil.findChild(mainGo, "btn")
	local icon = goutil.findChild(mainGo, "btn/icon")

	GameUtil.rmClickHandler(btnGo)
	MaterialMgr.clearIcon(icon)
end

function OriginAnExtremeStageView:_onUpdateInfoCol()
	local isPassStage = self._subMo:isExtremeStagePassed(self._curStageId)
	local dizzyInfos = {}
	local isHaveDizzy = false

	for posId = 1, self._fmtView.transform.childCount do
		local go = self._fmtView.transform:GetChild(posId - 1)
		local round = goutil.findChild(go, "round")
		local txtRound = goutil.findChildTextComponent(go, "round/txt")
		local tagCur = goutil.findChild(go, "round/tagCur")
		local dizzyCount = self._subMo:getDizzyCountExtreme(posId)
		local dizzyCountByStage = self._subMo:getDizzyCountExtremeByStage(self._curStageId, posId)
		local isCur = dizzyCountByStage > 0

		if isPassStage and isCur then
			table.insert(dizzyInfos, {
				posId = posId,
				round = dizzyCountByStage
			})
		end

		txtRound.text = string.format("%s回合", dizzyCount)

		GameUtil.SetActive(tagCur, isCur)
		GameUtil.SetActive(round, dizzyCount > 0)

		isHaveDizzy = isHaveDizzy or dizzyCount > 0
	end

	GameUtil.SetActive(self._tagEmptyFmt, not isHaveDizzy)
	self._dizzyScrollerList:reloadData(dizzyInfos)

	self._dizzyScrView:GetComponent(ComponentType.ScrollRect).verticalNormalizedPosition = 1

	GameUtil.SetActive(self._tagEmptyDizzy, #dizzyInfos <= 0)

	local totalBlockHeal = self._subMo:getExtremeTotalBlockHealTimes()
	local buffData = OriginAnConfig.instance:getExtremeBuffDataByTimes(self._activityId, totalBlockHeal)

	if buffData then
		self._txtBuffDesc.text = buffData.buffDesc or "无"
	end

	local banRaceList = self._subMo:getStageExtremeBanRaceList(self._curStageId)

	self._petScrollerList:reloadData(banRaceList)

	self._petScrView:GetComponent(ComponentType.ScrollRect).horizontalNormalizedPosition = 0

	GameUtil.SetActive(self._tagEmptyPet, #banRaceList <= 0)
	GameUtil.SetActive(self._btnEnter, not isPassStage)
	GameUtil.SetActive(self._btnReset, isPassStage)
end

function OriginAnExtremeStageView:_onClearInfoCol()
	self._dizzyScrollerList:dispose()
	self._petScrollerList:dispose()
end

function OriginAnExtremeStageView:_updateDizzyCell(view, cell, data, tag)
	local mainGo = cell.gameObject
	local txtDesc = goutil.findChildTextComponent(mainGo, "txtDesc")

	txtDesc.text = string.format("%s号位 %s回合", data.posId, data.round)
end

function OriginAnExtremeStageView:_clearDizzyCell(cell)
	return
end

function OriginAnExtremeStageView:_updatePetCell(view, cell, raceId, tag)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")
	local proxy = MaterialMgr.setCell(MatType.Pet, raceId, item)

	if proxy then
		local tmpMo = FightingPowerPetMo.createPetByLevel(raceId, 1, 1, 0)

		proxy.binder:setClickCallBack(function()
			CommonTipsMgr.instance:showPetTips(tmpMo, true)
		end)
	end
end

function OriginAnExtremeStageView:_clearPetCell(cell)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")

	MaterialMgr.resetAll(item)
end

function OriginAnExtremeStageView:_onClickBtnEnter()
	local isPass = self._subMo:isExtremeStagePassed(self._curStageId)

	if isPass then
		FloatWordMgr.instance:show("已通关")

		return
	end

	OriginAnController.instance:enterBattleExtreme(self._activityId, self._curStageId)
end

function OriginAnExtremeStageView:_onClickBtnReset()
	local isPass = self._subMo:isExtremeStagePassed(self._curStageId)

	if not isPass then
		FloatWordMgr.instance:show("无需重置")

		return
	end

	local tipsContent = "是否重置本关，解除精灵封印和清除本关眩晕"

	local function okFunc()
		OriginAnController.instance:sendPM_OriginAnResetExtremeReq(self._activityId, self._curStageId)
	end

	TipsFacade.instance:openPopupWindow("提示", tipsContent, okFunc, nil, "确定", "取消")
end

function OriginAnExtremeStageView:_onClickBtnTips()
	local data = OriginAnConfig.instance:getActivityData(self._activityId)

	TipsFacade.instance:openRulesView(data.ruleKeyMain)
end

function OriginAnExtremeStageView:_onClickBtnBuff()
	UIStateManager.instance:push(ViewName.OriginAnExtremeBuffView, self._activityId)
end

return OriginAnExtremeStageView
