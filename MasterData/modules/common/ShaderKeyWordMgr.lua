-- chunkname: @modules/common/ShaderKeyWordMgr.lua

module("modules.common.ShaderKeyWordMgr", package.seeall)

local ShaderKeyWordMgr = class("ShaderKeyWordMgr")

ShaderKeyWordMgr.CLIPALPHA = "_CLIPALPHA_ON"

function ShaderKeyWordMgr.init()
	if not ShaderKeyWordMgr.enableKeyWordDict then
		ShaderKeyWordMgr.enableKeyWordDict = {}
		ShaderKeyWordMgr.disableList = {}
		ShaderKeyWordMgr.updateHandle = UpdateBeat:CreateListener(ShaderKeyWordMgr._onFrame)

		UpdateBeat:AddListener(ShaderKeyWordMgr.updateHandle)
	end
end

function ShaderKeyWordMgr._onFrame()
	local keyWordDict = ShaderKeyWordMgr.enableKeyWordDict
	local disableList = ShaderKeyWordMgr.disableList

	tabletool.clear(disableList)

	local currentTime = Time.time

	for keyWord, time in pairs(keyWordDict) do
		if time < currentTime then
			table.insert(disableList, keyWord)
		end
	end

	for _, keyWord in ipairs(disableList) do
		ShaderKeyWordMgr.disableKeyWord(keyWord)
	end
end

function ShaderKeyWordMgr.enableKeyWordAutoDisable(keyWord, delay)
	delay = delay or 0

	if delay < 0 then
		return
	end

	if not keyWord then
		return
	end

	ShaderKeyWordMgr.init()

	local keyWordDict = ShaderKeyWordMgr.enableKeyWordDict
	local disableTime = Time.time + delay

	if not keyWordDict[keyWord] then
		keyWordDict[keyWord] = disableTime

		UnityEngine.Shader.EnableKeyword(keyWord)
	elseif disableTime > keyWordDict[keyWord] then
		keyWordDict[keyWord] = disableTime
	end
end

function ShaderKeyWordMgr.enableKeyWorkNotDisable(keyWord)
	UnityEngine.Shader.EnableKeyword(keyWord)

	ShaderKeyWordMgr.enableKeyWordDict[keyWord] = nil
end

function ShaderKeyWordMgr.disableKeyWord(keyWord)
	if ShaderKeyWordMgr.enableKeyWordDict then
		ShaderKeyWordMgr.enableKeyWordDict[keyWord] = nil
	end

	UnityEngine.Shader.DisableKeyword(keyWord)
end

function ShaderKeyWordMgr.clear()
	ShaderKeyWordMgr.enableKeyWordDict = nil
	ShaderKeyWordMgr.disableList = nil

	if ShaderKeyWordMgr.updateHandle then
		UpdateBeat:RemoveListener(ShaderKeyWordMgr.updateHandle)
	end
end

return ShaderKeyWordMgr
