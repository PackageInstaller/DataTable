-- chunkname: @/tmp/or_script/lua_compile/dm/devutils/TestSceneMediator.lua

TestSceneMediator = class("TestSceneMediator", DmSceneMediator)

function TestSceneMediator:initialize()
	super.initialize(self)
end

function TestSceneMediator:dispose()
	super.dispose(self)
end

function TestSceneMediator:onRegister()
	super.onRegister(self)
end

function TestSceneMediator:onRemove()
	super.onRemove(self)
end

function TestSceneMediator:enterWithData(data)
	cclog("[info]", "===== Running TEST scene =====")

	if GameConfigs.testCase ~= nil then
		self:runTestCase(GameConfigs.testCase)
	end
end

function TestSceneMediator:runTestCase(testCase)
	if testCase.moduleURL ~= nil then
		require(testCase.moduleURL)
	end

	if testCase.mediator == nil then
		return
	end

	local injector = self:getInjector()
	local gameContext = injector:getInstance("GameContext")
	local viewMap = gameContext:getViewMap()
	local mediatorMap = gameContext:getMediatorMap()
	local testViewName = "DevTestView"

	if testCase.viewName ~= nil then
		testViewName = testCase.viewName
	end

	if testCase.viewRes ~= nil then
		viewMap:mapViewToRes(testViewName, testCase.viewRes)
	else
		viewMap:mapViewToCreator(testViewName, function()
			return cc.Node:create()
		end)
	end

	mediatorMap:mapView(testViewName, testCase.mediator)

	local view = injector:getInstance(testViewName)

	if view ~= nil then
		self:dispatch(ViewEvent:new(EVT_SWITCH_VIEW, view, testCase.data))
	end
end
