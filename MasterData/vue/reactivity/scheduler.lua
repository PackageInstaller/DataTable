local nextTick = require("Vue.reactivity.nextTick").nextTick
local select, pairs, type, tinsert, tremove, tsort, setmetatable = select, pairs, type, table.insert, table.remove, table.sort, _ENV.setmetatable
local config = require("Vue.reactivity.config")
local __DEV__ = config.__DEV__
local ErrorCodes = require("Vue.reactivity.ErrorCodes")
local reactiveUtils = require("Vue.reactivity.reactiveUtils")
local callWithErrorHandling, array_includes = reactiveUtils.callWithErrorHandling, reactiveUtils.array_includes
local queue = {}
local has = {}
local postFlushCbs = {}
local isFlushing = false
local isFlushPending = false
local RECURSION_LIMIT = 100
local INFINITE = 1.0E100
local FLUSH_DEPTH_LIMIT = 100

local function getId(job)
  return "function" == type(job) and INFINITE or job.id
end

local function checkRecursiveUpdates(seen, fn)
  if not seen[fn] then
    seen[fn] = 1
  else
    local count = seen[fn]
    if count > RECURSION_LIMIT then
      reactiveUtils.warn("Maximum recursive updates exceeded. " .. "You may have code that is mutating state in your component's " .. "render function or updated hook or watcher source function.")
    else
      seen[fn] = count + 1
    end
  end
end

local function flushPostFlushCbs(seen)
  if #postFlushCbs > 0 then
    local cbs = {}
    for i = 1, #postFlushCbs do
      cbs[postFlushCbs[i]] = true
    end
    postFlushCbs = {}
    if __DEV__ and not seen then
      seen = {}
    end
    for cb in pairs(cbs) do
      if __DEV__ then
        checkRecursiveUpdates(seen, cb)
      end
      cb()
    end
  end
end

local queueFlush
local MAX_JOB_EXEC_PER_FRAME = 5
local MAX_LOOP_PER_FRAME = 256
local _lastFrameCount = -1
local _jobExecCount = {}
local _loopCount = 0
local UnityTime = CS.UnityEngine.Time

local function _resetFrameCounters()
  local frame = UnityTime.frameCount
  if frame ~= _lastFrameCount then
    _lastFrameCount = frame
    table.clear(_jobExecCount)
    _loopCount = 0
  end
end

local function flushJobs(seen, depth)
  depth = depth or 0
  if depth > FLUSH_DEPTH_LIMIT then
    reactiveUtils.warn("[Vue Scheduler] flushJobs recursive depth exceeded " .. FLUSH_DEPTH_LIMIT .. ", possible reactive infinite loop! Breaking out.")
    isFlushing = false
    return
  end
  isFlushPending = false
  isFlushing = true
  local job
  if __DEV__ and not seen then
    seen = {}
  end
  tsort(queue, function(a, b)
    local aid = a.id
    local bid = b.id
    if aid == bid then
      return a.sortId < b.sortId
    else
      return aid < bid
    end
  end)
  job = tremove(queue, 1)
  local deferred
  while job and nil ~= job do
    _resetFrameCounters()
    _loopCount = _loopCount + 1
    if _loopCount > MAX_LOOP_PER_FRAME then
      tinsert(queue, 1, job)
      break
    end
    local jobId = job.id
    local execCount = _jobExecCount[jobId] or 0
    if execCount >= MAX_JOB_EXEC_PER_FRAME then
      deferred = deferred or {}
      tinsert(deferred, job)
    else
      _jobExecCount[jobId] = execCount + 1
      has[job] = nil
      if __DEV__ then
        checkRecursiveUpdates(seen, job)
      end
      callWithErrorHandling(job, nil, ErrorCodes.SCHEDULER)
    end
    job = tremove(queue, 1)
  end
  if deferred then
    for i = 1, #deferred do
      tinsert(queue, deferred[i])
    end
  end
  flushPostFlushCbs(seen)
  isFlushing = false
  if #queue > 0 then
    _resetFrameCounters()
    if _loopCount > MAX_LOOP_PER_FRAME then
      isFlushPending = false
      queueFlush()
    else
      flushJobs(seen, depth + 1)
    end
  elseif #postFlushCbs > 0 then
    flushJobs(seen, depth + 1)
  end
end

function queueFlush()
  if not isFlushing and not isFlushPending then
    isFlushPending = true
    if __DEV__ and not config.async then
      flushJobs()
      return
    end
    nextTick(flushJobs)
  end
end

local sortId = 0

local function queueJob(job)
  if not has[job] then
    if "function" == type(job) then
      local fn = job
      job = setmetatable({id = INFINITE}, {
        __call = function(self, ...)
          has[fn] = nil
          do return fn, ... end
          return fn, ...
        end
      })
      has[fn] = job
    else
      has[job] = job
    end
    sortId = sortId + 1
    job.sortId = sortId
    tinsert(queue, job)
    queueFlush()
  end
end

local function invalidateJob(job)
  local realjob = has[job]
  if realjob then
    for i, v in ipairs(queue) do
      if v == realjob then
        has[job] = nil
        table.remove(queue, i)
        return
      end
    end
  end
end

local function queuePostFlushCb(...)
  local count = select("#", ...)
  for i = 1, count do
    local cb = select(i, ...)
    if cb then
      tinsert(postFlushCbs, cb)
    end
  end
  queueFlush()
end

return {
  queueJob = queueJob,
  invalidateJob = invalidateJob,
  queuePostFlushCb = queuePostFlushCb
}
