local roleInputor = {}
roleInputor.__index = roleInputor
local INPUT_PROTECT_TYPE = Const.INPUT_PROTECT_TYPE

function roleInputor.new(base, role)
  local result = setmetatable({}, base)
  result.role = role
  local max = 30
  local stack = {}
  for i = 1, max do
    stack[i] = {}
  end
  result.caches = {
    stack = stack,
    top = 1,
    max = max,
    num = 0
  }
  result.ipType = nil
  return result
end

function roleInputor.init(inputor)
  local role = inputor.role
  local btns = role.btns
  local atk = btns.atk
  local dash = btns.dash
  local sk1 = btns.sk1
  local sk2 = btns.sk2
  local ult = btns.ult
  inputor.btnList = {
    atk,
    dash,
    sk1,
    sk2,
    ult
  }
  inputor.btns = {
    atk = atk,
    [15] = atk,
    dash = dash,
    [18] = dash,
    sk1 = sk1,
    [19] = sk1,
    sk2 = sk2,
    [20] = sk2,
    ult = ult,
    [62] = ult
  }
end

function roleInputor:onBtnDown(keycode)
  local btn = self.btns[keycode]
  if not btn then
    return
  end
  btn:down()
end

function roleInputor:tick()
  for _, btn in ipairs(self.btnList) do
    btn:tick()
  end
end

function roleInputor.onBtnCancelUp(inputor, keycode)
  local btn = inputor.btns[keycode]
  if not btn then
    return
  end
  btn:cancelUp()
end

function roleInputor:onBtnUp(keycode)
  local btn = self.btns[keycode]
  if not btn then
    return
  end
  btn:up()
end

function roleInputor:onBtnCancel(keycode)
  local btn = self.btns[keycode]
  if not btn then
    return
  end
  btn:onCancel()
end

function roleInputor.cache(inputor, event)
  local caches = inputor.caches
  local stack = caches.stack
  local top = caches.top
  local max = caches.max
  local record = stack[top]
  for key, value in pairs(event) do
    record[key] = value
  end
  if inputor.caches.num ~= inputor.caches.max then
    inputor.caches.num = inputor.caches.num + 1
  end
  top = top + 1
  top = max < top and 1 or top
  inputor.caches.top = top
end

function roleInputor.validTop(inputor)
  local caches = inputor.caches
  local num = caches.num
  if 0 == num then
    return
  end
  local stack = caches.stack
  local top = caches.top
  local max = caches.max
  local i = top - 1
  i = i < 1 and max or i
  local pos
  while num > 0 do
    local event = stack[i]
    if not event then
      local role = inputor.role
      Log.Error(role.npc:get_hero_name() .. ".inputor.validTop() is called, num is " .. num .. ", i is " .. i .. ", roleAct is " .. role.skAct.name .. [[
 input cache is:
 ]] .. inputor:tostring())
      break
    end
    if _G.next(event.skActs) then
      pos = i
      break
    end
    i = i - 1
    i = i < 1 and max or i
    num = num - 1
  end
  return pos, num
end

function roleInputor.pop(inputor, retainCache, ignoreIcon, timeOffset)
  local caches = inputor.caches
  local stack = caches.stack
  local max = caches.max
  timeOffset = timeOffset or 0
  local now = Global.time - timeOffset
  local i, num = inputor:validTop()
  if not i then
    return
  end
  local popAct
  do
    local event = stack[i]
    if not event then
      local role = inputor.role
      Log.Error(role.npc:get_hero_name() .. ".inputor.pop() is called, roleAct is " .. role.skAct.name .. [[
 input cache is:
 ]] .. inputor:toStr())
      return
    end
    local btn = event.btn
    local icon = event.icon
    if event.name == "hold" and icon:getState() == "holding" and (ignoreIcon or icon == btn.icon) then
      popAct = icon.pop(event)
      if popAct then
        goto lbl_107
      else
        i = i - 1
        i = i < 1 and max or i
        num = num - 1
      end
    end
  end
  while num > 0 do
    local event = stack[i]
    if not event then
      local role = inputor.role
      role:debugOutput("inputor.pop() is called, roleAct is " .. role.skAct.name .. [[
 input cache is:
 ]] .. inputor:toStr())
      break
    end
    if now < event.timer then
      local btn = event.btn
      local icon = event.icon
      if ignoreIcon or btn.icon == icon then
        popAct = icon.pop(event)
        if not popAct then
          goto lbl_98
        end
        break
      end
    end
    ::lbl_98::
    i = i - 1
    i = i < 1 and max or i
    num = num - 1
  end
  ::lbl_107::
  local popTypes = inputor.POP_TYPE
  if not retainCache then
    retainCache = popTypes.CLEAR
  elseif true == retainCache then
    retainCache = popTypes.TRY
  end
  inputor.do_pop_clear[retainCache](inputor, popAct)
  return popAct
