local DM_RedDot = class("DM_RedDot")
DM_RedDot.PlayerPrefs = CS.UnityEngine.PlayerPrefs
DM_RedDot.PREFIX = "RedDot"
DM_RedDot.INVALID_KEY = "RedDot_InvalidKey"
DM_RedDot.STATUS = {UNREAD = 0, READ = 1}
DM_RedDot.DAY_KEY = nil
DM_RedDot.MONTH_KEY = nil
DM_RedDot.WEEK_KEY = nil
DM_RedDot.INVALID_DAY = 0
DM_RedDot.INVALID_WEEK = 0
DM_RedDot.INVALID_MONTH = 0

function DM_RedDot:Ctor()
end

function DM_RedDot:Clear()
  DM_RedDot.Destory()
end

function DM_RedDot.Init()
  DM_RedDot.Destory()
  DM_RedDot.InitShopNodeTree()
end

function DM_RedDot.Destory()
  DM_RedDot.DAY_KEY = nil
  DM_RedDot.MONTH_KEY = nil
  DM_RedDot.WEEK_KEY = nil
  DM_RedDot.DestoryShopNodeTree()
end

function DM_RedDot._GetKey(...)
  local nameTable = {
    ...
  }
  local rawKey = table.concat(nameTable, ".")
  if #rawKey ~= #nameTable - 1 then
    return table.concat({
      NekoData.BehaviorManager.BM_Game:GetMyRoleInfo().userid,
      DM_RedDot.PREFIX,
      rawKey
    }, ".")
  else
    LogError("DM_RedDot", "Empty identity!")
    return DM_RedDot.INVALID_KEY
  end
end

function DM_RedDot._GetRedDotIsUnreadWithKey(...)
  local key = DM_RedDot._GetKey(...)
  local value = DM_RedDot.PlayerPrefs.GetInt(key, DM_RedDot.STATUS.UNREAD)
  return value == DM_RedDot.STATUS.UNREAD
end

function DM_RedDot._SetRedDotReadWithKey(...)
  local key = DM_RedDot._GetKey(...)
  DM_RedDot.PlayerPrefs.SetInt(key, DM_RedDot.STATUS.READ)
end

function DM_RedDot._SetRedDotUnreadWithKey(...)
  local key = DM_RedDot._GetKey(...)
  DM_RedDot.PlayerPrefs.SetInt(key, DM_RedDot.STATUS.UNREAD)
end

function DM_RedDot.GetRedDotIsUnreadWithNode(node)
  if node == nil then
    LogError("DM_RedDot", "The node is nil!")
    return
  end
  local key = node.nodeName
  local value = DM_RedDot.PlayerPrefs.GetInt(key, DM_RedDot.STATUS.UNREAD)
  return value == DM_RedDot.STATUS.UNREAD
end

function DM_RedDot.SetRedDotReadWithNode(node)
  if node == nil then
    LogError("DM_RedDot", "The node is nil!")
    return
  end
  local key = node.nodeName
  DM_RedDot.PlayerPrefs.SetInt(key, DM_RedDot.STATUS.READ)
end

function DM_RedDot.SetRedDotUnreadWithNode(node)
  if node == nil then
    LogError("DM_RedDot", "The node is nil!")
    return
  end
  local key = node.nodeName
  DM_RedDot.PlayerPrefs.SetInt(key, DM_RedDot.STATUS.UNREAD)
end

