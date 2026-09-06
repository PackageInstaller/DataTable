-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guide/controller/GuideController.lua

module("logic.extensions.guide.controller.GuideController", package.seeall)

local GuideController = class("GuideController", BaseController)

function GuideController:onInit()
	GuideController.super.onInit(self)
	self:onReset()
	self.registerNotify(self, GlobalNotify.BagDetailsShow, self._onBagDetailsShow, self)
	self.registerNotify(self, GlobalNotify.BagDetailsHide, self._onBagDetailsHide, self)
	self.registerNotify(self, GlobalNotify.HookSkillStart, self._onBattleHurt, self)
	self.registerNotify(self, GlobalNotify.OnViewClose, self._onViewClose, self)
	self.registerNotify(self, GlobalNotify.CopyDataReady, self.checkGuideInTaskFinish, self)
	self.registerNotify(self, GlobalNotify.TaskViewDataUpdate, self._onTaskFish, self, NotifyPriority.Low)
	self.registerNotify(self, "guide_close_view", self.onCloseAll, self)
	self.registerNotify(self, "guide_open_view", self.onOpenView, self)

	self.isBagPetDetailsShow = true
end

function GuideController:onReset()
	self.isBagPetDetailsShow = nil
	self.currGuideViewPool = nil
	self.viewVariablePool = {}
	self.viewVarCallBackPool = {}
end

function GuideController:getOrCheckVarAndDoOnce(key, callback)
	self.viewVarCallBackPool[key] = callback

	return self.viewVariablePool[key]
end

function GuideController:setViewVar(key, value)
	self.viewVariablePool[key] = value

	if value then
		print(">>>>>>>>>>>>>>>>>>>>>>> GuideController:setViewVar( key ,value)", key, value)

		local callback = self.viewVarCallBackPool[key]

		GameUtil.callBack(callback, key, value)
	end
end

function GuideController:clearVarCallBack(key)
	print(">>>>>>>>>>>>>>>>>>>>>>> GuideController:clearVarCallBack( key )", key)

	self.viewVarCallBackPool[key] = nil
end

function GuideController:onCloseAll()
	self:finishGuide()
	UIStateManager.instance:clear(true)
end

function GuideController:onOpenView(guideBase)
	if guideBase then
		local obj = guideBase:getJsonParams()

		if not string.nilorempty(obj.viewName) then
			UIStateManager.instance:push(obj.viewName)
		end
	end
end

function GuideController:onSceneLoadedFinish(sceneType, sceneId)
	local scene = SceneMgr.instance:getCurScene()

	self:checkGuideInScene(sceneId, sceneType)
	print("onSceneLoadedFinishonSceneLoadedFinishonSceneLoadedFinish>>>>>>>>>>>", sceneId, sceneType)

	if sceneType == SceneType.Battle and BattleModel.instance:getActionMode() == GameEnum.ActionModel.UserAction_Skill then
		LocalUserDataController.instance:doCallbackWhenFirst("PanelGuideType.ActionMode", function()
			local function onCloseView()
				BattleFacade.instance:setBattlePause(false)
			end

			UIStateManager.instance:open(ViewName.PanelGuide, GameEnum.PanelGuideType.ActionMode, onCloseView)
			BattleFacade.instance:setBattlePause(true)
		end)
	end
end

function GuideController:checkBranchIsFinish(branchId)
	local branch = GuideModel.instance:getGuideBranch(branchId)

	if branch and not branch:isFinished() then
		return false
	end

	return true
end

function GuideController:onViewEnterFinish(viewName)
	print(">>>>>>>>>  onViewEnterFinish:", viewName)

	self.isBagPetDetailsShow = nil

	GuideModel.instance:checkGuidesNeedForceToOnEnterView(viewName)

	local tView = self:_getTopView()
	local tChild = self:_getTopViewChild(tView)

	if tView and tView.isViewGuidable then
		self:checkGuide(tView.viewName, (tChild or nil) and tChild.viewName)
	end
end

function GuideController:onViewExitFinish(viewName)
	self.isBagPetDetailsShow = nil

	GuideModel.instance:checkGuidesNeedForceToOnExitView(viewName)

	local tView = self:_getTopView()
	local tChild = self:_getTopViewChild(tView)

	if tView and tView.isViewGuidable then
		self:checkGuide(tView.viewName, (tChild or nil) and tChild.viewName)
	else
		GuideModel.instance:finishGuideBranch()
	end
end

