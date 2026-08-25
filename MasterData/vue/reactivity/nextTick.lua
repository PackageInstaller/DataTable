local tinsert = table.insert
local isUsingMicroTask = false
local callbacks = {}
local copies = {}
local pending = false
local isDisable = false

local function flushCallbacks()
  if isDisable then
    table.clear(callbacks)
    return
  end
  pending = false
  table.clear(copies)
  table.mergeWithoutGc(copies, callbacks)
  table.clear(callbacks)
  for i = 1, #copies do
    copies[i]()
  end
  return #copies > 0
end

local function nextTick(cb, ctx)
  tinsert(callbacks, function()
    if cb then
      cb(ctx)
    end
  end)
end

local function setDisable()
  isDisable = true
end

return {
  flushCallbacks = flushCallbacks,
  nextTick = nextTick,
  setDisable = setDisable
}
