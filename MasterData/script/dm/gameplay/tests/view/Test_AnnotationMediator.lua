-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/tests/view/Test_AnnotationMediator.lua

Test_AnnotationMediator = class("Test_AnnotationMediator", DmAreaViewMediator)

Test_AnnotationMediator:has("_testAnnotationSystem", {
	is = "r"
}):injectWith("TestAnnotationSystem")

function Test_AnnotationMediator:initialize()
	super.initialize(self)
end

function Test_AnnotationMediator:dispose()
	super.dispose(self)
end

function Test_AnnotationMediator:onRegister()
	super.onRegister(self)
end

function Test_AnnotationMediator:enterWithData(data)
	self:setupView()
end

function Test_AnnotationMediator:setupView()
	self._testAnnotationSystem:func3()

	local tempData = {}
	local system = tempData.System

	system:func2(1, 2)
end