function GuideController:checkGuide(viewName, childName)
	GuideModel.instance:checkGuidesNeedForceToInView(viewName, childName)

	local guideBranch = GuideModel.instance:getGuideBranchWithView(viewName, childName)

	if guideBranch and not guideBranch:isFinished() then
		self:startGuide(guideBranch)
	else
		local guideBranch = GuideModel.instance:getCurrGuideBranch()

		if guideBranch and guideBranch:isGuiding() then
			local guide = guideBranch:getGuide()

			if not guide:isTriggeredByScene() then
				GuideModel.instance:finishGuideBranch()
			end
		end
	end
end

function GuideController:tryFinishCurrGuideBranch()
	local guideBranch = GuideModel.instance:getCurrGuideBranch()

	if guideBranch and guideBranch:isGuiding() then
		local guide = guideBranch:getGuide()

		if not guide:isTriggeredByScene() then
			GuideModel.instance:finishGuideBranch()
		end
	end
end

function GuideController:checkBranchIsGuiding(branchId, gid)
	local guideBranch = GuideModel.instance:getCurrGuideBranch()

	if guideBranch and guideBranch:isGuiding() then
		local flag = guideBranch.branchId == branchId

		if gid == nil then
			return flag
		else
			local guide = guideBranch:getGuide()

			if guide then
				return flag and guide:getGuideId() == gid
			end
		end
	end

	return false
end

function GuideController:addGuideView(viewName)
	self.currGuideViewPool = self.currGuideViewPool or {}
	self.currGuideViewPool[viewName] = true
end

function GuideController:checkHasGuideView(viewName)
	if self.currGuideViewPool then
		return checkbool(self.currGuideViewPool[viewName])
	end

	return false
end

function GuideController:tryStopAni(v)
	local guideBranch = v.parentPresentor and GuideModel.instance:getGuideBranchWithView(v.parentPresentor.viewName, v.viewName) or GuideModel.instance:getGuideBranchWithView(v.viewName)

	if guideBranch and not guideBranch:isFinished() then
		print(">>>>>>>>>>>>>尝试关闭动画", v.viewName)

		if ViewMgr.instance:isOpen(v.viewName) and v.viewWithGuide and v.mainGO then
			self:trySetAni(v, false)
		end
	end
end

function GuideController:trySetAni(v, boo)
	local ani = v.mainGO:GetComponent("Animator")

	if ani and ani.enabled then
		print(">>>>>>>>>>>>>尝试关闭动画 成功/失败", v.viewName, "ani.enabled = ", ani.enabled, boo)

		if GoUtil.IsAnimatorPlaying(ani) then
			GoUtil.SkipAnimator(ani)
		end
	end
end

function GuideController:checkGuideByBranch(guideBranch)
	if guideBranch and not guideBranch:isFinished() and guideBranch:shouldTrigger() then
		self:startGuide(guideBranch)
	else
		local guideBranch = GuideModel.instance:getCurrGuideBranch()

		if guideBranch and guideBranch:isGuiding() then
			local guide = guideBranch:getGuide()

			if not guide:isTriggeredByScene() then
				GuideModel.instance:finishGuideBranch()
			end
		end
	end
end

function GuideController:checkGuideInScene(sceneId, sceneType)
	GuideModel.instance:checkGuidesNeedForceToInScene(sceneId, sceneType)

	local guideBranch = GuideModel.instance:getGuideBranchWithScene(sceneId, sceneType)

	if guideBranch and not guideBranch:isFinished() then
		self:startGuide(guideBranch)
	else
		local guideBranch = GuideModel.instance:getCurrGuideBranch()

		if guideBranch and guideBranch:isGuiding() then
			local guide = guideBranch:getGuide()

			if guide:finishOnEnterSceneId() == sceneId then
				GuideModel.instance:finishGuideBranch()
			end
		end
	end
end

function GuideController:checkGuideInTaskFinish(taskId)
	local guideBranch = GuideModel.instance:getCurrGuideBranch()

	print("<color='#ffff00'>>>>>>>>>>>>>>>任务更新 guideBranch </color>：", guideBranch, (guideBranch or nil) and (guideBranch.branchId or "nil"))

	if guideBranch and guideBranch:isGuiding() then
		return
	end

	local tView = self:_getTopView()
	local childName = ""
	local tChild = self:_getTopViewChild(tView)

	if tChild then
		childName = tChild.viewName
	end

	print("<color='#ffff00'>>>>>>>>>>>>>>>任务更新 topview</color>：", (tView or nil) and (tView.viewName or "nil"))

	if tView and tView.isViewGuidable then
		self:checkGuide(tView.viewName, childName)
	end
end

