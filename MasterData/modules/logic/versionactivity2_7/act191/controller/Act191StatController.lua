-- chunkname: @modules/logic/versionactivity2_7/act191/controller/Act191StatController.lua

module("modules.logic.versionactivity2_7.act191.controller.Act191StatController", package.seeall)

local Act191StatController = class("Act191StatController", BaseController)

function Act191StatController:onInit()
	self:reInit()
end

function Act191StatController:reInit()
	self.viewOpenTimeMap = {}
	self.startTime = nil
end

function Act191StatController:setActInfo(info)
	self.actInfo = info
end

function Act191StatController:onViewOpen(viewName)
	if viewName == ViewName.Act191MainView then
		self.startTime = ServerTime.now()
	end

	self.viewOpenTimeMap[viewName] = self.viewOpenTimeMap[viewName] or ServerTime.now()
end

function Act191StatController:statViewClose(viewName, manual, param)
	if viewName == ViewName.Act191MainView then
		self:statGameTime(viewName)

		if manual then
			self.startTime = nil
		else
			self.startTime = ServerTime.now()
		end
	end

	if not self.viewOpenTimeMap[viewName] then
		return
	end

	param = param or ""

	local time = ServerTime.now() - self.viewOpenTimeMap[viewName]
	local baseInfo = {}
	local nodeInfo = {}

	if self.actInfo then
		local gameInfo = self.actInfo:getGameInfo()

		baseInfo = {
			coin = gameInfo.coin,
			stage = gameInfo.curStage,
			node = gameInfo.curNode,
			score = gameInfo.score,
			rank = gameInfo.rank
		}

		local detailMo = gameInfo:getNodeDetailMo(nil, true)

		if detailMo then
			nodeInfo = {
				shopId = detailMo.shopId,
				eventId = detailMo.eventId,
				type = detailMo.type
			}
		end
	end

	local actId = Activity191Controller.instance:getActId()
	local gameUid = Activity191Helper.getPlayerPrefs(actId, "Act191GameCostTime", 1)

	StatController.instance:track(StatEnum.EventName.Act191CloseView, {
		[StatEnum.EventProperties.Act191GameUid] = tostring(gameUid),
		[StatEnum.EventProperties.Act191BaseInfo] = baseInfo,
		[StatEnum.EventProperties.Act191NodeInfo] = nodeInfo,
		[StatEnum.EventProperties.ViewName] = viewName,
		[StatEnum.EventProperties.UseTime] = time,
		[StatEnum.EventProperties.CooperGarland_From] = manual and "Manual" or "Auto",
		[StatEnum.EventProperties.ProductName] = param
	})

	self.viewOpenTimeMap[viewName] = nil
end

function Act191StatController:statButtonClick(viewName, buttonName)
	local gameInfo = self.actInfo:getGameInfo()
	local baseInfo = {
		coin = gameInfo.coin,
		stage = gameInfo.curStage,
		node = gameInfo.curNode,
		score = gameInfo.score,
		rank = gameInfo.rank
	}
	local detailMo = gameInfo:getNodeDetailMo(nil, true)
	local actId = Activity191Controller.instance:getActId()
	local gameUid = Activity191Helper.getPlayerPrefs(actId, "Act191GameCostTime", 1)

	StatController.instance:track(StatEnum.EventName.ButtonClick, {
		[StatEnum.EventProperties.Act191GameUid] = tostring(gameUid),
		[StatEnum.EventProperties.Act191BaseInfo] = baseInfo,
		[StatEnum.EventProperties.Act191NodeInfo] = (detailMo or nil) and {
			shopId = detailMo.shopId,
			eventId = detailMo.eventId,
			type = detailMo.type
		},
		[StatEnum.EventProperties.ViewName] = viewName,
		[StatEnum.EventProperties.ButtonName] = buttonName
	})
end

function Act191StatController:statGameTime(viewName)
	local useTime

	if self.startTime then
		useTime = ServerTime.now() - self.startTime
	end

	if not FightDataHelper.fieldMgr.customData[FightCustomData.CustomDataType.Act191].createTime then
		do
			local creatTime = ServerTime.now()

			useTime = ServerTime.now() - creatTime
		end

		local baseInfo = {}
		local nodeInfo = {}

		if self.actInfo then
			local gameInfo = self.actInfo:getGameInfo()

			if gameInfo.state == Activity191Enum.GameState.Normal then
				baseInfo = {
					coin = gameInfo.coin,
					stage = gameInfo.curStage,
					node = gameInfo.curNode,
					score = gameInfo.score,
					rank = gameInfo.rank
				}

				local detailMo = gameInfo:getNodeDetailMo(nil, true)

				if detailMo then
					nodeInfo = {
						shopId = detailMo.shopId,
						eventId = detailMo.eventId,
						type = detailMo.type
					}
				end
			end
		end

		local actId = Activity191Controller.instance:getActId()
		local gameUid = Activity191Helper.getPlayerPrefs(actId, "Act191GameCostTime", 1)

		StatController.instance:track(StatEnum.EventName.Act191GameTime, {
			[StatEnum.EventProperties.Act191BaseInfo] = baseInfo,
			[StatEnum.EventProperties.Act191NodeInfo] = nodeInfo,
			[StatEnum.EventProperties.ViewName] = viewName,
			[StatEnum.EventProperties.UseTime] = useTime,
			[StatEnum.EventProperties.Act191GameUid] = tostring(gameUid)
		})
	end
end

Act191StatController.instance = Act191StatController.New()

return Act191StatController
