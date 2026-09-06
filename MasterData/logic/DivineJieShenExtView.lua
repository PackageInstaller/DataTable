-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinejieshen/view/DivineJieShenExtView.lua

module("logic.extensions.divinejieshen.view.DivineJieShenExtView", package.seeall)

local DivineJieShenExtView = class("DivineJieShenExtView", ViewComponent)

function DivineJieShenExtView:ctor()
	DivineJieShenExtView.super.ctor(self)
end

function DivineJieShenExtView:buildUI()
	DivineJieShenExtView.super.buildUI(self)

	local tabScrView = goutil.findChild(self.mainGO, "tabCol/scrView")
	local tabScrCell = goutil.findChild(self.mainGO, "tabCol/scrCell")

	self._tabScrollList = ScrollerList.create(tabScrView, tabScrCell, GameUtil.handler(self._updateTabCell, self), GameUtil.handler(self._clearTabCell, self))

	self._tabScrollList:setCenterMode(true)

	self._enterLeftFightBtn = goutil.findChild(self.mainGO, "rightView/leftFormation/enterFightBtnLeft")
	self._resetLeftFightBtn = goutil.findChild(self.mainGO, "rightView/leftFormation/resetFightBtnLeft")
	self._enterRightFightBtn = goutil.findChild(self.mainGO, "rightView/rightFormation/enterFightBtnRight")
	self._resetRightFightBtn = goutil.findChild(self.mainGO, "rightView/rightFormation/resetFightBtnRight")
	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._slider = self:getSlider("rightView/slider/slider_2")
	self._bottomTowerGroup = goutil.findChild(self.mainGO, "rightView/slider/bottomTowerTextGroup")
	self._sliderRightButtomText = goutil.findChildTextComponent(self.mainGO, "rightView/slider/rightBottomTowerText")
	self._noFinishTipText = goutil.findChildTextComponent(self.mainGO, "rightView/finishText")
	self._leftFmtView = goutil.findChild(self.mainGO, "rightView/leftFormation/formationLeft")
	self._rightFmtView = goutil.findChild(self.mainGO, "rightView/rightFormation/formationRight")
	self._btnTip = goutil.findChild(self.mainGO, "leftTop/btnTip")
	self._towerNameArr = {
		"icon_17000_yi02",
		"icon_16026_shenyaochi",
		"icon_16026_shenyaoyi"
	}
end

function DivineJieShenExtView:bindEvents()
	DivineJieShenExtView.super.bindEvents(self)
	GameUtil.addClickHandler(self._enterLeftFightBtn, GameUtil.handler(self._onClikBtnFight, self, GameEnum.BattleTeam.Left))
	GameUtil.addClickHandler(self._resetLeftFightBtn, GameUtil.handler(self._onClikBtnReset, self, GameEnum.BattleTeam.Left))
	GameUtil.addClickHandler(self._enterRightFightBtn, GameUtil.handler(self._onClikBtnFight, self, GameEnum.BattleTeam.Right))
	GameUtil.addClickHandler(self._resetRightFightBtn, GameUtil.handler(self._onClikBtnReset, self, GameEnum.BattleTeam.Right))
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClikBtnTip, self)
end

function DivineJieShenExtView:unbindEvents()
	DivineJieShenExtView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._enterLeftFightBtn)
	GameUtil.rmClickHandler(self._resetLeftFightBtn)
	GameUtil.rmClickHandler(self._enterRightFightBtn)
	GameUtil.rmClickHandler(self._resetRightFightBtn)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
end

function DivineJieShenExtView:onEnter()
	DivineJieShenExtView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = DivineJieShenController.instance:getActivityId()
	end

	self._activityType = DivineJieShenController.instance:getActivityType()

	local isInTime = DivineJieShenController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		local text = string.format("活动不在开启期限内( activityId = %d )", self._activityId)

		local function func()
			self:close()
		end

		TipsFacade.instance:openTipWindow("提示", text, func, "确定", UnityEngine.TextAnchor.MiddleCenter)

		return
	end

	self._curTowerId = 1
	self._divineJieShenMo = DivineJieShenModel.instance:getDivineJieShenMo(self._activityId)

	self.addGEvent(self, GlobalNotify.HandlePM_DivineJieShenClgGetInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_DivineJieShenClgResetExtremeStageRes, self._onUpdate, self)
	DivineJieShenController.instance:sendPM_DivineJieShenClgGetInfoReq(self._activityId)
