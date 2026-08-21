-- chunkname: @Util\\Layer.lua

Layer = {
	Water = 4,
	Default = 0,
	TransparentFX = 1,
	UI = 5,
	["Ignore Raycast"] = 2
}
LayerMask = {
	value = 0
}

setmetatable(LayerMask, LayerMask)

function LayerMask.__call(t, v)
	return LayerMask.New(v)
end

function LayerMask.New(value)
	local layer = {
		value = 0
	}

	layer.value = value and value or 0

	setmetatable(layer, LayerMask)

	return layer
end

function LayerMask.NameToLayer(name)
	return Layer[name]
end

function LayerMask.MultiLayer(...)
	local arg = {
		...
	}
	local value = 0

	for i = 1, #arg do
		value = value + bit.lshift(1, LayerMask.NameToLayer(arg[i]))
	end

	return value
end
