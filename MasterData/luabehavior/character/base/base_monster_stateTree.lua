local stateTreeBase = {}
stateTreeBase.__index = stateTreeBase
local stnBase = import("character.base.base_monster_stateTreeNode")

function stateTreeBase.curStatesStr(tree)
  local str = ""
  for _, state in ipairs(tree.states) do
    str = str .. "-" .. state.name
  end
  return str
end

function stateTreeBase.print(tree, _node, _level)
  local node = _node or tree.root
  local level = _level or 1
  local prefix = ""
  local slash = "------"
  local blank = "               |"
  for i = 1, level - 1 do
    prefix = prefix .. blank
  end
  prefix = prefix .. slash
  local string = prefix .. node.name
  for _, child in ipairs(node.children) do
    string = string .. "\n" .. tree:print(child, level + 1)
  end
  if not _node then
    return
  else
    return string
  end
end

if GAME_DEBUG then
  function stateTreeBase.new(base, monster)
    local result = setmetatable({}, base)
    
    result.monster = monster
    result.debugSwitch = monster.debugSwitch
    result.states = {}
    result.tarStates = {}
    result.oldStates = {}
    result.finStates = {}
    result.startStates = {}
    result.debugInfo = {
      tickTrans = {},
      finTrans = {},
      path = {
        num = 0,
        add = function(path, node)
          local num = path.num + 1
          path.num = num
          path[num] = node
        end,
        clear = function(path)
          path.num = 0
        end
      }
    }
    return result
  end
  
  function stateTreeBase.start(tree, state)
    local monster = tree.monster
    tree.failNode = monster.states.decisionFailed
    tree.root:start()
    tree:transState(state)
  end
  
  function stateTreeBase.tick(tree)
    for _, state in ipairs(tree.states) do
      state:tick()
      local nextState = state:tickTrans()
      if nextState then
        local tickTransInfo = tree.debugInfo.tickTrans
        tickTransInfo.updateFrame = Global.frame_id
        tickTransInfo.initNode = state
        tickTransInfo.tarNode = nextState
        tree:transState(nextState)
        return
      end
    end
  end
  
  function stateTreeBase.finTrans(tree)
    local states = tree.states
    local nextState, initState
    for i = #states, 1, -1 do
      local state = states[i]
      nextState = state:finTrans()
      if nextState then
        initState = state
        break
      end
    end
    if not nextState then
      local monster = tree.monster
      Util.debug_output(tostring(monster.npc.id) .. "." .. tostring(monster.npc.uuid) .. ".finTrans is called but no target is returned, curStates are :\n" .. tree:curStatesStr())
    end
    local finTransInfo = tree.debugInfo.finTrans
    finTransInfo.updateFrame = Global.frame_id
    finTransInfo.initNode = initState
    finTransInfo.tarNode = nextState
    tree:transState(nextState)
  end
  
  function stateTreeBase.chooseAction(tree, state)
    local node = state or tree.root
    local pathInfo = tree.debugInfo.path
    pathInfo:clear()
    while true do
      pathInfo:add(node)
      local forward = false
      if node:isReady() then
        if node.type == "action" then
          return node
        else
          local child = node:chooseChild()
          if child then
            node = child
            forward = true
          end
        end
      end
      if not forward then
        while true do
          if node.nextSibling then
            node = node.nextSibling
            break
          elseif node.parent then
            node = node.parent
          else
            return nil
          end
        end
      end
    end
  end
  
  function stateTreeBase.transState(tree, nextState, isForce)
    if tree.transLock then
      return tree.monster:debugOutput("尝试在transState尚未结束时再次调用transState，请检查相关代码")
    end
    tree.transLock = true
    nextState = nextState or tree.root
    local tar
    if isForce then
      local isReady = nextState.isReady
      nextState.isReady = Const.TURE_FUN
      tar = tree:chooseAction(nextState)
      nextState.isReady = isReady
    else
      tar = tree:chooseAction(nextState)
    end
    if not tar or tar == tree.failNode then
      tree:printDebugInfo()
    end
    tree:setAction(tar)
    local oldStates = tree.oldStates
    local tarStates = tree.tarStates
    local newStates = tree.states
    local finStates = tree.finStates
    local startStates = tree.startStates
    local node = nextState.parent
    while node do
      table.insert(tarStates, 1, node)
      node = node.parent
    end
    local old_tar_divide_index = #oldStates
    local isSame = true
    for i = 1, #oldStates do
      if oldStates[i] ~= tarStates[i] then
        table.insert(finStates, 1, oldStates[i])
        if isSame then
          old_tar_divide_index = i - 1
          isSame = false
        end
      end
    end
    for i = 1, #tarStates do
      tarStates[i] = nil
    end
    local insertPos = #finStates + 1
    local oldState, newState
    for i = 1, old_tar_divide_index do
      oldState = oldStates[i]
      newState = newStates[i]
      if oldState ~= newState then
        table.insert(finStates, insertPos, oldState)
        table.insert(startStates, newState)
      end
    end
    for i = old_tar_divide_index + 1, math.max(#newStates, #oldStates) do
      table.insert(startStates, newStates[i])
    end
    local monster = tree.monster
    local finDebug = monster.debugSwitch.finishState
    local str = finDebug and ""
    for i, finState in ipairs(finStates) do
      finState:finish()
      finStates[i] = nil
      if finDebug then
        str = finState.name .. "-" .. str
      end
    end
    if finDebug then
      str = "Finish States\t<<< " .. str
      monster:debugOutput(str)
    end
    local startDebug = monster.debugSwitch.startState
    str = startDebug and "Start States\t>>> "
    for i, startState in ipairs(startStates) do
      startState:start()
      startStates[i] = nil
      if startDebug then
        str = str .. startState.name .. "-"
      end
    end
    if str then
      monster:debugOutput(str)
    end
    tree.transLock = false
    return tar
  end
  
  function stateTreeBase.printDebugInfo(tree)
    local debugInfo = tree.debugInfo
    local monster = tree.monster
    local str = monster.npc.id .. "." .. monster.npc.uuid .. "： 行为树决策失败，相关信息如下：\n"
    if debugInfo.tickTrans.initNode then
      str = str .. "tickTrans最新调用帧：" .. debugInfo.tickTrans.updateFrame .. "， 发起节点：" .. debugInfo.tickTrans.initNode.name .. "， 目标节点：" .. debugInfo.tickTrans.tarNode.name .. "\n"
    end
    if debugInfo.finTrans.initNode then
      str = str .. "finTrans最新调用帧：" .. debugInfo.finTrans.updateFrame .. "， 发起节点：" .. debugInfo.finTrans.initNode.name .. "， 目标节点：" .. debugInfo.finTrans.tarNode.name .. "\n"
    end
    str = str .. "当前状态为：" .. tree:curStatesStr() .. "\n"
    str = str .. "决策路径为："
    for i = 1, debugInfo.path.num do
      str = str .. "-" .. debugInfo.path[i].name
    end
    str = str .. "\n"
    str = str .. "调用堆栈为：" .. debug.traceback()
    Log.Error(str)
  end
  
  function stateTreeBase.setAction(tree, action)
    local temp = tree.oldStates
    tree.oldStates = tree.states
    tree.states = temp
    for i, _ in ipairs(tree.states) do
      tree.states[i] = nil
    end
    local monster = tree.monster
    monster.preState = monster.state
    monster.state = action
    if monster.debugSwitch.curState then
      monster:logState()
    end
    local node = action
    while node do
      table.insert(tree.states, 1, node)
      node = node.parent
    end
  end
  
  function stateTreeBase.derive(tree, nextAction)
    if not nextAction then
      return
    end
    local states = tree.states
    local replacePos = #states
    local curAction = states[replacePos]
    curAction:finish()
    states[replacePos] = nextAction
    local monster = tree.monster
    monster.preState = monster.state
    monster.state = nextAction
    local debugSwitch = monster.debugSwitch
    if debugSwitch.curState then
      monster:logState()
    end
    if debugSwitch.finishState then
      monster:debugOutput("Finish States\t<<< " .. curAction.name)
    end
    if debugSwitch.startState then
      monster:debugOutput("Start States\t>>> " .. nextAction.name)
    end
    nextAction:start()
  end
else
  function stateTreeBase.new(base, monster)
    local result = setmetatable({}, base)
    
    result.monster = monster
    result.root = stnBase:new("root", monster)
    result.states = {}
    result.tarStates = {}
    result.oldStates = {}
    result.finStates = {}
    result.startStates = {}
    return result
  end
  
  function stateTreeBase.start(tree, state)
    tree.root:start()
    tree:transState(state)
  end
  
  function stateTreeBase.tick(tree)
    for _, state in ipairs(tree.states) do
      state:tick()
      local nextState = state:tickTrans()
      if nextState then
        tree:transState(nextState)
        return
      end
    end
  end
  
  function stateTreeBase.finTrans(tree)
    local states = tree.states
    local nextState
    for i = #states, 1, -1 do
      local state = states[i]
      nextState = state:finTrans()
      if nextState then
        break
      end
    end
    tree:transState(nextState)
  end
  
  function stateTreeBase.chooseAction(tree, state)
    local node = state or tree.root
    while true do
      local forward = false
      if node:isReady() then
        if node.type == "action" then
          return node
        else
          local child = node:chooseChild()
          if child then
            node = child
            forward = true
          end
        end
      end
      if not forward then
        while true do
          if node.nextSibling then
            node = node.nextSibling
            break
          elseif node.parent then
            node = node.parent
          else
            return nil
          end
        end
      end
    end
  end
  
  function stateTreeBase.transState(tree, nextState, isForce)
    if tree.transLock then
      return tree.monster:debugOutput("尝试在transState尚未结束时再次调用transState，请检查相关代码")
    end
    tree.transLock = true
    nextState = nextState or tree.root
    local tar
    if isForce then
      local isReady = nextState.isReady
      nextState.isReady = Const.TURE_FUN
      tar = tree:chooseAction(nextState)
      nextState.isReady = isReady
    else
      tar = tree:chooseAction(nextState)
    end
    tree:setAction(tar)
    local oldStates = tree.oldStates
    local tarStates = tree.tarStates
    local newStates = tree.states
    local finStates = tree.finStates
    local startStates = tree.startStates
    local node = nextState.parent
    while node do
      table.insert(tarStates, 1, node)
      node = node.parent
    end
    local old_tar_divide_index = #oldStates
    local isSame = true
    for i = 1, #oldStates do
      if oldStates[i] ~= tarStates[i] then
        table.insert(finStates, 1, oldStates[i])
        if isSame then
          old_tar_divide_index = i - 1
          isSame = false
        end
      end
    end
    for i = 1, #tarStates do
      tarStates[i] = nil
    end
    local insertPos = #finStates + 1
    local oldState, newState
    for i = 1, old_tar_divide_index do
      oldState = oldStates[i]
      newState = newStates[i]
      if oldState ~= newState then
        table.insert(finStates, insertPos, oldState)
        table.insert(startStates, newState)
      end
    end
    for i = old_tar_divide_index + 1, math.max(#newStates, #oldStates) do
      table.insert(startStates, newStates[i])
    end
    for i, finState in ipairs(finStates) do
      finState:finish()
      finStates[i] = nil
    end
    for i, startState in ipairs(startStates) do
      startState:start()
      startStates[i] = nil
    end
    tree.transLock = false
    return tar
  end
  
  function stateTreeBase.setAction(tree, action)
    local temp = tree.oldStates
    tree.oldStates = tree.states
    tree.states = temp
    for i, _ in ipairs(tree.states) do
      tree.states[i] = nil
    end
    local monster = tree.monster
    monster.preState = monster.state
    monster.state = action
    local node = action
    while node do
      table.insert(tree.states, 1, node)
      node = node.parent
    end
  end
  
  function stateTreeBase.derive(tree, nextAction)
    if not nextAction then
      return
    end
    local states = tree.states
    local replacePos = #states
    local curAction = states[replacePos]
    curAction:finish()
    states[replacePos] = nextAction
    local monster = tree.monster
    monster.preState = monster.state
    monster.state = nextAction
    nextAction:start()
  end
  
  function stateTreeBase.printDebugInfo(tree)
  end
end

function stateTreeBase.chooseChildAction(tree, state)
  local node = state or tree.root
  if not state:isReady() then
    return nil
  end
  while true do
    local forward = false
    if node:isReady() then
      if node.type == "action" then
        return node
      else
        local child = node:chooseChild()
        if child then
          node = child
          forward = true
        end
      end
    end
    if not forward then
      while true do
        if node == state then
          return nil
        end
        if node.nextSibling then
          node = node.nextSibling
          break
        elseif node.parent then
          node = node.parent
        else
          return nil
        end
      end
    end
  end
end

function stateTreeBase.curState(tree)
  local states = tree.states
  return states[#states]
end

return stateTreeBase