end

function DivineJieShenExtView:onExit()
	DivineJieShenExtView.super.onExit(self)
end

function DivineJieShenExtView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function DivineJieShenExtView:_onUpdateUI()
	self:_onUpdateTabColUI()
	self:_onUpdateFmtColUI()
	self:_onUpdateRightViewUI()
end

function DivineJieShenExtView:_onUpdateTabColUI()
	self._tabScrollList:reloadData(self._tabInfoList)
end

function DivineJieShenExtView:_onClikBtnTip()
	local key = DivineJieShenConfig.instance:getCommonValue(self._activityId, "ruleKeyExt")

	TipsFacade.instance:openRulesView(key)
end

function DivineJieShenExtView:_onUpdateData()
	self._tabInfoList = {}

	local cfg = DivineJieShenConfig.instance:getExtTowerData(self._activityId)

	for index, data in ipairs(cfg or {}) do
		local info = {}

		info.index = index
		info.data = data
		info.towerId = data.towerId

		table.insert(self._tabInfoList, info)
	end

	local curTowerId = self._divineJieShenMo:getCurTowerIdInExt()

	self:_updateTowerAndStageId(curTowerId)
end

function DivineJieShenExtView:_updateTowerAndStageId(towerId)
	self._curTowerId = towerId
	self._curStageId = self._divineJieShenMo:getStageIdInExt(towerId)
end

function DivineJieShenExtView:_onUpdateFmtColUI()
	local towerId = self._curTowerId
	local stageId = self._curStageId
	local stageData = DivineJieShenConfig.instance:getExtStageData(self._activityId, towerId, stageId)

	if stageData then
		if not stageData.creepsMasterIdLeft then
			local creepsMasterIdLeft = 0

			if stageData then
				if not stageData.creepsMasterIdRight then
					local creepsMasterIdRight = 0
					local enemyCreepsCfgLeft = DivineJieShenConfig.instance:getClgCreepsCfg(creepsMasterIdLeft) or {}
					local enemyCreepsCfgRight = DivineJieShenConfig.instance:getClgCreepsCfg(creepsMasterIdRight) or {}

					self:_showFromCell(self._leftFmtView, enemyCreepsCfgLeft)
					self:_showFromCell(self._rightFmtView, enemyCreepsCfgRight)
				end
			end
		end
	end
end

function DivineJieShenExtView:_showFromCell(fmtView, cfg)
	local map = {}

	for _, data in ipairs(cfg) do
		map[data.posId] = data
	end

	for posId = 1, fmtView.transform.childCount do
		local creepsData = map[posId]
		local go = fmtView.transform:GetChild(posId - 1)
		local con = goutil.findChild(go, "con")

		MaterialMgr.clearIcon(con)
		GameUtil.SetActive(go, false)

		if creepsData then
			MaterialMgr.setIcon(con, MatType.PET_SKIN, (checknumber(creepsData.faceId) > 0 or nil) and checknumber(creepsData.faceId))
			GameUtil.SetActive(go, true)
			GameUtil.SetActive(con, true)
		end
	end
end

