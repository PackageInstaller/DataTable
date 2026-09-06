-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/theater/controller/TheaterController.lua

module("logic.extensions.theater.controller.TheaterController", package.seeall)

local TheaterController = class("TheaterController", BaseController)

function TheaterController:ctor()
	TheaterController.super.ctor(self)
end

function TheaterController:onInit()
	TheaterController.super.onInit(self)

	self._stopExpressionParam = {}
	self._stopDialogParam = {}
	self._waitQueue = {}
	self._theaterRules = {}
	self._theaterInfo = {}
	self._actionComplete = true
	self._expressionComplete = true
	self._dialogComplete = true
	self._faceComplete = true
end

function TheaterController:onReset()
	TheaterController.super.onReset(self)

	self._stopExpressionParam = {}
	self._stopDialogParam = {}
	self._waitQueue = {}
	self._theaterRules = {}
	self._theaterInfo = {}
	self._actionComplete = true
	self._expressionComplete = true
	self._dialogComplete = true
	self._faceComplete = true
end

function TheaterController:registerRule(theaterId, ruleName, go)
	self._theaterRules[theaterId] = self._theaterRules[theaterId] or {}

	local rules = TheaterModel.instance:getInitRuleById(theaterId)

	for k, v in pairs(rules) do
		if k == ruleName then
			local model = TheaterModel.instance:getRuleComponents(go)

			self._theaterRules[theaterId][ruleName] = model

			for key, v in pairs(rules[ruleName]) do
				model[key] = v
			end

			return model
		end
	end
end

function TheaterController:play(theaterId, status, stopCallback, callbackObj)
	if not self:isPlayComplete() or #self._waitQueue > 0 then
		if theaterId == self._playIngId then
			local statusInfo = clone(self._theaterInfo[theaterId][status])

			statusInfo.stopCallback = stopCallback
			statusInfo.stopCallbackObj = callbackObj

			table.insert(self._waitQueue, statusInfo)
		end
	else
		self._theaterInfo[theaterId] = self._theaterInfo[theaterId] or TheaterModel.instance:getInitContentById(theaterId)

		if self._theaterInfo[theaterId][status] == nil then
			printError("缺少剧场id:%d,第%d幕的配置", theaterId, status)
		end

		self._rulesIng, self._playIngId = self._theaterRules[theaterId], theaterId

		local statusInfo = clone(self._theaterInfo[theaterId][status])

		self._stopCallback = stopCallback
		self._stopCallbackObj = callbackObj

		self:_switchStatus(self._theaterRules[theaterId], statusInfo)
	end
end

function TheaterController:stop()
	removetimer(self._playAction, self)
	FixedUpdateBeat:Remove(self._checkAnimationEnd, self)
	removetimer(self.__playFace, self)
	removetimer(self._playExpression, self)
	removetimer(self._stopExpression, self)
	removetimer(self._playDialog, self)
	removetimer(self._stopDialog, self)

	self._actionComplete = true
	self._expressionComplete = true
	self._dialogComplete = true
	self._faceComplete = true
	self._playIngId = nil
	self._stopExpressionParam = {}
	self._stopDialogParam = {}

	if self._stopCallback then
		self._stopCallback(self._stopCallbackObj)
	end
end

function TheaterController:clearExpressionRes()
	for k, rule in pairs(self._rulesIng) do
		goutil.setActive(rule.face, false)
		goutil.setActive(rule.expression, false)
		goutil.setActive(rule.dialogGo, false)
		uGuiUtil.clearImage(rule.expression)
		uGuiUtil.clearImage(rule.face)
	end
end

function TheaterController:isPlayComplete()
	return self._actionComplete and self._expressionComplete and self._dialogComplete and self._faceComplete
end

function TheaterController:_tryPlayNextStatus()
	if self:isPlayComplete() then
		local theaterId = self._playIngId

		self:stop()

		if #self._waitQueue > 0 then
			local statusInfo = self._waitQueue[1]

			table.remove(self._waitQueue, 1)

			self._playIngId = theaterId
			self._stopCallback = statusInfo.stopCallback
			self._stopCallbackObj = statusInfo.stopCallbackObj

			self:_switchStatus(self._theaterRules[theaterId], statusInfo)
		end
	end
end

