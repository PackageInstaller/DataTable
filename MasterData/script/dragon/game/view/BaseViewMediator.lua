-- chunkname: @/tmp/or_script/lua_compile/dragon/game/view/BaseViewMediator.lua

BaseViewMediator = class("BaseViewMediator", legs.Mediator)

BaseViewMediator:has("_currentSceneMediator", {
	is = "r"
}):injectWith("BaseSceneMediator", "activeScene")

function BaseViewMediator:adjustLayout(targetFrame)
	return
end

function BaseViewMediator:addSubLayer(layerView, zOrder, frame)
	return self:addSubLayerTo(self:getView(), layerView, zOrder, frame)
end

function BaseViewMediator:addSubLayerTo(parentView, layerView, zOrder, frame)
	if zOrder ~= nil then
		parentView:addChild(layerView, zOrder)
	else
		parentView:addChild(layerView)
	end

	local mediator = self:getMediatorMap():retrieveMediator(layerView)

	if mediator ~= nil then
		if frame == nil then
			local size = parentView:getContentSize()

			frame = cc.rect(0, 0, size.width, size.height)
		end

		mediator:adjustLayout(frame)
	end

	return mediator, layerView
end

function BaseViewMediator:getMediatorOfView(view)
	return self:getMediatorMap():retrieveMediator(view)
end
