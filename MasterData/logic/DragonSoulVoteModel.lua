-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonsoulvote/model/DragonSoulVoteModel.lua

module("logic.extensions.dragonsoulvote.model.DragonSoulVoteModel", package.seeall)

local DragonSoulVoteModel = class("DragonSoulVoteModel", BaseModel)

function DragonSoulVoteModel:onInit()
	self:onReset()
end

function DragonSoulVoteModel:onReset()
	self._msgPool = {}
end

function DragonSoulVoteModel:getInfo(activityId)
	return self._msgPool[activityId]
end

function DragonSoulVoteModel:onGetInfo(msg)
	local activityId = msg.activityId

	self._msgPool[activityId] = GameUtil.pbToTable(msg)
end

function DragonSoulVoteModel:onGetPrize(msg)
	local activityId = msg.activityId
	local prizeId = msg.prizeId
	local info = self:getInfo(activityId)

	if info then
		info.gainPrizeIds = info.gainPrizeIds or {}

		table.insert(info.gainPrizeIds, prizeId)
	end
end

function DragonSoulVoteModel:onMakeRole(msg)
	return
end

function DragonSoulVoteModel:onVote(msg, left, right, count)
	local activityId = msg.activityId
	local info = self:getInfo(activityId)

	if info then
		info.voteInfos = info.voteInfos or {}

		local has = false

		for i, v in ipairs(info.voteInfos) do
			if v.item.left == left and v.item.right == right then
				v.voteCount = checknumber(v.voteCount) + count
				has = true

				break
			end
		end

		if not has then
			local obj = {}

			obj.item = {}
			obj.item.left = left
			obj.item.right = right
			obj.voteCount = count

			table.insert(info.voteInfos, obj)
		end
	end
end

DragonSoulVoteModel.instance = DragonSoulVoteModel.New()

return DragonSoulVoteModel
