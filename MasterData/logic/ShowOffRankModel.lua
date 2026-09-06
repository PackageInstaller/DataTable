-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/showoff/model/ShowOffRankModel.lua

module("logic.extensions.showoff.model.ShowOffRankModel", package.seeall)

local ShowOffRankModel = class("ShowOffRankModel", BaseModel)

function ShowOffRankModel:onInit()
	self:onReset()
end

function ShowOffRankModel:onReset()
	self._msgPool = {}
end

function ShowOffRankModel:onGetRankInfo(msg)
	local tb = GameUtil.pbToTable(msg)
	local rankId = tb.rankId
	local member = checknumber(tb.member)

	self._msgPool[rankId] = self._msgPool[rankId] or {}
	self._msgPool[rankId][member] = tb
end

function ShowOffRankModel:getRankInfo(rankId, member)
	if self._msgPool[rankId] then
		return self._msgPool[rankId][member]
	end
end

ShowOffRankModel.instance = ShowOffRankModel.New()

return ShowOffRankModel
