-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinemiyaclg/view/DivineMiyaClgLevelView.lua

module("logic.extensions.divinemiyaclg.view.DivineMiyaClgLevelView", package.seeall)

local DivineMiyaClgLevelView = class("DivineMiyaClgLevelView", ViewComponent)

function DivineMiyaClgLevelView:ctor()
	DivineMiyaClgLevelView.super.ctor(self)
end

function DivineMiyaClgLevelView:unbindEvents()
	DivineMiyaClgLevelView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSkillBuff)
	GameUtil.rmClickHandler(self._btnUseSkill)
	GameUtil.rmClickHandler(self._btnChallenge)
	GameUtil.rmClickHandler(self._btnConfirm)
	GameUtil.rmClickHandler(self._btnRule)

	local triggerGo = self._arrowLongGo

	if triggerGo then
		BeginDragHandler.Get(triggerGo):RemoveLuaHandler(self._beginDragHandler)
		EndDragHandler.Get(triggerGo):RemoveLuaHandler(self._endDragHandler)
		DragHandler.Get(triggerGo):RemoveLuaHandler(self._dragHandler)
	end
end

function DivineMiyaClgLevelView:bindEvents()
	DivineMiyaClgLevelView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
	GameUtil.addClickHandler(self._btnSkillBuff, self._onClickSkillBuff, self)
	GameUtil.addClickHandler(self._btnUseSkill, self._onClickUseSkill, self)
	GameUtil.addClickHandler(self._btnChallenge, self._onClickChallenge, self)
	GameUtil.addClickHandler(self._btnConfirm, self._onClickConfirm, self)
	GameUtil.addClickHandler(self._btnRule, self._onClickRule, self)

	if self._arrowLongGo then
		self._beginDragHandler = BeginDragHandler.Get(self._arrowLongGo):AddLuaHandler(function(_go, eventData)
			self:_onLongBeginDragHandler(_go, eventData)
		end)
		self._endDragHandler = EndDragHandler.Get(self._arrowLongGo):AddLuaHandler(function(_go, eventData)
			self:_onLongEndDragHandler(_go, eventData)
		end)
		self._dragHandler = DragHandler.Get(self._arrowLongGo):AddLuaHandler(function(_go, eventData)
			self:_onLongDragHandler(_go, eventData)
		end)
	end

	if self._arrowMidGo then
		self._beginDragHandler = BeginDragHandler.Get(self._arrowMidGo):AddLuaHandler(function(_go, eventData)
			self:_onMidBeginDragHandler(_go, eventData)
		end)
		self._endDragHandler = EndDragHandler.Get(self._arrowMidGo):AddLuaHandler(function(_go, eventData)
			self:_onMidEndDragHandler(_go, eventData)
		end)
		self._dragHandler = DragHandler.Get(self._arrowMidGo):AddLuaHandler(function(_go, eventData)
			self:_onMidDragHandler(_go, eventData)
		end)
	end
end

function DivineMiyaClgLevelView:buildUI()
	DivineMiyaClgLevelView.super.buildUI(self)

	self._btnClose = self:getGo("topLeft/btnClose")
	self._btnRule = self:getGo("topLeft/btnRule")
	self._btnSkillBuff = self:getGo("btnSkillBuff")
	self._teamEnemy = self:getGo("teamEnemy")
	self._enemyList = {}

	for i = 1, 9 do
		self._enemyList[i] = {
			go = goutil.findChild(self._teamEnemy, "cell_" .. i),
			con = goutil.findChild(self._teamEnemy, "cell_" .. i .. "/icon")
		}
	end

	self._pass = self:getGo("teamEnemy/pass")
	self._txtDesc = self:getTxt("txtDesc")
	self._txtRule = self:getTxt("txtRule")
	self._txtTime = self:getTxt("txtTime")
	self._btnUseSkill = self:getGo("btnUseSkill")
	self._btnChallenge = self:getGo("btnChallenge")
	self._btnConfirm = self:getGo("pan/btnConfirm")
	self._pan = self:getGo("pan")
	self._panEffectCon = self:getGo("pan/effectCon")
	self._clockPan = self:getGo("pan/clockPan")
	self._stageGo = self:getGo("pan/clockPan/stageGo")
	self._panPosRecord = self._clockPan:GetComponent(ComponentType.TestRecordPos)
	self._clockList = ItemGroup.New(self._clockPan, self._stageGo)
	self._arrowLong = self:getGo("pan/arrowLong")
	self._arrowLongGo = self:getGo("pan/arrowLong/img")
	self._arrowMid = self:getGo("pan/arrowMid")
	self._arrowMidGo = self:getGo("pan/arrowMid/btnArea")
