-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingofradiantgoldclg/view/KingOfRadiantGoldClgCollectView.lua

module("logic.extensions.kingofradiantgoldclg.view.KingOfRadiantGoldClgCollectView", package.seeall)

local KingOfRadiantGoldClgCollectView = class("KingOfRadiantGoldClgCollectView", ViewComponent)

function KingOfRadiantGoldClgCollectView:ctor()
	KingOfRadiantGoldClgCollectView.super.ctor(self)
end

function KingOfRadiantGoldClgCollectView:buildUI()
	KingOfRadiantGoldClgCollectView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnOneKeyPass = self:getGo("btnOneKeyPass")
	self._btnGet = self:getGo("btnGet")
	self._redBtnGet = self:getGo("btnGet/redpoint")
	self._hasGain = self:getGo("btnGet/hasGain")
	self._txtProgress = self:getTxt("txtProgress")
	self._goldView = self:getGo("goldView")
	self._goldCellList = {}

	for idx = 1, self._goldView.transform.childCount do
		local mainGo = self._goldView.transform:GetChild(idx - 1).gameObject
		local cell = {}

		cell._mainGo = mainGo
		cell._icon = goutil.findChild(mainGo, "icon")

		table.insert(self._goldCellList, cell)
	end
end

function KingOfRadiantGoldClgCollectView:bindEvents()
	KingOfRadiantGoldClgCollectView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnOneKeyPass, self._onClickBtnOneKeyPass, self)
	GameUtil.addClickHandler(self._btnGet, self._onClickBtnGet, self)
end

function KingOfRadiantGoldClgCollectView:unbindEvents()
	KingOfRadiantGoldClgCollectView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnOneKeyPass)
	GameUtil.rmClickHandler(self._btnGet)
end

function KingOfRadiantGoldClgCollectView:onEnter()
	KingOfRadiantGoldClgCollectView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._activityType = KingOfRadiantGoldClgController.instance:getActivityType()

	local isInTime = KingOfRadiantGoldClgController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._clgMo = KingOfRadiantGoldClgController.instance:getClgMo(self._activityId)

	self.addGEvent(self, GlobalNotify.HandlePM_KingOfRadiantGoldClgInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_KingOfRadiantGoldClgOneKeyPassRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_KingOfRadiantGoldClgGainPetRes, self._onUpdate, self)
	RedPointController.instance:regRedPoint(self._redBtnGet, RedPointModel.ID_KingOfRadiantGoldClg_FinialPrize)
	self:_onUpdate()
end

function KingOfRadiantGoldClgCollectView:onExit()
	KingOfRadiantGoldClgCollectView.super.onExit(self)
	RedPointController.instance:unregRedPoint(self._redBtnGet)
	self:_onClearGoldCol()
end

function KingOfRadiantGoldClgCollectView:_onUpdate()
	local cfgs = KingOfRadiantGoldClgConfig.instance:getStageCfgs(self._activityId) or {}
	local totalCount = 0
	local passCount = 0

	for _, cfg in ipairs(cfgs) do
		for _, data in ipairs(cfg) do
			totalCount = totalCount + 1

			local cell = self._goldCellList[totalCount]

			if cell == nil then
				printError(string.format("配置超出，预制缺失gold( activityId:%s, challengeId:%s, stageId:%s )", self._activityId, data.challengeId, data.stageId))

				break
			end

			self:_updateGoldCell(cell, data.challengeId, data.stageId)

			if self._clgMo:isPassStage(data.challengeId, data.stageId) then
				passCount = passCount + 1
			end
		end
	end

	self._totalCount = totalCount
	self._passCount = passCount

	for idx, cell in ipairs(self._goldCellList) do
		if totalCount < idx then
			self:_clearGoldCell(cell)
		end

		GameUtil.SetActive(cell._mainGo, idx <= self._totalCount)
	end

	local isHasGain = self._clgMo:isHasGainPrize()

	GameUtil.SetActive(self._btnOneKeyPass, not isHasGain and self._passCount < self._totalCount)
	GameUtil.SetActive(self._btnGet, self._passCount >= self._totalCount)
	GameUtil.SetActive(self._hasGain, isHasGain)

	if self._strTxtProgress == nil then
		self._strTxtProgress = self._txtProgress.text
	end

	self._txtProgress.text = string.format(self._strTxtProgress, self._passCount, self._totalCount)
end

function KingOfRadiantGoldClgCollectView:_onClearGoldCol()
	for _, cell in pairs(self._goldCellList) do
		self:_clearGoldCell(cell)
	end
end

function KingOfRadiantGoldClgCollectView:_updateGoldCell(cell, challengeId, stageId)
	local isPass = self._clgMo:isPassStage(challengeId, stageId)

	GameUtil.SetActive(cell._icon, isPass)
end

function KingOfRadiantGoldClgCollectView:_clearGoldCell(cell)
	return
end

function KingOfRadiantGoldClgCollectView:_onClickBtnOneKeyPass()
	if self._clgMo:isHasGainPrize() then
		FloatWordMgr.instance:show("您已获得最终奖励")

		return
	end

	if self._passCount >= self._totalCount then
		FloatWordMgr.instance:show("已集满")

		return
	end

	local diffCount = Mathf.Max(self._totalCount - self._passCount, 0)
	local passData = KingOfRadiantGoldClgConfig.instance:getPassData(self._activityId, diffCount)

	if passData == nil then
		FloatWordMgr.instance:show("无法进行一键通关")

		return
	end

	local matType, matId, matNum = MaterialMgr.getMatParams(passData.cost)
	local matName = MaterialMgr.getMaterialsName(matType, matId)
	local content = string.format("是否确认消耗[%s*%s]\n一键激活剩余的勋章？\nps：价格根据当前勋章的剩余数量换算\n剩余数量越少，价格越低哦！", matName, matNum)

	local function successCallBack()
		KingOfRadiantGoldClgController.instance:sendPM_KingOfRadiantGoldClgOneKeyPassReq(self._activityId, diffCount)
	end

	local toggleFunc, togTxt
	local alignment = UnityEngine.TextAnchor.MiddleCenter
	local otherCallBack, autoOpenSource

	TipsFacade.instance:openPopupCostMatViewNew(matType, matId, matNum, content, successCallBack, toggleFunc, togTxt, alignment, otherCallBack, autoOpenSource)
end

function KingOfRadiantGoldClgCollectView:_onClickBtnGet()
	local result = self._clgMo:getTryResultAndTipsGetFinalPrize(true)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	KingOfRadiantGoldClgController.instance:sendPM_KingOfRadiantGoldClgGainPetReq(self._activityId)
end

return KingOfRadiantGoldClgCollectView
