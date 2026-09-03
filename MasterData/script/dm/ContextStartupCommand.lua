-- chunkname: @/tmp/or_script/lua_compile/dm/ContextStartupCommand.lua

ContextStartupCommand = class("ContextStartupCommand", legs.Command, _M)

ContextStartupCommand:has("_gameContext", {
	is = "r"
}):injectWith("GameContext")

function ContextStartupCommand:execute(event)
	require("dm.assets.init")
	require("dm.base.all")

	local context = self:getGameContext()
	local injector = self:getInjector()
	local commandMap = self:getCommandMap()
	local mediatorMap = self:getMediatorMap()
	local viewMap = context:getViewMap()

	local function sceneCreator()
		return cc.Scene:create()
	end

	if DEBUG > 0 then
		xpcall(function()
			require("dm.devutils.init")
		end, function(msg)
			if msg:find("module 'dm.devutils.init' not found:") == nil then
				print(debug.traceback(msg, 3))
			end

			return msg
		end)
		viewMap:mapViewToCreator("testScene", sceneCreator)
		mediatorMap:mapView("testScene", "TestSceneMediator")
		require("dm.gameplay.storyeditor.StoryEditorMediator")
		viewMap:mapViewToCreator("storyEditorScene", sceneCreator)
		mediatorMap:mapView("storyEditorScene", "StoryEditorMediator")
	end

	context:loadModuleByName("launch")
end
