-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/colorfuleggs/model/eggs/ColorfulEggFactory.lua

module("logic.extensions.colorfuleggs.model.eggs.ColorfulEggFactory", package.seeall)

local ColorfulEggFactory = class("ColorfulEggFactory")
local eggsById = {}

function ColorfulEggFactory.registerEggs()
	return
end

function ColorfulEggFactory.createEgg(id)
	local eggCo = ColorfulEggConfig.instance:getColorfulEggCo(id)
	local eggCls = eggsById[id]

	if eggCls then
		return eggCls.New(eggCo)
	end

	return ColorfulEggFactory._createDefault(eggCo)
end

function ColorfulEggFactory._createDefault(eggCo)
	return ColorfulEggBase.New(eggCo)
end

return ColorfulEggFactory
