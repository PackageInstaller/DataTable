local M = Global.util.create_class()

function M:_init()
  self.v_listeners = setmetatable({}, Global.config.KEY_WEAK_METATABLE)
  self.v_widgets = setmetatable({}, Global.config.WEAK_METATABLE)
  self.v_gameobjs = setmetatable({}, Global.config.WEAK_METATABLE)
  self.v_playable_stopped_actions = setmetatable({}, Global.config.KEY_WEAK_METATABLE)
end

function M:add_listener(root, listener, cb)
  listener:RemoveAllListeners()
  listener:AddListener(cb)
  if not root then
    Log.Error("add listener error, please check param: root", debug.traceback())
    return
  end
  local listeners = self.v_listeners[root]
  if not listeners then
    listeners = {}
    self.v_listeners[root] = listeners
  end
  listeners[listener] = cb
end

function M:remove_listener(root, listener)
  listener:RemoveAllListeners()
  local listeners = self.v_listeners[root]
  if listeners then
    listeners[listener] = nil
  end
end

function M:get_listener(root, listener)
  return self.v_listeners[root] and self.v_listeners[root][listener]
end

function M:add_playable_stopped_action(root, playable, action)
  if not root then
    Log.Error("add_playable_stopped_action error, please check param: root", debug.traceback())
    return
  end
  local actions = self.v_playable_stopped_actions[root]
  if not actions then
    actions = {}
    self.v_playable_stopped_actions[root] = actions
  end
  playable:RemovePlayableDirectorListener()
  actions[playable] = action
  playable:stopped("+", action)
end

function M:remove_playable_stopped_action(root, playable)
  if not root then
    Log.Error("remove_playable_stopped_action error, please check param: root", debug.traceback())
    return
  end
  playable:RemovePlayableDirectorListener()
  local actions = self.v_playable_stopped_actions[root]
  if not actions then
    return
  end
  actions[playable] = nil
end

function M:register_ui_widget(widget)
  self.v_widgets[widget] = true
end

function M:on_instantiate_gameobj(obj)
  self.v_gameobjs[obj] = true
end

function M:on_destroy_gameobj(obj)
  self.v_gameobjs[obj] = nil
end

function M:on_add_ui(obj)
end

function M:on_destroy_ui_object(root)
  if not root then
    return
  end
  local listeners = self.v_listeners[root]
  if listeners then
    for listener, _ in pairs(listeners) do
      listener:RemoveAllListeners()
    end
  end
  self.v_listeners[root] = nil
  local actions = self.v_playable_stopped_actions[root]
  if actions then
    for playable in pairs(actions) do
      playable:RemovePlayableDirectorListener()
    end
    self.v_playable_stopped_actions[root] = nil
  end
end

function M:release_all_listeners_on_reload()
  for root, v in pairs(self.v_listeners) do
    self:on_destroy_ui_object(root)
  end
end

return M
