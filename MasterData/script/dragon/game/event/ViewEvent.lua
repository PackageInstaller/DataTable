-- chunkname: @/tmp/or_script/lua_compile/dragon/game/event/ViewEvent.lua

EVT_SWITCH_SCENE = "EVT_SWITCH_SCENE"
SceneEvent = class("SceneEvent", Event)

SceneEvent:has("_sceneName", {
	is = "r"
})
SceneEvent:has("_options", {
	is = "r"
})

function SceneEvent:initialize(type, sceneName, options, data)
	super.initialize(self, type, data)

	self._sceneName = sceneName
	self._options = options
end

EVT_SWITCH_VIEW = "EVT_SWITCH_VIEW"
EVT_PUSH_VIEW = "EVT_PUSH_VIEW"
EVT_SHOW_POPUP = "EVT_SHOW_POPUP"
EVT_SHOW_TOAST = "EVT_SHOW_TOAST"
EVT_SHOW_REWARD_TOAST = "EVT_SHOW_REWARD_TOAST"
EVT_PLAY_EFFECT = "EVT_PLAY_EFFECT"
EVT_DISMISS_VIEW = "EVT_DISMISS_VIEW"
EVT_CLOSE_POPUP = "EVT_CLOSE_POPUP"
ViewEvent = class("ViewEvent", Event)

ViewEvent:has("_view", {
	is = "r"
})
ViewEvent:has("_options", {
	is = "r"
})
ViewEvent:has("_delegate", {
	is = "r"
})

function ViewEvent:initialize(type, view, options, data, delegate)
	super.initialize(self, type, data)

	self._view = view
	self._options = options or {}
	self._delegate = delegate
end

ToastEvent = class("ToastEvent", ViewEvent)

ToastEvent:has("_toast", {
	is = "r"
})

function ToastEvent:initialize(type, toast, options, data, delegate)
	super.initialize(self, type, toast:getView(), options, data, delegate)

	self._toast = toast
end
