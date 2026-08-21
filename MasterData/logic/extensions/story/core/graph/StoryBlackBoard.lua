-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/core/graph/StoryBlackBoard.lua

module("logic.extensions.story.core.graph.StoryBlackBoard", package.seeall)

local M = class("StoryBlackBoard")

M.s_storyGraphAssetKey = "_storyGraphAsset"

function M:ctor(graphAsset)
	self._tb_datas = {}

	self:AddData(M.s_storyGraphAssetKey, graphAsset)
end

function M:GraphAsset()
	return self._tb_datas[M.s_storyGraphAssetKey]
end

function M:AddData(key, obj)
	if self._tb_datas[key] then
		printError("黑板中已存在该数据:key=", key)

		return
	end

	self._tb_datas[key] = obj
end

function M:RemoveData(key)
	if self._tb_datas[key] then
		local val = self._tb_datas[key]

		self._tb_datas[key] = nil

		return val
	end

	return nil
end

function M:CheckExist(key)
	return self._tb_datas[key] ~= nil
end

function M:Reset()
	self._tb_datas = {}
end

return M
