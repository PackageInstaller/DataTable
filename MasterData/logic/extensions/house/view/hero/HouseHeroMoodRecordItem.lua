-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/house/view/hero/HouseHeroMoodRecordItem.lua

module("logic.extensions.house.view.hero.HouseHeroMoodRecordItem", package.seeall)

local M = class("HouseHeroMoodRecordItem")
local kDescCount = 4

function M:ctor(compContainer)
	self._mainGO = compContainer.gameObject

	self:_buildUI()
end

function M:OnDestroy()
	self:unbindEvents()
end

function M:_buildUI()
	self._txtTime = goutil.findChildTextComponent(self._mainGO, "txtTime")
	self._arrayDesc = {}

	for i = 1, kDescCount do
		local descRoot = goutil.findChild(self._mainGO, string.format("desc_item_group/desc_%s", i))

		table.insert(self._arrayDesc, descRoot)
	end

	self:bindEvents()
end

function M:bindEvents()
	return
end

function M:unbindEvents()
	return
end

function M:setVisible(visible)
	goutil.setActive(self._mainGO, visible)
end

function M:updateData(recordMO)
	self._txtTime.text = recordMO:getDescTime()

	local descList = recordMO:getDescDataList()

	for idx, descRoot in ipairs(self._arrayDesc) do
		local descData = descList[idx]

		if descData then
			goutil.setActive(descRoot, true)

			local descTxt = goutil.findChildTextComponent(descRoot, "txtDesc")
			local valueTxt = goutil.findChildTextComponent(descRoot, "txtChange")

			descTxt.text = descData.descStr
			valueTxt.text = descData.valueStr

			local str = string.sub(descData.valueStr, 1, 1)
			local colorStr = "#8E8E8E"

			if str == "+" then
				colorStr = "#6bd0b9"
			elseif str == "-" then
				colorStr = "#fe5d5d"
			end

			valueTxt.color = parsecolor(colorStr)
		else
			goutil.setActive(descRoot, false)
		end
	end
end

return M
