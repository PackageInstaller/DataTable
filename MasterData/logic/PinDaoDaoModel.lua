-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pindaodao/model/PinDaoDaoModel.lua

module("logic.extensions.pindaodao.model.PinDaoDaoModel", package.seeall)

local PinDaoDaoModel = class("PinDaoDaoModel", BaseModel)

function PinDaoDaoModel:onInit()
	self:onReset()
end

function PinDaoDaoModel:onReset()
	self._infoMap = {}
end

function PinDaoDaoModel:getInfoByActId(activityId)
	local info = self._infoMap[activityId]

	if not info then
		printInfo("拼刀刀数据不存在，activityId=%d", activityId)
	end

	return info
end

function PinDaoDaoModel:handlePM_PinDaoDaoInfoRes(msg)
	local newInfo = GameUtil.pbToTable(msg)
	local activityId = newInfo.activityId

	self._infoMap[activityId] = newInfo
end

function PinDaoDaoModel:handlePM_PinDaoDaoHelpReduceRes(msg)
	return
end

function PinDaoDaoModel:handlePM_PinDaoDaoBuyGoodsRes(msg)
	local activityId = msg.activityId
	local info = self._infoMap[activityId]

	if info then
		info.buyGoodsIds = info.buyGoodsIds or {}

		table.insert(info.buyGoodsIds, msg.goodsId)
	end
end

function PinDaoDaoModel:handlePM_PinDaoDaoPlayerInfoRes(msg)
	return
end

function PinDaoDaoModel:handleNotifyPinDaoDaoReduceInfoChange(msg)
	local newInfo = GameUtil.pbToTable(msg)
	local activityId = msg.activityId
	local info = self._infoMap[activityId]

	if info then
		if not info.reduceItemList then
			table.insert(info.reduceItemList, newInfo.reduceItem)

			info.reduceItemList = info.reduceItemList
		end
	end
end

PinDaoDaoModel.instance = PinDaoDaoModel.New()

return PinDaoDaoModel
