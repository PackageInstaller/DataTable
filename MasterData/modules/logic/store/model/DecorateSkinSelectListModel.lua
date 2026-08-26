-- chunkname: @modules/logic/store/model/DecorateSkinSelectListModel.lua

module("modules.logic.store.model.DecorateSkinSelectListModel", package.seeall)

local DecorateSkinSelectListModel = class("DecorateSkinSelectListModel", ListScrollModel)

function DecorateSkinSelectListModel:refreshList(itemId)
	local list = self:getSkinList(itemId)

	self:setList(list)
end

function DecorateSkinSelectListModel:getSkinList(itemId)
	local config = ItemConfig.instance:getItemCo(itemId)

	if config then
		if not config.effect then
			local effect = ""
			local param = GameUtil.splitString2(effect, true)
			local skinList = param[1]
			local list = {}

			for i, v in ipairs(skinList) do
				local data = {}

				data.id = v
				data.index = i
				data.isOwned = HeroModel.instance:checkHasSkin(v) and 1 or 0

				table.insert(list, data)
			end

			table.sort(list, SortUtil.tableKeyLower({
				"isOwned",
				"index"
			}))

			return list
		end
	end
end

DecorateSkinSelectListModel.instance = DecorateSkinSelectListModel.New()

return DecorateSkinSelectListModel
