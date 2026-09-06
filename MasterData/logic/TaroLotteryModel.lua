-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tarolottery/model/TaroLotteryModel.lua

module("logic.extensions.tarolottery.model.TaroLotteryModel", package.seeall)

local TaroLotteryModel = class("TaroLotteryModel", BaseModel)

function TaroLotteryModel:onInit()
	self:onReset()
end

function TaroLotteryModel:onReset()
	self._msg_map = {}
end

function TaroLotteryModel:onGetInfo(msg)
	local activityId = msg.activityId

	self._msg_map[activityId] = GameUtil.pbToTable(msg)
end

function TaroLotteryModel:onGetPrize(msg)
	local activityId = msg.activityId
	local info = self._msg_map[activityId]

	if info then
		info.progressPrizeIds = info.progressPrizeIds or {}

		table.insert(info.progressPrizeIds, msg.prizeId)
	end
end

function TaroLotteryModel:getInfo(activityId)
	return self._msg_map[activityId]
end

function TaroLotteryModel:onGetDraw(msg)
	local activityId = msg.activityId
	local pb = GameUtil.pbToTable(msg)
	local info = self._msg_map[activityId]

	if info then
		info.drawTimes = time

		if not info.tarotTimes then
			if not pb.tarotIds then
				local tarotIds = {}

				for i, id in ipairs(tarotIds) do
					local found = false

					for j, v in ipairs(info.tarotTimes) do
						if v.left == id then
							v.right = v.right + 1
							found = true

							break
						end
					end

					if not found then
						local obj = {}

						obj.left = id
						obj.right = 1

						table.insert(info.tarotTimes, obj)
					end
				end

				info.tarotTimes = info.tarotTimes
				self._msg_map[activityId] = info
			end
		end
	end
end

TaroLotteryModel.instance = TaroLotteryModel.New()

return TaroLotteryModel
