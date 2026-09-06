-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/luotiandajiao/view/LTDaJiaoMainView.lua

module("logic.extensions.luotiandajiao.view.LTDaJiaoMainView", package.seeall)

local LTDaJiaoMainView = class("LTDaJiaoMainView", TableViewComponent)
local MaxWaitCount = 12
local MaxChampionWaitCount = 14

function LTDaJiaoMainView:buildUI()
	LTDaJiaoMainView.super.buildUI(self)

	self._closeButton = self:getBtn("btnClose")
	self._championUI = self:getGo("championui")
	self._commonUI = self:getGo("commonui")
	self._maskGo = self:getGo("mask")
	self._myHeadGo = self:getGo("commonui/roleshow/playerInfo1/head")
	self._myTxtArea = self:getTxt("commonui/roleshow/playerInfo1/txtArea")
	self._myTxtName = self:getTxt("commonui/roleshow/playerInfo1/txtName")
	self._enemyHeadGo = self:getGo("commonui/roleshow/playerInfo2/head")
	self._enemyTxtArea = self:getTxt("commonui/roleshow/playerInfo2/txtArea")
	self._enemyTxtName = self:getTxt("commonui/roleshow/playerInfo2/txtName")
	self._roleShowGo = self:getGo("commonui/roleshow")
	self._waitSelectGo = self:getGo("commonui/waitSelect")
	self._headCommonCell = self:getGo("commonui/waitSelect/headcell")

	self._headCommonCell:SetActive(false)

	self._gridGo = self:getGo("commonui/waitSelect/grid")
	self._btnCommonStart = self:getBtn("commonui/btnStart")
	self._passShowGo = self:getGo("commonui/passShow")
	self._passHeadIcon = self:getGo("commonui/passShow/head")
	self._passTxtName = self:getTxt("commonui/passShow/txtName")
	self._passImgNum = self:getGo("commonui/passShow/imgNum"):GetComponent(typeof(UIImgNumeralText))
	self._animator = goutil.findChildComponent(self.mainGO, "commonui", "Animator")
	self._effectParent = self:getGo("commonui/effect")
	self._headChampionCell = self:getGo("championui/headcell")

	self._headChampionCell:SetActive(false)

	self._middleChampion = self:getGo("championui/middleChampion")
	self._challengeGroupGo = self:getGo("championui/challengeGroup")
	self._btnChampionStart = self:getBtn("championui/btnStart")
	self._winShowGo = self:getGo("championui/winShow")
	self._championRecordPos = self._challengeGroupGo:GetComponent(typeof(TestRecordPos))
	self._passChampionHeadIcon = self:getGo("championui/winShow/head")

	self:_initWaitSelectShow()
	self:_initChampionWaitSelctShow()
end

function LTDaJiaoMainView:bindEvents()
	LTDaJiaoMainView.super.bindEvents(self)
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._btnCommonStart:AddClickListener(self._onClickCommonStart, self)
	self._btnChampionStart:AddClickListener(self._onClickChampionStart, self)
end

function LTDaJiaoMainView:unbindEvents()
	LTDaJiaoMainView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
	self._btnCommonStart:RemoveClickListener()
	self._btnChampionStart:RemoveClickListener()
end

function LTDaJiaoMainView:onEnter()
	LTDaJiaoMainView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.LuoTianDaJiaoChoiceRes, self._onChoiceRes, self)

	self._waitSelectInfos = {}

	self:_resetRightShow()

	self._activityId = self:getFirstParam()

	if not self:_isInActivityTime() then
		return
	end

	self:_initCommonMyHeadShow()
	self:_initCommonPassHeadShow()
	self:_initTeams()
	self:_playVsEffect()
end

function LTDaJiaoMainView:onExit()
	LTDaJiaoMainView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.LuoTianDaJiaoChoiceRes, self._onChoiceRes, self)
	self:_removeRoleShowHead()
	self:_removeWaitSelectHead()
	self:_removeChampionHead()
	self:_removeTween()
	self:_stopSelectEnemyAnimation()
	self:_removeVsEffect()
