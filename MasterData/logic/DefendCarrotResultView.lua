-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/defendcarrot/view/DefendCarrotResultView.lua

module("logic.extensions.defendcarrot.view.DefendCarrotResultView", package.seeall)

local DefendCarrotResultView = class("DefendCarrotResultView", ViewComponent)

function DefendCarrotResultView:ctor()
	DefendCarrotResultView.super.ctor(self)
end

function DefendCarrotResultView:unbindEvents()
	DefendCarrotResultView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnReturn)
	GameUtil.rmClickHandler(self._btnRestart)
end

function DefendCarrotResultView:bindEvents()
	DefendCarrotResultView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnReturn, GameUtil.handler(self._onClickReturn, self))
	GameUtil.addClickHandler(self._btnRestart, GameUtil.handler(self._onClickRestart, self))
	GameUtil.addClickHandler(self._btnNext, GameUtil.handler(self._onClickNext, self))
end

function DefendCarrotResultView:buildUI()
	DefendCarrotResultView.super.buildUI(self)

	self._btnReturn = self:getGo("btnReturn")
	self._btnRestart = self:getGo("btnRestart")
	self._btnNext = self:getGo("btnNext")
	self._txtTitle = self:getTxt("txtTitle")
	self._bgPass = self:getGo("bgPass")
	self._bgFail = self:getGo("bgFail")
	self._tableviewGo = self:getGo("tableview")
	self._tablecellGo = self:getGo("tableview/tablecell")
	self._tableview = ScrollerList.create(self._tableviewGo, self._tablecellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._txtTips = self:getTxt("txtTips")
end

function DefendCarrotResultView:onExit()
	DefendCarrotResultView.super.onExit(self)
	self._tableview:dispose()
end

function DefendCarrotResultView:onEnter()
	DefendCarrotResultView.super.onEnter(self)

	self._curActivityId = 0
	self._curStageId = 0

	local params = self:getOpenParam()

	if params then
		self._curActivityId = checknumber(params[1])
		self._curStageId = checknumber(params[2])
	end

	if self._curActivityId <= 0 then
		self._curActivityId = 517001
	end

	self._isWin = false

	local isOver = DefendCarrotGameController.instance:isGameOver()
	local isAlive = DefendCarrotGameController.instance:getCurCarrotHp() > 0

	self._isWin = isOver and isAlive

	goutil.setActive(self._btnRestart, not self._isWin)
	goutil.setActive(self._bgFail, not self._isWin)
	goutil.setActive(self._bgPass, self._isWin)

	local curStageCfg = DefendCarrotConfig.instance:getStageCfgByStageId(self._curActivityId, self._curStageId)
	local passStoryId = checknumber(curStageCfg.passStoryId)

	self:_updateUI()

	if self._isWin then
		local key = string.format("%s_%s_%s", self._viewPresentor.viewName, self._curActivityId, self._curStageId)

		GameUtil.doCallbackWhenFirst(key, function()
			if passStoryId > 0 then
				GlobalDispatcher:dispatch(GlobalNotify.PushStory, passStoryId, StoryModel.StoryType.SCCopy)
			end
		end)
	end
end

function DefendCarrotResultView:_updateUI()
	goutil.setActive(self._btnNext, false)

	self._txtTips.text = ""

	if self._isWin then
		self._txtTitle.text = ""

		local nextStageCfg = DefendCarrotConfig.instance:getStageCfgByStageId(self._curActivityId, self._curStageId + 1)

		if nextStageCfg then
			local dateOpen = GameUtil.string2date(nextStageCfg.openDate)

			if GameUtil.getTimePeriod(nextStageCfg.openDate, "") == GameUtil.inTimePeriod then
				goutil.setActive(self._btnNext, true)
			else
				self._txtTips.text = string.format("%d.%d %d:%02d开启下一关", dateOpen.month, dateOpen.day, dateOpen.hour, dateOpen.min)
			end
		else
			self._txtTips.text = "恭喜通关，已无更多关卡"
		end
	else
		local curWave, totalWave = DefendCarrotGameController.instance:getCurWave()

		self._txtTitle.text = string.format("%d/%d波次", curWave, totalWave)
	end

	local taskCfgs = DefendCarrotConfig.instance:getStageTaskCfgs(self._curActivityId, self._curStageId)

	self._killCountMap = DefendCarrotGameController.instance:getCurkillCountMap()
	self._buildInfoMap = DefendCarrotGameController.instance:getCurBuildCountMap()
	self._recycleCountMap = DefendCarrotGameController.instance:getCurRecycleCountMap()

	self._tableview:reloadData(taskCfgs)
end

function DefendCarrotResultView:_updateCell(view, cell, data)
	local go = cell.gameObject
	local bgPass = goutil.findChild(go, "bgPass")
	local bgFail = goutil.findChild(go, "bgFail")

	goutil.setActive(bgFail, not self._isWin)
	goutil.setActive(bgPass, self._isWin)

	local iconReward = goutil.findChild(go, "reward/icon")
	local txtNum = goutil.findChildTextComponent(go, "reward/txt")
	local prizeType, prizeId, prizeNum = MaterialMgr.getMatParams(data.prize)

	txtNum.text = string.format("%d", prizeNum)

	MaterialMgr.setIcon(iconReward, prizeType, prizeId)

	local txtDescFailGo = goutil.findChild(go, "txtDescFail")
	local txtDescPassGo = goutil.findChild(go, "txtDescPass")

	goutil.setActive(txtDescFailGo, not self._isWin)
	goutil.setActive(txtDescPassGo, self._isWin)

	local txtDesc = txtDescFailGo:GetComponent(goutil.Type_UIText)
	local txtStatusFailGo = goutil.findChild(go, "txtStatusFail")
	local txtStatusPassGo = goutil.findChild(go, "txtStatusPass")

	goutil.setActive(txtStatusFailGo, not self._isWin)
	goutil.setActive(txtStatusPassGo, self._isWin)

	local txtStatus = txtStatusFailGo:GetComponent(goutil.Type_UIText)

	if self._isWin then
		txtStatus = txtStatusPassGo:GetComponent(goutil.Type_UIText)
	end

	local taskId = data.taskId
	local param = GameUtil.jsonToTable(data.param)
	local weaponId = 0
	local num = 0
	local isFinish = false
	local goFinished = goutil.findChild(go, "finished")
	local taskDesc = ""

	if param then
		weaponId = checknumber(param.x)
		num = checknumber(param.n)
	end

	local curKillCount = checknumber(self._killCountMap[weaponId])
	local curBuildCount = checknumber(self._buildInfoMap[weaponId])
	local curRecycleCount = checknumber(self._recycleCountMap[weaponId])
	local isGained = DefendCarrotModel.instance:isExtraTaskCompleted(self._curActivityId, self._curStageId, data.taskId)
	local weaponCfg = DefendCarrotConfig.instance:getWeaponCfg(self._curActivityId, weaponId)

	if weaponCfg then
		taskDesc = data.taskDesc
		taskDesc = string.gsub(data.taskDesc, "{x}", weaponCfg.weaponName)
		taskDesc = string.gsub(data.taskDesc, "{n}", num)

		if taskId == DefendCarrotEnum.TaskType.BuildNotLessThan then
			isFinish = num <= curBuildCount - curRecycleCount
		elseif taskId == DefendCarrotEnum.TaskType.KillNotLessThan then
			isFinish = num <= curKillCount
		elseif taskId == DefendCarrotEnum.TaskType.BuildNotGreaterThan then
			isFinish = curBuildCount <= num
		end

		txtStatus.text = isGained and "已领取" or isFinish and (self._isWin and "已完成" or "未通关，不可领取") or "未完成"
	else
		printError("额外任务参数出错: " .. self._curActivityId .. ", weaponId: " .. weaponId .. ", taskId: " .. taskId)
	end

	;((self._isWin or nil) and txtDescPassGo:GetComponent(goutil.Type_UIText)).text = taskDesc

	goutil.setActive(goFinished, isFinish)

	local iconWeapon = goutil.findChildComponent(go, "weaponicon", "UIImageSpriteChange")
	local imageIcon = iconWeapon:GetComponent(goutil.Type_UIImage)

	iconWeapon:ChangeSprite(weaponCfg.weaponPic)
	imageIcon:SetNativeSize()
end

function DefendCarrotResultView:_clearCell(cell)
	local iconReward = goutil.findChild(cell.gameObject, "reward/icon")

	MaterialMgr.resetAll(iconReward)
end

function DefendCarrotResultView:_onClickReturn()
	self:close()
	UIStateManager.instance:popByName(ViewName.DefendCarrotGameView)
end

function DefendCarrotResultView:_onClickRestart()
	self:close()
	UIStateManager.instance:popByName(ViewName.DefendCarrotGameView)
	DefendCarrotController.instance:startGame(self._curActivityId, self._curStageId)
end

function DefendCarrotResultView:_onClickNext()
	self:close()
	UIStateManager.instance:popByName(ViewName.DefendCarrotGameView)
	DefendCarrotController.instance:startGame(self._curActivityId, self._curStageId + 1)
end

return DefendCarrotResultView
