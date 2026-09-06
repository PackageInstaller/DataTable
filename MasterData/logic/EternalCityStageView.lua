-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/eternalcity/view/EternalCityStageView.lua

module("logic.extensions.eternalcity.view.EternalCityStageView", package.seeall)

local EternalCityStageView = class("EternalCityStageView", ViewComponent)

function EternalCityStageView:buildUI()
	EternalCityStageView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._txtTitle = self:getTxt("leftTop/txtTitle")

	local stageScrView = self:getGo("stageCol/scrView")
	local stageScrCell = self:getGo("stageCol/scrCell")

	self._stageScrollerList = ScrollerList.create(stageScrView, stageScrCell, GameUtil.handler(self._updateStageCell, self), GameUtil.handler(self._clearStageCell, self))
	self._txtStage = self:getTxt("infoCol/txtStage")
	self._imgPass = self:getGo("infoCol/fmt/imgPass")
	self._fmtView = self:getGo("infoCol/fmt/fmtView")

	local prizeScrView = self:getGo("infoCol/prizeCol/scrView")
	local prizeScrCell = self:getGo("infoCol/prizeCol/scrCell")

	self._prizeScrollerList = ScrollerList.create(prizeScrView, prizeScrCell, GameUtil.handler(self._updatePrizeCell, self), GameUtil.handler(self._clearPrizeCell, self))

	self._prizeScrollerList:setCenterMode(true)

	self._btnEnter = self:getGo("infoCol/btnEnter")
	self._btnBuild = self:getGo("infoCol/btnBuild")
	self._btnShop = self:getGo("infoCol/btnShop")
end

function EternalCityStageView:bindEvents()
	EternalCityStageView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnBuild, self._onClickBtnBuild, self)
	GameUtil.addClickHandler(self._btnEnter, self._onClickBtnEnter, self)
	GameUtil.addClickHandler(self._btnShop, self._onClickBtnShop, self)
end

function EternalCityStageView:unbindEvents()
	EternalCityStageView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnBuild)
	GameUtil.rmClickHandler(self._btnEnter)
	GameUtil.rmClickHandler(self._btnShop)
end

function EternalCityStageView:onEnter()
	EternalCityStageView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	local isInTime = ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._subMo = EternalCityController.instance:getSubMo(self._activityId)
	self._actData = EternalCityConfig.instance:getActivityData(self._activityId)
	self._selectStageId = 0

	self.addGEvent(self, GlobalNotify.HandlePM_EternalCityInfoRes, self._onUpdate, self)
	self:_onUpdate()
end

function EternalCityStageView:onExit()
	EternalCityStageView.super.onExit(self)
	self:_onClearStageCol()
	self:_onClearInfoCol()
end