end

function LTDaJiaoMainView:_onClickClose()
	self:close()
end

function LTDaJiaoMainView:_onClickCommonStart()
	if self._curGroupCfg then
		if LTDaJiaoModel.instance:isPass(self._curGroupCfg.group) then
			FloatWordMgr.instance:show("本组已通关")
		elseif LTDaJiaoModel.instance:getCurRobot() then
			self:_openMissionView()
		else
			self:_playSelectEnemyAnimation()
			LuoTianDaJiaoAgent.instance:sendPM_LuoTianDaJiaoChoiceReq(self._activityId)
			printInfo("test sendPM_LuoTianDaJiaoChoiceReq", self._activityId)
		end
	end
end

function LTDaJiaoMainView:_openMissionView()
	local planId = LTDaJiaoModel.instance:curChallengePlanId()
	local groupId = LTDaJiaoModel.instance:getCurGroupId()
	local stage = LTDaJiaoModel.instance:getCurBeatRobotCount() + 1

	if self._curGroupCfg and stage > self._curGroupCfg.robotNum then
		stage = self._curGroupCfg.robotNum
	end

	UIStateManager.instance:push(ViewName.LTDJMissionView, planId, groupId, stage)
end

function LTDaJiaoMainView:_onClickChampionStart()
	if self._curGroupCfg then
		if LTDaJiaoModel.instance:isPass(self._curGroupCfg.group) then
			FloatWordMgr.instance:show("本组已通关")
		else
			local planId = LTDaJiaoModel.instance:curChallengePlanId()
			local groupId = LTDaJiaoModel.instance:getCurGroupId()
			local stage = LTDaJiaoModel.instance:getChampionCurMaxStage()

			UIStateManager.instance:push(ViewName.LTDJMissionView, planId, groupId, stage)
		end
	end
end

function LTDaJiaoMainView:_getPath()
	return {
		cellPath = "teams/cell",
		viewPath = "teams/Scrollview"
	}
end

function LTDaJiaoMainView:_updateCell(view, cell, data)
	local btnClick = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btnClick")
	local passGo = goutil.findChild(cell, "pass")
	local lockGo = goutil.findChild(cell, "lock")
	local txtDesc = goutil.findChildTextComponent(cell, "btnClick/txtDesc")
	local redPoint = goutil.findChild(cell, "redPoint")
	local changeGroup = btnClick.gameObject:GetComponent(typeof(UIChangeGroup))

	btnClick:AddClickListener(function()
		if data.isSelect then
			return
		end

		if not data.isUnlock then
			if data.unlockTimestamp then
				local date = GameUtil.time2date(data.unlockTimestamp)

				FloatWordMgr.instance:show(string.format("此关卡在%d年%d月%d日 %02d:%02d:%02d 后开启", date.year, date.month, date.day, date.hour, date.min, date.sec))
			else
				FloatWordMgr.instance:show("此关卡还未解锁")
			end

			return
		end

		self:_updateTeamSelect(data.cfg.group)
		self:_updateRightMatchShow(data.isChampion, data.cfg)
	end)
	changeGroup:SetState(data.isSelect and 1 or 0)
	passGo:SetActive(data.isPass)
	lockGo:SetActive(not data.isUnlock)
	redPoint:SetActive(data.isUnlock and not data.isPass)

	txtDesc.text = data.desc

	if data.isSelect then
		self:_updateRightMatchShow(data.isChampion, data.cfg)
	end
end

function LTDaJiaoMainView:_clearTableview(cell)
	local btnClick = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btnClick")

	btnClick:RemoveClickListener()
end

function LTDaJiaoMainView:_updateTeamSelect(groupId)
	for i, v in ipairs(self._curViewDatas) do
		v.isSelect = v.cfg.group == groupId
	end

	self:reloadData()
end

function LTDaJiaoMainView:_isInActivityTime()
	if not LTDaJiaoModel.instance:isInActivityTime() then
		self:_popupCloseTip()

		return false
	end

	return true
end

