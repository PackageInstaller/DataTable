-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/jiuclg/view/JiuClgLevelView.lua

module("logic.extensions.jiuclg.view.JiuClgLevelView", package.seeall)

local JiuClgLevelView = class("JiuClgLevelView", ViewComponent)

JiuClgLevelView.MaxStageNum = 5

function JiuClgLevelView:buildUI()
	JiuClgLevelView.super.buildUI(self)

	self._btnClose = self:getBtn("leftTop/btnClose")
	self._btnExtreme = self:getGo("btnExtreme")
	self._btnReset = self:getBtn("btnReset")
	self._btnLook = self:getBtn("btnLook")
	self._normalSelect = self:getGo("btnNormal/select")
	self._extremeSelect = self:getGo("btnExtreme/select")
	self._txtTitle = self:getTxt("leftTop/txtTitle")
	self._btnTip = self:getGo("leftTop/btnTip")
	self.scrollerGo = self:getGo("tableview")
	self.cellGo = self:getGo("tableview/tablecell")
	self._scrollList = ScrollerList.create(self.scrollerGo, self.cellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._stageContainer = self:getGo("stageContainer")
	self._recordPos = self._stageContainer:GetComponent(ComponentType.TestRecordPos)

	local stageCell = self:getGo("stageCell")

	self._lineList = {}
	self._stageList = {}

	for i = 1, 5 do
		local tem = self:getGo("lineContainer/img" .. i)

		table.insert(self._lineList, tem)

		local element = {}
		local go

		if i == 1 then
			go = stageCell

			stageCell.transform:SetParent(self._stageContainer.transform)

			go.name = "stageCell" .. i
		else
			go = goutil.cloneAndSetParent(stageCell, self._stageContainer.transform, "stageCell" .. i)
		end

		element.btn = goutil.findChild(go, "btn")
		element.txtName = goutil.findChildTextComponent(go, "btn/txtName")
		element.txtNum = goutil.findChildTextComponent(go, "btn/txtNum")
		element.lockGo = goutil.findChild(go, "btn/lock")
		element.passGo = goutil.findChild(go, "btn/pass")
		element.rewardGo = goutil.findChild(go, "reward")
		element.rewardNode = goutil.findChild(go, "reward/node")
		element.rewardGeted = goutil.findChild(go, "reward/geted")
		element.bgSpriteChange0 = goutil.findChildComponent(go, "btn/bg0", ComponentType.UIImageSpriteChange)
		element.bgSpriteChange1 = goutil.findChildComponent(go, "btn/bg1", ComponentType.UIImageSpriteChange)
		element.imgBg1 = goutil.findChildComponent(go, "btn/bg1", ComponentType.Image)

		table.insert(self._stageList, element)
	end

	self._recordPos:LoadPlan(0)

	self._bgGo = self:getGo("bg")
	self._normalPass = self:getGo("btnNormal/pass")
	self._extremePass = self:getGo("btnExtreme/pass")
end

function JiuClgLevelView:bindEvents()
	JiuClgLevelView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnExtreme, self._onClickExtreme, self)
	GameUtil.addClickHandler(self._btnReset, self._onClickReset, self)
	GameUtil.addClickHandler(self._btnLook, self._onClickLook, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickHelp, self)
end

function JiuClgLevelView:unbindEvents()
	JiuClgLevelView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnExtreme)
	GameUtil.rmClickHandler(self._btnReset)
	GameUtil.rmClickHandler(self._btnLook)
	GameUtil.rmClickHandler(self._btnTip)
end

function JiuClgLevelView:onEnter()
	JiuClgLevelView.super.onEnter(self)

	local params = self:getOpenParam()

	self._activityId = checknumber(params[1])
	self._activityType = JiuClgController.instance:getActivityType()
	self._isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(self._activityId)

	local isInTime = JiuClgController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self:_changeToTab(JiuClgModel.ExtremeClg)

	self._cfgActivity = JiuClgConfig.instance:getActivityCfg(self._activityId)

	GameUtil.SetActive(self._btnExtreme, not self._isAoqiGodProcessType)
	self.addGEvent(self, GlobalNotify.JiuClgResetExtremePhaseRes, self._onResetExtremePhaseRes, self)
	self.addGEvent(self, GlobalNotify.JiuClgExtremeFightConfirmRes, self._onExtremeFightConfirmRes, self)
