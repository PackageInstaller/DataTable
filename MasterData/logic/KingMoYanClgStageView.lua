-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingmoyanclg/view/KingMoYanClgStageView.lua

module("logic.extensions.kingmoyanclg.view.KingMoYanClgStageView", package.seeall)

local KingMoYanClgStageView = class("KingMoYanClgStageView", ViewComponent)

function KingMoYanClgStageView:buildUI()
	KingMoYanClgStageView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._btnTip = goutil.findChild(self.mainGO, "leftTop/btnTip")
	self._txtOpenTime = goutil.findChildTextComponent(self.mainGO, "txtOpenTime/txt")

	local fmtScrView = goutil.findChild(self.mainGO, "fmtCol/scrView")
	local fmtScrCell = goutil.findChild(self.mainGO, "fmtCol/scrCell")

	self._fmtScrollerList = ScrollerList.create(fmtScrView, fmtScrCell, GameUtil.handler(self._updateFmtCell, self), GameUtil.handler(self._clearFmtCell, self))
	self._txtTips = goutil.findChildTextComponent(self.mainGO, "tips/txt")
	self._strTips = self._txtTips.text
	self._btnReset = goutil.findChild(self.mainGO, "btnReset")
	self._txtTimeGo = self:getGo("txtOpenTime")
	self._txtOpenTime = goutil.findChildTextComponent(self.mainGO, "txtOpenTime/txt")
	self._progressCol = goutil.findChild(self.mainGO, "progressCol")
	self._progressScrollerview = goutil.findChild(self.mainGO, "progressCol/scrView")
	self._progressScrollercell = goutil.findChild(self.mainGO, "progressCol/scrCell")
	self._progressBar = goutil.findChild(self.mainGO, "progressCol/scrView/Viewport/Content/progressBar")
	self._sliderComp = self:getSlider("progressCol/scrView/Viewport/Content/progressBar")
	self._txtNumProgress = goutil.findChildTextComponent(self.mainGO, "progressCol/total/txtNum")
	self._progressScrollerList = ScrollerList.create(self._progressScrollerview, self._progressScrollercell, GameUtil.handler(self._updateProgressCell, self), GameUtil.handler(self._clearProgressCell, self))
end

function KingMoYanClgStageView:bindEvents()
	KingMoYanClgStageView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, function()
		local key = self._actData.ruleKeyMain

		TipsFacade.instance:openRulesView(key)
	end)
	GameUtil.addClickHandler(self._btnReset, self._onClickBtnReset, self)
end

function KingMoYanClgStageView:unbindEvents()
	KingMoYanClgStageView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnReset)
end

function KingMoYanClgStageView:onEnter()
	KingMoYanClgStageView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._activityType = KingMoYanClgController.instance:getActivityType()

	local isInTime = KingMoYanClgController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._moYanClgMo = KingMoYanClgController.instance:getKingMoYanClgMo(self._activityId)
	self._actData = KingMoYanClgConfig.instance:getActData(self._activityId)
	self._isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(self._activityId)

	self:_initAoqiGodUI()
	self:_onSetUI()
	self.addGEvent(self, GlobalNotify.HandlePM_KingMoYanClgInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_KingMoYanClgResetRes, self._sendInfoReq, self)
	self.addGEvent(self, GlobalNotify.HandlePM_KingMoYanClgConfirmRes, self._sendInfoReq, self)
	self:_sendInfoReq()

	local changeSetId = self._moYanClgMo:popChangeSetId()

	if changeSetId then
		MaterialController.instance:showChangeSetInTemp(changeSetId)
	end
end

function KingMoYanClgStageView:onExit()
	KingMoYanClgStageView.super.onExit(self)
	uGuiUtil.clearImage(self._btnReset)
	self:_onClearFmtColUI()
	self:_onClearProgressCol()
end

function KingMoYanClgStageView:_initAoqiGodUI()
	GameUtil.SetActive(self._txtTimeGo, not self._isAoqiGodProcessType)
end

function KingMoYanClgStageView:_sendInfoReq()
	KingMoYanClgController.instance:sendPM_KingMoYanClgInfoReq(self._activityId)
end