function TheaterController:_switchStatus(rules, statusInfo)
	for k, rule in pairs(rules) do
		goutil.setActive(rule.face, false)

		if rule.defaultFace then
			uGuiUtil.setSpriteToImage(rule.face, uGuiUtil.SpriteType.BigBg, GameUrl.getTheaterUrl(rule.defaultFace.url), function()
				goutil.setActive(rule.face, true)
			end)
		end

		goutil.setActive(rule.expression, false)

		if rule.defaultExpression then
			uGuiUtil.setSpriteToImage(rule.expression, uGuiUtil.SpriteType.BigBg, GameUrl.getTheaterUrl(rule.defaultExpression.url), function()
				goutil.setActive(rule.expression, true)
			end)
		end

		goutil.setActive(rule.dialogGo, false)

		if rule.defaultAction then
			rule.animation:Play(rule.defaultAction.name)
		end
	end

	if statusInfo.actionList then
		self._actionList = statusInfo.actionList
		self._actionComplete = false

		settimer(statusInfo.actionList[1].startTime, self._playAction, self, false)
	else
		self._actionComplete = true
	end

	if statusInfo.faceList then
		self._faceList = statusInfo.faceList
		self._faceComplete = false

		settimer(statusInfo.faceList[1].startTime, self._playFace, self, false)
	else
		self._faceComplete = true
	end

	if statusInfo.expressionList then
		self._expressionList = statusInfo.expressionList
		self._expressionComplete = false

		settimer(statusInfo.expressionList[1].startTime, self._playExpression, self, false)
	else
		self._expressionComplete = true
	end

	if statusInfo.dialogList then
		self._dialogEd = {}

		for k, rule in pairs(rules) do
			rule.dialogText:AddStepEventHandler(function()
				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(rule.dialogText.gameObject:GetComponent(goutil.Type_RectTransform))
				GameUtil.setHeight(rule.dialogGo, GameUtil.getHeight(rule.dialogText.gameObject) + rule.dialogHeightDiff)
				GameUtil.setWidth(rule.dialogGo, GameUtil.getWidth(rule.dialogText.gameObject) + rule.dialogWidthDiff)
			end)

			self._dialogEd[k] = true
		end

		self._dialogList = statusInfo.dialogList
		self._dialogComplete = false

		settimer(statusInfo.dialogList[1].startTime, self._playDialog, self, false)
	else
		self._dialogComplete = true
	end

	if statusInfo.pointList then
		self._pointList = statusInfo.pointList
		self._moveIndex = 0

		FixedUpdateBeat:Add(self._ruleMove, self)
	else
		self._moveComplete = true
	end
end

function TheaterController:_playAction()
	local actionParam, nextAction = self._actionList[1], self._actionList[2]

	self._rulesIng[actionParam.ruleName].animation:Play(actionParam.name)
	table.remove(self._actionList, 1)

	if nextAction then
		settimer(nextAction.startTime - actionParam.startTime, self._playAction, self, false)
	else
		FixedUpdateBeat:Add(self._checkAnimationEnd, self)
	end
end

function TheaterController:_checkAnimationEnd()
	local rules, flag = self._rulesIng, true

	for k, rule in pairs(rules) do
		if rule.animation.isPlaying then
			flag = false

			break
		end
	end

	if flag then
		FixedUpdateBeat:Remove(self._checkAnimationEnd, self)

		self._actionComplete = true

		self:_tryPlayNextStatus()
	end
end

function TheaterController:_playFace()
	local faceParam, nextFace = self._faceList[1], self._faceList[2]

	uGuiUtil.clearImage(self._rulesIng[faceParam.ruleName].face)
	goutil.setActive(self._rulesIng[faceParam.ruleName].face, false)
	uGuiUtil.setSpriteToImage(self._rulesIng[faceParam.ruleName].face, uGuiUtil.SpriteType.BigBg, faceParam.url, function()
		goutil.setActive(self._rulesIng[faceParam.ruleName].face, true)
	end)

	if faceParam.x and faceParam.y then
		GameUtil.setPos(self._rulesIng[faceParam.ruleName].face, faceParam.x, faceParam.y, faceParam.z)
	end

	table.remove(self._faceList, 1)

	if nextFace then
		settimer(nextFace.startTime - faceParam.startTime, self._playFace, self, false)
	else
		self._faceComplete = true

		self:_tryPlayNextStatus()
	end
end

