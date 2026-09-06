-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/qichallenge/view/QiChallengeHardLevelView.lua

module("logic.extensions.qichallenge.view.QiChallengeHardLevelView", package.seeall)

local QiChallengeHardLevelView = class("QiChallengeHardLevelView", ViewComponent)
local PerPageCount = 5

function QiChallengeHardLevelView:ctor()
	QiChallengeHardLevelView.super.ctor(self)
end

function QiChallengeHardLevelView:buildUI()
	QiChallengeHardLevelView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnChallenge = self:getBtn("info/btnChallenge")
	self._redPointChallenge = self:getGo("info/btnChallenge/redpoint")
	self._btnReset = self:getBtn("info/btnReset")
	self._btnDebuff = self:getBtn("btnDebuff")
	self._levelCellList = {}

	for i = 1, 5 do
		local go = self:getGo("level_" .. i)
		local cell = {
			go = go,
			index = i,
			btnChallenge = GameUtil.asBtn(goutil.findChild(go, "btnChallenge")),
			select = goutil.findChild(go, "select"),
			txtLevel = goutil.findChildTextComponent(go, "btnChallenge/txtLevel"),
			passed = goutil.findChild(go, "btnChallenge/passed")
		}

		table.insert(self._levelCellList, cell)
	end

	self._btnPre = self:getBtn("btnPre")
	self._btnNext = self:getBtn("btnNext")
	self._sliderLevel = self:getSlider("level/slider")
	self._txtLevel = self:getTxt("level/slider/FillArea/info/txtLevel")
	self._txtDown = self:getTxt("level/txtDown")
	self._txtUp = self:getTxt("level/txtUp")
	self._headIcon = self:getGo("level/slider/FillArea/info/head")
	self._txtLevelName = self:getTxt("info/txtName")
	self._txtCondition1 = self:getTxt("info/txtCondition1")
	self._txtCondition2 = self:getTxt("info/txtCondition2")
	self._conditionState1 = self:getGo("info/txtCondition1/yes")
	self._conditionState2 = self:getGo("info/txtCondition2/yes")
	self.petTableview = self:getGo("info/petview")
	self.petCell = self:getGo("info/petcell")
	self.petScrollList = ScrollerList.create(self.petTableview, self.petCell, GameUtil.handler(self._updatePetCell, self), GameUtil.handler(self._clearPetCell, self))
	self.rewardTableview = self:getGo("info/rewardview")
	self.rewardCell = self:getGo("info/rewardcell")
	self.rewardScrollList = ScrollerList.create(self.rewardTableview, self.rewardCell, GameUtil.handler(self._updateRewardCell, self), GameUtil.handler(self._clearRewardCell, self))
	self._dragArea = Framework.UIDragTrigger.Get(self:getGo("dragArea"))
end

function QiChallengeHardLevelView:bindEvents()
	QiChallengeHardLevelView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnChallenge:AddClickListener(self._onClickChallenge, self)
	self._btnReset:AddClickListener(self._onClickReset, self)
	self._btnDebuff:AddClickListener(self._onClickDebuff, self)
	self._btnPre:AddClickListener(self._onClickPrePage, self)
	self._btnNext:AddClickListener(self._onClickNextPage, self)
	self._dragArea:AddEndDragListener(self._onEndDrag, self)

	for i = 1, PerPageCount do
		GameUtil.addClickHandler(self._levelCellList[i].btnChallenge, function()
			self:_onSelectLevel(i)
		end, self)
	end
end

function QiChallengeHardLevelView:unbindEvents()
	QiChallengeHardLevelView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnChallenge:RemoveClickListener()
	self._btnReset:RemoveClickListener()
	self._btnDebuff:RemoveClickListener()
	self._btnPre:RemoveClickListener()
	self._btnNext:RemoveClickListener()
	self._dragArea:RemoveEndDragListener()

	for i = 1, PerPageCount do
		GameUtil.rmClickHandler(self._levelCellList[i].btnChallenge)
	end
end

function QiChallengeHardLevelView:onEnter()
	QiChallengeHardLevelView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.handlePM_QiChallengeGetInfoRes, self._refreshUI, self)
	GlobalDispatcher:addListener(GlobalNotify.handlePM_QiChallengeExtremeResetRes, self._PM_QiChallengeExtremeResetRes, self)

	self._activityId = self:getFirstParam()
	self._activityCfg = QiChallengeConfig.instance:getActivityCfg(self._activityId)
	self._hardChallengeCfgs = QiChallengeConfig.instance:getHardChallengeCfgs(self._activityCfg.extremePlanId)
	self._totalLevelCount = #self._hardChallengeCfgs
	self._maxPage = Mathf.Ceil(self._totalLevelCount / PerPageCount)

	QiChallengeAgent.instance:sendPM_QiChallengeGetInfoReq(self._activityId)
	GameUtil.SetActive(self._redPointChallenge, false)
