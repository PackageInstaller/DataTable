-- chunkname: @/tmp/or_script/lua_compile/dm/battle/logic/components/BagComponent.lua

BagComponent = class("BagComponent", BaseComponent)

function BagComponent:initialize()
	super.initialize(self)
end

function BagComponent:initWithRawData(data)
	super.initWithRawData(self, data)

	if data == nil then
		self._carriedItems = nil
	else
		local carriedItems = {}

		for i, packet in ipairs(data) do
			local list = {}

			for j, item in ipairs(packet.list) do
				local var_2_0 = {
					type = item.type,
					id = item.id,
					unit = item.unit
				}

				var_2_0.count = item.count or 1
				list[j] = var_2_0
			end

			carriedItems[i] = {
				hpRatio = packet.hp,
				list = list
			}
		end

		self._carriedItems = carriedItems
	end

	return self
end

function BagComponent:dropItems(condition)
	local carriedItems = self._carriedItems

	if carriedItems == nil then
		return nil
	end

	local droppedItems, k = nil, 1

	for _, packet in ipairs(carriedItems) do
		if packet.list ~= nil and condition(packet) then
			if droppedItems == nil then
				droppedItems = {}
			end

			for _, x in ipairs(packet.list) do
				k = k + 1
				droppedItems[k] = x
			end

			packet.list = nil
		end
	end

	return k > 1 and droppedItems or nil
end