end

function roleInputor:clear()
  self.caches.top = 1
  self.caches.num = 0
end

local POP_TYPE = Const.INPUTOR_POP_TYPE
roleInputor.POP_TYPE = POP_TYPE
roleInputor.do_pop_clear = {
  [POP_TYPE.CLEAR] = roleInputor.clear,
  [POP_TYPE.RETAIN] = Const.NIL_FUN,
  [POP_TYPE.TRY] = function(inputor, popAct)
    if popAct then
      return inputor:clear()
    end
  end
}

function roleInputor.resetUi(inputor, oldInputor)
  local isOldRoleStay = oldInputor and oldInputor.role:isInRealStay()
  for i, btn in pairs(inputor.btnList) do
    local icon = btn.icon
    local oldBtn
    if oldInputor then
      oldBtn = oldInputor.btnList[i]
      btn.icon = oldBtn.icon
      btn.isDown = oldBtn.isDown
      if oldBtn.isDown and isOldRoleStay then
        oldBtn:up()
      end
    else
      btn.icon = nil
      btn.isDown = false
    end
    btn:clearUiCfg()
    btn:setIcon(icon, 0.1)
  end
end

function roleInputor.toStr(inputor)
  local caches = inputor.caches
  local i = caches.top - 1
  i = i < 1 and caches.max or i
  local num = caches.num
  local role = inputor.role
  local str = "\n" .. role.npc:get_hero_name() .. ".input cache num is " .. tostring(num) .. ", top is " .. tostring(caches.top) .. ", current time is " .. tostring(Global.time) .. ", stack is \n"
  local j = 0
  while num > 0 do
    local event = caches.stack[i]
    j = j + 1
    if event then
      str = str .. "cache " .. tostring(j) .. ": btn is " .. event.btn.name .. ", icon is " .. event.icon.name .. ", event is " .. event.name .. ", timer is " .. tostring(event.timer) .. "\n"
    else
      str = str .. "cache " .. tostring(j) .. ": nil \n"
    end
    i = i - 1
    i = i < 1 and caches.max or i
    num = num - 1
  end
  return str
end

function roleInputor.disable(inputor)
  clear_input(nil, true)
  inputor:clear()
  for _, btn in ipairs(inputor.btnList) do
    if btn.isDown then
      inputor:onBtnCancelUp(btn.id)
    end
  end
  local nilFun = Const.NIL_FUN
  inputor.onBtnDown = nilFun
  inputor.onBtnUp = nilFun
  inputor.onBtnCancelUp = nilFun
end

function roleInputor.enable(inputor)
  inputor:clear()
  inputor.onBtnDown = nil
  inputor.onBtnUp = nil
  inputor.onBtnCancelUp = nil
end

function roleInputor.setIPtype(inputor, type, clearCache)
  inputor.ipType = type
  if clearCache then
    return inputor:clear()
  end
end

function roleInputor.canHold(inputor)
  return inputor.ipType ~= INPUT_PROTECT_TYPE.BLOCK_INPUT
end

function roleInputor.canOutput(inputor)
  return not inputor.ipType
end

function roleInputor.canCache(inputor)
  return inputor.ipType ~= INPUT_PROTECT_TYPE.BLOCK_INPUT
end

return roleInputor
