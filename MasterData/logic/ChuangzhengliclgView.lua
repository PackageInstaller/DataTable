-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chuangzhengli/view/ChuangzhengliclgView.lua

module("logic.extensions.chuangzhengli.view.ChuangzhengliclgView", package.seeall)

local ChuangzhengliclgView = class("ChuangzhengliclgView", ViewComponent)

function ChuangzhengliclgView:ctor()
	ChuangzhengliclgView.super.ctor(self)
end

function ChuangzhengliclgView:unbindEvents()
	ChuangzhengliclgView.super.unbindEvents(self)
	self._btnTip:RemoveClickListener()
	self._btnLunhun:RemoveClickListener()
	self._btnReward:RemoveClickListener()
	self._btnQiji:RemoveClickListener()
	self._btnClose:RemoveClickListener()
	self._btnReset:RemoveClickListener()
	self._customInput:RemoveListener()
end

function ChuangzhengliclgView:bindEvents()
	ChuangzhengliclgView.super.bindEvents(self)
	self._btnTip:AddClickListener(self._onClickbtnTip, self)
	self._btnLunhun:AddClickListener(self._onClickbtnLunhun, self)
	self._btnReward:AddClickListener(self._onClickbtnReward, self)
	self._btnQiji:AddClickListener(self._onClickbtnQiji, self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
	self._btnReset:AddClickListener(self._onClickbtnReset, self)
	self._customInput:AddListener(self._onCustomInputCallback, self)
end

function ChuangzhengliclgView:buildUI()
	ChuangzhengliclgView.super.buildUI(self)

	self._txtDamage = self:getTxt("damagetip/txtDamage")
	self._singleLine = self:getGo("fmtCol/fmtView"):GetComponent(ComponentType.UILayoutSingleLine)
	self._fmtCol_fmtView = goutil.findChild(self.mainGO, "fmtCol/fmtView")
	self._fmtCol_fmtCell = goutil.findChild(self.mainGO, "fmtCol/fmtCell")
	self._btnTip = self:getBtn("btnTip")
	self._txtTime = self:getTxt("txtTime")
	self._btnLunhun = self:getBtn("rule/btnLunhun")
	self._btnReward = self:getBtn("info/btnReward")
	self._btnQiji = self:getBtn("rule/btnQiji")
	self._conGo = self:getGo("progress/tableview/Viewport/Content/Slider/Fill Area/Fill/handle/head/con")
	self._itemGo = self:getGo("rule/item")
	self._btnClose = self:getBtn("btnClose")
	self._btnReset = self:getBtn("btnReset")
	self._tipsObjGo = self:getGo("tipsObj")
	self._customInput = UICustomInput.Get(self._tipsObjGo)
	self._txtDesc = self:getTxt("tipsObj/txtDesc")
	self._txtCondition = self:getTxt("txtCondition")
	self._iconGo = self:getGo("info/btnReward/icon")
	self._levelSlider = self:getSlider("info/level")
	self._upLevelTxt = self:getTxt("info/txtUp")
	self._downLevelTxt = self:getTxt("info/txtDown")
	self._curLevelTxt = self:getTxt("info/level/Fill Area/info/txtLevel")
	self._headObj = self:getGo("info/level/Fill Area/info/head")
	self._txtTitle = self:getTxt("tipsObj/txtTitle")
end

function ChuangzhengliclgView:onExit()
	ChuangzhengliclgView.super.onExit(self)
	self:_onClearFmtColUI()
	HeadItemController.instance:resetHeadCell(self._headObj)
	MaterialMgr.resetAll(self._itemGo)
	MaterialMgr.resetAll(self._iconGo)
end

function ChuangzhengliclgView:onEnter()
	ChuangzhengliclgView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.ChuangZhengliClgGetInfoRes, self._updateUI, self)
	self.addGEvent(self, GlobalNotify.ChuangZhengliClgResetStageRes, self._onChuangZhengliClgResetStageRes, self)

	self._activityId = self:getFirstParam()
	self._actStartTime = ActivityDefineController.instance:getStartTimeAndEndTime(ChuangzhengliController.instance:getActivityType(), self._activityId)
	self._info = ChuangzhengliModel.instance:getInfo(self._activityId)

	local stageCfgs = ChuangzhengliConfig.instance:getStageCfgs(self._activityId)

	self._nextStageId = self._info.passStageId + 1

	if self._nextStageId >= #stageCfgs then
		self._nextStageId = #stageCfgs
	end

	self._actCfg = ChuangzhengliConfig.instance:getActCfg(self._activityId)
	self._params = GameUtil.jsonToTable(self._actCfg.paramStr)

	self:_updateUI()
	self:_setTime()
	self:_setStageReward()
	self:_showCondition()
	self:_setSliderInfo()
	goutil.setActive(self._tipsObjGo, false)
	ChuangZhengliClgAgent.instance:sendPM_ChuangZhengliClgGetInfoReq(self._activityId)
