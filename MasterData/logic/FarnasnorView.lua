-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/farnas/view/FarnasnorView.lua

module("logic.extensions.farnas.view.FarnasnorView", package.seeall)

local FarnasnorView = class("FarnasnorView", ViewComponent)

function FarnasnorView:buildUI()
	FarnasnorView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._btnTip = goutil.findChild(self.mainGO, "leftTop/btnTip")
	self._txtTitle = goutil.findChildTextComponent(self.mainGO, "leftTop/txtTitle")
	self._fmtCol_fmtView = goutil.findChild(self.mainGO, "fmtCol/fmtView")
	self._fmtCol_fmtCell = goutil.findChild(self.mainGO, "fmtCol/fmtCell")

	GameUtil.SetActive(self._fmtCol_fmtCell, false)

	local worldRoot = self:getGo("worldRoot")

	self._worldSliderMo = WorldSliderMo.New(worldRoot)
	self._txtWorldScore = goutil.findChildTextComponent(self.mainGO, "worldRoot/worldPrize/score/txtScore")
	self._tipsCol = goutil.findChild(self.mainGO, "tipsCol")
	self._tipsCol_txt = goutil.findChildTextComponent(self.mainGO, "tipsCol/txt")
	self._singleLine = self:getGo("fmtCol/fmtView"):GetComponent(ComponentType.UILayoutSingleLine)
end

function FarnasnorView:bindEvents()
	FarnasnorView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	self._worldSliderMo:bindEvents()
end

function FarnasnorView:unbindEvents()
	FarnasnorView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	self._worldSliderMo:unbindEvents()
end

function FarnasnorView:onEnter()
	FarnasnorView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._activityType = FarnasController.instance:getActivityType()

	if self._activityId <= 0 then
		local text = string.format("活动不在开启期限内( activityId = %d )", self._activityId)

		local function func()
			self:close()
		end

		TipsFacade.instance:openTipWindow("提示", text, func, "确定", UnityEngine.TextAnchor.MiddleCenter)

		return
	end

	self:_onSetUI()
	self.addGEvent(self, GlobalNotify.FarnasClgGetInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.FarnasGainNormalClgProgressPrizeRes, self._onUpdate, self)
	self:_onUpdate()
end

function FarnasnorView:onExit()
	FarnasnorView.super.onExit(self)
	self:_onClearSliderCol()
	self:_onClearFmtColUI()
end

function FarnasnorView:_onSetUI()
	self:_initScoreSlider()

	self._tipsCol_txt.text = FarnasConfig.instance:getNorRuleDesc(self._activityId)

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self._tipsCol:GetComponent(goutil.Type_RectTransform))
end

function FarnasnorView:_onUpdate()
	self:_onUpdateSliderColUI()
	self:_onUpdateFmtColUI()
end

function FarnasnorView:_onUpdateSliderColUI()
	self._worldSliderMo:updateWorldReward()
	self._worldSliderMo:relocation()
end

function FarnasnorView:_onClearSliderCol()
	self._worldSliderMo:onExit()
end

function FarnasnorView:_initScoreSlider()
	local worldParam = {}

	worldParam.view = self
	worldParam.isShowDefaultPos = true
	worldParam.elementSpacing = 90
	worldParam.isUpToBottom = false
	worldParam.prizeCfgs = FarnasConfig.instance:getNorProgressCfgs(self._activityId)

	function worldParam.getWorldProgress()
		return FarnasController.instance:getProgressOfNorClg()
	end

	function worldParam.getNeedScoreByRewardCfg(data)
		return data.progress
	end

	function worldParam.isWorldRewardCanGet(data)
		return FarnasController.instance:isCanGainPrizeOfNorClg(self._activityId, data.dataBitId)
	end

	function worldParam.isWorldRewardGeted(data)
		return FarnasController.instance:isHasGainPrizeOfNorClg(self._activityId, data.dataBitId)
	end

	function worldParam.sendGainWorldPrizeReq(data)
		FarnasChallengeAgent.instance:sendPM_FarnasGainNormalClgProgressPrizeReq(self._activityId, data.dataBitId)
	end

	function worldParam.getPrizeText(rewardCfg)
		return string.format("%d", FarnasController.instance:getProgressOfNorClg())
	end

	function worldParam.getScoreTxtByCfg(data)
		return string.format("%d", data.progress)
	end

	worldParam.txtWorldScore = self._txtWorldScore
	worldParam.worldSliderEndOffset = 35

	self._worldSliderMo:initParam(worldParam)
	self._worldSliderMo:onEnter()
	self._worldSliderMo:updateWorldReward()
	self._worldSliderMo:relocation()