end

function JiuClgLevelView:onExit()
	JiuClgLevelView.super.onExit(self)
	self._scrollList:dispose()
	self:_clearStages()
end

function JiuClgLevelView:_onClickExtreme()
	self:_changeToTab(JiuClgModel.ExtremeClg)
end

function JiuClgLevelView:_onClickReset()
	if not self:_checkPassAoqiGodProcessResult() then
		return
	end

	if JiuClgModel.instance:isExtremePassAll(self._activityId) then
		FloatWordMgr.instance:show("极限挑战已通关")

		return
	end

	if JiuClgModel.instance:getCurExtremeStageId(self._activityId) == 1 then
		FloatWordMgr.instance:show("未通过关卡，无需重置")

		return
	end

	local text = "是否确认重置当前所有关卡"

	local function okFunc()
		JiuClgAgent.instance:sendPM_JiuClgResetExtremePhaseReq(self._activityId)
	end

	TipsFacade.instance:openPopupWindow(lang("tip"), text, okFunc)
end

function JiuClgLevelView:_onClickLook()
	UIStateManager.instance:push(ViewName.JiuClgLookView, self._activityId)
end

function JiuClgLevelView:_onClickHelp()
	local key = self._cfgActivity.mainRuleKey

	TipsFacade.instance:openRulesView(key)
end

function JiuClgLevelView:_onResetExtremePhaseRes()
	if self._curClg == JiuClgModel.ExtremeClg then
		self:_updateExtremeLevels()
	end
end

function JiuClgLevelView:_onExtremeFightConfirmRes()
	if self._curClg == JiuClgModel.ExtremeClg then
		self:_updateExtremeLevels()
	end
end

function JiuClgLevelView:_updateCell(view, cell, data, tag)
	local txtName = goutil.findChildTextComponent(cell, "btn/txtName")
	local lockGo = goutil.findChild(cell, "btn/lock")
	local passGo = goutil.findChild(cell, "btn/pass")
	local btn = goutil.findChild(cell, "btn")

	txtName.text = data.name

	local isLock = false
	local isOpen = true
	local curPhaseId = 1

	if self._curClg == JiuClgModel.ExtremeClg then
		local isPass = JiuClgModel.instance:isExtremePassAll(self._activityId)

		if isPass then
			curPhaseId = self._maxExtremePhaseNum
			isLock = false
			isPass = true

			goutil.setActive(lockGo, false)
			goutil.setActive(passGo, isPass)
		else
			curPhaseId = JiuClgModel.instance:getCurExtremePhaseId(self._activityId)
			isLock = curPhaseId < data.phaseId
			isPass = curPhaseId > data.phaseId

			goutil.setActive(lockGo, isLock)
			goutil.setActive(passGo, isPass)
		end
	else
		local isPass = JiuClgModel.instance:isNormalPassAll(self._activityId)

		if isPass then
			curPhaseId = self._maxNormalPhaseNum
			isLock = false
			isPass = true

			goutil.setActive(lockGo, false)
			goutil.setActive(passGo, isPass)
		else
			curPhaseId = JiuClgModel.instance:getCurNormalPhaseId(self._activityId)
			isOpen = ServerTime.now() > GameUtil.string2time(data.openTime)
			isLock = curPhaseId < data.phaseId or curPhaseId == data.phaseId and not isOpen
			isPass = curPhaseId > data.phaseId

			goutil.setActive(lockGo, isLock)
			goutil.setActive(passGo, isPass)
		end
	end

	GameUtil.addClickHandler(btn, function()
		if self._curClg == JiuClgModel.ExtremeClg then
			if isLock then
				FloatWordMgr.instance:show("请先通过上一层")
			end
		elseif isLock then
			if isOpen then
				FloatWordMgr.instance:show("请先通过上一层")
			else
				local date = GameUtil.string2date(data.openTime)

				FloatWordMgr.instance:show(string.format("开启时间：%02d月%02d日 %02d:%02d开启", date.month, date.day, date.hour, date.min))
			end
		end
	end)