function EternalCityStageView:_onUpdate()
	local cfg = EternalCityConfig.instance:getStageDatas(self._activityId) or {}

	if cfg then
		for _, data in ipairs(cfg) do
			self._selectStageId = data.stageId

			if not self._subMo:isPassStage(data.stageId) then
				break
			end
		end
	end

	self._selectStageId = Mathf.Clamp(self._selectStageId, 1, #cfg)

	self:_onUpdateStageCol()
	self:_onUpdateInfoCol()

	local isPassAll = self._subMo:isPassAllStages()

	if isPassAll then
		local tipsContent = "关卡已全部通关，进入BOSS挑战"

		local function okFunc()
			self:close()
			UIStateManager.instance:push(ViewName.EternalCityBossView, self._activityId)
		end

		TipsFacade.instance:openTipWindowNoX("提示", tipsContent, okFunc, "确定", UnityEngine.TextAnchor.MiddleCenter)
	end
end

function EternalCityStageView:_onUpdateStageCol()
	local datas = EternalCityConfig.instance:getStageDatas(self._activityId) or {}

	self._stageScrollerList:reloadData(datas)

	local index = 0

	for idx, data in ipairs(datas) do
		if self._selectStageId == data.stageId then
			index = idx - 1

			break
		end
	end

	self._stageScrollerList:MoveCellToCenter(index)
end

function EternalCityStageView:_onClearStageCol()
	self._stageScrollerList:dispose()
end

function EternalCityStageView:_updateStageCell(view, cell, data, tag)
	local stageId = data.stageId
	local data = EternalCityConfig.instance:getStageData(self._activityId, stageId)
	local isUnlock = self._subMo:isUnlockStage(stageId)
	local isUnlockByTime = self._subMo:isUnlockStageByTime(stageId)
	local isUnlockByCond = self._subMo:isUnlockStageByCond(stageId)
	local isPass = self._subMo:isPassStage(stageId)
	local isSelected = self._selectStageId == stageId
	local mainGo = cell.gameObject
	local posA = goutil.findChild(mainGo, "posA")
	local posB = goutil.findChild(mainGo, "posB")
	local root = goutil.findChild(mainGo, "root")
	local txtName = goutil.findChildTextComponent(mainGo, "root/txtName")
	local tagLock = goutil.findChild(mainGo, "root/tagLock")
	local txtTagLock = goutil.findChildTextComponent(mainGo, "root/tagLock/txt")
	local tagPass = goutil.findChild(mainGo, "root/tagPass")
	local tagGray = goutil.findChild(mainGo, "root/tagGray")

	txtName.text = data.name

	GameUtil.SetActive(txtName.gameObject, isUnlock)

	local posGo = cell.data % 2 == 1 and posA or posB
	local x, y, z = Framework.TransformUtil.GetLocalPos(posGo.transform, 0, 0, 0)

	GameUtil.setLocalPos(root, x, y, z)
	GameUtil.SetActive(tagLock, not isUnlock)
	GameUtil.SetActive(tagPass, isPass)
	GameUtil.SetActive(tagGray, (isPass or not isUnlock) and not isSelected)

	if not isUnlockByTime then
		local openTime = data.openTime
		local date = GameUtil.string2date(openTime)

		txtTagLock.text = string.format("%02d.%02d %02d:%02d\n开启", date.month, date.day, date.hour, date.min)
	elseif not isUnlockByCond then
		txtTagLock.text = "未通关\n前一关卡"
	end
end

function EternalCityStageView:_clearStageCell(mainGo)
	return
end

function EternalCityStageView:_onUpdateInfoCol()
	if not self._selectStageId then
		local stageId = 0
		local stageData = EternalCityConfig.instance:getStageData(self._activityId, stageId)

		if not stageData then
			self:_onClearInfoCol()

			return
		end

		self._txtStage.text = string.format("第%s关", stageId)

		local creepsMasterId = stageData.creepsMasterId
		local creepsCfg = EternalCityConfig.instance:getCreepsDatas(creepsMasterId) or {}

		for posId = 1, self._fmtView.transform.childCount do
			local go = self._fmtView.transform:GetChild(posId - 1)
			local mask = goutil.findChild(go, "mask")
			local icon = goutil.findChild(go, "mask/icon")
			local creepsData

			for _, cData in ipairs(creepsCfg) do
				if cData.posId == posId then
					creepsData = cData

					break
				end
			end

			GameUtil.SetActive(mask, creepsData ~= nil)

			if creepsData then
				local petMo = FightingPowerPetMo.New()

				petMo:fromChallengeCreepCo(creepsData, creepsCfg)

				petMo.creepName = creepsData.creepName

				MaterialMgr.setIcon(icon, MatType.Pet, petMo.curFaceId)
				GameUtil.addClickHandler(go, function()
					CommonTipsMgr.instance:showPetTips(petMo)
				end)
			else
				MaterialMgr.clearIcon(icon)
			end
		end

		local prizeList = {}

		if not string.nilorempty(stageData.prize) then
			local arr = string.split(stageData.prize, "#")

			table.insertto(prizeList, arr)
		end

		self._prizeScrollerList:reloadData(prizeList)

		local isPass = self._subMo:isPassStage(stageId)

		GameUtil.SetActive(self._btnEnter, not isPass)

		local result = self:_getTryEnterStageResultAndTips(false, stageId)

		GameUtil.SetGray(self._btnEnter, result ~= GameEnum.ResultCode.Success)
	end
end

function EternalCityStageView:_onClearInfoCol()
	self._txtStage.text = ""

	for posId = 1, self._fmtView.transform.childCount do
		local go = self._fmtView.transform:GetChild(posId - 1)
		local icon = goutil.findChild(go, "mask/icon")

		MaterialMgr.clearIcon(icon)
		GameUtil.rmClickHandler(go)
	end

	self._prizeScrollerList:dispose()
end

function EternalCityStageView:_updatePrizeCell(view, cell, prizeStr, tag)
	local mainGo = cell.gameObject

	MaterialMgr.setCellByCfg(prizeStr, mainGo)
end

function EternalCityStageView:_clearPrizeCell(cell)
	local mainGo = cell.gameObject

	MaterialMgr.resetAll(mainGo)
end

function EternalCityStageView:_onClickBtnTip()
	local key = self._actData.ruleKeyStage

	TipsFacade.instance:openRulesView(key)
end

function EternalCityStageView:_onClickBtnBuild()
	UIStateManager.instance:push(ViewName.EternalCityActiveBuildView, self._activityId)
end

function EternalCityStageView:_onClickBtnShop()
	UIStateManager.instance:push(ViewName.EternalCityBagView, self._activityId)
	UIStateManager.instance:push(ViewName.EternalCityBuildShopTabView, self._activityId)
end

function EternalCityStageView:_onClickBtnEnter()
	local stageId = self._selectStageId
	local result = self:_getTryEnterStageResultAndTips(true, stageId)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	EternalCityController.instance:enterStageBattle(self._activityId, stageId)
end

function EternalCityStageView:_getTryEnterStageResultAndTips(isNeedTips, stageId)
	local result = GameEnum.ResultCode.Success
	local tips = ""

	if not ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._activityId) then
		result = GameEnum.ResultCode.Error
		tips = "不在活动时间范围内"
	end

	if result == GameEnum.ResultCode.Success and self._subMo:isPassStage(stageId) then
		result = GameEnum.ResultCode.Error
		tips = "已通关"
	end

	if result == GameEnum.ResultCode.Success and not self._subMo:isUnlockStageByTime(stageId) then
		result = GameEnum.ResultCode.Error
		tips = "未到开启时间"
	end

	if result == GameEnum.ResultCode.Success and not self._subMo:isUnlockStageByCond(stageId) then
		result = GameEnum.ResultCode.Error
		tips = "未通关前一关卡"
	end

	if isNeedTips then
		FloatWordMgr.instance:show(tips)
	end

	return result
end

return EternalCityStageView
