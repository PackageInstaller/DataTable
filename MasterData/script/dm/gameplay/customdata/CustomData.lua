-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/customdata/CustomData.lua

CustomData = class("CustomData", objectlua.Object, _M)
PrefixType = {
	kGuide = "GUIDE",
	kStory = "STORY",
	kGlobal = "GLOBAL"
}

function CustomData:initialize(id)
	super.initialize(self)

	self._customData = {}
end

function CustomData:dispose()
	super.dispose(self)
end

function CustomData:sync(data)
	for key, value in pairs(data) do
		local keyData = string.split(key, "#")
		local prefixType

		if #keyData == 1 then
			prefixType = PrefixType.kGlobal
			key = keyData[1]
		elseif #keyData == 2 then
			prefixType = keyData[1]
			key = keyData[2]
		elseif #keyData == 3 then
			prefixType = keyData[1]
			key = keyData[2] .. "#" .. keyData[3]
		end

		self:setValue(prefixType, key, value)
	end
end

function CustomData:getValue(type, key, default)
	type = type or PrefixType.kGlobal

	local value = default
	local customData = self._customData[type]

	value = customData and customData[key] ~= nil and customData[key] or value

	return value
end

function CustomData:setValue(type, key, value)
	type = type or PrefixType.kGlobal

	local customData = self._customData[type]

	if customData == nil then
		customData = {}
		self._customData[type] = customData
	end

	customData[key] = value
end

function CustomData:getValuesByType(type)
	return self._customData[type]
end