end

function ChuangzhengliclgView:_updateUI()
	self:_onUpdateFmtColUI()
end

function ChuangzhengliclgView:_onClearFmtColUI()
	local parentTran = self._fmtCol_fmtView.transform

	for i = 1, parentTran.childCount do
		local mainGo = goutil.findChild(parentTran, self._fmtCol_fmtCell.name .. "_" .. i)

		if mainGo then
			self:_clearFmtCell(mainGo)
		end
	end
end

function ChuangzhengliclgView:_clearFmtCell(mainGo)
	local btnFormation = goutil.findChild(mainGo, "btnFormation")

	for posId = 1, 9 do
		local go = goutil.findChild(mainGo, "cell_" .. posId)
		local icon = goutil.findChild(go, "con")

		MaterialMgr.resetAll(icon)
	end

	GameUtil.rmClickHandler(btnFormation)
end

function ChuangzhengliclgView:_onUpdateFmtColUI()
	local parentTran = self._fmtCol_fmtView.transform
	local childGo = self._fmtCol_fmtCell
	local children = GameUtil.getChildren(parentTran)
	local cfgs = ChuangzhengliConfig.instance:getCreepsMasterCfgs(self._activityId, self._nextStageId)
	local length = #cfgs

	goutil.setActive(childGo, false)

	for idx, cfg in ipairs(cfgs) do
		local mainGo = children[idx]

		if mainGo == nil then
			mainGo = goutil.cloneAndSetParent(childGo, parentTran, string.format("%s_%s", childGo.name, idx))
		end

		self:_updateFmtCell(mainGo, cfg)
		goutil.setActive(mainGo, true)
	end

	for idx = 1, parentTran.childCount do
		local mainGo = parentTran:GetChild(idx - 1)

		GameUtil.SetActive(mainGo, idx <= length)
	end

	GameUtil.SetActive(self._btnReset, length > 1)
	self._singleLine:Layout()
end

function ChuangzhengliclgView:_updateFmtCell(mainGo, masterCfg)
	local imgPass = goutil.findChild(mainGo, "imgPass")
	local btnFormation = goutil.findChild(mainGo, "btnFormation")
	local creepsCfgs = ChuangzhengliConfig.instance:getCreepsCfgs(masterCfg.creepsMasterId)
	local isPass = ChuangzhengliModel.instance:isChallenged(self._activityId, self._nextStageId, masterCfg.creepsMasterId)

	for posId = 1, 9 do
		local go = goutil.findChild(mainGo, "cell_" .. posId)
		local icon = goutil.findChild(go, "con")
		local creepsData

		for _, cData in ipairs(creepsCfgs) do
			if cData.posId == posId then
				creepsData = cData

				break
			end
		end

		goutil.setActive(go, creepsData)

		if creepsData then
			local skinId = checknumber(creepsData.faceId)

			if skinId == 0 then
				skinId = creepsData.raceId
			end

			MaterialMgr.setIcon(icon, MatType.Pet, skinId)
		else
			MaterialMgr.resetAll(icon)
		end
	end

	local cfgs = ChuangzhengliConfig.instance:getCreepsMasterCfgs(self._activityId, self._nextStageId)
	local length = #cfgs

	isPass = isPass and length > 1

	GameUtil.SetActive(imgPass, isPass)
	GameUtil.addClickHandler(btnFormation, GameUtil.handler(self._onClickFmtCellBtnFormation, self, isPass, masterCfg))
end