function TheaterController:_playExpression()
	local expressionParam, nextExpression = self._expressionList[1], self._expressionList[2]

	uGuiUtil.clearImage(self._rulesIng[expressionParam.ruleName].expression)
	goutil.setActive(self._rulesIng[expressionParam.ruleName].expression, false)
	uGuiUtil.setSpriteToImage(self._rulesIng[expressionParam.ruleName].expression, uGuiUtil.SpriteType.BigBg, expressionParam.url, function()
		goutil.setActive(self._rulesIng[expressionParam.ruleName].expression, true)
	end)

	if expressionParam.endTime >= 0 then
		table.insert(self._stopExpressionParam, {
			rule = expressionParam.ruleName,
			time = expressionParam.startTime + expressionParam.endTime,
			setTime = os.time(),
			endTime = expressionParam.endTime
		})

		if #self._stopExpressionParam == 1 then
			settimer(expressionParam.endTime, self._stopExpression, self, false)
		else
			table.sort(self._stopExpressionParam, function(a, b)
				return a.time < b.time
			end)
			removetimer(self._stopExpression, self)

			local _time = os.time() - self._stopExpressionParam[1].setTime

			settimer(self._stopExpressionParam[1].endTime - _time, self._stopExpression, self, false)
		end
	end

	table.remove(self._expressionList, 1)

	if nextExpression then
		settimer(nextExpression.startTime - expressionParam.startTime, self._playExpression, self, false)
	elseif #self._stopExpressionParam == 0 then
		self._expressionComplete = true

		self:_tryPlayNextStatus()
	end
end

function TheaterController:_stopExpression()
	local param, next = self._stopExpressionParam[1], self._stopExpressionParam[2]

	uGuiUtil.clearImage(self._rulesIng[param.rule].expression)
	goutil.setActive(self._rulesIng[param.rule].expression, false)
	table.remove(self._stopExpressionParam, 1)

	if next then
		settimer(next.time - param.time, self._stopExpression, self, false)
	else
		self._expressionComplete = true

		self:_tryPlayNextStatus()
	end
end

function TheaterController:_playDialog()
	local dialogParam, nextDialog = self._dialogList[1], self._dialogList[2]

	self._rulesIng[dialogParam.ruleName].dialogText:SetText(dialogParam.content)

	self._dialogEd[dialogParam.ruleName] = false

	self._rulesIng[dialogParam.ruleName].dialogText:AddEventHandler(function()
		self._dialogEd[dialogParam.ruleName] = true

		local flag = true

		for k, v in pairs(self._dialogEd) do
			if not v then
				flag = false

				break
			end
		end

		if flag and #self._stopDialogParam == 0 and #self._dialogList == 0 then
			self._dialogComplete = true

			self:_tryPlayNextStatus()
		end
	end)
	goutil.setActive(self._rulesIng[dialogParam.ruleName].dialogGo, true)
	table.remove(self._dialogList, 1)

	if dialogParam.endTime >= 0 then
		table.insert(self._stopDialogParam, {
			rule = dialogParam.ruleName,
			time = dialogParam.startTime + dialogParam.endTime,
			setTime = os.time(),
			endTime = dialogParam.endTime
		})

		if #self._stopDialogParam == 1 then
			settimer(dialogParam.endTime, self._stopDialog, self, false)
		else
			table.sort(self._stopDialogParam, function(a, b)
				return a.time < b.time
			end)
			removetimer(self._stopDialog, self)

			local _time = os.time() - self._stopDialogParam[1].setTime

			settimer(self._stopDialogParam[1].endTime - _time, self._stopDialog, self, false)
		end
	end

	if nextDialog then
		settimer(nextDialog.startTime - dialogParam.startTime, self._playDialog, self, false)
	end
end

function TheaterController:_stopDialog()
	local param, next = self._stopDialogParam[1], self._stopDialogParam[2]

	self._rulesIng[param.rule].dialogText:SetText("")
	goutil.setActive(self._rulesIng[param.rule].dialogGo, false)
	table.remove(self._stopDialogParam, 1)

	if next then
		settimer(next.time - param.time, self._stopExpression, self, false)
	else
		local flag = true

		for k, v in pairs(self._dialogEd) do
			if not v then
				flag = false

				break
			end
		end

		if flag and #self._dialogList == 0 then
			self._dialogComplete = true

			self:_tryPlayNextStatus()
		end
	end
end

function TheaterController:_ruleMove()
	local flag = true

	for i, value in ipairs(self._pointList) do
		if value.points[self._moveIndex] then
			GameUtil.setPos(self._rulesIng[value.ruleName].go, value.points[self._moveIndex].x, value.points[self._moveIndex].y)

			flag = false
		end
	end

	self._moveIndex = self._moveIndex + 1

	if flag then
		self._moveComplete = true

		FixedUpdateBeat:Remove(self._ruleMove, self)
	end
end

TheaterController.instance = TheaterController.New()

return TheaterController