function DM_RedDot.NowIsNewDay()
  if DM_RedDot.DAY_KEY == nil then
    DM_RedDot.DAY_KEY = DM_RedDot._GetKey("KeyLastLoginDay")
  end
  local nowDay = tonumber(os.date("!%Y%m%d", ServerGameTimer.GetServerTimeForecast() // 1000))
  local lastDay = DM_RedDot.PlayerPrefs.GetInt(DM_RedDot.DAY_KEY, DM_RedDot.INVALID_DAY)
  DM_RedDot.PlayerPrefs.SetInt(DM_RedDot.DAY_KEY, nowDay)
  return nowDay ~= lastDay
end

function DM_RedDot.NowIsNewMonth()
  if DM_RedDot.MONTH_KEY == nil then
    DM_RedDot.MONTH_KEY = DM_RedDot._GetKey("KeyLastLoginMonth")
  end
  local nowMonth = tonumber(os.date("!%Y%m", ServerGameTimer.GetServerTimeForecast() // 1000))
  local lastMonth = DM_RedDot.PlayerPrefs.GetInt(DM_RedDot.MONTH_KEY, DM_RedDot.INVALID_MONTH)
  DM_RedDot.PlayerPrefs.SetInt(DM_RedDot.MONTH_KEY, nowMonth)
  return nowMonth ~= lastMonth
end

function DM_RedDot.NowIsNewWeek()
  if DM_RedDot.WEEK_KEY == nil then
    DM_RedDot.WEEK_KEY = DM_RedDot._GetKey("KeyLastLoginWeek")
  end
  local nowWeek = tonumber(os.date("!%Y%m%W", ServerGameTimer.GetServerTimeForecast() // 1000 + 14400))
  local lastWeek = DM_RedDot.PlayerPrefs.GetInt(DM_RedDot.WEEK_KEY, DM_RedDot.INVALID_WEEK)
  DM_RedDot.PlayerPrefs.SetInt(DM_RedDot.WEEK_KEY, nowWeek)
  return nowWeek ~= lastWeek
end

function DM_RedDot.ParseTimeStr(timeStr)
  local _, _, year, month, day, hour, min, sec = string.find(timeStr, "(%d+)%-(%d+)%-(%d+)%s(%d+)%:(%d+)%:(%d+)")
  return {
    year = year,
    month = month,
    day = day,
    hour = hour,
    min = min,
    sec = sec
  }
end

DM_RedDot.nodeRoot = {
  nodeName = "root",
  nodeIndex = "root",
  haveRedDot = false,
  childNode = {},
  fatherNode = nil
}

function DM_RedDot.CreateNewNodeToTree(nodeName, fatherNode, haveRedDot)
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
    table.insert(nowNodeName, 1, nowFatherNode.nodeIndex)
    nowFatherNode = nowFatherNode.fatherNode
  end
  local newNode = {
    nodeName = DM_RedDot._GetKey(table.unpack(nowNodeName)),
    nodeIndex = nodeName,
    haveRedDot = haveRedDot,
    childNode = {},
    fatherNode = fatherNode
  }
  fatherNode.childNode[newNode.nodeIndex] = newNode
  return newNode
end

function DM_RedDot.AddExistNodeToTree(node, fatherNode)
  if node == nil then
    LogError("DM_RedDot", "The node is nil!")
    return
  end
  if fatherNode == nil then
    fatherNode = DM_RedDot.nodeRoot
  end
  fatherNode.childNode[node.nodeIndex] = node
end

function DM_RedDot.ClearNodeChild(node)
  if node == nil then
    LogError("DM_RedDot", "The node is nil!")
    return
  end
  for key, _ in pairs(node.childNode) do
    node.childNode[key] = nil
  end
end

function DM_RedDot.GetNodeResult(node, onlyThis)
  if node == nil then
    LogError("DM_RedDot", "The node is nil!")
    return false
  end
  local haveRedDotType = type(node.haveRedDot)
  if haveRedDotType == "function" then
    if node.haveRedDot() == true then
      return true
    end
  elseif haveRedDotType == "boolean" then
    if node.haveRedDot == true then
      return true
    end
  else
    LogErrorFormat("DM_RedDot", "Unkown haveRedDot type: %s!", haveRedDotType)
    return false
  end
  if not onlyThis then
    for _, value in pairs(node.childNode) do
      if DM_RedDot.GetNodeResult(value, onlyThis) == true then
        return true
      end
    end
  end
  return false
end

function DM_RedDot.SetNodeRead(node, saveToLocal, recursive)
  if node == nil then
    LogError("DM_RedDot", "The node is nil!")
    return
  end
  local haveRedDotType = type(node.haveRedDot)
  if haveRedDotType == "function" then
  elseif haveRedDotType == "boolean" then
    node.haveRedDot = false
  else
    LogErrorFormat("DM_RedDot", "Unkown haveRedDot type: %s!", haveRedDotType)
    return
  end
  if saveToLocal == true then
    DM_RedDot.SetRedDotReadWithNode(node)
  end
  if recursive == true then
    for _, value in pairs(node.childNode) do
      DM_RedDot.SetNodeRead(value, saveToLocal, recursive)
    end
  end
end

function DM_RedDot.SetNodeUnread(node, saveToLocal, recursive)
  if node == nil then
    LogError("DM_RedDot", "The node is nil!")
    return
  end
  local haveRedDotType = type(node.haveRedDot)
  if haveRedDotType == "function" then
  elseif haveRedDotType == "boolean" then
    node.haveRedDot = true
  else
    LogErrorFormat("DM_RedDot", "Unkown haveRedDot type: %s!", haveRedDotType)
    return
  end
  if saveToLocal == true then
    DM_RedDot.SetRedDotUnreadWithNode(node)
  end
  if recursive == true then
    for _, value in pairs(node.childNode) do
      DM_RedDot.SetNodeUnread(value, saveToLocal, recursive)
    end
  end
end

DM_RedDot.nodeShop = nil
DM_RedDot.nodeChildShop = {}
DM_RedDot.shopTimeLimitTable = {
  [5] = BeanManager.GetTableByName("recharge.ccommoditlimitpackage"),
  [6] = BeanManager.GetTableByName("recharge.ccommoditclothes")
}
DM_RedDot.shopTimeLimitTableTimer = {}
DM_RedDot.shopTimeLimitTableHelper = {}
DM_RedDot.SServerTimeRechedObserver = {}
DM_RedDot.DoNextFuncTable = {}

function DM_RedDot.InitShopNodeTree()
  LuaNotificationCenter.AddObserver(DM_RedDot.SServerTimeRechedObserver, DM_RedDot._InitShopNodeTree, Common.n_SServerTimeReached)
end

function DM_RedDot._InitShopNodeTree()
  LuaNotificationCenter.RemoveObserver(DM_RedDot.SServerTimeRechedObserver, Common.n_SServerTimeReached)
  DM_RedDot.nodeShop = DM_RedDot.CreateNewNodeToTree("KeyShop")
  if not DM_RedDot.GetIDOpenFirst(DM_RedDot.nodeShop.nodeName) then
    DM_RedDot.nodeShop.haveRedDot = DM_RedDot.GetRedDotIsUnreadWithNode(DM_RedDot.nodeShop)
  end
  DM_RedDot.CreateShopTree()
  DM_RedDot.CreateFriendTree()
  DM_RedDot.CreateCourtYardTree()
  DM_RedDot.StartShopTimeLimitHandler1()
  for _, func in ipairs(DM_RedDot.DoNextFuncTable) do
    func()
  end
  for key, _ in ipairs(DM_RedDot.DoNextFuncTable) do
    DM_RedDot.DoNextFuncTable[key] = nil
  end
end

function DM_RedDot.CreateShopTree(firstAdd)
  local function doNext()
    local dailyGiftShop = DM_RedDot.CreateNewNodeToTree("KeyDailyGiftShop", DM_RedDot.nodeShop)
    
    dailyGiftShop.haveRedDot = DM_RedDot.GetRedDotIsUnreadWithNode(dailyGiftShop)
    if DM_RedDot.NowIsNewDay() then
      DM_RedDot.SetNodeUnread(dailyGiftShop, true)
    end
    local shopAccumulation = DM_RedDot.CreateNewNodeToTree("KeyHasAccumulationRewardToGet", DM_RedDot.nodeShop, function()
      return NekoData.BehaviorManager.BM_Shop:HasAccumulationRewardToGet()
    end)
    local shopFashionReward = DM_RedDot.CreateNewNodeToTree("KeyHasFashionRewardToGet", DM_RedDot.nodeShop, function()
      return NekoData.BehaviorManager.BM_SkinList:IsHasBoxReddot()
    end)
    DM_RedDot.nodeChildShop[4] = DM_RedDot.CreateNewNodeToTree("KeyChildShop4", DM_RedDot.nodeShop)
    DM_RedDot.CreateNewNodeToTree("ItemData", DM_RedDot.nodeChildShop[4])
    DM_RedDot.nodeChildShop[50] = DM_RedDot.CreateNewNodeToTree("KeyChildShop50", DM_RedDot.nodeShop)
    DM_RedDot.CreateNewNodeToTree("ItemData", DM_RedDot.nodeChildShop[50])
    DM_RedDot.nodeChildShop[5] = DM_RedDot.CreateNewNodeToTree("KeyChildShop5", DM_RedDot.nodeShop)
    if not DM_RedDot.GetIDOpenFirst(DM_RedDot.nodeChildShop[5].nodeName) then
      DM_RedDot.nodeChildShop[5].haveRedDot = DM_RedDot.GetRedDotIsUnreadWithNode(DM_RedDot.nodeChildShop[5])
    end
    DM_RedDot.CreateNewNodeToTree("ItemData", DM_RedDot.nodeChildShop[5])
    DM_RedDot.nodeChildShop[20] = DM_RedDot.CreateNewNodeToTree("KeyChildShop20", DM_RedDot.nodeShop)
    if not DM_RedDot.GetIDOpenFirst(DM_RedDot.nodeChildShop[20].nodeName) then
      DM_RedDot.nodeChildShop[20].haveRedDot = DM_RedDot.GetRedDotIsUnreadWithNode(DM_RedDot.nodeChildShop[20])
      if DM_RedDot.NowIsNewMonth() then
        DM_RedDot.SetNodeUnread(DM_RedDot.nodeChildShop[20], true)
      end
    end
    DM_RedDot.CreateNewNodeToTree("ItemData", DM_RedDot.nodeChildShop[20])
    DM_RedDot.nodeChildShop[62] = DM_RedDot.CreateNewNodeToTree("KeyChildShop62", DM_RedDot.nodeShop)
    DM_RedDot.CreateNewNodeToTree("ItemData", DM_RedDot.nodeChildShop[62])
    DM_RedDot.nodeChildShop[63] = DM_RedDot.CreateNewNodeToTree("KeyChildShop63", DM_RedDot.nodeShop)
    DM_RedDot.CreateNewNodeToTree("ItemData", DM_RedDot.nodeChildShop[63])
    DM_RedDot.nodeChildShop[64] = DM_RedDot.CreateNewNodeToTree("KeyChildShop64", DM_RedDot.nodeShop)
    DM_RedDot.CreateNewNodeToTree("ItemData", DM_RedDot.nodeChildShop[64])
    DM_RedDot.nodeChildShop[65] = DM_RedDot.CreateNewNodeToTree("KeyChildShop65", DM_RedDot.nodeShop)
    DM_RedDot.CreateNewNodeToTree("ItemData", DM_RedDot.nodeChildShop[65])
    DM_RedDot.nodeChildShop[46] = DM_RedDot.CreateNewNodeToTree("KeyChildShop46", DM_RedDot.nodeShop)
    DM_RedDot.nodeChildShop[46].haveRedDot = DM_RedDot.GetRedDotIsUnreadWithNode(DM_RedDot.nodeChildShop[46])
    if DM_RedDot.NowIsNewWeek() then
      DM_RedDot.SetNodeUnread(DM_RedDot.nodeChildShop[46], true)
    end
    DM_RedDot.CreateNewNodeToTree("ItemData", DM_RedDot.nodeChildShop[46])
    DM_RedDot.nodeChildShop[37] = DM_RedDot.CreateNewNodeToTree("KeyChildShop37", DM_RedDot.nodeShop)
    if not DM_RedDot.GetIDOpenFirst(DM_RedDot.nodeChildShop[37].nodeName) then
      DM_RedDot.nodeChildShop[37].haveRedDot = DM_RedDot.GetRedDotIsUnreadWithNode(DM_RedDot.nodeChildShop[37])
    end
    DM_RedDot.CreateNewNodeToTree("ItemData", DM_RedDot.nodeChildShop[37])
    DM_RedDot.nodeChildShop[6] = DM_RedDot.CreateNewNodeToTree("KeyChildShop6", DM_RedDot.nodeShop)
    if not DM_RedDot.GetIDOpenFirst(DM_RedDot.nodeChildShop[6].nodeName) then
      DM_RedDot.nodeChildShop[6].haveRedDot = DM_RedDot.GetRedDotIsUnreadWithNode(DM_RedDot.nodeChildShop[6])
    end
    DM_RedDot.CreateNewNodeToTree("ItemData", DM_RedDot.nodeChildShop[6])
    if firstAdd then
      DM_RedDot.SetNodeUnread(DM_RedDot.nodeShop)
      DM_RedDot.SetIDNotOpenFirst(DM_RedDot.nodeShop.nodeName)
      LuaNotificationCenter.PostNotification(Common.n_ShopRedPoint, nil, nil)
    end
  end
  
  if DM_RedDot.nodeShop == nil then
    table.insert(DM_RedDot.DoNextFuncTable, doNext)
  else
    doNext()
  end
end

function DM_RedDot.CreateFriendTree(firstAdd)
  local function doNext()
    DM_RedDot.nodeChildShop[9] = DM_RedDot.CreateNewNodeToTree("KeyChildShop9", DM_RedDot.nodeShop)
    
    if not DM_RedDot.GetIDOpenFirst(DM_RedDot.nodeChildShop[9].nodeName) then
      DM_RedDot.nodeChildShop[9].haveRedDot = DM_RedDot.GetRedDotIsUnreadWithNode(DM_RedDot.nodeChildShop[9])
    end
    if firstAdd then
      DM_RedDot.SetNodeUnread(DM_RedDot.nodeChildShop[9])
      DM_RedDot.SetIDNotOpenFirst(DM_RedDot.nodeChildShop[9].nodeName)
      LuaNotificationCenter.PostNotification(Common.n_ShopRedPoint, nil, nil)
    end
  end
  
  if DM_RedDot.nodeShop == nil then
    table.insert(DM_RedDot.DoNextFuncTable, doNext)
  else
    doNext()
  end
end

function DM_RedDot.CreateCourtYardTree(firstAdd)
  local function doNext()
    DM_RedDot.nodeChildShop[13] = DM_RedDot.CreateNewNodeToTree("KeyChildShop13", DM_RedDot.nodeShop)
    
    if not DM_RedDot.GetIDOpenFirst(DM_RedDot.nodeChildShop[13].nodeName) then
      DM_RedDot.nodeChildShop[13].haveRedDot = DM_RedDot.GetRedDotIsUnreadWithNode(DM_RedDot.nodeChildShop[13])
    end
    if firstAdd then
      DM_RedDot.SetNodeUnread(DM_RedDot.nodeChildShop[13])
      DM_RedDot.SetIDNotOpenFirst(DM_RedDot.nodeChildShop[13].nodeName)
      LuaNotificationCenter.PostNotification(Common.n_ShopRedPoint, nil, nil)
    end
  end
  
  if DM_RedDot.nodeShop == nil then
    table.insert(DM_RedDot.DoNextFuncTable, doNext)
  else
    doNext()
  end
end

function DM_RedDot.DestoryShopNodeTree()
  if DM_RedDot.nodeShop then
    DM_RedDot.ClearNodeChild(DM_RedDot.nodeShop)
    DM_RedDot.nodeShop.fatherNode.childNode[DM_RedDot.nodeShop.nodeIndex] = nil
    DM_RedDot.nodeShop = nil
  end
  for key, _ in pairs(DM_RedDot.nodeChildShop) do
    DM_RedDot.nodeChildShop[key] = nil
  end
  for key, _ in pairs(DM_RedDot.shopTimeLimitTableTimer) do
    ServerGameTimer.RemoveTask(DM_RedDot.shopTimeLimitTableTimer[key])
    DM_RedDot.shopTimeLimitTableTimer[key] = nil
  end
  for key, _ in pairs(DM_RedDot.shopTimeLimitTableHelper) do
    DM_RedDot.shopTimeLimitTableHelper[key] = nil
  end
  for key, _ in pairs(DM_RedDot.DoNextFuncTable) do
    DM_RedDot.DoNextFuncTable[key] = nil
  end
end

function DM_RedDot.GetIDOpenFirst(id)
  return DM_RedDot._GetRedDotIsUnreadWithKey("IDOpenFirst_", id)
end

function DM_RedDot.SetIDNotOpenFirst(id)
  DM_RedDot._SetRedDotReadWithKey("IDOpenFirst_", id)
end

function DM_RedDot.OnSShopRedPointNotify(protocol)
  for _, value in pairs(protocol.freeRedPointList) do
    local function doNext()
      DM_RedDot.SetNodeUnread(DM_RedDot.nodeChildShop[value], true)
    end
    
    if DM_RedDot.nodeShop == nil then
      table.insert(DM_RedDot.DoNextFuncTable, doNext)
    else
      doNext()
    end
  end
  for _, value in pairs(protocol.redPointList) do
    if not DM_RedDot.GetIDOpenFirst(DM_RedDot.nodeChildShop[value].nodeName) then
      local function doNext()
        DM_RedDot.SetNodeUnread(DM_RedDot.nodeChildShop[value], true)
      end
      
      if DM_RedDot.nodeShop == nil then
        table.insert(DM_RedDot.DoNextFuncTable, doNext)
      else
        doNext()
      end
    end
  end
  LuaNotificationCenter.PostNotification(Common.n_ShopRedPoint, nil, nil)
end

function DM_RedDot.OnSCheckShopRedpoint(protocol)
  LogInfoFormat("DM_RedDot", "SCheckShopRedpoint: %s", table.concat({
    protocol.shoptype,
    "|",
    protocol.goodId,
    "|",
    protocol.canDo
  }))
  if protocol.canDo == 1 then
    DM_RedDot.SetNodeUnread(DM_RedDot.nodeChildShop[protocol.shoptype], true)
    LuaNotificationCenter.PostNotification(Common.n_ShopRedPoint, nil, nil)
  end
end

function DM_RedDot.StartShopTimeLimitHandler1()
  local nowTime = ServerGameTimer.GetServerTimeForecast() // 1000
  for key, value in pairs(DM_RedDot.shopTimeLimitTable) do
    for _, value2 in pairs(value:GetAllIds()) do
      local rec = value:GetRecorder(value2)
      if rec.OpenTime ~= "0" and rec.CloseTime ~= "0" then
        local openTime = os.time(DM_RedDot.ParseTimeStr(rec.OpenTime))
        local closeTime = os.time(DM_RedDot.ParseTimeStr(rec.CloseTime))
        if nowTime < openTime then
          table.insert(DM_RedDot.shopTimeLimitTableHelper, {
            shopID = key,
            goodID = rec.id,
            openTime = openTime
          })
        elseif nowTime < closeTime then
          local tempNode = DM_RedDot.CreateNewNodeToTree(rec.id, DM_RedDot.nodeChildShop[key].childNode.ItemData)
          tempNode.haveRedDot = DM_RedDot.GetRedDotIsUnreadWithNode(tempNode)
          if DM_RedDot.GetNodeResult(tempNode) then
            LogInfoFormat("DM_RedDot", "CCheckShopRedpoint: %s", table.concat({
              key,
              "|",
              rec.id
            }))
            local protocol = LuaNetManager.CreateProtocol("protocol.shop.ccheckshopredpoint")
            protocol.shoptype = key
            protocol.goodId = rec.id
            protocol:Send()
          end
          DM_RedDot.nodeChildShop[key].childNode.ItemData.childNode[tempNode.nodeIndex] = nil
        end
      end
    end
  end
  table.sort(DM_RedDot.shopTimeLimitTableHelper, function(a, b)
    return a.openTime < b.openTime
  end)
  DM_RedDot.StartShopTimeLimitHandler2()
end

function DM_RedDot.StartShopTimeLimitHandler2()
  local nowTime = ServerGameTimer.GetServerTimeForecast() // 1000
  local nearlestTime
  local tempTable1 = {}
  local tempTable2 = {}
  for _, value in ipairs(DM_RedDot.shopTimeLimitTableHelper) do
    if nearlestTime == nil then
      nearlestTime = value.openTime
    end
    if nearlestTime == value.openTime then
      table.insert(tempTable1, value)
    else
      table.insert(tempTable2, value)
    end
  end
  DM_RedDot.shopTimeLimitTableHelper = tempTable2
  if 0 < #tempTable1 then
    local timerID = ServerGameTimer.AddTask(os.difftime(nearlestTime, nowTime), -1, function()
      local protocol = LuaNetManager.CreateProtocol("protocol.shop.ccheckshopredpoint")
      if protocol then
        for _, value in ipairs(tempTable1) do
          LogInfoFormat("DM_RedDot", "CCheckShopRedpoint: %s", table.concat({
            value.shopID,
            "|",
            value.goodID
          }))
          protocol.shoptype = value.shopID
          protocol.goodId = value.goodID
          protocol:Send()
        end
      end
      DM_RedDot.StartShopTimeLimitHandler2()
    end)
    table.insert(DM_RedDot.shopTimeLimitTableTimer, timerID)
  end
end

return DM_RedDot
