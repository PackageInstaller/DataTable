-- chunkname: @modules/logic/player/model/IconTipModel.lua

module("modules.logic.player.model.IconTipModel", package.seeall)

local IconTipModel = class("IconTipModel", BaseModel)

function IconTipModel:onInit()
	self._iconslist = {}
end

function IconTipModel:setIconList(id)
	self._iconslist = {}

	local itemlist = ItemModel.instance:getItemList()
	local noShowDict = {}
	local allUnLockIconMo = {}
	local strToList = {}

	for _, v in pairs(itemlist) do
		local config = lua_item.configDict[v.id]

		if config and config.subType == ItemEnum.SubType.Portrait and not noShowDict[v.id] then
			local iconMo = {}

			iconMo.id = config.id
			iconMo.icon = config.icon
			iconMo.name = config.name
			iconMo.isused = config.id == id and 1 or 0
			iconMo.effect = config.effect

			local list = strToList[config.effect]

			if not list then
				list = {}

				for _, str in ipairs(string.split(config.effect, "#")) do
					table.insert(list, tonumber(str) or 0)
				end

				strToList[config.effect] = list
			end

			local switchCount = #list

			if switchCount > 0 then
				local find = false

				iconMo.effectPortraitDic = {}

				for i = switchCount, 1, -1 do
					local headId = list[i]

					iconMo.effectPortraitDic[headId] = true

					if find then
						noShowDict[headId] = true
					elseif headId == config.id then
						find = true
					end
				end
			end

			allUnLockIconMo[config.id] = iconMo
		end
	end

	for id, iconMo in pairs(allUnLockIconMo) do
		if not noShowDict[id] then
			table.insert(self._iconslist, iconMo)
		end
	end

	self:setIconsList()
end

function IconTipModel:setSelectIcon(id)
	self._selectIcon = id

	PlayerController.instance:dispatchEvent(PlayerEvent.SelectPortrait, id)
end

function IconTipModel:getSelectIcon()
	return self._selectIcon
end

function IconTipModel:setIconsList()
	IconListModel.instance:setIconList(self._iconslist)
end

IconTipModel.instance = IconTipModel.New()

return IconTipModel