function LTDaJiaoMainView:_popupCloseTip()
	UIStateManager.instance:closeAllModalViews()
	TipsFacade.instance:openTipWindowNoX("提示", "罗天大醮未在活动时间内哦", function()
		self:_onClickClose()
	end, "确定")
end

function LTDaJiaoMainView:_resetRightShow()
	self._commonUI:SetActive(false)
	self._championUI:SetActive(false)
end

function LTDaJiaoMainView:_initTeams()
	local list = LTDaJiaoController.instance:getGroupList()
	local reverseList = {}

	for i, v in ipairs(list) do
		table.insert(reverseList, 1, v)
	end

	self:updateListData(reverseList)
end

function LTDaJiaoMainView:_updateRightMatchShow(isChampion, groupCfg)
	self._curGroupCfg = groupCfg

	self._championUI:SetActive(isChampion)
	self._commonUI:SetActive(not isChampion)

	if isChampion then
		self:_updateChampionShow(groupCfg)
	else
		self:_updateCommonShow(groupCfg)
	end
end

function LTDaJiaoMainView:_updateCommonShow(groupCfg)
	if LTDaJiaoModel.instance:isPass(groupCfg.group) then
		self._roleShowGo:SetActive(false)
		self._waitSelectGo:SetActive(false)
		self._btnCommonStart.gameObject:SetActive(false)
		self._passShowGo:SetActive(true)
		self:_updateCommonPassImgNum()
	else
		self._roleShowGo:SetActive(true)
		self._waitSelectGo:SetActive(true)
		self._btnCommonStart.gameObject:SetActive(true)
		self._passShowGo:SetActive(false)
		self:_updateCommonEnemyHeadShow()
		self:_updateWaitSelectShow(groupCfg)
	end
end

function LTDaJiaoMainView:_updateChampionShow(groupCfg)
	if LTDaJiaoModel.instance:isPass(groupCfg.group) then
		self._middleChampion:SetActive(false)
		self._challengeGroupGo:SetActive(false)
		self._btnChampionStart.gameObject:SetActive(false)
		self._winShowGo:SetActive(true)
	else
		self._middleChampion:SetActive(true)
		self._challengeGroupGo:SetActive(true)
		self._btnChampionStart.gameObject:SetActive(true)
		self._winShowGo:SetActive(false)
		self:_updateChampionWaitSelectShow(groupCfg)
	end
end

function LTDaJiaoMainView:_initCommonMyHeadShow()
	MaterialMgr.resetAll(self._myHeadGo)
	HeadItemController.instance:setMyHeadCell(self._myHeadGo)

	self._myTxtArea.text = RoleModel.instance:getAreaName()
	self._myTxtName.text = RoleModel.instance:getUserName()
end

function LTDaJiaoMainView:_updateCommonEnemyHeadShow()
	MaterialMgr.resetAll(self._enemyHeadGo)

	local curRobot = LTDaJiaoModel.instance:getCurRobot()

	if curRobot then
		HeadItemController.instance:setHeadCellByInfo(self._enemyHeadGo, curRobot.info)

		self._enemyTxtArea.text = curRobot.areaName
		self._enemyTxtName.text = curRobot.info.userName
	else
		self._enemyTxtArea.text = "???"
		self._enemyTxtName.text = "???"
	end
end

function LTDaJiaoMainView:_removeRoleShowHead()
	MaterialMgr.resetAll(self._myHeadGo)
	MaterialMgr.resetAll(self._enemyHeadGo)
	MaterialMgr.resetAll(self._passHeadIcon)
	MaterialMgr.resetAll(self._passChampionHeadIcon)
end

function LTDaJiaoMainView:_initCommonPassHeadShow()
	MaterialMgr.resetAll(self._passHeadIcon)
	HeadItemController.instance:setMyHeadCell(self._passHeadIcon)

	self._passTxtName.text = RoleModel.instance:getUserName()

	MaterialMgr.resetAll(self._passChampionHeadIcon)
	HeadItemController.instance:setMyHeadCell(self._passChampionHeadIcon)
end

