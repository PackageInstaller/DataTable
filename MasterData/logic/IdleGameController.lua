-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/idlegame/controller/IdleGameController.lua

module("logic.extensions.idlegame.controller.IdleGameController", package.seeall)

local IdleGameController = class("IdleGameController", BaseController)

function IdleGameController:ctor()
	return
end

function IdleGameController:onInit()
	XiaoNuoPlaceAgent.instance:addHandler(XiaoNuoPlaceAgent.PM_XiaoNuoOnPlayerReconnectRes, function(msg, status)
		if status == 0 then
			local info = msg.info

			IdleGameModel.instance:handlePM_XiaoNuoOnPlayerReconnectRes(info)
			IdleGameController.instance:localNotify("refreshMoneyInfo")
		end
	end)
	self:onReset()
end

function IdleGameController:onReset()
	self._isReqing = false

	RedPointController.instance:regUserDayRedPoint(RedPointModel.ID_IDLEGAME_START)
end

function IdleGameController:buyNuo(level)
	if IdleGameModel.instance:getMemberCount() >= IdleGameModel.instance:getCapacity() then
		FloatWordMgr.instance:show("放置的小诺已经满啦，请先合成高级小诺")
	elseif IdleGameModel.instance:getCurMoney() < IdleGameModel.instance:getBuyPrice(level) then
		FloatWordMgr.instance:show("萌值不够")
	else
		local cost = IdleGameModel.instance:getBuyPrice(level)

		if not self._isReqing then
			self._isReqing = true

			XiaoNuoPlaceAgent.instance:sendPM_XiaoNuoBuyReq(level, function(msg)
				self._isReqing = false

				IdleGameModel.instance:handlePM_XiaoNuoBuyRes(msg, cost)
				IdleGameController.instance:localNotify("AddNewNuo", msg.member)
			end, nil, function()
				self._isReqing = false
			end)
		end
	end
end

function IdleGameController:oneKeyCp(successCall)
	if self._isReqing then
		return
	end

	self._isReqing = true

	XiaoNuoPlaceAgent.instance:sendPM_XiaoNuoOneKeyComposeReq(function(msg)
		self._isReqing = false

		if successCall ~= nil then
			successCall(msg)
		end
	end, nil, function()
		self._isReqing = false
	end)
end

function IdleGameController:sendCallCp()
	self.doingOnekey = true

	local isFound = false
	local t = IdleGameModel.instance:getMembers()
	local arr = {}

	for _, v in ipairs(t) do
		if v.level > 0 then
			table.insert(arr, v)
		end
	end

	ArraySort.sortOn(arr, "level")

	if #arr > 1 then
		local last = arr[1]

		for i = 2, #arr do
			local tem = arr[i]

			if last.level == tem.level then
				isFound = true

				self:sendOneKey()

				break
			else
				last = tem
			end
		end
	end

	if isFound == false then
		self.doingOnekey = false

		FloatWordMgr.instance:show("一键合成结束，当前没有2只相同的小诺")
	end
end

function IdleGameController:sendOneKey()
	XiaoNuoPlaceAgent.instance:sendPM_XiaoNuoOneKeyComposeReq(function(msg)
		self.operate = msg.operate

		IdleGameModel.instance:handlePM_XiaoNuoOnPlayerReconnectRes(msg)
		self:startOperate()
	end)
end

function IdleGameController:startOperate()
	local preMaxLv = IdleGameModel.instance:getMaxNuoLevel()

	for _, msg in ipairs(self.operate) do
		IdleGameModel.instance:handlePM_XiaoNuoOneKeyRes(msg.target, msg)
		IdleGameController.instance:localNotify("ComposeNuo", {
			level = 0,
			position = msg.target
		}, msg)
	end

	local maxLv = IdleGameModel.instance:getMaxNuoLevel()

	if preMaxLv < maxLv then
		UIStateManager.instance:open(ViewName.UnlockNewNuo, maxLv)
	end

	self.doingOnekey = false
end

function IdleGameController:sendCompose(source, target)
	if self._isReqing then
		return
	end

	self._isReqing = true

	XiaoNuoPlaceAgent.instance:sendPM_XiaoNuoComposeReq(source, target, function(msg)
		self._isReqing = false

		local hasNew = false

		if IdleGameModel.instance:getMaxNuoLevel() < msg.new_member.level then
			hasNew = true

			UIStateManager.instance:open(ViewName.UnlockNewNuo, msg.new_member.level)
		end

		IdleGameModel.instance:handlePM_XiaoNuoComposeRes(target, msg)
		IdleGameController.instance:localNotify("ComposeNuo", {
			level = 0,
			position = target
		}, msg.new_member)
	end, nil, function()
		self._isReqing = false
	end)
end

function IdleGameController:sendReqRankData()
	XiaoNuoPlaceAgent.instance:sendPM_XiaoNuoRankReq(function(msg)
		IdleGameModel.instance:setRankData(msg)
		GlobalDispatcher:dispatch(GlobalNotify.RankDataGet)
	end)
end

IdleGameController.instance = IdleGameController.New()

return IdleGameController
