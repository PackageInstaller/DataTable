-- chunkname: @modules/logic/store/model/SkinSelfSelectListModel.lua

module("modules.logic.store.model.SkinSelfSelectListModel", package.seeall)

local SkinSelfSelectListModel = class("SkinSelfSelectListModel", SkinDiscountCompensateListModel)

function SkinSelfSelectListModel:initList(itemId)
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

			local skinCount = #skinList
			local moList = {}
			local haveSkinCount = 0

			for _, id in ipairs(skinList) do
				local skinConfig = SkinConfig.instance:getSkinCo(id)

				if not skinConfig then
					logError("皮肤折扣,不存在的皮肤id: " .. tostring(id))
				else
					local mo = {}

					mo.type = SkinDiscountCompensateEnum.ItemType.Skin
					mo.id = id
					mo.itemId = itemId

					local isOwned = HeroModel.instance:checkHasSkin(id)

					mo.isOwned = isOwned and 1 or 0
					mo.skinLevel = -skinConfig.skinLevel

					table.insert(moList, mo)

					if isOwned then
						haveSkinCount = haveSkinCount + 1
					end
				end
			end

			table.sort(moList, SortUtil.tableKeyLower({
				"isOwned",
				"skinLevel",
				"id"
			}))

			local haveAll = skinCount == haveSkinCount

			if haveAll then
				local exchangeMo = {}

				exchangeMo.type = SkinDiscountCompensateEnum.ItemType.ExchangeItem
				exchangeMo.itemParam = param[2]
				exchangeMo.id = 0

				table.insert(moList, 1, exchangeMo)
			end

			for index, mo in ipairs(moList) do
				mo.index = index
			end

			self.isHaveAll = haveAll

			self:setList(moList)
		end
	end
end

function SkinSelfSelectListModel:haveAll()
	return self.isHaveAll
end

SkinSelfSelectListModel.instance = SkinSelfSelectListModel.New()

return SkinSelfSelectListModel
