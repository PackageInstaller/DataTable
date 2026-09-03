-- chunkname: @/tmp/or_script/lua_compile/dm/utils/VideoSprite.lua

module("VideoSprite", package.seeall)
require("dm.utils.CommonUtils")

local videoSpriteTable = {}
local frameEventTag = 1001
local eventMap = {}

local function chackAudioFilePath(audioPath)
	local curPath = audioPath
	local language = getCurrentLanguage()

	if language ~= GameDefaultLanguage then
		local dir = string.split(audioPath, ".usm")

		curPath = dir[1] .. "_" .. language .. ".usm"

		if not cc.FileUtils:getInstance():isFileExist(dir[1] .. "_" .. language .. ".usm") then
			curPath = audioPath
		end
	end

	return curPath
end

function create(audioPath, callback, player, isAsync)
	audioPath = chackAudioFilePath(audioPath)

	local videoSprite = player and cri.MovieSprite:createWithPlayer(player) or cri.MovieSprite:createWithDefaultPlayer()
	local traceback = string.split(debug.traceback("", 2), "\n")
	local key = "create from: " .. string.trim(traceback[3])

	table.insert(videoSpriteTable, {
		key,
		videoSprite
	})
	videoSprite:setListener(function(sprite, eventType, eventTag)
		if callback then
			local eventName

			callback(videoSprite, eventType == 1 and "complete" or eventMap[eventTag])
		end
	end)

	function videoSprite.addFrameEvent(sp, eventName, frameIndex)
		eventMap[frameEventTag] = eventName

		sp:getPlayer():registerFrameEvent(frameIndex, frameEventTag)

		frameEventTag = frameEventTag + 1
	end

	function videoSprite.removeFrameEvent(sp, eventName, frameIndex)
		local removeFrameEventTag = table.keyof(eventMap, eventName)

		if removeFrameEventTag then
			sp:getPlayer():unregisterFrameEvent(frameIndex, removeFrameEventTag)
		end
	end

	local oldSetContentSize = videoSprite.setContentSize

	function videoSprite.setContentSize(sp, size)
		sp:setQuadVertices({
			x = 0,
			y = 0,
			width = size.width,
			height = size.height
		})
		oldSetContentSize(sp, size)
	end

	videoSprite:setContentSize(cc.size(1386, 852))
	videoSprite:setAnchorPoint(0.5, 0.5)

	if not player then
		local player = videoSprite:getPlayer()

		player:setFile(audioPath)

		if isAsync or not player.startAndWaitPlaying then
			player:start()
		else
			player:startAndWaitPlaying()
		end
	end

	return videoSprite
end

function cleanVideoSprite()
	for k, v in pairs(videoSpriteTable) do
		local videoSprite = v[2]

		if not tolua.isnull(videoSprite) and videoSprite:getParent() then
			videoSprite:removeFromParent()
			CommonUtils.uploadDataToBugly("VideoSprite leak", v[1])
		end
	end

	videoSpriteTable = {}
end

function createSkillVideo(audioPath)
	local videoSprite = cri.MovieSprite:createWithDefaultPlayer()

	audioPath = chackAudioFilePath(audioPath)

	local traceback = string.split(debug.traceback("", 2), "\n")
	local key = "create from: " .. string.trim(traceback[3])

	table.insert(videoSpriteTable, {
		key,
		videoSprite
	})

	local oldSetContentSize = videoSprite.setContentSize

	function videoSprite.setContentSize(sp, size)
		sp:setQuadVertices({
			x = 0,
			y = 0,
			width = size.width,
			height = size.height
		})
		oldSetContentSize(sp, size)
	end

	function videoSprite.setCallback(sp, callback)
		sp:setListener(function(ins, eventType, eventTag)
			if callback then
				local eventName

				callback(videoSprite, eventType == 1 and "complete" or eventMap[eventTag])
			end
		end)
	end

	function videoSprite.setSpeed(sp, speed)
		sp:getPlayer():setSpeed(speed)
	end

	function videoSprite.start(sp)
		sp:getPlayer():start()
	end

	function videoSprite.pause(sp, pause)
		sp:getPlayer():pause(pause)
	end

	function videoSprite.isPaused(sp)
		return sp:getPlayer():isPaused()
	end

	local player = videoSprite:getPlayer()

	player:setFile(audioPath)
	player:start()

	return videoSprite
end