function KingMoYanClgStageView:_onSetUI()
	self._txtOpenTime.text = GameUtil.getActTimeDesc(self._activityType, self._activityId)

	local skinId = KingMoYanClgController.instance:getSkinId(self._activityId)
	local modelCo = CharacterConfig.instance:getModelCo(skinId)

	uGuiUtil.setSpriteToImage(self._btnReset, uGuiUtil.SpriteType.BigBg, GameUrl.getPetImgUrl(modelCo.cardName), function()
		self._btnReset:GetComponent(goutil.Type_UIImage):SetNativeSize()
	end)
end

function KingMoYanClgStageView:_onUpdate()
	self:_onUpdateFmtColUI()
	self:_onUpdateProgressCol()

	local buffId = self._moYanClgMo:getCurBuffId()
	local buffData = KingMoYanClgConfig.instance:getBuffData(self._activityId, buffId)

	self._txtTips.text = buffData and buffData.desc or self._strTips
end

function KingMoYanClgStageView:_onUpdateFmtColUI()
	local cfg = KingMoYanClgConfig.instance:getStageCfg(self._activityId)

	self._fmtScrollerList:reloadData(cfg)

	local cellIdx = 0

	for idx, data in ipairs(cfg) do
		if self._moYanClgMo:isPassStageInCur(data.stageId) then
			cellIdx = idx
		else
			break
		end
	end

	self._fmtScrollerList:MoveCellToCenter(cellIdx)
end

function KingMoYanClgStageView:_onClearFmtColUI()
	self._fmtScrollerList:dispose()
end

function KingMoYanClgStageView:_updateFmtCell(view, cell, data, tag)
	local stageId = data.stageId
	local isPass = self._moYanClgMo:isPassStageInCur(stageId)
	local isPassStageInHistory = self._moYanClgMo:isPassStageInHistory(stageId)
	local isUnlock = self._moYanClgMo:isUnlockStage(stageId)
	local masterData = KingMoYanClgConfig.instance:getMasterData(data.creepsMasterId)
	local creepsCfg = KingMoYanClgConfig.instance:getCreepsCfg(data.creepsMasterId)
	local mainGo = cell.gameObject
	local btnEnter = goutil.findChild(mainGo, "btnEnter")
	local txtCond = goutil.findChildTextComponent(mainGo, "cond/txt")
	local fmt = goutil.findChild(mainGo, "fmt")
	local fmtView = goutil.findChild(mainGo, "fmt/fmtView")
	local imgPass = goutil.findChild(mainGo, "fmt/imgPass")
	local imgLock = goutil.findChild(mainGo, "fmt/imgLock")
	local prize = goutil.findChild(mainGo, "prize")
	local prizeItem = goutil.findChild(mainGo, "prize/item")
	local imgHasGain = goutil.findChild(mainGo, "prize/imgHasGain")
	local txtTitle = goutil.findChildTextComponent(mainGo, "txtTitle")

	txtTitle.text = string.format("第%s关", stageId)

	local fMo = FightingPowerPetMo.New()

	for posId = 1, fmtView.transform.childCount do
		local go = fmtView.transform:GetChild(posId - 1)
		local icon = goutil.findChild(go, "icon")
		local creepsData

		for _, cData in ipairs(creepsCfg) do
			if cData.posId == posId then
				creepsData = cData

				break
			end
		end

		if creepsData then
			local skinId = checknumber(creepsData.faceId)

			if skinId == 0 then
				skinId = creepsData.raceId
			end

			local proxy = MaterialMgr.setCell(MatType.Pet, skinId, icon)

			if proxy then
				fMo:fromChallengeCreepCo(creepsData)

				local petMo = fMo:toBaseBagPetMo()

				proxy.binder:setClickCallBack(function()
					CommonTipsMgr.instance:showPetTips(petMo, true)
				end)
			end
		else
			MaterialMgr.resetAll(icon)
		end
	end

	GameUtil.SetActive(prize, not self._isAoqiGodProcessType)
	GameUtil.SetActive(imgPass, isPass)
	GameUtil.SetGray(btnEnter, isPass)
	MaterialMgr.setCellByCfg(data.prize, prizeItem)
	GameUtil.SetActive(imgHasGain, isPassStageInHistory)
	GameUtil.SetActive(imgLock, not isUnlock)

	txtCond.text = masterData.WinDesc

	GameUtil.addClickHandler(btnEnter, function()
		local result = GameEnum.ResultCode.Success
		local tips = ""
		local mo = self._moYanClgMo

		if not KingMoYanClgController.instance:isInActivityTime(self._activityId) then
			result = GameEnum.ResultCode.Error
			tips = "不在活动时间内"
		elseif mo:isPassAll() then
			result = GameEnum.ResultCode.Error
			tips = "已通关"
		elseif mo:isPassStageInCur(stageId) then
			result = GameEnum.ResultCode.Error
			tips = "已通关"
		elseif not mo:isUnlockStage(stageId) then
			result = GameEnum.ResultCode.Error
			tips = "未解锁，请通关上一关卡"
		end

		if result ~= GameEnum.ResultCode.Success then
			FloatWordMgr.instance:show(tips)

			return
		end

		KingMoYanClgController.instance:enterBattle(self._activityId, stageId)
	end)
