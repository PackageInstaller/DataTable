-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/datamanager/dm_reddot.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local DM_RedDot = class("DM_RedDot")
DM_RedDot.PlayerPrefs = (CS.UnityEngine).PlayerPrefs
DM_RedDot.PREFIX = "RedDot"
DM_RedDot.INVALID_KEY = "RedDot_InvalidKey"
DM_RedDot.STATUS = {UNREAD = 0, READ = 1}
DM_RedDot.DAY_KEY = nil
DM_RedDot.MONTH_KEY = nil
DM_RedDot.WEEK_KEY = nil
DM_RedDot.INVALID_DAY = 0
DM_RedDot.INVALID_WEEK = 0
DM_RedDot.INVALID_MONTH = 0
DM_RedDot.Ctor = function(self)
  -- function num : 0_0
end

DM_RedDot.Clear = function(self)
  -- function num : 0_1 , upvalues : DM_RedDot
  (DM_RedDot.Destory)()
end

DM_RedDot.Init = function()
  -- function num : 0_2 , upvalues : DM_RedDot
  (DM_RedDot.Destory)()
  ;
  (DM_RedDot.InitShopNodeTree)()
end

DM_RedDot.Destory = function()
  -- function num : 0_3 , upvalues : DM_RedDot
  DM_RedDot.DAY_KEY = nil
  DM_RedDot.MONTH_KEY = nil
  DM_RedDot.WEEK_KEY = nil
  ;
  (DM_RedDot.DestoryShopNodeTree)()
end

