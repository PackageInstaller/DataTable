-- chunkname: @modules/logic/store/model/SkinDiscountCompensateListModel.lua

module("modules.logic.store.model.SkinDiscountCompensateListModel", package.seeall)

local SkinDiscountCompensateListModel = class("SkinDiscountCompensateListModel", ListScrollModel)

function SkinDiscountCompensateListModel:initList(itemId)
	self.referenceTime = UnityEngine.Time.timeSinceLevelLoad

	local config = ItemConfig.instance:getItemCo(itemId)

	if config then
		if not config.effect then
			local effect = ""
			local param = GameUtil.splitString2(effect, true)

			if not param then
				logError("皮肤折扣,当前道具不存在皮肤配置 id: " .. tostring(itemId))

				return
			end

			local skinList = param[1]

			if not skinList or next(skinList) == nil then
				logError("皮肤折扣,当前道具不存在皮肤配置 id: " .. tostring(itemId))

				return
			end

			local moList = {}

			for _, id in ipairs(skinList) do
				local skinConfig = SkinConfig.instance:getSkinCo(id)

				if not skinConfig then
					logError("皮肤折扣,不存在的皮肤id: " .. tostring(id))
				elseif string.nilorempty(skinConfig.compensate) then
					logError("皮肤折扣,不存在返利配置 id: " .. tostring(id))
				else
					local mo = {}

					mo.id = id
					mo.itemId = itemId
					mo.isOwned = HeroModel.instance:checkHasSkin(id) and 1 or 0
					mo.skinLevel = -skinConfig.skinLevel

					table.insert(moList, mo)
				end
			end

			table.sort(moList, SortUtil.tableKeyLower({
				"isOwned",
				"skinLevel",
				"id"
			}))

			for index, mo in ipairs(moList) do
				mo.index = index
			end

			self:setList(moList)
		end
	end
end

function SkinDiscountCompensateListModel:getReferenceTime()
	return self.referenceTime
end

function SkinDiscountCompensateListModel:getNextSkinIndex(mo)
	local nowIndex = self:getIndex(mo) or 1
	local list = self:getList()
	local firstNotOwnedIndex

	for i, v in ipairs(list) do
		local isOwned = v.isOwned == 1

		if not isOwned then
			if firstNotOwnedIndex == nil then
				firstNotOwnedIndex = i
			end

			if nowIndex < i then
				return i
			end
		end
	end

	return firstNotOwnedIndex
end

function SkinDiscountCompensateListModel:getSkinIndex(skinId)
	local list = self:getList()

	for i, v in ipairs(list) do
		if skinId == v.id then
			return i
		end
	end
end

SkinDiscountCompensateListModel.instance = SkinDiscountCompensateListModel.New()

return SkinDiscountCompensateListModel
