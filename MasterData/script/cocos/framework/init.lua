-- chunkname: @/tmp/or_script/lua_compile/cocos/framework/init.lua

if type(DEBUG) ~= "number" then
	DEBUG = 0
end

printInfo("")
printInfo("# DEBUG                        = " .. DEBUG)
printInfo("#")

device = require("cocos.framework.device")
display = require("cocos.framework.display")
audio = require("cocos.framework.audio")
transition = require("cocos.framework.transition")

require("cocos.framework.extends.NodeEx")
require("cocos.framework.extends.SpriteEx")
require("cocos.framework.extends.LayerEx")
require("cocos.framework.extends.MenuEx")

if ccui then
	require("cocos.framework.extends.UIWidget")
	require("cocos.framework.extends.UICheckBox")
	require("cocos.framework.extends.UIEditBox")
	require("cocos.framework.extends.UIListView")
	require("cocos.framework.extends.UIPageView")
	require("cocos.framework.extends.UIScrollView")
	require("cocos.framework.extends.UISlider")
	require("cocos.framework.extends.UITextField")
end

require("cocos.framework.package_support")

local __g = _G

cc.exports = {}

setmetatable(cc.exports, {
	__newindex = function(_, name, value)
		rawset(__g, name, value)
	end,
	__index = function(_, name)
		return rawget(__g, name)
	end
})

function cc.disable_global()
	setmetatable(__g, {
		__newindex = function(_, name, value)
			error(string.format("USE \" cc.exports.%s = value \" INSTEAD OF SET GLOBAL VARIABLE", name), 0)
		end
	})
end

if CC_DISABLE_GLOBAL then
	cc.disable_global()
end