function ChuangzhengliclgView:_onClickFmtCellBtnFormation(isPass, masterCfg)
	local info = ChuangzhengliModel.instance:getInfo(self._activityId)
	local cfgs = ChuangzhengliConfig.instance:getStageCfgs(self._activityId)

	if info.passStageId >= #cfgs then
		FloatWordMgr.instance:show("已通过全部关卡")

		return
	end

	if isPass then
		FloatWordMgr.instance:show("该阵型已通关")

		return
	end

	local stageCfg = ChuangzhengliConfig.instance:getStageCfg(self._activityId, self._nextStageId)

	if (stageCfg.openDay - 1) * 86400 + self._actStartTime > ServerTime.now() then
		FloatWordMgr.instance:show(string.format("第%s天开启", stageCfg.openDay))

		return
	end

	local teamIndex = 0

	for i, v in ipairs(stageCfg.teams) do
		if v == masterCfg.creepsMasterId then
			teamIndex = i

			break
		end
	end

	ChuangzhengliController.instance:enterMission(self._activityId, self._nextStageId, teamIndex, masterCfg.creepsMasterId)
end

function ChuangzhengliclgView:_onClickbtnTip()
	local challengeCfg = ChuangzhengliController.instance:getChallengeCfg()

	TipsFacade.instance:openRulesView(challengeCfg.ruleKey)
end

function ChuangzhengliclgView:_onClickbtnClose()
	self:close()
end

function ChuangzhengliclgView:_onClickbtnReset()
	local info = ChuangzhengliModel.instance:getInfo(self._activityId)
	local isLock = true

	if info.teamLockRaceIds then
		isLock = false

		for _, v in pairs(info.teamLockRaceIds) do
			if #v.list > 0 then
				isLock = true

				break
			end
		end
	end

	if isLock then
		TipsFacade.instance:openPopupWindow("提示", "确定要重置吗？", function()
			ChuangZhengliClgAgent.instance:sendPM_ChuangZhengliClgResetStageReq(self._activityId, self._nextStageId)
		end)
	else
		FloatWordMgr.instance:show("暂时不需要重置")
	end
end

function ChuangzhengliclgView:_setTime()
	self._txtTime.text = TimeGateController.instance:getActTimeShow(self._activityId)
end

function ChuangzhengliclgView:_onClickbtnLunhun()
	self:_showTips("lunhunDesc", "轮回印记")
end

function ChuangzhengliclgView:_onClickbtnReward()
	UIStateManager.instance:push(ViewName.ChuangzhenglirewardView, self._activityId)
end

function ChuangzhengliclgView:_onClickbtnQiji()
	self:_showTips("qijiDesc", "奇迹印记")
end

function ChuangzhengliclgView:_setStageReward()
	local stageCfg = ChuangzhengliConfig.instance:getStageCfg(self._activityId, self._nextStageId)

	MaterialMgr.setCellByCfg(stageCfg.passPrize, self._itemGo)
end

function ChuangzhengliclgView:_onChuangZhengliClgResetStageRes()
	self:_onUpdateFmtColUI()
	self:_showCondition()
end

function ChuangzhengliclgView:_onCustomInputCallback(hover)
	if not hover then
		goutil.setActive(self._tipsObjGo, false)
	end
end

function ChuangzhengliclgView:_showTips(key, title)
	self._txtDesc.text = self._actCfg[key]
	self._txtTitle.text = title

	goutil.setActive(self._tipsObjGo, true)
end

function ChuangzhengliclgView:_showCondition()
	local stageCfg = ChuangzhengliConfig.instance:getStageCfg(self._activityId, self._nextStageId)
	local score = ChuangzhengliModel.instance:getCurrScore(self._activityId)

	if score >= stageCfg.counterRequiredNum then
		if not GameEnum.ColorConst.Green then
			local color = GameEnum.ColorConst.Red

			self._txtCondition.text = string.format("奇迹印记最多的精灵获得印记数量>=<color=%s>%s</color>/%s个", color, score, stageCfg.counterRequiredNum)
		end
	end
end

function ChuangzhengliclgView:_setSliderInfo()
	local stageCfgs = ChuangzhengliConfig.instance:getStageCfgs(self._activityId)
	local nextStageId = self._info.passStageId + 1

	self._totalCount = #stageCfgs
	nextStageId = math.min(nextStageId, self._totalCount)
	self._upLevelTxt.text = string.format("%d层", self._totalCount)
	self._downLevelTxt.text = "1层"
	self._curLevelTxt.text = string.format("当前%d层", nextStageId)

	self._levelSlider:SetValue((nextStageId - 1) / (self._totalCount - 1))
	HeadItemController.instance:setMyHeadCell(self._headObj)
	MaterialMgr.setIcon(self._iconGo, MatType.Item, 247)
end

return ChuangzhengliclgView