end

function DivineMiyaClgLevelView:onExit()
	DivineMiyaClgLevelView.super.onExit(self)
	self._clockList:dispose(self._clearStageCell, self)

	if self._skillUseEffs then
		UIEffectManager.instance:stopEffect(self._skillUseEffs)

		self._skillUseEffs = nil
	end

	removetimer(self._onShakeNumEnd, self)

	if self._panEffect then
		UIEffectManager.instance:stopEffect(self._panEffect)

		self._panEffect = nil
	end
end

function DivineMiyaClgLevelView:onEnter()
	DivineMiyaClgLevelView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_DivineMiYaClgGetInfoRes, self._refreshView, self)
	self.addGEvent(self, GlobalNotify.PM_DivineMiYaClgSwitchStageRes, self._PM_DivineMiYaClgSwitchStageRes, self)

	self._activityId = self:getFirstParam()
	self._activityCfg = DivineMiyaClgConfig.instance:getActivityCfg(self._activityId)
	self._curChallengeStageId = 1

	local ruleCfg = RulesConfig.instance:getRuleCo(self._activityCfg.stageRule)

	self._txtDesc.text = self._activityCfg.stageRule
	self._longStageId = 1
	self._midStageId = 6
	self._curShowStageId = 1

	self:_refreshView()

	if not DivineMiyaClgModel.instance:getReadImgRule(self._activityId) then
		self:_onClickRule()
		DivineMiyaClgModel.instance:saveReadImgRule(self._activityId)
	end
end