end

function QiChallengeHardLevelView:onExit()
	QiChallengeHardLevelView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.handlePM_QiChallengeGetInfoRes, self._refreshUI, self)
	GlobalDispatcher:removeListener(GlobalNotify.handlePM_QiChallengeExtremeResetRes, self._PM_QiChallengeExtremeResetRes, self)
	self.petScrollList:dispose()
	self.rewardScrollList:dispose()
	self:_clearLevelSlider()
end

function QiChallengeHardLevelView:_refreshUI()
	local curPassStage = QiChallengeModel.instance:getPassStage()

	self._curSelectLevelIndex = Mathf.Clamp(curPassStage + 1, 1, self._totalLevelCount)

	if curPassStage == self._totalLevelCount then
		self._isComplete = true
	end

	self._curPage = self:_getPageByStage(self._curSelectLevelIndex)

	self:_updateLevels()
	self:_initLevelSlider()
	self:_updateCurSelectLevelInfo()
end

function QiChallengeHardLevelView:_onClickClose()
	self:close()
end

function QiChallengeHardLevelView:_onClickChallenge()
	local curPassStage = QiChallengeModel.instance:getPassStage()

	if self._curSelectLevelIndex > curPassStage + 1 then
		FloatWordMgr.instance:show(string.format("请先通过第%d关", curPassStage + 1))
	elseif self._curSelectLevelIndex < curPassStage + 1 then
		FloatWordMgr.instance:show("已通关")
	else
		local customFmtMo = QiChallengeModel.instance:getHardFmtMo()
		local cfg = self._hardChallengeCfgs[self._curSelectLevelIndex]

		customFmtMo:initParams(self._activityId, cfg.extremePlanId, cfg.challengeId)
		CustomFmtController.instance:showMissionView(customFmtMo)
	end
end

function QiChallengeHardLevelView:_onClickReset()
	local title = lang("提示")
	local content = lang("重置后，压制效果将会清零，但是已经通关的奖励无法再次获得，请问是否继续重置？")

	TipsFacade.instance:openPopupWindow(title, content, function()
		QiChallengeAgent.instance:sendPM_QiChallengeExtremeResetReq(self._activityId)
	end)
end

function QiChallengeHardLevelView:_onClickDebuff()
	UIStateManager.instance:push(ViewName.QiChallengeSuppressView, self._activityId)
end

function QiChallengeHardLevelView:_onClickPrePage()
	if self._curPage <= 1 then
		self._curPage = 1

		return
	end

	self._curPage = self._curPage - 1

	self:_updateLevels()
end

function QiChallengeHardLevelView:_onClickNextPage()
	if self._curPage >= self._maxPage then
		self._curPage = self._maxPage

		return
	end

	self._curPage = self._curPage + 1

	self:_updateLevels()
end

function QiChallengeHardLevelView:_onSelectLevel(index)
	local lastIndex = self._curSelectLevelIndex

	self._curSelectLevelIndex = (self._curPage - 1) * PerPageCount + index

	for i, v in ipairs(self._levelCellList) do
		if v.index == index then
			GameUtil.SetActive(v.select, true)
		else
			GameUtil.SetActive(v.select, false)
		end
	end

	if lastIndex ~= self._curSelectLevelIndex then
		self:_updateCurSelectLevelInfo()
	end
end

function QiChallengeHardLevelView:_onEndDrag(eventData)
	if eventData.position.y - eventData.pressPosition.y >= 0 then
		self:_onClickPrePage()
	else
		self:_onClickNextPage()
	end
end

function QiChallengeHardLevelView:_getStartAndEndIndex(page)
	return (page - 1) * PerPageCount + 1, page * PerPageCount
end

function QiChallengeHardLevelView:_getPageByStage(stage)
	return Mathf.Floor((stage - 1) / PerPageCount) + 1
end

function QiChallengeHardLevelView:_updateLevels()
	self:_updateLevelSlider()

	local startIndex, endIndex = self:_getStartAndEndIndex(self._curPage)

	GameUtil.SetActive(self._btnPre, self._curPage ~= 1)
	GameUtil.SetActive(self._btnNext, self._curPage ~= self._maxPage)

	local curIndex = startIndex

	curIndex = endIndex <= QiChallengeModel.instance:getPassStage() and endIndex or startIndex > QiChallengeModel.instance:getPassStage() and startIndex or QiChallengeModel.instance:getPassStage() + 1

	for i, v in ipairs(self._levelCellList) do
		local index = (self._curPage - 1) * PerPageCount + v.index

		GameUtil.SetActive(v.go, index <= self._totalLevelCount)

		v.txtLevel.text = langPara("第%s关", GameUtil.getChineseNumber(index))

		GameUtil.SetActive(v.select, curIndex == index)
		GameUtil.SetActive(v.passed, index <= QiChallengeModel.instance:getPassStage())
	end
