-- chunkname: @modules/logic/versionactivity3_3/arcade/rpc/ArcadeInSideRpc.lua

module("modules.logic.versionactivity3_3.arcade.rpc.ArcadeInSideRpc", package.seeall)

local ArcadeInSideRpc = class("ArcadeInSideRpc", BaseRpc)

function ArcadeInSideRpc:sendArcadeGetInSideInfoRequest(callback, callbackObj)
	local req = ArcadeInSideModule_pb.ArcadeGetInSideInfoRequest()

	self:sendMsg(req, callback, callbackObj)
end

function ArcadeInSideRpc:onReceiveArcadeGetInSideInfoReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end
end

function ArcadeInSideRpc:_fillPlayerData(arcadePlayer, info)
	if not info then
		return
	end

	arcadePlayer.id = info.id
	arcadePlayer.attackAttrId = info.attackAttrId or 0

	if info.skillCounterBox then
		for _, boxData in ipairs(info.skillCounterBox) do
			local skillId = boxData.skillId
			local counters = boxData.counters

			if skillId and counters then
				local box = ArcadeDef_pb.ArcadeSkillCounterBox()

				box.skillId = skillId

				for _, counterData in ipairs(counters) do
					local counter = ArcadeDef_pb.ArcadeSkillCounter()

					counter.key = counterData.key
					counter.count = counterData.count

					table.insert(box.counters, counter)
				end

				table.insert(arcadePlayer.skillCounterBox, box)
			end
		end
	end
end

function ArcadeInSideRpc:_fillAttrData(attrContainer, info)
	if not info then
		return
	end

	for _, value in ipairs(info.attrValues) do
		local attrValue = ArcadeDef_pb.ArcadeAttrValue()

		attrValue.id = value.id
		attrValue.base = value.base

		if value.rate then
			attrValue.rate = value.rate
		end

		if value.extra then
			attrValue.extra = value.extra
		end

		table.insert(attrContainer.attrValues, attrValue)
	end
end

function ArcadeInSideRpc:_fillCollectionData(collectibleSlots, info)
	if not info then
		return
	end

	for _, data in ipairs(info) do
		local slot = ArcadeDef_pb.ArcadeCollectibleSlot()

		slot.type = data.type

		local collectData = data.collectible

		slot.collectible.id = collectData.id
		slot.collectible.durability = collectData.durability
		slot.collectible.useTimes = collectData.useTimes

		if collectData.counterBox then
			for _, boxData in ipairs(collectData.counterBox) do
				local skillId = boxData.skillId
				local counters = boxData.counters

				if skillId and counters then
					local box = ArcadeDef_pb.ArcadeSkillCounterBox()

					box.skillId = skillId

					for _, counterData in ipairs(counters) do
						local counter = ArcadeDef_pb.ArcadeSkillCounter()

						counter.key = counterData.key
						counter.count = counterData.count

						table.insert(box.counters, counter)
					end

					table.insert(slot.collectible.counterBox, box)
				end
			end
		end

		table.insert(collectibleSlots, slot)
	end
end

function ArcadeInSideRpc:_fillPropData(prop, info)
	if not info then
		return
	end

	if info.hotfix and next(info.hotfix) then
		for _, strHotfix in ipairs(info.hotfix) do
			table.insert(prop.hotfix, strHotfix)
		end
	end

	prop.areaId = info.areaId or 0
	prop.roomId = info.roomId or 0
	prop.progress = info.progress or 0
	prop.difficulty = info.difficulty or 0
	prop.maxKillMonsterNum = info.maxKillMonsterNum or 0
	prop.totalGainGoldNum = info.totalGainGoldNum or 0
	prop.highestScore = info.highestScore or 0
	prop.clearedRoomNum = info.clearedRoomNum or 0
end

function ArcadeInSideRpc:_fillExtendData(extendInfo, info)
	if not info then
		return
	end

	for _, book in ipairs(info.addedBook.books) do
		local bookType = book.type
		local list = book.eleId
		local arcadeBook = ArcadeDef_pb.ArcadeBook()

		arcadeBook.type = bookType

		for _, id in ipairs(list) do
			table.insert(arcadeBook.eleId, id)
		end

		table.insert(extendInfo.addedBook.books, arcadeBook)
	end

	extendInfo.settleScore = info.settleScore

	for _, characterId in ipairs(info.unlockRoleIds) do
		table.insert(extendInfo.unlockRoleIds, characterId)
	end

	for _, difficulty in ipairs(info.unlockDifficultyIds) do
		table.insert(extendInfo.unlockDifficultyIds, difficulty)
	end
end

function ArcadeInSideRpc:_fillPassiveSkillData(skillIds, info)
	if not info then
		return
	end

	for _, skillId in ipairs(info) do
		table.insert(skillIds, skillId)
	end
end

function ArcadeInSideRpc:sendArcadeSaveGameRequest(info, callback, callbackObj)
	local req = ArcadeInSideModule_pb.ArcadeSaveGameRequest()

	self:_fillPlayerData(req.info.player, info.player)
	self:_fillAttrData(req.info.attrContainer, info.attrContainer)
	self:_fillCollectionData(req.info.collectibleSlots, info.collectibleSlots)
	self:_fillPropData(req.info.prop, info.prop)
	self:_fillExtendData(req.info.extendInfo, info.extendInfo)
	self:_fillPassiveSkillData(req.info.passiveSkillIds, info.passiveSkillIds)
	self:sendMsg(req, callback, callbackObj)
end

function ArcadeInSideRpc:onReceiveArcadeSaveGameReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end
end

function ArcadeInSideRpc:sendArcadeSettleGameRequest(type, info, callback, callbackObj)
	local req = ArcadeInSideModule_pb.ArcadeSettleGameRequest()

	req.type = type

	self:_fillAttrData(req.info.attrContainer, info.attrContainer)
	self:_fillPropData(req.info.prop, info.prop)
	self:_fillExtendData(req.info.extendInfo, info.extendInfo)
	self:sendMsg(req, callback, callbackObj)
end

function ArcadeInSideRpc:onReceiveArcadeSettleGameReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end
end

ArcadeInSideRpc.instance = ArcadeInSideRpc.New()

return ArcadeInSideRpc
