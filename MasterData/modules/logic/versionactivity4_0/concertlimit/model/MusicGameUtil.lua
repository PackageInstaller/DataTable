-- chunkname: @modules/logic/versionactivity4_0/concertlimit/model/MusicGameUtil.lua

module("modules.logic.versionactivity4_0.concertlimit.model.MusicGameUtil", package.seeall)

local MusicGameUtil = class("MusicGameUtil")

function MusicGameUtil.getRandomIndex(randomList)
	local total = 0

	for _, v in ipairs(randomList) do
		total = total + v
	end

	if total <= 0 then
		return 0
	end

	local randValue = math.random(1, total)
	local sum = 0

	for i, v in ipairs(randomList) do
		sum = sum + v

		if randValue <= sum then
			return i
		end
	end

	return 0
end

function MusicGameUtil.getRandomSplitGroups(count, n)
	if not n then
		return {}
	end

	local base = math.floor(count / n)
	local extra = count % n
	local result = {}

	for i = 1, n do
		result[i] = base
	end

	for i = 1, extra do
		local index = math.random(n)

		result[index] = result[index] + 1
	end

	return result
end

function MusicGameUtil.getBlockConnectDir(startPosX, startPosY, endPosX, endPosY)
	if startPosY < endPosY then
		return MusicGameEnum.Direction.Down
	elseif endPosY < startPosY then
		return MusicGameEnum.Direction.Up
	elseif endPosX < startPosX then
		return MusicGameEnum.Direction.Left
	elseif startPosX < endPosX then
		return MusicGameEnum.Direction.Right
	end

	return MusicGameEnum.Direction.Up
end

return MusicGameUtil
