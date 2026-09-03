-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/spStage/view/SpStageTestSceneMediator.lua

SpStageTestSceneMediator = class("SpStageTestSceneMediator", DmSceneMediator, _M)

function SpStageTestSceneMediator:initialize()
	super.initialize(self)
end

function SpStageTestSceneMediator:dispose()
	super.dispose(self)
end

function SpStageTestSceneMediator:onRegister()
	super.onRegister(self)
end

function SpStageTestSceneMediator:onRemove()
	super.onRemove(self)
end

function SpStageTestSceneMediator:enterWithData(data)
	local view = self:getInjector():getInstance("SpStageFinishView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {}, nil, nil))
end