function LTDaJiaoMainView:_updateCommonPassImgNum()
	if self._curGroupCfg and self._curGroupCfg.desc then
		self._passImgNum:SetNum(self._curGroupCfg.desc)
	else
		self._passImgNum:SetNum(0)
	end
end

function LTDaJiaoMainView:_initWaitSelectShow()
	self._commonHeadList = {}

	for i = 1, MaxWaitCount do
		local go = goutil.cloneAndSetParent(self._headCommonCell, self._gridGo.transform, "waitItem" .. i)

		go:SetActive(false)

		local element = {}

		element.go = go
		element.headGo = goutil.findChild(go, "head")
		element.txtName = goutil.findChildTextComponent(go, "txtName")
		element.defeated = goutil.findChild(go, "defeated")
		element.select = goutil.findChild(go, "select")

		table.insert(self._commonHeadList, element)
	end
end

function LTDaJiaoMainView:_updateWaitSelectInfoList()
	local curRobot = LTDaJiaoModel.instance:getCurRobot()
	local groupList = LTDaJiaoModel.instance:getCurGroupRobots()

	self._waitSelectInfos = {}

	for i, v in ipairs(groupList) do
		local element = {}

		element.isBeat = LTDaJiaoModel.instance:isBeatCurRobot(v.info.userId)
		element.name = v.info.userName
		element.headInfo = v.info
		element.isSelect = curRobot and curRobot.info.userId == v.info.userId

		table.insert(self._waitSelectInfos, element)
	end
end

function LTDaJiaoMainView:_updateWaitSelectShow(groupCfg)
	self:_updateWaitSelectInfoList()

	local count = #self._waitSelectInfos

	for i = 1, MaxWaitCount do
		MaterialMgr.resetAll(self._commonHeadList[i].headGo)

		if i <= count then
			local element = self._waitSelectInfos[i]

			self._commonHeadList[i].go:SetActive(true)

			if not element.isBeat then
				HeadItemController.instance:setHeadCellByInfo(self._commonHeadList[i].headGo, element.headInfo)
			end

			self._commonHeadList[i].txtName.text = element.name

			self._commonHeadList[i].defeated:SetActive(element.isBeat)
		else
			self._commonHeadList[i].go:SetActive(false)
		end
	end

	self:_updateSelectEnemy()
end

function LTDaJiaoMainView:_removeWaitSelectHead()
	for i = 1, MaxWaitCount do
		if self._commonHeadList[i].headGo then
			MaterialMgr.resetAll(self._commonHeadList[i].headGo)
		end
	end
end

function LTDaJiaoMainView:_onChoiceRes()
	printInfo("test _onChoiceRes")

	self._isRecieveRes = true
end

function LTDaJiaoMainView:_updateSelectEnemy()
	local curRobot = LTDaJiaoModel.instance:getCurRobot()

	if curRobot then
		for i, v in ipairs(self._waitSelectInfos) do
			if self._commonHeadList[i] then
				local element = self._commonHeadList[i]

				element.select:SetActive(v.headInfo.userId == curRobot.info.userId)
			end
		end
	else
		for i, v in ipairs(self._waitSelectInfos) do
			if self._commonHeadList[i] then
				local element = self._commonHeadList[i]

				element.select:SetActive(false)
			end
		end
	end
end

function LTDaJiaoMainView:_initChampionWaitSelctShow()
	self._championHeadList = {}

	for i = 1, MaxChampionWaitCount do
		local go = goutil.cloneAndSetParent(self._headChampionCell, self._challengeGroupGo.transform, "waitItem" .. i)

		go:SetActive(false)

		local element = {}

		element.go = go
		element.headGo = goutil.findChild(go, "head")
		element.txtName = goutil.findChildTextComponent(go, "txtName")
		element.defeated = goutil.findChild(go, "defeated")
		element.selectGo = goutil.findChild(go, "select")
		element.winIcon = goutil.findChild(go, "win")

		table.insert(self._championHeadList, element)
	end

	self._championRecordPos:LoadPlan(0)
end