function DivineMiyaClgLevelView:_refreshView()
	self._isSwitching = false
	self._stageCfg = DivineMiyaClgConfig.instance:getStageCfgs(self._activityId)
	self._longStageId = DivineMiyaClgModel.instance:getCurPassMaxStage(self._activityId) + 1

	if self._longStageId > #self._stageCfg then
		self._longStageId = #self._stageCfg
	end

	if self._midStageId <= self._longStageId then
		self._midStageId = math.min(self._longStageId + 2, #self._stageCfg)
	end

	self._curShowStageId = self._longStageId
	self._stageGoMap = {}

	self._clockList:updateWithMoArray(self._stageCfg, self._updateStageCell, self)
	self._panPosRecord:LoadPlan(0)

	self.angleList = {}

	local stageCount = #self._stageCfg
	local preRotation = 360 / stageCount
	local totalRotation = preRotation / 2

	while totalRotation < 360 do
		table.insert(self.angleList, totalRotation)

		totalRotation = totalRotation + preRotation
	end

	self:_changeLongToStage(self._longStageId)
	self:_changeMidToStage(self._midStageId)

	self._txtTime.text = langPara("星辰混沌：%d次", DivineMiyaClgModel.instance:getUsedSkillCount(self._activityId))

	self:_refreshCurStageInfo()
end

function DivineMiyaClgLevelView:_refreshStage()
	local stageCfg = DivineMiyaClgConfig.instance:getStageCfgs(self._activityId)

	self._stageGoMap = {}

	self._clockList:updateWithMoArray(stageCfg, self._updateStageCell, self)
	self._panPosRecord:LoadPlan(0)
	self:_refreshCurStageInfo()
end

function DivineMiyaClgLevelView:_refreshCurStageInfo()
	local info = DivineMiyaClgModel.instance:getStageInfo(self._activityId, self._curShowStageId)
	local curStagCfg = DivineMiyaClgConfig.instance:getStageCfg(self._activityId, (info or nil) and info.fightStageId)
	local creepCfg = DivineMiyaClgConfig.instance:getCreepsCfg(curStagCfg.creepsMasterId)

	for i = 1, 9 do
		MaterialMgr.resetAll(self._enemyList[i].con)
		GameUtil.SetActive(self._enemyList[i].go, false)
	end

	if creepCfg then
		for i, v in ipairs(creepCfg) do
			if self._enemyList[v.posId] then
				GameUtil.setLocalScale(self._enemyList[v.posId].con, 0.8, 0.8, 0.8)

				local proxy = MaterialMgr.setCell(MatType.Pet, v.raceId, self._enemyList[v.posId].con)

				if proxy then
					proxy.binder:setAutoTips(false)
				end

				GameUtil.SetActive(self._enemyList[v.posId].go, true)
			end
		end
	end

	self._txtRule.text = curStagCfg.rule

	GameUtil.SetActive(self._pass, self._curShowStageId <= DivineMiyaClgModel.instance:getCurPassMaxStage(self._activityId))
	GameUtil.SetActive(self._btnChallenge, self._curShowStageId == DivineMiyaClgModel.instance:getCurPassMaxStage(self._activityId) + 1)
end

function DivineMiyaClgLevelView:_updateStageCell(cell, data, index)
	local go = cell.mainGO
	local txtCurStatge = goutil.findChildComponent(go, "txtCur", ComponentType.UIImgNumeralText)
	local txtNomalStatge = goutil.findChildComponent(go, "txtNomal", ComponentType.UIImgNumeralText)
	local imgActivate = goutil.findChild(go, "imgActivate")
	local imgPass = goutil.findChild(go, "imgPass")
	local info = DivineMiyaClgModel.instance:getStageInfo(self._activityId, data.stageId)

	GameUtil.SetActive(imgActivate, data.stageId == self._curShowStageId)
	GameUtil.SetActive(imgPass, data.stageId < DivineMiyaClgModel.instance:getCurPassMaxStage(self._activityId) + 1)

	self._stageGoMap[data.stageId] = go

	GameUtil.SetActive(txtNomalStatge, false)
	GameUtil.SetActive(txtCurStatge, false)

	if data.stageId > DivineMiyaClgModel.instance:getCurPassMaxStage(self._activityId) + 1 then
		GameUtil.SetActive(txtNomalStatge, true)
	elseif data.stageId <= DivineMiyaClgModel.instance:getCurPassMaxStage(self._activityId) then
		GameUtil.SetActive(txtNomalStatge, true)
	else
		GameUtil.SetActive(txtCurStatge, true)
	end

	if info then
		txtCurStatge:SetNum(info.fightStageId)
		txtNomalStatge:SetNum(info.fightStageId)
	else
		txtCurStatge:SetNum(data.stageId)
		txtNomalStatge:SetNum(data.stageId)
	end

	GameUtil.rmClickHandler(go)
	GameUtil.addClickHandler(go, function()
		self:_onClickStage(data.stageId)
	end)
end

function DivineMiyaClgLevelView:_clearStageCell(cell)
	local go = cell.mainGO

	GameUtil.rmClickHandler(go)
end

function DivineMiyaClgLevelView:_onLongBeginDragHandler(go, eventData)
	self._isDraging = true
end

function DivineMiyaClgLevelView:_onLongEndDragHandler(go, eventData)
	self._isDraging = false

	local _, _, rotation = GameUtil.getLocalRotation(self._arrowLong)
	local targetRotation = 360 - rotation

	if targetRotation < self.angleList[1] then
		targetRotation = targetRotation + 360
	end

	local index = 1

	for i, v in ipairs(self.angleList) do
		if targetRotation < v then
			break
		end

		index = i
	end

	if index <= DivineMiyaClgModel.instance:getCurPassMaxStage(self._activityId) + 1 then
		self._longStageId = index

		self:_changeLongToStage(self._longStageId)
	else
		FloatWordMgr.instance:show(lang("只能回退时辰不可前进 请重试"))

		self._longStageId = DivineMiyaClgModel.instance:getCurPassMaxStage(self._activityId) + 1

		self:_changeLongToStage(self._longStageId)
	end
end

function DivineMiyaClgLevelView:_onLongDragHandler(go, eventData)
	local rectTransform = self._pan:GetComponent("RectTransform")
	local posEvent = goutil.screenToLocalPos(eventData.position, rectTransform)
	local dirVect = Vector3.New(posEvent.x, posEvent.y, 0) - GameUtil.getLocalPos(self._arrowLong)
	local angle = -Vector3.AngleAroundAxis(dirVect, Vector3.up, Vector3.forward)

	GameUtil.setLocalRotation(self._arrowLong, 0, 0, angle)
end

function DivineMiyaClgLevelView:_onMidBeginDragHandler(go, eventData)
	self._isDraging = true
end

function DivineMiyaClgLevelView:_onMidEndDragHandler(go, eventData)
	local maxPassStage = DivineMiyaClgModel.instance:getCurPassMaxStage(self._activityId)
	local curStage = maxPassStage + 1

	self._isDraging = false

	local _, _, rotation = GameUtil.getLocalRotation(self._arrowMid)
	local targetRotation = 360 - rotation

	if targetRotation < self.angleList[1] then
		targetRotation = targetRotation + 360
	end

	local index = 1

	for i, v in ipairs(self.angleList) do
		if targetRotation < v then
			break
		end

		index = i
	end

	if curStage <= index then
		self._midStageId = index

		self:_changeMidToStage(self._midStageId)
	else
		FloatWordMgr.instance:show(lang("当前时辰已过，不可选中交换"))

		self._midStageId = math.min(curStage + 1, #self._stageCfg)

		self:_changeMidToStage(self._midStageId)
	end
end

function DivineMiyaClgLevelView:_onMidDragHandler(go, eventData)
	local rectTransform = self._pan:GetComponent("RectTransform")
	local posEvent = goutil.screenToLocalPos(eventData.position, rectTransform)
	local dirVect = Vector3.New(posEvent.x, posEvent.y, 0) - GameUtil.getLocalPos(self._arrowMid)
	local angle = -Vector3.AngleAroundAxis(dirVect, Vector3.up, Vector3.forward)

	GameUtil.setLocalRotation(self._arrowMid, 0, 0, angle)
end

function DivineMiyaClgLevelView:_changeMidToStage(stageId)
	local go = self._stageGoMap[stageId]
	local stagePos = GameUtil.getLocalPos(go) + GameUtil.getLocalPos(self._clockPan)
	local dirVect = stagePos - GameUtil.getLocalPos(self._arrowMid)
	local angle = -Vector3.AngleAroundAxis(dirVect, Vector3.up, Vector3.forward)

	GameUtil.setLocalRotation(self._arrowMid, 0, 0, angle)
end

function DivineMiyaClgLevelView:_changeLongToStage(stageId)
	local go = self._stageGoMap[stageId]
	local stagePos = GameUtil.getLocalPos(go) + GameUtil.getLocalPos(self._clockPan)
	local dirVect = stagePos - GameUtil.getLocalPos(self._arrowLong)
	local angle = -Vector3.AngleAroundAxis(dirVect, Vector3.up, Vector3.forward)

	GameUtil.setLocalRotation(self._arrowLong, 0, 0, angle)

	if self._skillUseEffs then
		UIEffectManager.instance:stopEffect(self._skillUseEffs)

		self._skillUseEffs = nil
	end

	local curPassMaxStage = DivineMiyaClgModel.instance:getCurPassMaxStage(self._activityId)

	if stageId ~= curPassMaxStage + 1 and #self._stageCfg > DivineMiyaClgModel.instance:getMaxStagePassed(self._activityId) then
		local effGo = self._btnUseSkill
		local path = "20240823/miyatiaozhan/fx_ui_symy_ddcs.prefab"
		local effect = UIEffectManager.instance:playEffect(self, path, nil, 0, 0, true)

		effect:setParent(effGo.transform)
		effect:setLocalPos(0, 0, 0)
		effect:setScale(1, 1, 1)

		self._skillUseEffs = effect
	end
end

function DivineMiyaClgLevelView:_onClickStage(stageId)
	self._curShowStageId = stageId

	self:_refreshStage()
end

function DivineMiyaClgLevelView:_onClickSkillBuff()
	UIStateManager.instance:push(ViewName.DivineMiyaClgSkillBuffView, self._activityId)
end

function DivineMiyaClgLevelView:_onClickUseSkill()
	local maxPassStage = DivineMiyaClgModel.instance:getCurPassMaxStage(self._activityId)
	local curStage = maxPassStage + 1

	if self._longStageId == curStage then
		local maxPassStageInfo = DivineMiyaClgModel.instance:getStageInfo(self._activityId, maxPassStage)
		local curStepUseSkill = DivineMiyaClgModel.instance:getUsedSkillCount(self._activityId)

		if ((maxPassStageInfo or nil) and DivineMiyaClgModel.instance:getUsedSkillCount(self._activityId) - maxPassStageInfo.passedSnapshotUsedSkillCount) <= 0 then
			FloatWordMgr.instance:show(lang("拨动橙色指针可回退时辰"))
		else
			local content = lang("是否回到当前时辰初始状态")

			TipsFacade.instance:openPopupWindow(lang("提示"), content, function()
				DivineMiYaClgAgent.instance:sendPM_DivineMiYaClgReset2StageReq(self._activityId, self._longStageId)
			end)
		end
	elseif #self._stageCfg <= DivineMiyaClgModel.instance:getMaxStagePassed(self._activityId) then
		FloatWordMgr.instance:show(lang("已通关"))
	elseif curStage > self._longStageId then
		local content = lang("是否确定回到当前选中的时辰")

		TipsFacade.instance:openPopupWindow(lang("提示"), content, function()
			DivineMiYaClgAgent.instance:sendPM_DivineMiYaClgReset2StageReq(self._activityId, self._longStageId)
		end)
	else
		FloatWordMgr.instance:show(lang("只能回退时辰不可前进 请重试"))

		self._longStageId = curStage

		self:_changeLongToStage(self._longStageId)
	end
end

function DivineMiyaClgLevelView:_onClickConfirm()
	if self._isSwitching == true then
		return
	end

	local maxPassStage = DivineMiyaClgModel.instance:getCurPassMaxStage(self._activityId)
	local curStage = maxPassStage + 1

	if self._midStageId == curStage then
		FloatWordMgr.instance:show(lang("不可与当前时辰交换"))

		self._midStageId = math.min(curStage + 1, #self._stageCfg)

		self:_changeMidToStage(self._midStageId)
	elseif curStage > self._longStageId then
		FloatWordMgr.instance:show(langPara("时辰%d已通关不可交换", self._longStageId))
	elseif curStage < self._midStageId then
		local changeStageId = self._midStageId
		local changeStageInfo = DivineMiyaClgModel.instance:getStageInfo(self._activityId, changeStageId)

		if changeStageInfo then
			changeStageId = changeStageInfo.fightStageId
		end

		local curStageId = curStage
		local curStageInfo = DivineMiyaClgModel.instance:getStageInfo(self._activityId, curStageId)

		if curStageInfo then
			curStageId = curStageInfo.fightStageId
		end

		local content = langPara("是否确认当前%d时，与%d时进行交换。交换后增加星辰混沌次数。", curStageId, changeStageId)

		TipsFacade.instance:openPopupWindow(lang("提示"), content, function()
			DivineMiYaClgAgent.instance:sendPM_DivineMiYaClgSwitchStageReq(self._activityId, self._midStageId)
		end)
	else
		FloatWordMgr.instance:show(lang("当前时辰已过，不可选中交换"))

		self._midStageId = math.min(curStage + 1, #self._stageCfg)

		self:_changeMidToStage(self._midStageId)
	end
end

function DivineMiyaClgLevelView:_onClickChallenge()
	local fmtMo = DivineMiyaClgModel.instance:getFmtMo()
	local curStageId = DivineMiyaClgModel.instance:getCurPassMaxStage(self._activityId) + 1
	local nextStageId = curStageId + 1

	if nextStageId > #self._stageCfg then
		nextStageId = 1
	end

	local preStageId = curStageId - 1

	if preStageId <= 0 then
		preStageId = #self._stageCfg
	end

	fmtMo:initParams(self._activityId, curStageId, nextStageId, preStageId)
	CustomFmtController.instance:showMissionView(fmtMo)
end

function DivineMiyaClgLevelView:_onClickClose()
	if not self._isSwitching then
		self:close()
	end
end

function DivineMiyaClgLevelView:_onClickRule()
	local ruleCfg = DivineMiyaClgConfig.instance:getRuleCfgs(self._activityId)
	local list = {}

	for i, v in ipairs(ruleCfg) do
		table.insert(list, {
			url = GameUrl.getBigbgFolderUrl("shenyaomiya", v.res),
			desc = v.desc
		})
	end

	UIStateManager.instance:push(ViewName.DivineMiYaClgImgRuleView, list, lang(""))
end

function DivineMiyaClgLevelView:_PM_DivineMiYaClgSwitchStageRes()
	self._isSwitching = true

	local minGo = self._stageGoMap[self._midStageId]
	local longGo = self._stageGoMap[self._longStageId]
	local minNum = goutil.findChild(minGo, "txtNomal")
	local longNum = goutil.findChild(longGo, "txtCur")
	local _, _, longRotation = GameUtil.getLocalRotation(self._arrowLong)
	local _, _, midRotation = GameUtil.getLocalRotation(self._arrowMid)
	local longTween = UnityTweens.TweenRotate.StartTween(self._arrowLong, Vector3.New(0, 0, longRotation), Vector3.New(0, 0, longRotation + 720), 1)
	local midTween = UnityTweens.TweenRotate.StartTween(self._arrowMid, Vector3.New(0, 0, midRotation), Vector3.New(0, 0, midRotation - 720), 1)

	if self._panEffect then
		UIEffectManager.instance:stopEffect(self._panEffect)

		self._panEffect = nil
	end

	local panEffectPath = "20240823/miyatiaozhan/fx_ui_shenyaomy_loop.prefab"

	self._panEffect = UIEffectManager.instance:playEffect(self, panEffectPath, nil, 0, 0, true)

	self._panEffect:setParent(self._panEffectCon.transform)
	self._panEffect:setLocalPos(0, 0, 0)
	self._panEffect:setScale(1, 1, 1)
	longTween:AddListener(function()
		local longNumTween = UnityTweens.TweenRotate.StartTween(longNum, Vector3.New(0, 0, -10), Vector3.New(0, 0, 10), 0.1)
		local minNumTween = UnityTweens.TweenRotate.StartTween(minNum, Vector3.New(0, 0, -10), Vector3.New(0, 0, 10), 0.1)

		longNumTween.loopType = UnityTweens.LoopType.pingPong
		minNumTween.loopType = UnityTweens.LoopType.pingPong

		settimer(0.4, self._onShakeNumEnd, self, false)
	end)
end

function DivineMiyaClgLevelView:_onShakeNumEnd()
	local minGo = self._stageGoMap[self._midStageId]
	local longGo = self._stageGoMap[self._longStageId]

	if not minGo or not longGo then
		if self._panEffect then
			UIEffectManager.instance:stopEffect(self._panEffect)

			self._panEffect = nil
		end

		return
	end

	local minNum = goutil.findChild(minGo, "txtNomal")
	local longNum = goutil.findChild(longGo, "txtCur")

	UnityTweens.TweenRotate.StopTween(minNum)
	UnityTweens.TweenRotate.StopTween(longNum)
	GameUtil.setLocalRotation(minNum, 0, 0, 0)
	GameUtil.setLocalRotation(longNum, 0, 0, 0)

	local changeEffectPath = "20240823/miyatiaozhan/fx_ui_shenyaomy_jieshu.prefab"
	local changeEffect1 = UIEffectManager.instance:playEffect(self, changeEffectPath, nil, 0, 0, false, nil, function()
		if self._panEffect then
			UIEffectManager.instance:stopEffect(self._panEffect)

			self._panEffect = nil
		end
	end)

	changeEffect1:setParent(minGo.transform)
	changeEffect1:setLocalPos(0, 0, 0)
	changeEffect1:setScale(1, 1, 1)

	local changeEffect2 = UIEffectManager.instance:playEffect(self, changeEffectPath, nil, 0, 0, false)

	changeEffect2:setParent(longGo.transform)
	changeEffect2:setLocalPos(0, 0, 0)
	changeEffect2:setScale(1, 1, 1)
	self:_refreshView()
end

return DivineMiyaClgLevelView