function DivineJieShenExtView:_updateTabCell(view, cell, info, tag)
	local timeLimit = goutil.findChild(cell, "TimeLimit")
	local timeLimitText = goutil.findChildTextComponent(cell, "TimeLimit/timeLimitText")
	local txtStage = goutil.findChildTextComponent(cell, "txtStage")
	local tipSelect = goutil.findChild(cell, "imgSelect")
	local imgPass = goutil.findChild(cell, "imgPass")
	local tabIdx = info.index
	local data = info.data
	local towerId = info.towerId
	local lastTowerId = towerId - 1
	local isPassLastTower = self._divineJieShenMo:isPassInTowerInExt(lastTowerId)
	local isGetTime = DivineJieShenController.instance:checkTowerIsInTime(self._activityId, towerId)

	txtStage.text = data.towerName

	local isSelect = self._curTowerId == towerId

	GameUtil.SetActive(tipSelect, isSelect)

	local thisTowerIsPass = self._divineJieShenMo:isPassInTowerInExt(towerId)

	GameUtil.SetActive(imgPass, thisTowerIsPass)

	local lockStr = ""

	if not isPassLastTower and not isGetTime then
		local lastData = DivineJieShenConfig.instance:getExtOnlyTowerData(self._activityId, lastTowerId)
		local timeStr = GameUtil.formatTimeString("%m.%d %H:%M", data.openTime)

		lockStr = string.format("通关%s\n%s\n后开启", lastData.towerName, timeStr)
	elseif not isPassLastTower and isGetTime then
		local lastData = DivineJieShenConfig.instance:getExtOnlyTowerData(self._activityId, lastTowerId)

		lockStr = string.format("通关%s\n后开启", lastData.towerName)
	elseif isPassLastTower and not isGetTime then
		local timeStr = GameUtil.formatTimeString("%m.%d %H:%M", data.openTime)

		lockStr = string.format("%s\n后开启", timeStr)
	end

	timeLimitText.text = lockStr

	GameUtil.SetActive(timeLimit, not isPassLastTower or not isGetTime)

	local iconHead = goutil.findChild(cell, "img/Image")

	uGuiUtil.setSpriteToImage(iconHead, uGuiUtil.SpriteType.BigBg, GameUrl.getCharacterIconUrl(self._towerNameArr[tabIdx]))
	GameUtil.addClickHandler(cell, GameUtil.handler(self._clickTabCell, self, towerId, thisTowerIsPass))
end

function DivineJieShenExtView:_clickTabCell(towerId, clickTowerIsPass)
	if not DivineJieShenController.instance:checkTowerIsInTime(self._activityId, towerId) then
		FloatWordMgr.instance:show("关卡未到开启时间，不可进入")

		return
	end

	local curTowerId = self._divineJieShenMo:getCurTowerIdInExt()

	if curTowerId < towerId then
		FloatWordMgr.instance:show("未通关上一大关，不可进入该关卡")

		return
	end

	if clickTowerIsPass then
		FloatWordMgr.instance:show("关卡已通关,不可返回")

		return
	end

	self:_updateTowerAndStageId(towerId)
	self:_onUpdateUI()
end

function DivineJieShenExtView:_clearTabCell(cell)
	local mainGo = cell.gameObject

	GameUtil.rmClickHandler(mainGo)
end