end

function JiuClgLevelView:_clearCell(cell)
	local btn = goutil.findChild(cell, "btn")

	GameUtil.rmClickHandler(btn)
end

function JiuClgLevelView:_changeToTab(clgState)
	self._curClg = Mathf.Clamp(clgState, 1, 2)

	GameUtil.saveUserData(JiuClgModel.ChallengeTypeKey, clgState)

	local isExtreme = clgState == JiuClgModel.ExtremeClg

	goutil.setActive(self._extremeSelect, isExtreme)
	goutil.setActive(self._normalSelect, not isExtreme)
	goutil.setActive(self._btnReset.gameObject, isExtreme)
	goutil.setActive(self._btnLook.gameObject, isExtreme)

	self._txtTitle.text = isExtreme and "极限挑战" or "全民挑战"

	GameUtil.SetActive(self._normalPass, JiuClgModel.instance:isNormalPassAll(self._activityId))
	GameUtil.SetActive(self._extremePass, JiuClgModel.instance:isExtremePassAll(self._activityId))
	self:_changeBgImage(clgState)
	self:_updateLevels(clgState)
end

function JiuClgLevelView:_updateLevels(clgState)
	if clgState == JiuClgModel.ExtremeClg then
		self:_updateExtremeLevels()
	else
		self:_updateNormalLevels()
	end
end