function GuideController:startGuide(guideBranch)
	GuideModel.instance:finishGuideBranch(guideBranch)

	if not guideBranch:isGuiding() then
		GuideModel.instance:startGuideBranch(guideBranch)

		local guide = guideBranch:getGuide()

		if guide ~= nil then
			local uiType = guide:getGuideUIType()

			removetimer(self._onGuideAutoFinish, self)

			if uiType ~= GuideConst.GUIDE_UI_HEADVIEW and uiType ~= GuideConst.GUIDE_UI_TblHIGHT then
				local autoFinishTime = guide:autoFinishTime()

				if autoFinishTime and autoFinishTime > 0 then
					removetimer(self._onGuideAutoFinish, self)
					settimer(autoFinishTime, self._onGuideAutoFinish, self, false)
				end
			end
		end
	else
		printInfo("isGuiding")
	end
end

function GuideController:sendToSave(list)
	local tb = {}

	for i, v in ipairs(list) do
		local bid = v.bid
		local cid = v.cid

		print(">>>>>>>>>>>>>>> guide save", bid, cid)

		local newKvs = NewHandExtension_pb.NewHandKVNO()

		newKvs.key = bid
		newKvs.value = cid

		table.insert(tb, newKvs)
	end

	if #tb > 0 then
		NewHandAgent.instance:sendUpdateNewHandGuideKVsReq(tb, function()
			print(">>>>>>>>>>>>新手保存成功")
		end)
	end
end

function GuideController:forceFinishBranch(rcdId)
	rcdId = rcdId or GuideConst.INVALID_GUIDE_ID

	local branch = GuideModel.instance:getCurrGuideBranch()

	print(">>>>>>>>>强制结束  发送后端 前端也记", branch.branchId, rcdId)
	branch:setGuide(GuideConst.INVALID_GUIDE_ID)
	GuideModel.instance:finishGuideBranch()

	local list = {
		bid = branch.branchId,
		cid = rcdId
	}

	self:sendToSave({
		list
	})
	self:saveGuideInfo()
	self:removeGuideUI()
	self:checkCurTopViewGuide()
end

function GuideController:finishGuide()
	removetimer(self._onGuideAutoFinish, self)

	local guideBranch = GuideModel.instance:getCurrGuideBranch()

	if guideBranch and guideBranch:isGuiding() then
		GuideModel.instance:finishGuideBranch()

		local guide = guideBranch:getGuide()

		if guide then
			local nextGuideId = guide:nextGuideId()
			local params = guide:getJsonParams()

			guide:reportBehavior()

			local boo = false
			local rcdId = -1

			if guide:getForceType() == 1 then
				rcdId = -1
				boo = GuideModel.instance:updateSvrGuideData(guideBranch.branchId, -1)
			else
				rcdId = nextGuideId
				boo = GuideModel.instance:updateSvrGuideData(guideBranch.branchId, nextGuideId)
			end

			if boo then
				local list = {
					bid = guideBranch.branchId,
					cid = rcdId
				}

				self:sendToSave({
					list
				})
			end

			guideBranch:setGuide(nextGuideId)

			local nextGuide = guideBranch:getGuide()

			if nextGuide then
				local guideView = nextGuide:getParentGuideView()
				local isGuide = false
				local tView = self:_getTopView()
				local tChild = self:_getTopViewChild(tView)

				if tView and tView.viewName == guideView and tView.isViewGuidable then
					self:checkGuide(guideView, (tChild or nil) and tChild.viewName)

					isGuide = true
				end

				if isGuide then
					return nil
				end
			end
		end
	end

	self:saveGuideInfo()
	self:removeGuideUI()
end

function GuideController:loadGuideInfo()
	NewHandAgent.instance:sendGetAllNewHandGuideKVsReq(function(msg)
		local kvs = msg.kvs

		for i, v in ipairs(kvs) do
			local branchId = v.key
			local curId = v.value

			GuideModel.instance:updateSvrGuideData(branchId, curId)
			print(">>>>>>>>>>>>>>> guide start", branchId, curId)
		end

		self:loadGuideInit(GuideModel.instance.svrGuideList)
	end, nil, function()
		self:loadGuideInit()
	end)
end

function GuideController:loadGuideInit(svrData)
	svrData = svrData or {}

	local saveStr = UnityEngine.PlayerPrefs.GetString("guideInfos_" .. LoginModel.instance.userId)

	print(">>>>>>>>> 新手初始化", saveStr)

	local localInfos = GuideModel.instance:fromString(saveStr)

	GuideModel.instance:onServerGuideData(localInfos, svrData)
	self:checkCurTopViewGuide()
end

function GuideController:checkCurTopViewGuide()
	local tView = self:_getTopView()
	local tChild = self:_getTopViewChild(tView)

	if tView and tView.isViewGuidable then
		GuideModel.instance:checkGuidesNeedForceToOnEnterView(tView.viewName)
		self:checkGuide(tView.viewName, (tChild or nil) and tChild.viewName)
	end
end

