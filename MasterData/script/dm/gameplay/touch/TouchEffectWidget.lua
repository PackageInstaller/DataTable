-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/touch/TouchEffectWidget.lua

TouchEffectWidget = class("TouchEffectWidget", BaseWidget, _M)

TouchEffectWidget:has("_eventDispatcher", {
	is = "r"
}):injectWith("legs_sharedEventDispatcher")

function TouchEffectWidget.class:createWidgetNode()
	return cc.Node:create()
end

function TouchEffectWidget:dispose()
	self._dispose = true
	self._animCache = {}
end

function TouchEffectWidget:initialize(view)
	super.initialize(self, view)

	self._view = view
	self._posCache = {}
	self._animCache = {}

	self:createView()
end

function TouchEffectWidget:getView()
	return self._view
end

function TouchEffectWidget:createView()
	self:createTouchPanel()
end

function TouchEffectWidget:createTouchPanel()
	self._touchPanel = ccui.Layout:create()

	self._touchPanel:setTouchEnabled(false)
	self._touchPanel:setContentSize(self:getView():getContentSize())
	self:getView():addChild(self._touchPanel, 10, 101)
	self._touchPanel:setPosition(cc.p(0, 0))
	self._touchPanel:setVisible(true)

	local function onTouchBegin(touch, event)
		return self:touchBegin(touch, event)
	end

	local function onTouchEnd(touch, event)
		return self:touchEnd(touch, event)
	end

	local listener = cc.EventListenerTouchOneByOne:create()

	listener:setSwallowTouches(false)
	listener:registerScriptHandler(onTouchBegin, cc.Handler.EVENT_TOUCH_BEGAN)
	listener:registerScriptHandler(onTouchEnd, cc.Handler.EVENT_TOUCH_ENDED)
	self._touchPanel:getEventDispatcher():addEventListenerWithSceneGraphPriority(listener, self._touchPanel)

	self._touchListener = listener
end

function TouchEffectWidget:touchBegin(touch, event)
	self:onTouchPanelClick(touch)

	return true
end

function TouchEffectWidget:touchEnd(touch, event)
	local memeryCount = collectgarbage("count") / 1024

	if GameConfigs and GameConfigs.showNodeNumber or app.pkgConfig.showNodeNumber == 1 then
		self:dispatch(ShowTipEvent({
			duration = 2,
			tip = string.format("节点数量:%d,当前lua内存%dMB", CommonUtils.getCountNodeOfRootNode(), memeryCount)
		}))
	end

	if GameConfigs and GameConfigs.showTopView then
		local scene = self:getInjector():getInstance("BaseSceneMediator", "activeScene")

		for i = 1, #scene._areaViewStack do
			local areaInfo = scene._areaViewStack[i]
			local mediatorName = areaInfo.mediator.class._NAME

			print("areaViewStack=" .. i, mediatorName)

			if areaInfo.popupGroup then
				local popupViewStack = areaInfo.popupGroup._popupViewStack

				for index = 1, #popupViewStack do
					local popupInfo = popupViewStack[index]

					if popupInfo then
						-- block empty
					end
				end
			end
		end
	end
end

function TouchEffectWidget:createAnim()
	for anim, _ in pairs(self._animCache) do
		if not anim:isVisible() then
			return anim
		end
	end

	local newAnim = cc.MovieClip:create("light_djlzxg")

	newAnim:setPlaySpeed(1.5)

	self._animCache[newAnim] = true

	self._touchPanel:addChild(newAnim)

	return newAnim
end

function TouchEffectWidget:onTouchPanelClick(touch)
	if self._dispose then
		return
	end

	if self:isTouchEffectOff() then
		return
	end

	local pos = self._touchPanel:convertTouchToNodeSpaceAR(touch)
	local anim = self:createAnim()

	anim:setVisible(true)

	anim.posTag = posTag

	anim:gotoAndPlay(1)
	anim:addCallbackAtFrame(9, function(fid, mc, frameIndex)
		if anim:isVisible() then
			anim:stop()
			anim:setVisible(false)
		end
	end)
	anim:setPosition(pos)
end

function TouchEffectWidget:isTouchEffectOff()
	local settingSystem = self:getInjector():getInstance(SettingSystem)

	return (settingSystem or nil) and settingSystem:getSettingModel():isTouchEffectOff()
end

function TouchEffectWidget:dispatch(event)
	local eventDispatcher = self:getEventDispatcher()

	if eventDispatcher ~= nil then
		return eventDispatcher:dispatchEvent(event)
	end
end
