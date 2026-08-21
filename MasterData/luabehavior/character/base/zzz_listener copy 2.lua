local listener = {}
local switch = {
  on_missile_begin = {
    all = listener.instList,
    caster = {
      inst1,
      inst2
    },
    target = {
      inst1
    },
    [123] = {
      all = {
        inst1,
        inst2
      },
      caster = listener.instList,
      target = true
    },
    [456] = {onBegin = true, onBeignT = true}
  }
}

function lichi.on_missile_begin()
end

function lichi.on_self_missile_begin()
end

function lichi.on_target_self_missile_begin()
end

lichi.misLogics[123].onBeginA = function()
end
lichi.misLogics[123].onBegin = function()
end
lichi.misLogics[123].onBeginT = function()
end

function listener.on_missile_begin(behaviorClass, caster, target, misId, mis)
  local switch = switch.on_missile_begin
  local list, listener
  list = switch.all
  if list then
    for _, inst in pairs(list) do
      inst:on_misisle_begin(mis)
    end
  end
  list = switch.caster
  listener = list and list[caster]
  if listener then
    listener:on_self_missile_begin(mis)
  end
  list = switch.target
  listener = list and list[target]
  if listener then
    listener:on_target_self_missile_begin(mis)
  end
  local idList = switch[misId]
  if not idList then
    return
  end
  list = idList.all
  if list then
    for _, inst in pairs(list) do
      inst.misLogics[misId]:onBeginA(mis)
    end
  end
  list = idList.caster
  listener = list and list[caster]
  if listener then
    listener.misLogics[misId].onBegin(mis)
  end
  list = idList.target
  listener = list and list[target]
  if listener then
    listener.misLogics[misId].onBeginT(mis)
  end
end

return listener
