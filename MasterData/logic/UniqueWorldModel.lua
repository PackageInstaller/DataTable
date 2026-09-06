-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/uniqueworld/model/UniqueWorldModel.lua

module("logic.extensions.uniqueworld.model.UniqueWorldModel", package.seeall)

local UniqueWorldModel = class("UniqueWorldModel", BaseModel)

function UniqueWorldModel:onInit()
	self:onReset()
end

function UniqueWorldModel:onReset()
	self._infos = {}
	self._customFmtMoPool = {}
	self._gridFinishMap = {}
	self._shopMap = {}
	self._buffMap = {}
	self._petHpMap = {}
	self._itemMap = {}
	self._extGridInfoMap = {}
	self._changeSetIdList = {}
	self._curGameIsOver = false
end

function UniqueWorldModel:getInfo(activityId)
	return self._infos[activityId]
end

function UniqueWorldModel:getFmtMo(activityId)
	if self._customFmtMoPool[activityId] == nil then
		self._customFmtMoPool[activityId] = UniqueWorldFmtMo.New()
	end

	return self._customFmtMoPool[activityId]
end

function UniqueWorldModel:popChangeSetId(activityId)
	local changeSetIdList = self._changeSetIdList[activityId]

	if changeSetIdList then
		return table.remove(changeSetIdList)
	end
end

function UniqueWorldModel:setChangeSetId(activityId, changeSetId)
	self._changeSetIdList[activityId] = self._changeSetIdList[activityId] or {}

	local changeSetIdList = self._changeSetIdList[activityId]

	table.insert(changeSetIdList, changeSetId)
end

function UniqueWorldModel:getCurGameIsOver()
	return self._curGameIsOver
end

function UniqueWorldModel:setCurGameIsOver(isOver)
	self._curGameIsOver = isOver
end

function UniqueWorldModel:getFinishGridMap(activityId)
	return self._gridFinishMap[activityId]
end

function UniqueWorldModel:getShopList(activityId)
	return self._shopMap[activityId]
end

function UniqueWorldModel:getPetHpMap(activityId)
	return self._petHpMap[activityId]
end

function UniqueWorldModel:getItemMap(activityId)
	return self._itemMap[activityId]
end

function UniqueWorldModel:getExtGridInfoMap(activityId)
	return self._extGridInfoMap[activityId]
end

function UniqueWorldModel:getBuffMap(activityId)
	return self._buffMap[activityId]
end

function UniqueWorldModel:handlePM_UniqueWorldGetInfoRes(msg)
	self._infos[msg.activityId] = GameUtil.pbToTable(msg)

	local info = self._infos[msg.activityId]
	local mapInfo = info and info.mapInfo

	self._gridFinishMap[msg.activityId] = self._gridFinishMap[msg.activityId] or {}
	self._shopMap[msg.activityId] = self._shopMap[msg.activityId] or {}
	self._petHpMap[msg.activityId] = self._petHpMap[msg.activityId] or {}
	self._itemMap[msg.activityId] = self._itemMap[msg.activityId] or {}
	self._extGridInfoMap[msg.activityId] = self._extGridInfoMap[msg.activityId] or {}
	self._buffMap[msg.activityId] = self._buffMap[msg.activityId] or {}

	if mapInfo then
		if not mapInfo.normalGridIdList then
			local normalGridIdList = {}

			if not mapInfo.fightGridList then
				local fightGridList = {}

				if not mapInfo.npcGridList then
					local npcGridList = {}

					if not mapInfo.shopGridList then
						local shopGridList = {}

						if not mapInfo.petList then
							local petList = {}

							if not mapInfo.extGridInfo then
								local extGridInfoList = {}

								mapInfo.itemList = mapInfo.itemList or {}

								local itemList = mapInfo.itemList
								local finishMap = self._gridFinishMap[msg.activityId]
								local shopList = self._shopMap[msg.activityId]
								local petHpMap = self._petHpMap[msg.activityId]
								local itemMap = self._itemMap[msg.activityId]
								local extGridInfoMap = self._extGridInfoMap[msg.activityId]
								local buffMap = self._buffMap[msg.activityId]

								for _, grid in ipairs(normalGridIdList) do
									finishMap[grid.gridId] = grid.isFinish
								end

								for _, fightGridInfo in ipairs(fightGridList) do
									local creepsIdAndHpWanPercent = fightGridInfo.creepsIdAndHpWanPercent

									if creepsIdAndHpWanPercent then
										local finish = true

										for _, pair in ipairs(creepsIdAndHpWanPercent) do
											if pair.right > 0 then
												finish = false
											end
										end

										finishMap[fightGridInfo.gridId] = finish
									end
								end

								for _, npcGridInfo in ipairs(npcGridList) do
									finishMap[npcGridInfo.gridId] = npcGridInfo.optionId > 0
								end

								for _, shopInfo in ipairs(shopGridList) do
									if not shopInfo.buyItemIds then
										local buyItemIds = {}

										table.insertto(shopList, buyItemIds)
									end
								end

								for _, petInfo in ipairs(petList) do
									petHpMap[petInfo.creepsId] = petInfo.leftHpWanPercent
								end

								for _, itemInfo in ipairs(itemList) do
									itemMap[itemInfo.itemId] = itemInfo.count
								end

								for _, extGridInfo in ipairs(extGridInfoList) do
									extGridInfoMap[extGridInfo.gridId] = extGridInfo
								end

								if not TableUtil.isTableEmpty(mapInfo.buffList) then
									for _, buffInfo in ipairs(mapInfo.buffList) do
										buffMap[buffInfo.buffDefineId] = buffInfo
									end
								end
							end
						end
					end
				end
			end
		end
	end
end