DM_RedDot._GetKey = function(...)
  -- function num : 0_4 , upvalues : _ENV, DM_RedDot
  local nameTable = {...}
  local rawKey = (table.concat)(nameTable, ".")
  if #rawKey ~= #nameTable - 1 then
    return (table.concat)({(((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()).userid, DM_RedDot.PREFIX, rawKey}, ".")
  else
    LogError("DM_RedDot", "Empty identity!")
    return DM_RedDot.INVALID_KEY
  end
end

DM_RedDot._GetRedDotIsUnreadWithKey = function(...)
  -- function num : 0_5 , upvalues : DM_RedDot
  local key = (DM_RedDot._GetKey)(...)
  local value = ((DM_RedDot.PlayerPrefs).GetInt)(key, (DM_RedDot.STATUS).UNREAD)
  do return value == (DM_RedDot.STATUS).UNREAD end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

DM_RedDot._SetRedDotReadWithKey = function(...)
  -- function num : 0_6 , upvalues : DM_RedDot
  local key = (DM_RedDot._GetKey)(...)
  ;
  ((DM_RedDot.PlayerPrefs).SetInt)(key, (DM_RedDot.STATUS).READ)
end

DM_RedDot._SetRedDotUnreadWithKey = function(...)
  -- function num : 0_7 , upvalues : DM_RedDot
  local key = (DM_RedDot._GetKey)(...)
  ;
  ((DM_RedDot.PlayerPrefs).SetInt)(key, (DM_RedDot.STATUS).UNREAD)
end

DM_RedDot.GetRedDotIsUnreadWithNode = function(node)
  -- function num : 0_8 , upvalues : _ENV, DM_RedDot
  if node == nil then
    LogError("DM_RedDot", "The node is nil!")
    return 
  end
  local key = node.nodeName
  local value = ((DM_RedDot.PlayerPrefs).GetInt)(key, (DM_RedDot.STATUS).UNREAD)
  do return value == (DM_RedDot.STATUS).UNREAD end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

DM_RedDot.SetRedDotReadWithNode = function(node)
  -- function num : 0_9 , upvalues : _ENV, DM_RedDot
  if node == nil then
    LogError("DM_RedDot", "The node is nil!")
    return 
  end
  local key = node.nodeName
  ;
  ((DM_RedDot.PlayerPrefs).SetInt)(key, (DM_RedDot.STATUS).READ)
end

DM_RedDot.SetRedDotUnreadWithNode = function(node)
  -- function num : 0_10 , upvalues : _ENV, DM_RedDot
  if node == nil then
    LogError("DM_RedDot", "The node is nil!")
    return 
  end
  local key = node.nodeName
  ;
  ((DM_RedDot.PlayerPrefs).SetInt)(key, (DM_RedDot.STATUS).UNREAD)
end

DM_RedDot.NowIsNewDay = function()
  -- function num : 0_11 , upvalues : DM_RedDot, _ENV
  if DM_RedDot.DAY_KEY == nil then
    DM_RedDot.DAY_KEY = (DM_RedDot._GetKey)("KeyLastLoginDay")
  end
  local nowDay = tonumber((os.date)("!%Y%m%d", (ServerGameTimer.GetServerTimeForecast)() // 1000))
  local lastDay = ((DM_RedDot.PlayerPrefs).GetInt)(DM_RedDot.DAY_KEY, DM_RedDot.INVALID_DAY)
  ;
  ((DM_RedDot.PlayerPrefs).SetInt)(DM_RedDot.DAY_KEY, nowDay)
  do return nowDay ~= lastDay end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

DM_RedDot.NowIsNewMonth = function()
  -- function num : 0_12 , upvalues : DM_RedDot, _ENV
  if DM_RedDot.MONTH_KEY == nil then
    DM_RedDot.MONTH_KEY = (DM_RedDot._GetKey)("KeyLastLoginMonth")
  end
  local nowMonth = tonumber((os.date)("!%Y%m", (ServerGameTimer.GetServerTimeForecast)() // 1000))
  local lastMonth = ((DM_RedDot.PlayerPrefs).GetInt)(DM_RedDot.MONTH_KEY, DM_RedDot.INVALID_MONTH)
  ;
  ((DM_RedDot.PlayerPrefs).SetInt)(DM_RedDot.MONTH_KEY, nowMonth)
  do return nowMonth ~= lastMonth end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

DM_RedDot.NowIsNewWeek = function()
  -- function num : 0_13 , upvalues : DM_RedDot, _ENV
  if DM_RedDot.WEEK_KEY == nil then
    DM_RedDot.WEEK_KEY = (DM_RedDot._GetKey)("KeyLastLoginWeek")
  end
  local nowWeek = tonumber((os.date)("!%Y%m%W", (ServerGameTimer.GetServerTimeForecast)() // 1000 + 14400))
  local lastWeek = ((DM_RedDot.PlayerPrefs).GetInt)(DM_RedDot.WEEK_KEY, DM_RedDot.INVALID_WEEK)
  ;
  ((DM_RedDot.PlayerPrefs).SetInt)(DM_RedDot.WEEK_KEY, nowWeek)
  do return nowWeek ~= lastWeek end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

DM_RedDot.ParseTimeStr = function(timeStr)
  -- function num : 0_14 , upvalues : _ENV
  local _, _, year, month, day, hour, min, sec = (string.find)(timeStr, "(%d+)%-(%d+)%-(%d+)%s(%d+)%:(%d+)%:(%d+)")
  return {year = year, month = month, day = day, hour = hour, min = min, sec = sec}
end

DM_RedDot.nodeRoot = {nodeName = "root", nodeIndex = "root", haveRedDot = false, 
childNode = {}
, fatherNode = nil}
DM_RedDot.CreateNewNodeToTree = function(nodeName, fatherNode, haveRedDot)
  -- function num : 0_15 , upvalues : _ENV, DM_RedDot
  if nodeName == nil or nodeName == "" then
    LogError("DM_RedDot", "Empty nodeName!")
    return 
  end
  if fatherNode == nil then
    fatherNode = DM_RedDot.nodeRoot
  end
  if haveRedDot == nil then
    haveRedDot = false
  end
  nodeName = tostring(nodeName)
  local nowFatherNode = fatherNode
  local nowNodeName = {nodeName}
  while nowFatherNode do
    (table.insert)(nowNodeName, 1, nowFatherNode.nodeIndex)
    nowFatherNode = nowFatherNode.fatherNode
  end
  local newNode = {nodeName = (DM_RedDot._GetKey)((table.unpack)(nowNodeName)), nodeIndex = nodeName, haveRedDot = haveRedDot, 
childNode = {}
, fatherNode = fatherNode}
  -- DECOMPILER ERROR at PC48: Confused about usage of register: R6 in 'UnsetPending'

  ;
  (fatherNode.childNode)[newNode.nodeIndex] = newNode
  return newNode
end

DM_RedDot.AddExistNodeToTree = function(node, fatherNode)
  -- function num : 0_16 , upvalues : _ENV, DM_RedDot
  if node == nil then
    LogError("DM_RedDot", "The node is nil!")
    return 
  end
  if fatherNode == nil then
    fatherNode = DM_RedDot.nodeRoot
  end
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (fatherNode.childNode)[node.nodeIndex] = node
end

DM_RedDot.ClearNodeChild = function(node)
  -- function num : 0_17 , upvalues : _ENV
  if node == nil then
    LogError("DM_RedDot", "The node is nil!")
    return 
  end
  for key,_ in pairs(node.childNode) do
    -- DECOMPILER ERROR at PC12: Confused about usage of register: R6 in 'UnsetPending'

    (node.childNode)[key] = nil
  end
end

DM_RedDot.GetNodeResult = function(node, onlyThis)
  -- function num : 0_18 , upvalues : _ENV, DM_RedDot
  if node == nil then
    LogError("DM_RedDot", "The node is nil!")
    return false
  end
  local haveRedDotType = type(node.haveRedDot)
  -- DECOMPILER ERROR at PC18: Unhandled construct in 'MakeBoolean' P1

  if haveRedDotType == "function" and (node.haveRedDot)() == true then
    return true
  end
  -- DECOMPILER ERROR at PC26: Unhandled construct in 'MakeBoolean' P1

  if haveRedDotType == "boolean" and node.haveRedDot == true then
    return true
  end
  LogErrorFormat("DM_RedDot", "Unkown haveRedDot type: %s!", haveRedDotType)
  do return false end
  if not onlyThis then
    for _,value in pairs(node.childNode) do
      if (DM_RedDot.GetNodeResult)(value, onlyThis) == true then
        return true
      end
    end
  end
  do
    return false
  end
end

DM_RedDot.SetNodeRead = function(node, saveToLocal, recursive)
  -- function num : 0_19 , upvalues : _ENV, DM_RedDot
  if node == nil then
    LogError("DM_RedDot", "The node is nil!")
    return 
  end
  local haveRedDotType = type(node.haveRedDot)
  if haveRedDotType ~= "function" or haveRedDotType == "boolean" then
    node.haveRedDot = false
  else
    LogErrorFormat("DM_RedDot", "Unkown haveRedDot type: %s!", haveRedDotType)
    return 
  end
  if saveToLocal == true then
    (DM_RedDot.SetRedDotReadWithNode)(node)
  end
  if recursive == true then
    for _,value in pairs(node.childNode) do
      (DM_RedDot.SetNodeRead)(value, saveToLocal, recursive)
    end
  end
end

DM_RedDot.SetNodeUnread = function(node, saveToLocal, recursive)
  -- function num : 0_20 , upvalues : _ENV, DM_RedDot
  if node == nil then
    LogError("DM_RedDot", "The node is nil!")
    return 
  end
  local haveRedDotType = type(node.haveRedDot)
  if haveRedDotType ~= "function" or haveRedDotType == "boolean" then
    node.haveRedDot = true
  else
    LogErrorFormat("DM_RedDot", "Unkown haveRedDot type: %s!", haveRedDotType)
    return 
  end
  if saveToLocal == true then
    (DM_RedDot.SetRedDotUnreadWithNode)(node)
  end
  if recursive == true then
    for _,value in pairs(node.childNode) do
      (DM_RedDot.SetNodeUnread)(value, saveToLocal, recursive)
    end
  end
end

DM_RedDot.nodeShop = nil
DM_RedDot.nodeChildShop = {}
DM_RedDot.shopTimeLimitTable = {[5] = (BeanManager.GetTableByName)("recharge.ccommoditlimitpackage"), [6] = (BeanManager.GetTableByName)("recharge.ccommoditclothes")}
DM_RedDot.shopTimeLimitTableTimer = {}
DM_RedDot.shopTimeLimitTableHelper = {}
DM_RedDot.SServerTimeRechedObserver = {}
DM_RedDot.DoNextFuncTable = {}
DM_RedDot.InitShopNodeTree = function()
  -- function num : 0_21 , upvalues : _ENV, DM_RedDot
  (LuaNotificationCenter.AddObserver)(DM_RedDot.SServerTimeRechedObserver, DM_RedDot._InitShopNodeTree, Common.n_SServerTimeReached)
end

DM_RedDot._InitShopNodeTree = function()
  -- function num : 0_22 , upvalues : _ENV, DM_RedDot
  (LuaNotificationCenter.RemoveObserver)(DM_RedDot.SServerTimeRechedObserver, Common.n_SServerTimeReached)
  DM_RedDot.nodeShop = (DM_RedDot.CreateNewNodeToTree)("KeyShop")
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R0 in 'UnsetPending'

  if not (DM_RedDot.GetIDOpenFirst)((DM_RedDot.nodeShop).nodeName) then
    (DM_RedDot.nodeShop).haveRedDot = (DM_RedDot.GetRedDotIsUnreadWithNode)(DM_RedDot.nodeShop)
  end
  ;
  (DM_RedDot.CreateShopTree)()
  ;
  (DM_RedDot.CreateFriendTree)()
  ;
  (DM_RedDot.CreateCourtYardTree)()
  ;
  (DM_RedDot.StartShopTimeLimitHandler1)()
  for _,func in ipairs(DM_RedDot.DoNextFuncTable) do
    func()
  end
  for key,_ in ipairs(DM_RedDot.DoNextFuncTable) do
    -- DECOMPILER ERROR at PC42: Confused about usage of register: R5 in 'UnsetPending'

    (DM_RedDot.DoNextFuncTable)[key] = nil
  end
end

DM_RedDot.CreateShopTree = function(firstAdd)
  -- function num : 0_23 , upvalues : DM_RedDot, _ENV
  local doNext = function()
    -- function num : 0_23_0 , upvalues : DM_RedDot, _ENV, firstAdd
    local dailyGiftShop = (DM_RedDot.CreateNewNodeToTree)("KeyDailyGiftShop", DM_RedDot.nodeShop)
    dailyGiftShop.haveRedDot = (DM_RedDot.GetRedDotIsUnreadWithNode)(dailyGiftShop)
    if (DM_RedDot.NowIsNewDay)() then
      (DM_RedDot.SetNodeUnread)(dailyGiftShop, true)
    end
    local shopAccumulation = (DM_RedDot.CreateNewNodeToTree)("KeyHasAccumulationRewardToGet", DM_RedDot.nodeShop, function()
      -- function num : 0_23_0_0 , upvalues : _ENV
      return ((NekoData.BehaviorManager).BM_Shop):HasAccumulationRewardToGet()
    end
)
    local shopFashionReward = (DM_RedDot.CreateNewNodeToTree)("KeyHasFashionRewardToGet", DM_RedDot.nodeShop, function()
      -- function num : 0_23_0_1 , upvalues : _ENV
      return ((NekoData.BehaviorManager).BM_SkinList):IsHasBoxReddot()
    end
)
    -- DECOMPILER ERROR at PC31: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (DM_RedDot.nodeChildShop)[4] = (DM_RedDot.CreateNewNodeToTree)("KeyChildShop4", DM_RedDot.nodeShop)
    ;
    (DM_RedDot.CreateNewNodeToTree)("ItemData", (DM_RedDot.nodeChildShop)[4])
    -- DECOMPILER ERROR at PC42: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (DM_RedDot.nodeChildShop)[50] = (DM_RedDot.CreateNewNodeToTree)("KeyChildShop50", DM_RedDot.nodeShop)
    ;
    (DM_RedDot.CreateNewNodeToTree)("ItemData", (DM_RedDot.nodeChildShop)[50])
    -- DECOMPILER ERROR at PC53: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (DM_RedDot.nodeChildShop)[5] = (DM_RedDot.CreateNewNodeToTree)("KeyChildShop5", DM_RedDot.nodeShop)
    -- DECOMPILER ERROR at PC67: Confused about usage of register: R3 in 'UnsetPending'

    if not (DM_RedDot.GetIDOpenFirst)(((DM_RedDot.nodeChildShop)[5]).nodeName) then
      ((DM_RedDot.nodeChildShop)[5]).haveRedDot = (DM_RedDot.GetRedDotIsUnreadWithNode)((DM_RedDot.nodeChildShop)[5])
    end
    ;
    (DM_RedDot.CreateNewNodeToTree)("ItemData", (DM_RedDot.nodeChildShop)[5])
    -- DECOMPILER ERROR at PC78: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (DM_RedDot.nodeChildShop)[20] = (DM_RedDot.CreateNewNodeToTree)("KeyChildShop20", DM_RedDot.nodeShop)
    -- DECOMPILER ERROR at PC92: Confused about usage of register: R3 in 'UnsetPending'

    if not (DM_RedDot.GetIDOpenFirst)(((DM_RedDot.nodeChildShop)[20]).nodeName) then
      ((DM_RedDot.nodeChildShop)[20]).haveRedDot = (DM_RedDot.GetRedDotIsUnreadWithNode)((DM_RedDot.nodeChildShop)[20])
      if (DM_RedDot.NowIsNewMonth)() then
        (DM_RedDot.SetNodeUnread)((DM_RedDot.nodeChildShop)[20], true)
      end
    end
    ;
    (DM_RedDot.CreateNewNodeToTree)("ItemData", (DM_RedDot.nodeChildShop)[20])
    -- DECOMPILER ERROR at PC112: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (DM_RedDot.nodeChildShop)[46] = (DM_RedDot.CreateNewNodeToTree)("KeyChildShop46", DM_RedDot.nodeShop)
    -- DECOMPILER ERROR at PC119: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((DM_RedDot.nodeChildShop)[46]).haveRedDot = (DM_RedDot.GetRedDotIsUnreadWithNode)((DM_RedDot.nodeChildShop)[46])
    if (DM_RedDot.NowIsNewWeek)() then
      (DM_RedDot.SetNodeUnread)((DM_RedDot.nodeChildShop)[46], true)
    end
    ;
    (DM_RedDot.CreateNewNodeToTree)("ItemData", (DM_RedDot.nodeChildShop)[46])
    -- DECOMPILER ERROR at PC139: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (DM_RedDot.nodeChildShop)[37] = (DM_RedDot.CreateNewNodeToTree)("KeyChildShop37", DM_RedDot.nodeShop)
    -- DECOMPILER ERROR at PC153: Confused about usage of register: R3 in 'UnsetPending'

    if not (DM_RedDot.GetIDOpenFirst)(((DM_RedDot.nodeChildShop)[37]).nodeName) then
      ((DM_RedDot.nodeChildShop)[37]).haveRedDot = (DM_RedDot.GetRedDotIsUnreadWithNode)((DM_RedDot.nodeChildShop)[37])
    end
    ;
    (DM_RedDot.CreateNewNodeToTree)("ItemData", (DM_RedDot.nodeChildShop)[37])
    -- DECOMPILER ERROR at PC164: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (DM_RedDot.nodeChildShop)[6] = (DM_RedDot.CreateNewNodeToTree)("KeyChildShop6", DM_RedDot.nodeShop)
    -- DECOMPILER ERROR at PC178: Confused about usage of register: R3 in 'UnsetPending'

    if not (DM_RedDot.GetIDOpenFirst)(((DM_RedDot.nodeChildShop)[6]).nodeName) then
      ((DM_RedDot.nodeChildShop)[6]).haveRedDot = (DM_RedDot.GetRedDotIsUnreadWithNode)((DM_RedDot.nodeChildShop)[6])
    end
    ;
    (DM_RedDot.CreateNewNodeToTree)("ItemData", (DM_RedDot.nodeChildShop)[6])
    if firstAdd then
      (DM_RedDot.SetNodeUnread)(DM_RedDot.nodeShop)
      ;
      (DM_RedDot.SetIDNotOpenFirst)((DM_RedDot.nodeShop).nodeName)
      ;
      (LuaNotificationCenter.PostNotification)(Common.n_ShopRedPoint, nil, nil)
    end
  end

  if DM_RedDot.nodeShop == nil then
    (table.insert)(DM_RedDot.DoNextFuncTable, doNext)
  else
    doNext()
  end
end

DM_RedDot.CreateFriendTree = function(firstAdd)
  -- function num : 0_24 , upvalues : DM_RedDot, _ENV
  local doNext = function()
    -- function num : 0_24_0 , upvalues : DM_RedDot, firstAdd, _ENV
    -- DECOMPILER ERROR at PC5: Confused about usage of register: R0 in 'UnsetPending'

    (DM_RedDot.nodeChildShop)[9] = (DM_RedDot.CreateNewNodeToTree)("KeyChildShop9", DM_RedDot.nodeShop)
    -- DECOMPILER ERROR at PC19: Confused about usage of register: R0 in 'UnsetPending'

    if not (DM_RedDot.GetIDOpenFirst)(((DM_RedDot.nodeChildShop)[9]).nodeName) then
      ((DM_RedDot.nodeChildShop)[9]).haveRedDot = (DM_RedDot.GetRedDotIsUnreadWithNode)((DM_RedDot.nodeChildShop)[9])
    end
    if firstAdd then
      (DM_RedDot.SetNodeUnread)((DM_RedDot.nodeChildShop)[9])
      ;
      (DM_RedDot.SetIDNotOpenFirst)(((DM_RedDot.nodeChildShop)[9]).nodeName)
      ;
      (LuaNotificationCenter.PostNotification)(Common.n_ShopRedPoint, nil, nil)
    end
  end

  if DM_RedDot.nodeShop == nil then
    (table.insert)(DM_RedDot.DoNextFuncTable, doNext)
  else
    doNext()
  end
end

DM_RedDot.CreateCourtYardTree = function(firstAdd)
  -- function num : 0_25 , upvalues : DM_RedDot, _ENV
  local doNext = function()
    -- function num : 0_25_0 , upvalues : DM_RedDot, firstAdd, _ENV
    -- DECOMPILER ERROR at PC5: Confused about usage of register: R0 in 'UnsetPending'

    (DM_RedDot.nodeChildShop)[13] = (DM_RedDot.CreateNewNodeToTree)("KeyChildShop13", DM_RedDot.nodeShop)
    -- DECOMPILER ERROR at PC19: Confused about usage of register: R0 in 'UnsetPending'

    if not (DM_RedDot.GetIDOpenFirst)(((DM_RedDot.nodeChildShop)[13]).nodeName) then
      ((DM_RedDot.nodeChildShop)[13]).haveRedDot = (DM_RedDot.GetRedDotIsUnreadWithNode)((DM_RedDot.nodeChildShop)[13])
    end
    if firstAdd then
      (DM_RedDot.SetNodeUnread)((DM_RedDot.nodeChildShop)[13])
      ;
      (DM_RedDot.SetIDNotOpenFirst)(((DM_RedDot.nodeChildShop)[13]).nodeName)
      ;
      (LuaNotificationCenter.PostNotification)(Common.n_ShopRedPoint, nil, nil)
    end
  end

  if DM_RedDot.nodeShop == nil then
    (table.insert)(DM_RedDot.DoNextFuncTable, doNext)
  else
    doNext()
  end
end

DM_RedDot.DestoryShopNodeTree = function()
  -- function num : 0_26 , upvalues : DM_RedDot, _ENV
  if DM_RedDot.nodeShop then
    (DM_RedDot.ClearNodeChild)(DM_RedDot.nodeShop)
    -- DECOMPILER ERROR at PC11: Confused about usage of register: R0 in 'UnsetPending'

    ;
    (((DM_RedDot.nodeShop).fatherNode).childNode)[(DM_RedDot.nodeShop).nodeIndex] = nil
    DM_RedDot.nodeShop = nil
  end
  for key,_ in pairs(DM_RedDot.nodeChildShop) do
    -- DECOMPILER ERROR at PC18: Confused about usage of register: R5 in 'UnsetPending'

    (DM_RedDot.nodeChildShop)[key] = nil
  end
  for key,_ in pairs(DM_RedDot.shopTimeLimitTableTimer) do
    (ServerGameTimer.RemoveTask)((DM_RedDot.shopTimeLimitTableTimer)[key])
    -- DECOMPILER ERROR at PC31: Confused about usage of register: R5 in 'UnsetPending'

    ;
    (DM_RedDot.shopTimeLimitTableTimer)[key] = nil
  end
  for key,_ in pairs(DM_RedDot.shopTimeLimitTableHelper) do
    -- DECOMPILER ERROR at PC39: Confused about usage of register: R5 in 'UnsetPending'

    (DM_RedDot.shopTimeLimitTableHelper)[key] = nil
  end
  for key,_ in pairs(DM_RedDot.DoNextFuncTable) do
    -- DECOMPILER ERROR at PC47: Confused about usage of register: R5 in 'UnsetPending'

    (DM_RedDot.DoNextFuncTable)[key] = nil
  end
end

DM_RedDot.GetIDOpenFirst = function(id)
  -- function num : 0_27 , upvalues : DM_RedDot
  return (DM_RedDot._GetRedDotIsUnreadWithKey)("IDOpenFirst_", id)
end

DM_RedDot.SetIDNotOpenFirst = function(id)
  -- function num : 0_28 , upvalues : DM_RedDot
  (DM_RedDot._SetRedDotReadWithKey)("IDOpenFirst_", id)
end

DM_RedDot.OnSShopRedPointNotify = function(protocol)
  -- function num : 0_29 , upvalues : _ENV, DM_RedDot
  for _,value in pairs(protocol.freeRedPointList) do
    do
      local doNext = function()
    -- function num : 0_29_0 , upvalues : DM_RedDot, value
    (DM_RedDot.SetNodeUnread)((DM_RedDot.nodeChildShop)[value], true)
  end

      if DM_RedDot.nodeShop == nil then
        (table.insert)(DM_RedDot.DoNextFuncTable, doNext)
      else
        doNext()
      end
    end
  end
  for _,value in pairs(protocol.redPointList) do
    if not (DM_RedDot.GetIDOpenFirst)(((DM_RedDot.nodeChildShop)[value]).nodeName) then
      local doNext = function()
    -- function num : 0_29_1 , upvalues : DM_RedDot, value
    (DM_RedDot.SetNodeUnread)((DM_RedDot.nodeChildShop)[value], true)
  end

      if DM_RedDot.nodeShop == nil then
        (table.insert)(DM_RedDot.DoNextFuncTable, doNext)
      else
        doNext()
      end
    end
  end
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_ShopRedPoint, nil, nil)
end

DM_RedDot.OnSCheckShopRedpoint = function(protocol)
  -- function num : 0_30 , upvalues : _ENV, DM_RedDot
  LogInfoFormat("DM_RedDot", "SCheckShopRedpoint: %s", (table.concat)({protocol.shoptype, "|", protocol.goodId, "|", protocol.canDo}))
  if protocol.canDo == 1 then
    (DM_RedDot.SetNodeUnread)((DM_RedDot.nodeChildShop)[protocol.shoptype], true)
    ;
    (LuaNotificationCenter.PostNotification)(Common.n_ShopRedPoint, nil, nil)
  end
end

DM_RedDot.StartShopTimeLimitHandler1 = function()
  -- function num : 0_31 , upvalues : _ENV, DM_RedDot
  local nowTime = (ServerGameTimer.GetServerTimeForecast)() // 1000
  for key,value in pairs(DM_RedDot.shopTimeLimitTable) do
    for _,value2 in pairs(value:GetAllIds()) do
      local rec = value:GetRecorder(value2)
      if rec.OpenTime ~= "0" and rec.CloseTime ~= "0" then
        local openTime = (os.time)((DM_RedDot.ParseTimeStr)(rec.OpenTime))
        local closeTime = (os.time)((DM_RedDot.ParseTimeStr)(rec.CloseTime))
        if nowTime < openTime then
          (table.insert)(DM_RedDot.shopTimeLimitTableHelper, {shopID = key, goodID = rec.id, openTime = openTime})
        else
          if nowTime < closeTime then
            local tempNode = (DM_RedDot.CreateNewNodeToTree)(rec.id, (((DM_RedDot.nodeChildShop)[key]).childNode).ItemData)
            tempNode.haveRedDot = (DM_RedDot.GetRedDotIsUnreadWithNode)(tempNode)
            if (DM_RedDot.GetNodeResult)(tempNode) then
              LogInfoFormat("DM_RedDot", "CCheckShopRedpoint: %s", (table.concat)({key, "|", rec.id}))
              local protocol = (LuaNetManager.CreateProtocol)("protocol.shop.ccheckshopredpoint")
              protocol.shoptype = key
              protocol.goodId = rec.id
              protocol:Send()
            end
            do
              do
                -- DECOMPILER ERROR at PC91: Confused about usage of register: R15 in 'UnsetPending'

                ;
                (((((DM_RedDot.nodeChildShop)[key]).childNode).ItemData).childNode)[tempNode.nodeIndex] = nil
                -- DECOMPILER ERROR at PC92: LeaveBlock: unexpected jumping out DO_STMT

                -- DECOMPILER ERROR at PC92: LeaveBlock: unexpected jumping out IF_THEN_STMT

                -- DECOMPILER ERROR at PC92: LeaveBlock: unexpected jumping out IF_STMT

                -- DECOMPILER ERROR at PC92: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                -- DECOMPILER ERROR at PC92: LeaveBlock: unexpected jumping out IF_STMT

                -- DECOMPILER ERROR at PC92: LeaveBlock: unexpected jumping out IF_THEN_STMT

                -- DECOMPILER ERROR at PC92: LeaveBlock: unexpected jumping out IF_STMT

              end
            end
          end
        end
      end
    end
  end
  ;
  (table.sort)(DM_RedDot.shopTimeLimitTableHelper, function(a, b)
    -- function num : 0_31_0
    do return a.openTime < b.openTime end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  ;
  (DM_RedDot.StartShopTimeLimitHandler2)()
end

DM_RedDot.StartShopTimeLimitHandler2 = function()
  -- function num : 0_32 , upvalues : _ENV, DM_RedDot
  local nowTime = (ServerGameTimer.GetServerTimeForecast)() // 1000
  local nearlestTime = nil
  local tempTable1 = {}
  local tempTable2 = {}
  for _,value in ipairs(DM_RedDot.shopTimeLimitTableHelper) do
    if nearlestTime == nil then
      nearlestTime = value.openTime
    end
    if nearlestTime == value.openTime then
      (table.insert)(tempTable1, value)
    else
      ;
      (table.insert)(tempTable2, value)
    end
  end
  DM_RedDot.shopTimeLimitTableHelper = tempTable2
  if #tempTable1 > 0 then
    local timerID = (ServerGameTimer.AddTask)((os.difftime)(nearlestTime, nowTime), -1, function()
    -- function num : 0_32_0 , upvalues : _ENV, tempTable1, DM_RedDot
    local protocol = (LuaNetManager.CreateProtocol)("protocol.shop.ccheckshopredpoint")
    if protocol then
      for _,value in ipairs(tempTable1) do
        LogInfoFormat("DM_RedDot", "CCheckShopRedpoint: %s", (table.concat)({value.shopID, "|", value.goodID}))
        protocol.shoptype = value.shopID
        protocol.goodId = value.goodID
        protocol:Send()
      end
    end
    do
      ;
      (DM_RedDot.StartShopTimeLimitHandler2)()
    end
  end
)
    ;
    (table.insert)(DM_RedDot.shopTimeLimitTableTimer, timerID)
  end
end

return DM_RedDot

