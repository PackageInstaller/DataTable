-- chunkname: @modules/logic/autochess/main/model/rpcmo/AutoChessSceneExtMo.lua

module("modules.logic.autochess.main.model.rpcmo.AutoChessSceneExtMo", package.seeall)

local AutoChessSceneExtMo = pureTable("AutoChessSceneExtMo")

local function isSameChessUids(oldUids, newUids)
	if not oldUids or not newUids then
		return false
	end

	if #oldUids ~= #newUids then
		return false
	end

	local uidSet = {}

	for _, uid in ipairs(oldUids) do
		uidSet[uid] = true
	end

	for _, uid in ipairs(newUids) do
		if not uidSet[uid] then
			return false
		end
	end

	return true
end

function AutoChessSceneExtMo:init(str)
	local isOk, result = pcall(cjson.decode, str)

	if not isOk then
		logError("json非法: AutoChessScene.extInfo")

		return
	end

	self.lastBuyChessUid = tonumber(result.lastBuyChessUid)
	self.damageExtraTargetChessUids = result.damageExtraTargetChessUids
end

function AutoChessSceneExtMo:update(str)
	local isOk, result = pcall(cjson.decode, str)

	if not isOk then
		logError("json非法: AutoChessScene.extInfo")

		return
	end

	local isUpdate = false
	local lastBuyChessUid = tonumber(result.lastBuyChessUid)

	if self.lastBuyChessUid ~= lastBuyChessUid then
		self.lastBuyChessUid = lastBuyChessUid
		isUpdate = true
	end

	local damageExtraTargetChessUids = result.damageExtraTargetChessUids

	if not isSameChessUids(self.damageExtraTargetChessUids, damageExtraTargetChessUids) then
		self.damageExtraTargetChessUids = damageExtraTargetChessUids
		isUpdate = true
	end

	if isUpdate then
		AutoChessController.instance:dispatchEvent(AutoChessEvent.UpdateExtInfo)
	end
end

return AutoChessSceneExtMo
