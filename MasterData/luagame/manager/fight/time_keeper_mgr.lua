local M = Util.create_class()
local CSResLoader = CS.ResLoader
local UnityFind = _ENV.UnityFind
local UnityDontDestroyOnLoad = UnityGameObject.DontDestroyOnLoad
local TypeGlobalClock = typeof(CS.Chronos.GlobalClock)

function M:_init()
  local clock_root = UnityFind("ClockRoot")
  self.v_global_clock = nil
  if nil == clock_root then
    clock_root = UnityGameObject("ClockRoot")
    UnityDontDestroyOnLoad(clock_root)
    local full_res_path = CSResLoader.GetFullPath("RootClock")
    local go = ResMgr:load_gameobj(full_res_path)
    go.transform:SetParent(clock_root.transform)
    self.v_global_clock = go:GetComponent(TypeGlobalClock)
  else
    local go = clock_root.transform:GetChild(0).gameObject
    self.v_global_clock = go:GetComponent(TypeGlobalClock)
  end
  self.v_global_clock.gameObject:SetActiveEx(false)
  self.v_running = false
  self.v_playing = false
  self.v_record_map = {}
  self.v_inited = true
end

function M:_start_run()
  if not self.v_inited then
    self:_init()
  end
  if self.v_running then
    return
  end
  self.v_running = true
  self.v_global_clock.gameObject:SetActiveEx(true)
end

function M:_remove_timer()
  if self.v_timer then
    Timer:remove_timer(self.v_timer)
    self.v_timer = nil
  end
end

function M:record_time_invert(npc, time_limit)
  self:_start_run()
  npc.time_revert:start_record(time_limit)
  self.v_record_map[npc] = true
end

function M:_on_play_revert_finish()
  local cur = Global.real_time
  for npc in pairs(self.v_record_map) do
    npc.role_move_ctrl:set_enable(true)
    npc.act_ctrl:set_enable(true)
    npc.orienter:set_enable(true)
    local tf = npc:get_transform()
    local x, y, z = tf:GetPositionA()
    npc:raw_set_pos(x, y, z)
    npc.time_revert:update_born_time(cur)
  end
  self.v_global_clock.localTimeScale = 1
  self.v_playing = false
  self:_remove_timer()
  local cb = self.v_cb
  self.v_cb = nil
  if cb then
    cb()
  end
end

function M:_on_play_revert_start()
  for npc in pairs(self.v_record_map) do
    npc.role_move_ctrl:set_enable(false)
    npc.act_ctrl:set_enable(false)
    npc.orienter:set_enable(false)
  end
end

function M:_fix_revert_time(sec)
  local cur = Global.real_time
  local max = 0
  for npc in pairs(self.v_record_map) do
    local btime = cur - npc.time_revert:get_born_time()
    max = math.max(max, btime)
  end
  return math.min(sec, max)
end

function M:play_time_invert(sec, speed, cb)
  assert(sec)
  assert(speed and 0 ~= speed)
  if self.v_playing then
    Log.Error("已经在播放time revert", debug.traceback())
    return
  end
  sec = self:_fix_revert_time(sec)
  self.v_playing = true
  self.v_cb = cb
  self.v_global_clock.localTimeScale = speed
  local real_time = math.abs(sec / speed)
  self:_remove_timer()
  self.v_timer = Timer:add_timer("revert_time_timer", real_time, self._on_play_revert_finish, self)
  self:_on_play_revert_start()
end

function M:clear()
  self.v_running = false
  self.v_playing = false
  self.v_cb = nil
  self.v_record_map = nil
  self.v_inited = false
  self:_remove_timer()
  if self.v_global_clock then
    self.v_global_clock.gameObject:SetActiveEx(false)
    self.v_global_clock = nil
  end
end

return M