end

function QiChallengeHardLevelView:_initLevelSlider()
	self._txtDown.text = "1关"
	self._txtUp.text = langPara("%d关", self._totalLevelCount)

	MaterialMgr.setIcon(self._headIcon, MatType.Pet, self._activityCfg.raceId)
end

function QiChallengeHardLevelView:_clearLevelSlider()
	MaterialMgr.clearIcon(self._headIcon)
end

function QiChallengeHardLevelView:_updateLevelSlider()
	local curPassStage = QiChallengeModel.instance:getPassStage()
	local curLevel = curPassStage + 1
	local num = curLevel <= self._totalLevelCount and curLevel or self._totalLevelCount

	self._sliderLevel:SetValue((num - 1) / (self._totalLevelCount - 1))

	self._txtLevel.text = langPara("当前第%d关", num)
end

function QiChallengeHardLevelView:_updateCurSelectLevelInfo()
	local cfg = self._hardChallengeCfgs[self._curSelectLevelIndex]

	if not cfg then
		return
	end

	self._txtLevelName.text = langPara("第%d关", self._curSelectLevelIndex)

	local passStage = QiChallengeModel.instance:getPassStage()

	GameUtil.SetActive(self._btnReset, self._curSelectLevelIndex == passStage + 1)
	GameUtil.SetActive(self._btnChallenge, self._curSelectLevelIndex == passStage + 1)

	local isPass = passStage >= self._curSelectLevelIndex
	local teamCfg = QiChallengeConfig.instance:getCreepTeamCfg(cfg.creepsMasterId)

	self:_updateLevelCondtions(teamCfg, isPass)

	local creepsCfgList = QiChallengeConfig.instance:getCreepsCfg(cfg.creepsMasterId)
	local list = {}

	for k, v in pairs(creepsCfgList) do
		local mo = FightingPowerPetMo.New()

		mo:fromChallengeCreepCo(v, creepsCfgList)
		table.insert(list, mo)
	end

	self:_updateEnemyHeadIcons(list)
	self:_updateRewardIcons(cfg)
end

function QiChallengeHardLevelView:_updateLevelCondtions(cfg, isPass)
	goutil.setActive(self._txtCondition1.gameObject, true)
	goutil.setActive(self._txtCondition2.gameObject, true)
	goutil.setActive(self._conditionState1, isPass)
	goutil.setActive(self._conditionState2, isPass)

	if not string.nilorempty(cfg.winRule1) then
		self._txtCondition1.text = cfg.winRule1

		if not string.nilorempty(cfg.winRule2) then
			self._txtCondition2.text = cfg.winRule2
		else
			goutil.setActive(self._txtCondition2.gameObject, false)
		end
	elseif not string.nilorempty(cfg.winRule2) then
		self._txtCondition1.text = cfg.winRule2

		goutil.setActive(self._txtCondition2.gameObject, false)
	else
		goutil.setActive(self._txtCondition1.gameObject, false)
	end
end

function QiChallengeHardLevelView:_updateEnemyHeadIcons(cfgList)
	self.petScrollList:reloadData(cfgList)
end

function QiChallengeHardLevelView:_updateRewardIcons(cfg)
	local list = MaterialMgr.changeItemStrArr(cfg.prize)

	self.rewardScrollList:reloadData(list)
end

function QiChallengeHardLevelView:_updatePetCell(view, cell, data, tag)
	local proxy = MaterialMgr.setCellByMo(data, cell)

	if proxy then
		proxy.binder:setCallBack(function()
			CommonTipsMgr.instance:showPetTips(data)
		end)
	end
end

function QiChallengeHardLevelView:_clearPetCell(cell)
	MaterialMgr.resetAll(cell.gameObject)
end

function QiChallengeHardLevelView:_updateRewardCell(view, cell, data, tag)
	local go = cell.gameObject
	local con = goutil.findChild(go, "con")
	local gainPrize = goutil.findChild(go, "gainPrize")

	MaterialMgr.setCellByCfg(data, con)
	GameUtil.SetActive(gainPrize, self._curSelectLevelIndex <= QiChallengeModel.instance:getGainPrizeStage())
end

function QiChallengeHardLevelView:_clearRewardCell(cell)
	MaterialMgr.resetAll(cell.gameObject)
end

function QiChallengeHardLevelView:_PM_QiChallengeExtremeResetRes()
	QiChallengeAgent.instance:sendPM_QiChallengeGetInfoReq(self._activityId)
end

return QiChallengeHardLevelView
