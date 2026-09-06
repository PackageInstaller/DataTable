-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dreamteam/controller/FlipGameController.lua

module("logic.extensions.dreamteam.controller.FlipGameController", package.seeall)

local FlipGameController = class("FlipGameController", BaseController)
local recordDataStr = "FlipGameController"

function FlipGameController:ctor()
	return
end

function FlipGameController:onInit()
	self:onReset()
end

function FlipGameController:onReset()
	GlobalDispatcher:addListener("gotoflipgamestartview", self.gotoFlipGameStartView, self)
	GlobalDispatcher:addListener("gotoflipgamestartviewbyrelationship", self.gotoFlipGameStartViewByRelationship, self)
end

function FlipGameController:openGameStart(activityId)
	local isOpenedToday = GameUtil.getUserDayData(recordDataStr)

	if isOpenedToday then
		self:openGameMain(activityId)
	else
		GameUtil.saveUserDayData(recordDataStr, true)
		UIStateManager.instance:push(ViewName.FlipGameStart, activityId)
	end
end

function FlipGameController:openGameMain(activityId)
	UIStateManager.instance:push(ViewName.FlipGameMain, activityId)
end

function FlipGameController:openGameOver()
	UIStateManager.instance:push(ViewName.FlipGameOver)
end

function FlipGameController:gotoFlipGameStartView(params)
	local activityId = checknumber(params[1])

	self:openFlipGameStartView(activityId)
end

function FlipGameController:gotoFlipGameStartViewByRelationship(params)
	local activityId = checknumber(params[1])

	if activityId <= 0 then
		FloatWordMgr.instance:show("活动id错误")

		return
	end

	local function openGameOver(info)
		local tipsContent = "游戏结束"

		local function okFunc()
			if info and info.handler then
				info.handler:close()
			end
		end

		local alignment = UnityEngine.TextAnchor.MiddleCenter

		TipsFacade.instance:openTipWindowNoX("提示", tipsContent, okFunc, "确定", alignment)
	end

	FlipGameModel.instance:getFlipExMo():setOpenGameOverOfFlipExMo(openGameOver)
	self:openFlipGameStartView(activityId)
end

function FlipGameController:gotoFlipGameStartViewByEternalDragon(activityId, edActId)
	if activityId <= 0 then
		FloatWordMgr.instance:show("活动id错误")

		return
	end

	if not EternalDragonController.instance:isInActivityTime(edActId) then
		printError(string.format("传入参数错误( edActId = %s | yy运营-永恒圣龙揭秘.xlsx )", edActId))

		return
	end

	local function openGameOver(info)
		local tipsContent = "游戏结束"

		local function okFunc()
			if info and info.handler then
				info.handler:close()

				local score = info.score
				local data = EternalDragonConfig.instance:getEdActData(edActId)

				if data then
					::label_13_0::

					local var_13_0 = data.cutViewValidator

					if data.cutViewValidator then
						local needScore = data.cutViewValidator.score

						if (not string.nilorempty(needScore) or nil) and score >= checknumber(needScore) then
							EternalDragonController.instance:sendPM_EternalDragonCuttingReq(edActId)
						end
					end
				end
			end
		end

		local alignment = UnityEngine.TextAnchor.MiddleCenter

		TipsFacade.instance:openTipWindowNoX("提示", tipsContent, okFunc, "确定", alignment)
	end

	FlipGameModel.instance:getFlipExMo():setOpenGameOverOfFlipExMo(openGameOver)
	UIStateManager.instance:push(ViewName.FlipGameMainOfEternalDragonView, activityId)
end

function FlipGameController:openFlipGameStartView(activityId)
	activityId = checknumber(activityId)

	if activityId <= 0 then
		FloatWordMgr.instance:show("活动id错误")

		return
	end

	self._activityIdOfOpen = activityId

	GlobalDispatcher:addListener(GlobalNotify.FlipTouchGetInfo, self._handleOpenFlipGameStartView, self)
	FlipTouchAgent.instance:sendPM_FlipTouchGetInfoReq(activityId)
end

function FlipGameController:_handleOpenFlipGameStartView()
	GlobalDispatcher:removeListener(GlobalNotify.FlipTouchGetInfo, self._handleOpenFlipGameStartView, self)

	local activityId = checknumber(self._activityIdOfOpen)

	if activityId <= 0 then
		return
	else
		self._activityIdOfOpen = nil
	end

	local result, tips = DreamTeamController.instance:getTryPlayGameOfResultAndTips(activityId)

	FloatWordMgr.instance:show(tips)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	FlipGameController.instance:openGameStart(activityId)
end

FlipGameController.instance = FlipGameController.New()

return FlipGameController
