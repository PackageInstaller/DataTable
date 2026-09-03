-- chunkname: @/tmp/or_script/lua_compile/cocos/init.lua

require("cocos.cocos2d.Cocos2d")
require("cocos.cocos2d.Cocos2dConstants")
require("cocos.cocos2d.functions")

if __G__TRACKBACK__ == nil then
	function __G__TRACKBACK__(msg)
		local msg = debug.traceback(msg, 3)

		print(msg)

		return msg
	end
end

require("cocos.cocos2d.Opengl")
require("cocos.cocos2d.OpenglConstants")
require("cocos.cocosdenshion.AudioEngine")

if ccs ~= nil then
	require("cocos.cocostudio.CocoStudio")
end

if ccui ~= nil then
	require("cocos.ui.GuiConstants")
	require("cocos.ui.experimentalUIConstants")
end

require("cocos.extension.ExtensionConstants")
require("cocos.network.NetworkConstants")

if sp ~= nil then
	require("cocos.spine.SpineConstants")
end

require("cocos.cocos2d.DrawPrimitives")

if CC_USE_DEPRECATED then
	require("cocos.cocos2d.DeprecatedCocos2dClass")
	require("cocos.cocos2d.DeprecatedCocos2dEnum")
	require("cocos.cocos2d.DeprecatedCocos2dFunc")
	require("cocos.cocos2d.DeprecatedOpenglEnum")

	if ccs ~= nil then
		require("cocos.cocostudio.DeprecatedCocoStudioClass")
		require("cocos.cocostudio.DeprecatedCocoStudioFunc")
	end

	require("cocos.cocosbuilder.DeprecatedCocosBuilderClass")
	require("cocos.cocosdenshion.DeprecatedCocosDenshionClass")
	require("cocos.cocosdenshion.DeprecatedCocosDenshionFunc")
	require("cocos.extension.DeprecatedExtensionClass")
	require("cocos.extension.DeprecatedExtensionEnum")
	require("cocos.extension.DeprecatedExtensionFunc")
	require("cocos.network.DeprecatedNetworkClass")
	require("cocos.network.DeprecatedNetworkEnum")
	require("cocos.network.DeprecatedNetworkFunc")

	if ccui ~= nil then
		require("cocos.ui.DeprecatedUIEnum")
		require("cocos.ui.DeprecatedUIFunc")
	end
end

require("cocos.cocosbuilder.CCBReaderLoad")
require("cocos.physics3d.physics3d-constants")

if CC_USE_FRAMEWORK then
	require("cocos.framework.init")
end