end

function KingMoYanClgStageView:_clearFmtCell(mainGo)
	local fmtView = goutil.findChild(mainGo, "fmt/fmtView")
	local btnEnter = goutil.findChild(mainGo, "btnEnter")

	for posId = 1, fmtView.transform.childCount do
		local go = fmtView.transform:GetChild(posId - 1)
		local icon = goutil.findChild(go, "icon")

		MaterialMgr.resetAll(icon)
	end

	GameUtil.rmClickHandler(btnEnter)
end

function KingMoYanClgStageView:_onClickBtnReset()
	local result = GameEnum.ResultCode.Success
	local tips = ""
	local mo = self._moYanClgMo

	if not KingMoYanClgController.instance:isInActivityTime(self._activityId) then
		result = GameEnum.ResultCode.Error
		tips = "不在活动时间内"
	elseif mo:isPassAll() then
		result = GameEnum.ResultCode.Error
		tips = "已通关"
	elseif self._moYanClgMo:getCurStageId() <= 0 then
		result = GameEnum.ResultCode.Error
		tips = "未挑战通关任意关卡，无需重置"
	end

	if result ~= GameEnum.ResultCode.Success then
		FloatWordMgr.instance:show(tips)

		return
	end

	local tipsContent = "是否确认重置所有关卡？"

	local function okFunc()
		KingMoYanClgController.instance:sendPM_KingMoYanClgResetReq(self._activityId)
	end

	TipsFacade.instance:openPopupWindow("提示", tipsContent, okFunc, nil, "确定", "取消")
end

function KingMoYanClgStageView:_onUpdateProgressCol()
	local dataList = self:_getProgressDataList()
	local curProgress = self:_getCurProgress()
	local sliderComp = self:_getSliderComp()
	local scoreList = {}

	for _, data in ipairs(dataList) do
		table.insert(scoreList, self:_getProgressByData(data))
	end

	local index = 0

	for idx, data in ipairs(dataList) do
		if self:_isHasReach(data) then
			index = idx

			break
		end
	end

	self._progressScrollerList:reloadData(dataList)
	self._progressScrollerList:updateUnderSlider(sliderComp, curProgress, scoreList)
	self._progressScrollerList:MoveCellToCenter(index == -1 and 0 or index)

	self._txtNumProgress.text = string.format("%s", curProgress)
end

function KingMoYanClgStageView:_onClearProgressCol()
	self._progressScrollerList:dispose()
end

function KingMoYanClgStageView:_getProgressDataList()
	return KingMoYanClgConfig.instance:getBuffCfg(self._activityId)
end

function KingMoYanClgStageView:_getSliderComp()
	return self._sliderComp
end

function KingMoYanClgStageView:_getCurProgress()
	return self._moYanClgMo:getCurUltimateTimes()
end

function KingMoYanClgStageView:_getProgressByData(data)
	return data.num
end

function KingMoYanClgStageView:_isHasReach(data)
	local cur = self:_getCurProgress()
	local need = self:_getProgressByData(data)

	return need <= cur
end

function KingMoYanClgStageView:_updateProgressCell(view, cell, data, tag)
	local progress = self:_getProgressByData(data)
	local curProgress = self:_getCurProgress()
	local mainGo = cell.gameObject
	local imgPoint = goutil.findChild(mainGo, "imgPoint")
	local txtStage = goutil.findChildTextComponent(mainGo, "txtStage")
	local imgSelected = goutil.findChild(mainGo, "imgSelected")

	txtStage.text = self:_getProgressByData(data)

	GameUtil.SetActive(imgSelected, progress == curProgress)
	GameUtil.SetGray(imgPoint, curProgress < progress)
end

function KingMoYanClgStageView:_clearProgressCell(cell)
	return
end

return KingMoYanClgStageView
