local doAfterMgr = {}
doAfterMgr.__index = doAfterMgr

function doAfterMgr.new(base, behavior)
  local mgr = setmetatable({}, base)
  mgr.behavior = behavior
  mgr.timeNpc = get_npc_time(behavior.npc)
  mgr.timeGame = get_time()
  mgr.onground_task_list = {}
  mgr.background_task_list = {}
  mgr.remove_list = {}
  return mgr
end

function doAfterMgr.update(mgr)
  local behavior = mgr.behavior
  mgr.timeNpc = get_npc_time(behavior.npc)
  mgr.timeGame = get_time()
  for _, info in pairs(mgr.onground_task_list) do
    if info:isDue() then
      info.func(behavior, table.unpack(info))
      table.insert(mgr.remove_list, info)
    end
  end
  mgr:gc()
end

function doAfterMgr.updateBackground(mgr)
  local behavior = mgr.behavior
  mgr.timeNpc = get_npc_time(behavior.npc)
  mgr.timeGame = get_time()
  for _, info in pairs(mgr.background_task_list) do
    if info:isDue() then
      info.func(behavior, table.unpack(info))
      table.insert(mgr.remove_list, info)
    end
  end
  mgr:gc()
end

function doAfterMgr.gc(mgr)
  local remove_list = mgr.remove_list
  for _, info in ipairs(remove_list) do
    remove_list[info] = nil
    mgr.onground_task_list[info] = nil
    mgr.background_task_list[info] = nil
  end
end

function doAfterMgr.add(mgr, func, delay, isUpdateBackground, ...)
  if not delay or 0 == delay then
    NextFrameMgr:add_next_update(func, mgr.behavior, ...)
    return
  end
  local info = {
    ...
  }
  info.func = func
  info.mgr = mgr
  if delay < 0 then
    info.timer = get_npc_time(mgr.behavior.npc) + math.abs(delay)
    info.isDue = mgr.isDueNpc
  else
    info.timer = get_time() + delay
    info.isDue = mgr.isDueGame
  end
  mgr.onground_task_list[info] = info
  if isUpdateBackground then
    mgr.background_task_list[info] = info
  end
end

function doAfterMgr.isDueNpc(info)
  return info.mgr.timeNpc >= info.timer
end

function doAfterMgr.isDueGame(info)
  return info.mgr.timeGame >= info.timer
end

return doAfterMgr