function JiuClgLevelView:_updateExtremeLevels()
	local cfgs = JiuClgConfig.instance:getExtremePhaseCfgList(self._activityId)

	self._maxExtremePhaseNum = #cfgs

	self._scrollList:reloadData(cfgs)

	if JiuClgModel.instance:isExtremePassAll(self._activityId) then
		if not cfgs[#cfgs].phaseId then
			local phaseId = JiuClgModel.instance:getCurExtremePhaseId(self._activityId)

			self:_updateStages(JiuClgModel.ExtremeClg, phaseId)
		end
	end
end

function JiuClgLevelView:_updateNormalLevels()
	local cfgs = JiuClgConfig.instance:getNormalPhaseCfgList(self._activityId)

	self._maxNormalPhaseNum = #cfgs

	self._scrollList:reloadData(cfgs)

	if JiuClgModel.instance:isNormalPassAll(self._activityId) then
		if not cfgs[#cfgs].phaseId then
			local phaseId = JiuClgModel.instance:getCurNormalPhaseId(self._activityId)

			self:_updateStages(JiuClgModel.NormalClg, phaseId)
		end
	end
end

function JiuClgLevelView:_updateStages(clgState, phaseId)
	for i, stageElement in ipairs(self._stageList) do
		if clgState == JiuClgModel.ExtremeClg then
			local var_20_0 = JiuClgConfig.instance:getExtremeStageCfg(self._activityId, phaseId, i)

			if not var_20_0 then
				var_20_0 = JiuClgConfig.instance:getNormalStageCfg(self._activityId, phaseId, i)

				local cfg = var_20_0

				if cfg then
					GameUtil.SetActive(self._lineList[i], true)
					GameUtil.SetActive(stageElement.btn, true)

					stageElement.txtNum.text = string.format("%02d", i)
					stageElement.txtName.text = cfg.name

					local curPhaseId = 1
					local curStageId = 1

					if clgState == JiuClgModel.ExtremeClg then
						curPhaseId = JiuClgModel.instance:getCurExtremePhaseId(self._activityId)
						curStageId = JiuClgModel.instance:getCurExtremeStageId(self._activityId)

						goutil.setActive(stageElement.lockGo, curPhaseId == phaseId and curStageId < i)
						goutil.setActive(stageElement.passGo, phaseId < curPhaseId or i < curStageId)
						goutil.setActive(stageElement.rewardGo, false)
						MaterialMgr.resetAll(stageElement.rewardNode)
					else
						curPhaseId = JiuClgModel.instance:getCurNormalPhaseId(self._activityId)
						curStageId = JiuClgModel.instance:getCurNormalStageId(self._activityId)

						goutil.setActive(stageElement.lockGo, curPhaseId == phaseId and curStageId < i)
						goutil.setActive(stageElement.passGo, phaseId < curPhaseId or i < curStageId)
						goutil.setActive(stageElement.rewardGeted, phaseId < curPhaseId or i < curStageId)
						goutil.setActive(stageElement.rewardGo, true)
						MaterialMgr.resetAll(stageElement.rewardNode)
						MaterialMgr.setCellByCfg(cfg.prize, stageElement.rewardNode)
					end

					local num = 0.47058823529411764

					if curPhaseId == phaseId and curStageId < i then
						Game.ImageUtil.SetColorRGBA(stageElement.imgBg1, num, num, num, 1)
					else
						Game.ImageUtil.SetColorRGBA(stageElement.imgBg1, 1, 1, 1, 1)
					end

					stageElement.bgSpriteChange0:SetState(curStageId == i and 1 or 0)
					stageElement.bgSpriteChange1:SetState((i - 1) % 5)
					GameUtil.addClickHandler(stageElement.btn, function()
						if self._isAoqiGodProcessType and clgState == JiuClgModel.NormalClg then
							return
						end

						if not self:_checkPassAoqiGodProcessResult() then
							return
						end

						if clgState == JiuClgModel.NormalClg and JiuClgModel.instance:isNormalPassAll(self._activityId) then
							FloatWordMgr.instance:show("已通关")

							return
						end

						if curStageId < i then
							FloatWordMgr.instance:show("请先通过上一关")

							return
						end

						if curStageId > i then
							FloatWordMgr.instance:show("已通关")

							return
						end

						if clgState == JiuClgModel.NormalClg then
							local cfgPhase = JiuClgConfig.instance:getNormalPhaseCfg(self._activityId, phaseId)
							local startTimestamp = GameUtil.string2time(cfgPhase.openTime)

							if startTimestamp > ServerTime.now() then
								local date = GameUtil.time2date(startTimestamp)

								FloatWordMgr.instance:show(string.format("开启时间：%02d月%02d日 %02d:%02d开启", date.month, date.day, date.hour, date.min))

								return
							end
						end

						JiuClgController.instance:openMissionView(clgState, self._activityId, phaseId, i)
					end)
				else
					GameUtil.SetActive(self._lineList[i], false)
					GameUtil.SetActive(stageElement.btn, false)
				end
			end
		end
	end
end

function JiuClgLevelView:_clearStages()
	for i, stageElement in ipairs(self._stageList) do
		MaterialMgr.resetAll(stageElement.rewardNode)
		GameUtil.rmClickHandler(stageElement.btn)
	end
end

function JiuClgLevelView:_changeBgImage(clgState)
	if clgState == JiuClgModel.ExtremeClg then
		uGuiUtil.setSpriteToImage(self._bgGo, uGuiUtil.SpriteType.BigBg, JiuClgLevelViewPresentor.BgPath1)
	else
		uGuiUtil.setSpriteToImage(self._bgGo, uGuiUtil.SpriteType.BigBg, JiuClgLevelViewPresentor.BgPath2)
	end
end

function JiuClgLevelView:_checkPassAoqiGodProcessResult()
	if self._isAoqiGodProcessType then
		local result = AoqiGodController.instance:getTryClgResultAndTipsByAct(true, self._activityType, self._activityId)

		if result ~= GameEnum.ResultCode.Success then
			return false
		end
	end

	return true
end

return JiuClgLevelView