function LTDaJiaoMainView:_getCountByIndex(index)
	if index == 1 then
		return 8
	elseif index == 2 then
		return 4
	elseif index == 3 then
		return 2
	elseif index == 4 then
		return 0
	else
		return 0
	end
end

function LTDaJiaoMainView:_updateChampionWaitInfoList()
	self._waitChampionSelectInfos = {}

	local maxStage = LTDaJiaoModel.instance:getChampionCurMaxStage()

	if maxStage == 4 then
		-- block empty
	else
		for i = 1, maxStage do
			local myElement = {}

			myElement.name = RoleModel.instance:getUserName()
			myElement.isMySelf = true
			myElement.headInfo = nil
			myElement.stage = i

			table.insert(self._waitChampionSelectInfos, myElement)

			local userIdList = LTDaJiaoModel.instance:getChampionUserIdListByStage(i)

			for j, userId in ipairs(userIdList) do
				local robotInfo = LTDaJiaoModel.instance:getChampionRobotById(userId)

				if robotInfo then
					local element = {}

					element.name = robotInfo.info.userName
					element.headInfo = robotInfo.info
					element.isMySelf = false
					element.stage = i
					element.isWin = i < maxStage and LTDaJiaoModel.instance:isExistUserIdOnStage(i + 1, userId) or false

					table.insert(self._waitChampionSelectInfos, element)
				end
			end
		end
	end
end

function LTDaJiaoMainView:_updateChampionWaitSelectShow(groupCfg)
	self:_updateChampionWaitInfoList()

	local maxStage = LTDaJiaoModel.instance:getChampionCurMaxStage()
	local count = #self._waitChampionSelectInfos

	for i = 1, MaxChampionWaitCount do
		if i <= count then
			self._championHeadList[i].go:SetActive(true)

			local v = self._waitChampionSelectInfos[i]

			if v then
				if v.isMySelf then
					HeadItemController.instance:setMyHeadCell(self._championHeadList[i].headGo)
				elseif v.isWin or maxStage <= v.stage then
					HeadItemController.instance:setHeadCellByInfo(self._championHeadList[i].headGo, v.headInfo)
				end

				self._championHeadList[i].selectGo:SetActive(v.isMySelf)

				self._championHeadList[i].txtName.text = v.name

				if maxStage > v.stage then
					self._championHeadList[i].defeated:SetActive(not v.isMySelf and not v.isWin)
					self._championHeadList[i].winIcon:SetActive(v.isMySelf or v.isWin)
				else
					self._championHeadList[i].defeated:SetActive(false)
					self._championHeadList[i].winIcon:SetActive(false)
				end
			end
		else
			self._championHeadList[i].go:SetActive(false)
		end
	end
end

function LTDaJiaoMainView:_removeChampionHead()
	if self._championHeadList then
		for i, v in ipairs(self._championHeadList) do
			MaterialMgr.resetAll(self._championHeadList[i].headGo)
		end
	end
end

function LTDaJiaoMainView:_removeTween()
	if self._choiceTween then
		self._choiceTween:Kill()

		self._choiceTween = nil
	end
end

function LTDaJiaoMainView:_playSelectEnemyAnimation()
	self._minInternal = 0.05
	self._maxInternal = 0.3
	self._changeInternal = 0.1
	self._changeSign = -1
	self._curInternal = self._maxInternal
	self._timeRecord = 0
	self._isRecieveRes = false
	self._minPlayTime = 3
	self._minPlayTimeRecord = 0
	self._isTarget = false
	self._changeIndex = 0

	self:_openMask()
	settimer(0, self._onUpdate, self)
end

function LTDaJiaoMainView:_stopSelectEnemyAnimation()
	removetimer(self._onUpdate, self)
	self:_closeMask()
end