function DivineJieShenExtView:_onUpdateRightViewUI()
	local curTowerId = self._divineJieShenMo:getCurTowerIdInExt()
	local curStageId = self._divineJieShenMo:getStageIdInExt(curTowerId)
	local ruleTip = DivineJieShenController.instance:getCurTowerRule(self._activityId, curTowerId)
	local tips = goutil.findChildTextComponent(self.mainGO, "rightView/tips/txt")

	tips.text = ruleTip

	local leftTitle = goutil.findChildTextComponent(self.mainGO, "rightView/leftFormation/leftTitle/Image/Text")
	local rightTitle = goutil.findChildTextComponent(self.mainGO, "rightView/rightFormation/rightTitle/Image/Text")
	local leftTitleNum = self._divineJieShenMo:getScoreInTeamInExt(self._curTowerId, self._curStageId, GameEnum.BattleTeam.Left)
	local rightTitleNum = self._divineJieShenMo:getScoreInTeamInExt(self._curTowerId, self._curStageId, GameEnum.BattleTeam.Right)

	leftTitle.text = "存活精灵：" .. tostring(leftTitleNum) .. "只"
	rightTitle.text = "存活精灵：" .. tostring(rightTitleNum) .. "只"

	local isFinishCurStage = self._divineJieShenMo:isPassInStageInExt(self._curTowerId, self._curStageId)

	GameUtil.SetActive(self._noFinishTipText, not isFinishCurStage)

	local compareModeTxt = goutil.findChildTextComponent(self.mainGO, "rightView/compareModeTxt")

	compareModeTxt.text = DivineJieShenController.instance:getCompareMode(self._activityId, self._curTowerId, self._curStageId)

	local leftImgPass = goutil.findChild(self.mainGO, "rightView/leftFormation/imgPass1")
	local rightImgPass = goutil.findChild(self.mainGO, "rightView/rightFormation/imgPass2")
	local leftIsPass = self._divineJieShenMo:isPassInTeamInExt(self._curTowerId, self._curStageId, GameEnum.BattleTeam.Left)
	local rightIsPass = self._divineJieShenMo:isPassInTeamInExt(self._curTowerId, self._curStageId, GameEnum.BattleTeam.Right)

	GameUtil.SetActive(leftImgPass, leftIsPass)
	GameUtil.SetActive(rightImgPass, rightIsPass)
	GameUtil.SetActive(self._resetLeftFightBtn, leftIsPass)
	GameUtil.SetActive(self._enterLeftFightBtn, not leftIsPass)
	GameUtil.SetActive(self._resetRightFightBtn, rightIsPass)
	GameUtil.SetActive(self._enterRightFightBtn, not rightIsPass)

	local stageCount = self._divineJieShenMo:getStageCount(self._curTowerId)
	local curStage = self._divineJieShenMo:getStageIdInExt(self._curTowerId)

	self._slider:SetValue((curStage - 1) / (stageCount - 1))

	self._sliderRightButtomText.text = string.format("%d层", stageCount)

	if stageCount > 2 and #GameUtil.getChildren(self._bottomTowerGroup) < stageCount - 1 then
		local childTowerText = goutil.findChild(self._bottomTowerGroup, "Text")

		for i = 1, stageCount - 2 do
			local curTextObj = goutil.cloneAndSetParent(childTowerText, self._bottomTowerGroup.transform, string.format("Text%d", i))
			local curText = curTextObj:GetComponent("Text")

			curText.text = string.format("%s层", i + 1)
		end
	end
end

function DivineJieShenExtView:_onClikBtnReset(teamId)
	local curTowerId = self._divineJieShenMo:getCurTowerIdInExt()
	local curStageId = self._divineJieShenMo:getStageIdInExt(curTowerId)

	if self._divineJieShenMo:isPassInStageInExt(self._curTowerId, self._curStageId) then
		FloatWordMgr.instance:show("关卡已通关，不能重置")

		return
	end

	if curTowerId < self._curTowerId then
		FloatWordMgr.instance:show("关卡未解锁，不能重置")

		return
	end

	local text = string.format("当前存活精灵：%d，是否确认重置?", self._divineJieShenMo:getScoreInTeamInExt(curTowerId, curStageId, teamId))

	local function cancleFunc()
		return
	end

	local function sureFunc()
		DivineJieShenController.instance:sendPM_DivineJieShenClgResetExtremeStageReq(self._activityId, (teamId == GameEnum.BattleTeam.Right or nil) and false)
	end

	TipsFacade.instance:openPopupWindow("提示", text, sureFunc, cancleFunc, "确定", "取消")
end

function DivineJieShenExtView:_onClikBtnFight(teamId)
	local curTowerId = self._divineJieShenMo:getCurTowerIdInExt()
	local curStageId = self._divineJieShenMo:getStageIdInExt(curTowerId)

	if not DivineJieShenController.instance:checkTowerIsInTime(self._activityId, self._curTowerId) then
		FloatWordMgr.instance:show("关卡未到开启时间，不可进入")

		return
	end

	if self._divineJieShenMo:isPassInTowerInExt(self._curTowerId) then
		FloatWordMgr.instance:show("本关卡已通关，不能重新战斗")

		return
	end

	if curTowerId < self._curTowerId then
		FloatWordMgr.instance:show("未通关上一大关，不能进入战斗")

		return
	end

	DivineJieShenController.instance:enterBattleInExt(self._activityId, self._curTowerId, self._curStageId, teamId)
end

return DivineJieShenExtView