function UniqueWorldModel:handlePM_UniqueWorldNewGameRes(msg)
	self._infos[msg.activityId] = GameUtil.pbToTable(msg)
end

function UniqueWorldModel:handlePM_UniqueWorldMapChangeRes(msg)
	local activityId = msg.activityId
	local info = self._infos[activityId]
	local mapInfo = info and info.mapInfo
	local extParam = msg.extParam
	local finishMap = self._gridFinishMap[activityId]

	if mapInfo then
		local msgMapInfo = msg and GameUtil.pbToTable(msg.changeMapInfo)

		mapInfo.gameInfo = msgMapInfo and msgMapInfo.gameInfo

		if extParam == UniqueWorldEnum.ExtParam.NextLevel then
			mapInfo.normalGridIdList = nil
			mapInfo.shopGridList = nil
			mapInfo.fightGridList = nil
			mapInfo.extGridInfo = nil
			mapInfo.npcGridList = nil
			self._gridFinishMap[activityId] = {}
			self._shopMap[activityId] = {}
			self._extGridInfoMap[activityId] = {}
		elseif extParam == UniqueWorldEnum.ExtParam.GameEnd then
			self._gridFinishMap[activityId] = {}
			self._shopMap[activityId] = {}
			self._petHpMap[activityId] = {}
			self._itemMap[activityId] = {}
			self._extGridInfoMap[activityId] = {}
			self._buffMap[activityId] = {}
			self._changeSetIdList[activityId] = {}
			self._customFmtMoPool[activityId] = UniqueWorldFmtMo.New()
		else
			if not TableUtil.isTableEmpty(msgMapInfo.normalGridIdList) then
				mapInfo.normalGridIdList = msgMapInfo.normalGridIdList

				for _, npcInfo in ipairs(msgMapInfo.normalGridIdList) do
					finishMap[npcInfo.gridId] = npcInfo.isFinish
				end
			end

			if not TableUtil.isTableEmpty(msgMapInfo.shopGridList) then
				mapInfo.shopGridList = msgMapInfo.shopGridList

				for _, shopInfo in ipairs(msgMapInfo.shopGridList) do
					if not shopInfo.buyItemIds then
						local buyItemIds = {}

						table.insertto(self._shopMap[activityId], buyItemIds)
					end
				end
			end

			if not TableUtil.isTableEmpty(msgMapInfo.fightGridList) then
				mapInfo.fightGridList = msgMapInfo.fightGridList

				for _, fightGridInfo in ipairs(msgMapInfo.fightGridList) do
					local creepsIdAndHpWanPercent = fightGridInfo.creepsIdAndHpWanPercent

					if creepsIdAndHpWanPercent then
						local finish = true

						for _, pair in ipairs(creepsIdAndHpWanPercent) do
							if pair.right > 0 then
								finish = false
							end
						end

						finishMap[fightGridInfo.gridId] = finish
					end
				end
			end

			if not TableUtil.isTableEmpty(msgMapInfo.petList) then
				mapInfo.petList = mapInfo.petList or {}

				local petList = mapInfo.petList
				local petHpMap = self._petHpMap[activityId]

				if petHpMap then
					for _, msgPetInfo in ipairs(msgMapInfo.petList) do
						if petHpMap[msgPetInfo.creepsId] == nil then
							table.insert(petList, msgPetInfo)
						end

						petHpMap[msgPetInfo.creepsId] = msgPetInfo.leftHpWanPercent
					end
				end
			end

			if not TableUtil.isTableEmpty(msgMapInfo.extGridInfo) then
				mapInfo.extGridInfo = msgMapInfo.extGridInfo
			end

			if not TableUtil.isTableEmpty(msgMapInfo.npcGridList) then
				mapInfo.npcGridList = msgMapInfo.npcGridList

				for _, npcInfo in ipairs(msgMapInfo.npcGridList) do
					finishMap[npcInfo.gridId] = npcInfo.optionId > 0
				end
			end

			if not TableUtil.isTableEmpty(msgMapInfo.itemList) then
				mapInfo.itemList = mapInfo.itemList or {}

				local itemMap = self._itemMap[msg.activityId]

				for _, msgItem in ipairs(msgMapInfo.itemList) do
					if itemMap[msgItem.itemId] == nil then
						table.insert(mapInfo.itemList, msgItem)
					end

					itemMap[msgItem.itemId] = msgItem.count
				end
			end

			if not TableUtil.isTableEmpty(msgMapInfo.buffList) then
				local buffMap = self._buffMap[msg.activityId]

				mapInfo.buffList = msgMapInfo.buffList

				for _, buffInfo in ipairs(msgMapInfo.buffList) do
					buffMap[buffInfo.buffDefineId] = buffInfo
				end
			end

			if not TableUtil.isTableEmpty(msgMapInfo.extGridInfo) then
				mapInfo.extGridInfo = msgMapInfo.extGridInfo

				local extGridInfoMap = self._extGridInfoMap[activityId]

				for _, extGridInfo in ipairs(msgMapInfo.extGridInfo) do
					extGridInfoMap[extGridInfo.gridId] = extGridInfo
				end
			end
		end
	end
end

function UniqueWorldModel:handlePM_UniqueWorldGiveUpRes()
	self:onReset()
end

function UniqueWorldModel:gridHasFinish(activityId, gridId)
	local finishMap = self._gridFinishMap[activityId]

	if finishMap then
		return checkbool(finishMap[gridId])
	end
end

function UniqueWorldModel:allHpIsEmpty(activityId)
	local petHpMap = self._petHpMap[activityId]

	if petHpMap then
		for _, hpWanPercent in pairs(petHpMap) do
			if checknumber(hpWanPercent) > 0 then
				return false
			end
		end
	end

	return true
end

UniqueWorldModel.instance = UniqueWorldModel.New()

return UniqueWorldModel