function LTDaJiaoMainView:_onUpdate()
	self._minPlayTimeRecord = self._minPlayTimeRecord + Time.deltaTime

	if self._timeRecord < self._curInternal then
		self._timeRecord = self._timeRecord + Time.deltaTime
	else
		self._timeRecord = 0
		self._curInternal = self._curInternal + self._changeSign * self._changeInternal
		self._curInternal = Mathf.Clamp(self._curInternal, self._minInternal, self._maxInternal)

		if self._isRecieveRes then
			local count = 0

			self._isTarget, count = self:_doChangeSelect()

			if self._isTarget and count == 1 then
				self:_onSelectAnimationEnd()
			end

			if Mathf.Abs(self._curInternal - self._minInternal) <= 0.0001 then
				if self._minPlayTimeRecord >= self._minPlayTime then
					self._changeSign = 1
				end
			elseif Mathf.Abs(self._curInternal - self._maxInternal) <= 0.0001 and self._isTarget then
				self:_onSelectAnimationEnd()
			end
		else
			self:_doChangeSelect()
		end
	end
end

function LTDaJiaoMainView:_onSelectAnimationEnd()
	self:_stopSelectEnemyAnimation()
	self:_updateCommonEnemyHeadShow()
	self:_updateSelectEnemy()
	self:_openMask()
	self:_playCommonAnim("1")
	goutil.setActive(self._effectParent, false)

	self._effectTween = TweenUtil.DoDelay(0.6, function()
		if not goutil.isNil(self._effectParent) then
			goutil.setActive(self._effectParent, true)
		end
	end)
	self._choiceTween = TweenUtil.DoDelay(2, function()
		self:_closeMask()
		self:_openMissionView()
	end)
end

function LTDaJiaoMainView:_playCommonAnim(animName)
	self._animator:Play(animName)
end

function LTDaJiaoMainView:_openMask()
	self._maskGo:SetActive(true)
end

function LTDaJiaoMainView:_closeMask()
	self._maskGo:SetActive(false)
end

function LTDaJiaoMainView:_doChangeSelect()
	local availableList = {}

	for i, v in ipairs(self._waitSelectInfos) do
		if self._commonHeadList[i] then
			local element = self._commonHeadList[i]

			element.select:SetActive(false)

			if not v.isBeat then
				table.insert(availableList, i)
			end
		end
	end

	local isTarget = false
	local count = #availableList

	if count > 0 then
		local index = 1

		if count > 1 then
			index = availableList[self._changeIndex % count + 1]

			self._commonHeadList[availableList[self._changeIndex % count + 1]].select:SetActive(true)
		elseif count == 1 then
			index = availableList[1]

			self._commonHeadList[availableList[1]].select:SetActive(true)
		end

		local curRobot = LTDaJiaoModel.instance:getCurRobot()

		if curRobot then
			if curRobot.info.userId == self._waitSelectInfos[index].headInfo.userId then
				isTarget = true
			end
		else
			isTarget = false
		end
	end

	self._changeIndex = self._changeIndex + 1

	return isTarget, count
end

function LTDaJiaoMainView:_playVsEffect()
	goutil.setActive(self._effectParent, false)

	local effect = UIEffectManager.instance:playEffect(self, "fx_ui_luotiandajiao/fx_ui_luotiandajiao.prefab", self._effectParent.transform, 0, 0, true, false)

	effect:setParent(self._effectParent.transform)
	effect:setScale(1)

	effect.hideEffWhileNotOnTop = false
	self._vsUIEffect1 = effect
	self._vsUIEffect2 = UIEffectManager.instance:playEffect(self, "fx_ui_luotiandajiao/fx_ui_luotiandajiao_vs.prefab", self._effectParent.transform, 0, 0, true, false)

	self._vsUIEffect2:setParent(self._effectParent.transform)
	self._vsUIEffect2:setScale(1)

	self._vsUIEffect2.hideEffWhileNotOnTop = false
end

function LTDaJiaoMainView:_removeVsEffect()
	if self._vsUIEffect1 then
		UIEffectManager.instance:stopEffect(self._vsUIEffect1)

		self._vsUIEffect1 = nil
	end

	if self._vsUIEffect2 then
		UIEffectManager.instance:stopEffect(self._vsUIEffect2)

		self._vsUIEffect2 = nil
	end
end

return LTDaJiaoMainView
