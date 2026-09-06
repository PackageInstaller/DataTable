-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcardpreheat2023/model/YearCardPreheat2023Model.lua

module("logic.extensions.yearcardpreheat2023.model.YearCardPreheat2023Model", package.seeall)

local YearCardPreheat2023Model = class("YearCardPreheat2023Model", BaseModel)

function YearCardPreheat2023Model:onInit()
	self:onReset()
end

function YearCardPreheat2023Model:onReset()
	self._actId = 0
	self._curDesignId = 0
	self._posX = 0
	self._posY = 0
	self._curGridInfos = {}
	self._usesGameTimes = 0
	self._gainPersonPrizeIds = {}
	self._worldProgress = 0
	self._gainWorldPrizeIds = {}
	self._CSId = 0
	self._customFmtMo = nil
end

function YearCardPreheat2023Model:onGetInfo(msg)
	self._actId = checkint(msg.actId)
	self._curDesignId = checkint(msg.designId)
	self._posX = msg.posX
	self._posY = msg.posY
	self._usesGameTimes = msg.dailyGameTimes
	self._worldProgress = msg.worldProgress
	self._gainPersonPrizeIds = {}

	for _, v in ipairs(msg.gainPersonPrizeIds) do
		table.insert(self._gainPersonPrizeIds, v)
	end

	for _, v in ipairs(msg.gainWorldPrizeIds) do
		table.insert(self._gainWorldPrizeIds, v)
	end

	self._curGridInfos = {}

	for _, v in ipairs(msg.grids) do
		self:refreshGridData(v)
	end
end

function YearCardPreheat2023Model:onMove(msg)
	if msg:HasField("eventResult") then
		local eventResult = msg.eventResult

		if eventResult then
			self._posX = eventResult.x
			self._posY = eventResult.y

			for _, v in ipairs(eventResult.gird) do
				self:refreshGridData(v)
			end

			if eventResult.changeSetId then
				self._CSId = eventResult.changeSetId

				MaterialController.instance:saveChangeSetToTemp(eventResult.changeSetId)
			end
		end
	end

	if msg:HasField("moveResult") then
		local moveResult = msg.moveResult

		if moveResult then
			self._posX = moveResult.x
			self._posY = moveResult.y

			self:refreshGridData(moveResult.grid)
		end
	end
end

function YearCardPreheat2023Model:onCollateClue(msg)
	self._curDesignId = checkint(msg.designId)
	self._posX = msg.posX
	self._posY = msg.posY
	self._usesGameTimes = msg.dailyGameTimes
	self._curGridInfos = {}

	for _, v in ipairs(msg.grids) do
		self:refreshGridData(v)
	end
end

function YearCardPreheat2023Model:onGainPersonPrize(msg)
	self._gainPersonPrizeIds = self._gainPersonPrizeIds or {}

	table.insert(self._gainPersonPrizeIds, checkint(msg.id))
end

function YearCardPreheat2023Model:onGainProgressPrize(msg)
	self._gainWorldPrizeIds = self._gainWorldPrizeIds or {}

	table.insert(self._gainWorldPrizeIds, checkint(msg.id))
end

function YearCardPreheat2023Model:onEventFinish(msg)
	local result = msg.result

	if result then
		self._posX = result.x
		self._posY = result.y

		for _, v in ipairs(result.gird) do
			self:refreshGridData(v)
		end

		if result.changeSetId then
			self._CSId = result.changeSetId

			MaterialController.instance:saveChangeSetToTemp(result.changeSetId)
		end
	end
end

function YearCardPreheat2023Model:getActId()
	return self._actId
end

function YearCardPreheat2023Model:getPos()
	return self._posX, self._posY
end

function YearCardPreheat2023Model:getCurMapInfos()
	return self._curGridInfos
end

function YearCardPreheat2023Model:refreshGridData(info)
	if info then
		local gridInfo = self:getGridInfo(info.x, info.y)

		gridInfo = gridInfo or {}
		gridInfo.clueId = info.clueId
		gridInfo.gainClue = info.gainClue
		self._curGridInfos[info.x] = self._curGridInfos[info.x] or {}
		self._curGridInfos[info.x][info.y] = gridInfo
	end
end

function YearCardPreheat2023Model:getGridInfo(posX, posY)
	return self._curGridInfos[posX] and self._curGridInfos[posX][posY]
end

function YearCardPreheat2023Model:getCurDesignId()
	return self._curDesignId
end

function YearCardPreheat2023Model:getUsesGameTimes()
	return self._usesGameTimes
end

function YearCardPreheat2023Model:getCurProgress()
	return checkint(self._worldProgress)
end

function YearCardPreheat2023Model:getIsHasGainPersonPrizeId(id)
	return self._gainPersonPrizeIds and table.keyof(self._gainPersonPrizeIds, id)
end

function YearCardPreheat2023Model:getIsHasGainWorldPrizeId(id)
	return self._gainWorldPrizeIds and table.keyof(self._gainWorldPrizeIds, id)
end

function YearCardPreheat2023Model:ShowCI()
	MaterialController.instance:showChangeSetInTemp(self._CSId)

	self._CSId = 0
end

function YearCardPreheat2023Model:isFirstShowRuleView()
	local userDataKey = ViewName.YearCardPreheat2023GameRuleView .. self._actId

	return checkint(GameUtil.getUserData(userDataKey)) < 1
end

function YearCardPreheat2023Model:saveFirstShowRuleData()
	local userDataKey = ViewName.YearCardPreheat2023GameRuleView .. checkint(self._actId)

	GameUtil.saveUserData(userDataKey, 1)
end

function YearCardPreheat2023Model:isAbleCollate()
	return true
end

function YearCardPreheat2023Model:getCustomFmtMo()
	if self._customFmtMo == nil then
		self._customFmtMo = YearCardPreheat023FmtMo.New()
	end

	return self._customFmtMo
end

YearCardPreheat2023Model.instance = YearCardPreheat2023Model.New()

return YearCardPreheat2023Model
