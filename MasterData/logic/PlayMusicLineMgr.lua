-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playmusic/view/PlayMusicLineMgr.lua

module("logic.extensions.playmusic.view.PlayMusicLineMgr", package.seeall)

local PlayMusicLineMgr = class("PlayMusicLineMgr")

function PlayMusicLineMgr:ctor()
	return
end

function PlayMusicLineMgr:reset(gamePlanId)
	self._gamePlanId = checknumber(gamePlanId)

	if self._gamePlanId == 0 then
		printError("错误,缺失传入参数gamePlanId")

		return
	end

	self._lineCfg = PlayMusicConfig.instance:getPmLineCfgById(self._gamePlanId)

	if self._lineCfg == nil then
		printError(string.format("错误,无法找到配置( gamePlanId=%s )", self._gamePlanId))

		return
	end

	local posListGroup = self:_getPosListGroup()

	if #posListGroup ~= #self._lineCfg then
		printError(string.format("错误,线谱位置与配置表定义不符合,请检查( gamePlanId=%s )", self._gamePlanId))

		return
	end

	self._posInfoListGroup = {}

	for lineId, posList in ipairs(posListGroup) do
		local posInfoList = {}

		self._posInfoListGroup[lineId] = posInfoList

		for posIdx, pos in ipairs(posList) do
			local info = {}

			table.insert(posInfoList, info)

			info.lineId = lineId
			info.posIdx = posIdx
			info.pos = pos
		end
	end

	self._recordNodeListGroup = {}

	for lineId, posInfoList in ipairs(self._posInfoListGroup) do
		self._recordNodeListGroup[lineId] = {}

		for posIdx, posInfo in ipairs(posInfoList) do
			self._recordNodeListGroup[lineId][posIdx] = false
		end
	end

	self._recordNodePool = {}
end

function PlayMusicLineMgr:clear()
	self._gamePlanId = 0
	self._lineCfg = nil
	self._posInfoListGroup = nil
	self._recordNodeListGroup = nil
end

function PlayMusicLineMgr:destroy()
	return
end

function PlayMusicLineMgr:_getPosListGroup()
	return {
		{
			{
				221,
				-16
			},
			{
				356,
				113
			},
			{
				356,
				-16
			},
			{
				221,
				113
			}
		},
		{
			{
				487,
				125
			},
			{
				470,
				0
			},
			{
				109,
				-5
			},
			{
				91,
				116
			}
		},
		{
			{
				410,
				-45
			},
			{
				154,
				-45
			},
			{
				288,
				-112
			},
			{
				91,
				116
			}
		},
		{
			{
				288,
				231
			},
			{
				410,
				188
			},
			{
				165,
				188
			},
			{
				288,
				34
			}
		}
	}
end

function PlayMusicLineMgr:calcNewNodeInfo()
	local lineId = 0
	local symbolId = 0
	local tempLineIdList = {}

	for lineId, lineData in ipairs(self._lineCfg) do
		table.insert(tempLineIdList, lineId)
	end

	local radomLineIdList = {}
	local radomSymbolIdList = {}

	for i = 1, #tempLineIdList do
		lineId = 0

		table.clear(radomLineIdList)

		for _, lineId in ipairs(tempLineIdList) do
			for i = 1, self._lineCfg[lineId].lineProbability do
				table.insert(radomLineIdList, lineId)
			end
		end

		if #radomLineIdList > 0 then
			lineId = radomLineIdList[Mathf.Random(1, #radomLineIdList)]
		end

		if lineId == 0 then
			break
		end

		symbolId = 0

		table.clear(radomSymbolIdList)

		if self._lineCfg[lineId] and not string.nilorempty(self._lineCfg[lineId].symbolProbability) then
			local symbolStrArray = string.split(self._lineCfg[lineId].symbolProbability, "#")

			for _, symbolStr in ipairs(symbolStrArray) do
				local fieldArray = string.split(symbolStr, ":")

				for i = 1, checknumber(fieldArray[2]) do
					table.insert(radomSymbolIdList, checknumber(fieldArray[1]))
				end
			end

			if #radomSymbolIdList > 0 then
				symbolId = radomSymbolIdList[Mathf.Random(1, #radomSymbolIdList)]
			end
		end

		if symbolId == 0 then
			table.removebyvalue(tempLineIdList, lineId)
		end
	end

	return lineId, symbolId
end

function PlayMusicLineMgr:createNode(entityId, lineId)
	local posInfoList = self._posInfoListGroup[lineId]
	local fitPosInfoList = {}

	for _, posInfo in ipairs(posInfoList) do
		if self:_isFitPos(posInfo) then
			table.insert(fitPosInfoList, posInfo)
		end
	end

	local minPosIdx, maxPosIdx = 1, #fitPosInfoList
	local posX, posY

	if minPosIdx <= maxPosIdx then
		local radomPosIdx = Mathf.Random(minPosIdx, maxPosIdx)
		local info = fitPosInfoList[radomPosIdx]

		posY = info.pos[2]
		posX = info.pos[1]

		self:_createNodeRecord(entityId, info)
	end

	return posX, posY
end

function PlayMusicLineMgr:removeNode(entityId)
	self:_removeNodeRecord(entityId)
end

function PlayMusicLineMgr:_createNodeRecord(entityId, posInfo)
	self._recordNodePool[entityId] = posInfo
	self._recordNodeListGroup[posInfo.lineId][posInfo.posIdx] = true
end

function PlayMusicLineMgr:_removeNodeRecord(entityId)
	local posInfo = self._recordNodePool[entityId]

	if posInfo then
		self._recordNodePool[entityId] = nil
		self._recordNodeListGroup[posInfo.lineId][posInfo.posIdx] = false
	end
end

function PlayMusicLineMgr:_isFitPos(posInfo)
	return self._recordNodeListGroup[posInfo.lineId][posInfo.posIdx] == false
end

return PlayMusicLineMgr