function GuideController:saveGuideInfo()
	if LoginModel.instance.userId then
		UnityEngine.PlayerPrefs.SetString("guideInfos_" .. LoginModel.instance.userId, GuideModel.instance:toString())
	end
end

function GuideController:_onGuideAutoFinish()
	removetimer(self._onGuideAutoFinish, self)

	TaskModel.instance.finishByTimeout = true

	self:finishGuide()

	TaskModel.instance.finishByTimeout = nil
end

function GuideController:_getTopView()
	local top

	for k, v in pairs(ViewMgr.instance._views) do
		if ViewMgr.instance:isOpen(v.viewName) and (v.viewWithGuide or v.viewName == ViewAutoShowController.instance.currViewName) and not v.parentPresentor then
			if not top then
				top = v
			elseif top:attachToWhichRoot() < v:attachToWhichRoot() then
				top = v
			elseif top:attachToWhichRoot() == v:attachToWhichRoot() and GlobalModel.isUppon(v, top) then
				top = v
			end
		end
	end

	return top
end

function GuideController:_getTopViewChild(top)
	if top then
		for k, v in pairs(ViewMgr.instance._views) do
			if ViewMgr.instance:isOpen(v.viewName) and v.viewWithGuide and v.parentPresentor == top and v.isViewGuidable then
				return v
			end
		end
	end

	return nil
end

function GuideController:_onTaskDataReady()
	if GuideModel.instance:isGuiding() then
		return
	end

	local branch = GuideModel.instance:getGuideBranch(GuideConst.BRANCH_TASK)

	self:checkGuideInCurrView(branch)
end

function GuideController:_onBagDetailsShow()
	self.isBagPetDetailsShow = true

	if GuideModel.instance:isGuiding() then
		return
	end

	local branch = GuideModel.instance:getGuideBranch(GuideConst.BRANCH_PET)

	self:checkGuideInCurrView(branch)
end

function GuideController:_onContractShow()
	if GuideModel.instance:isGuiding() then
		return
	end

	local branch = GuideModel.instance:getGuideBranch(GuideConst.BRANCH_CONTRACT)

	self:checkGuideInCurrView(branch)
end

function GuideController:_onMissionShow()
	if GuideModel.instance:isGuiding() then
		return
	end

	local branch = GuideModel.instance:getGuideBranch(GuideConst.BRANCH_MISSION)

	self:checkGuideInCurrView(branch)
end

function GuideController:_onBagDetailsHide()
	self.isBagPetDetailsShow = nil

	local branch = GuideModel.instance:getGuideBranch(GuideConst.BRANCH_PET)

	self:checkGuideInCurrView(branch)
end

function GuideController:_onViewClose(view)
	return
end

function GuideController:_onBattleHurt(skill, target)
	local unit = skill.unit

	if skill.isUtlSkill and unit.teamId == BattleModel.instance.myTeamId then
		self:onDoGuide(GuideConst.BRANCH_BATTLE_GAS, unit)

		return
	end

	if unit.teamId == BattleModel.instance.myTeamId then
		local branch = GuideModel.instance:getGuideBranch(GuideConst.BRANCH_BATTLE_RESTRICTION)

		if branch and not branch:isFinished() then
			local tgts = {}

			table.insert(tgts, unit)
			table.insert(tgts, target)

			branch.guideTargetsData = tgts

			self:checkGuideByBranch(branch)
		end
	end
end

function GuideController:onDoGuide(branchType, param)
	local branch = GuideModel.instance:getGuideBranch(branchType)

	if not branch then
		return
	end

	if param then
		branch:setParam(param)
	end

	self:checkGuideByBranch(branch)
end

function GuideController:checkGuideInCurrView(branch)
	if branch and not branch:isFinished() then
		local tView = self:_getTopView()
		local childName = ""
		local tChild = self:_getTopViewChild(tView)

		if tChild then
			childName = tChild.viewName
		end

		if tView and tView.isViewGuidable then
			local guide = branch:getGuide()

			if guide:isTriggeredInView(tView.viewName, childName) then
				self:checkGuide(tView.viewName, childName)
			end
		end
	end
end

function GuideController:removeGuideUI()
	local removeUis = GuideModel.instance:getWillRemoveUI()

	if not removeUis then
		return nil
	end

	for i, v in ipairs(removeUis) do
		ViewMgr.instance:close(v)
	end
end

function GuideController:_onTaskFish(taskId)
	print(">>>>任务更新：", taskId)

	local task = TaskModel.instance:getTaskById(taskId)

	if task and task.taskCo and task.currStep then
		print("<color='#ffff00'>>>>>>>>>>>>>>>任务更新</color>：", taskId, task.currStep:getStepId())
	end

	self:checkGuideInTaskFinish(taskId)
end

GuideController.instance = GuideController.New()

return GuideController