end

function FarnasnorView:_onUpdateFmtColUI()
	local parentTran = self._fmtCol_fmtView.transform
	local childGo = self._fmtCol_fmtCell
	local children = GameUtil.getChildren(parentTran)
	local groupId = FarnasController.instance:getNormalClgTodayGroupId(self._activityId)
	local cfg = FarnasConfig.instance:getNorStageGroupCfg(self._activityId, groupId)
	local length = 0

	if cfg then
		length = #cfg

		for idx, data in ipairs(cfg) do
			local mainGo = children[idx]

			if mainGo == nil then
				mainGo = goutil.cloneAndSetParent(childGo, parentTran, string.format("%s_%s", childGo.name, idx))
			end

			self:_updateFmtCell(mainGo, data.groupId, data.dataBitId)
		end
	end

	for idx = 1, parentTran.childCount do
		local mainGo = parentTran:GetChild(idx - 1)

		GameUtil.SetActive(mainGo, idx <= length)
	end

	self._singleLine:Layout()
end

function FarnasnorView:_onClearFmtColUI()
	local parentTran = self._fmtCol_fmtView.transform
	local children = GameUtil.getChildren(parentTran)

	for _, mainGo in pairs(children) do
		self:_clearFmtCell(mainGo)
	end
end

function FarnasnorView:_updateFmtCell(mainGo, groupId, dataBitId)
	local isPass = false
	local score = FarnasController.instance:getBestScoreOfNorClg(self._activityId, dataBitId)
	local groupData = FarnasConfig.instance:getNorStageGroupCfgByDataBitId(self._activityId, groupId, dataBitId)
	local creepsMasterId = groupData.creepsMasterId
	local creepsCfgs = FarnasConfig.instance:getCreepsCfgs(creepsMasterId)
	local btnDetail = goutil.findChild(mainGo, "btnDetail")
	local fmt = goutil.findChild(mainGo, "fmt")
	local fmtView = goutil.findChild(mainGo, "fmt/fmtView")
	local imgPass = goutil.findChild(mainGo, "fmt/imgPass")
	local btnFormation = goutil.findChild(mainGo, "fmt/btnFormation")
	local txtScore = goutil.findChildTextComponent(mainGo, "txtScore")

	for posId = 1, fmtView.transform.childCount do
		local go = fmtView.transform:GetChild(posId - 1)
		local icon = goutil.findChild(go, "icon")
		local creepsData

		for _, cData in ipairs(creepsCfgs) do
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
				proxy.binder:setClickCallBack(nil)
			end
		else
			MaterialMgr.resetAll(icon)
		end
	end

	GameUtil.SetActive(imgPass, isPass)

	txtScore.text = score

	GameUtil.addClickHandler(btnDetail, GameUtil.handler(self._onClickFmtCellBtnDetail, self, groupId, dataBitId))
	GameUtil.addClickHandler(btnFormation, GameUtil.handler(self._onClickFmtCellBtnFormation, self, groupId, dataBitId))
end

function FarnasnorView:_clearFmtCell(mainGo)
	local fmtView = goutil.findChild(mainGo, "fmt/fmtView")
	local btnFormation = goutil.findChild(mainGo, "fmt/btnFormation")

	for posId = 1, fmtView.transform.childCount do
		local go = fmtView.transform:GetChild(posId - 1)
		local icon = goutil.findChild(go, "icon")

		MaterialMgr.resetAll(icon)
	end

	GameUtil.rmClickHandler(btnFormation)
end

function FarnasnorView:_onClickFmtCellBtnDetail(groupId, dataBitId)
	UIStateManager.instance:push(ViewName.FarnasnordetailView, self._activityId, groupId, dataBitId)
end

function FarnasnorView:_onClickFmtCellBtnFormation(groupId, dataBitId)
	local result, tips = FarnasController.instance:getTryFightNorClgResultAndTips(self._activityId, dataBitId)

	FloatWordMgr.instance:show(tips)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	FarnasController.instance:enterBattleOfNorClg(self._activityId, groupId, dataBitId)
end

function FarnasnorView:_onClickBtnTip()
	local key = FarnasConfig.instance:getRuleKey(self._activityId, "ruleKeyNor")

	TipsFacade.instance:openRulesView(key)
end

return FarnasnorView
