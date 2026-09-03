-- chunkname: @/tmp/or_script/lua_compile/dragon/game/command/SceneCommands.lua

SwitchSceneCommand = class("SwitchSceneCommand", legs.Command)

function SwitchSceneCommand:execute(event)
	local sceneName = event:getSceneName()

	assert(sceneName ~= nil, "Scene name expected!")

	local eventData = event:getData()
	local injector = self:getInjector()
	local newScene = injector:getInstance(sceneName)

	if newScene == nil then
		cclogf("[warning] Failed to create scene by name '%s'. Using default scene.", sceneName)

		newScene = cc.Scene:create()
	end

	local mediatorMap = self:getMediatorMap()

	newScene:registerScriptHandler(function(actionType)
		if actionType == "enter" then
			local sceneMediator = mediatorMap:retrieveMediator(newScene)

			if sceneMediator ~= nil and sceneMediator.enterWithData ~= nil then
				sceneMediator:enterWithData(eventData)
			end
		end
	end)

	local director = cc.Director:getInstance()

	if director:getRunningScene() then
		director:replaceScene(newScene)
	else
		director:runWithScene(newScene)
	end
end
