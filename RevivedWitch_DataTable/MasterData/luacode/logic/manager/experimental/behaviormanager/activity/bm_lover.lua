-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/behaviormanager/activity/bm_lover.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local BM_Lover = class("BM_Lover")
local CInterfaceFunction = (BeanManager.GetTableByName)("dungeonselect.cvalentineinterfacefunction")
local CInterEntry = (BeanManager.GetTableByName)("dungeonselect.cvalentineinterentry")
local CLoverLines = (BeanManager.GetTableByName)("activity.cvalentinelines")
local CLoverActivityEvent = require("protocols.def.protocol.activity.cloveractivityevent")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local Item = require("logic.manager.experimental.types.item")
BM_Lover.LineFuncitionType = {Store = 1, FlowerLeft = 2, FlowerRight = 3}
local PlayerPrefs = (CS.UnityEngine).PlayerPrefs
local RedPointPrefix = "LoverRedPoint"
local RedPointStatus = {UNREAD = 0, READ = 1}
BM_Lover.RedPointKey = {Banner = "Banner", Shop = "Shop", ShopChocolateTab = "ShopChocolateTab", Store = "Store", Flower = "Flower", Chocolate = "Chocolate"}
BM_Lover.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self._data = ((NekoData.Data).activities).lover
  self._lineList = {}
end

BM_Lover.OnDoorClick = function(self, Id)
  -- function num : 0_1 , upvalues : _ENV, CInterfaceFunction, CLoverActivityEvent
  local eventIds, locked = nil, nil
  for i,v in ipairs((self._data).constructions) do
    if v.ID == Id then
      eventIds = v.event
      locked = v.locked
      break
    end
  end
  do
    if #eventIds < 1 then
      LogErrorFormat("BM_Lover", "Click Null Door :%s", Id)
      return 
    end
    local type = (CInterfaceFunction:GetRecorder(eventIds[1])).type
    if type == CLoverActivityEvent.MAINLINE_BATTLE then
      local dialog = (DialogManager.CreateSingletonDialog)("activity.lover.loverstorybattledialog")
      dialog:SetData({functionID = eventIds[1], constructionID = Id})
    else
      do
        if type == CLoverActivityEvent.COMMON_BATTLE then
          local dialog = (DialogManager.CreateSingletonDialog)("activity.lover.loverbattledialog")
          dialog:SetData({functionIDs = eventIds, constructionID = Id, locked = locked})
        else
          do
            if type == CLoverActivityEvent.MAINLINE_PLOT then
              local dialog = (DialogManager.CreateSingletonDialog)("activity.lover.loverstorymaindialog")
              dialog:SetData({functionID = eventIds[1], constructionID = Id})
            end
          end
        end
      end
    end
  end
end

BM_Lover.GetConstructions = function(self)
  -- function num : 0_2
  return (self._data).constructions
end

BM_Lover.HasFinishBlockBattle = function(self, Id, EventID)
  -- function num : 0_3 , upvalues : _ENV
  for i,v in ipairs((self._data).constructions) do
    if Id == v.ID then
      return (table.contain)(v.autoExplore, EventID)
    end
  end
end

BM_Lover.ShowRedDot = function(self)
  -- function num : 0_4
  return self:GetRedPointWithLocalKey((self.RedPointKey).Banner)
end

BM_Lover.CheckFunctionUnLock = function(self, type)
  -- function num : 0_5 , upvalues : CLoverActivityEvent
  do return (((type ~= CLoverActivityEvent.ITEM_SHOP or ((self._data).Function).ItemShop ~= 1) and (type ~= CLoverActivityEvent.CHOCOLATE or ((self._data).Function).Chocolate ~= 1) and (type ~= CLoverActivityEvent.FLOWER_LIST or ((self._data).Function).Flowers ~= 1) and (type == CLoverActivityEvent.DIALOGUE_STORE and ((self._data).Function).DialogueStore == 1))) end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

BM_Lover.GetChocolateEntry = function(self)
  -- function num : 0_6
  return (self._data).ChocolateEntry
end

BM_Lover.GetRandomLine = function(self, functionType, condition)
  -- function num : 0_7 , upvalues : _ENV, CLoverLines
  local lineList = self._lineList
  if #lineList == 0 then
    for _,v in ipairs(CLoverLines:GetAllIds()) do
      local recorder = CLoverLines:GetRecorder(v)
      if not lineList[recorder.type] then
        lineList[recorder.type] = {}
      end
      -- DECOMPILER ERROR at PC31: Confused about usage of register: R10 in 'UnsetPending'

      if not (lineList[recorder.type])[recorder.condition] then
        (lineList[recorder.type])[recorder.condition] = {}
      end
      ;
      (table.insert)((lineList[recorder.type])[recorder.condition], recorder.textId)
    end
    self._lineList = lineList
  end
  if lineList[functionType] and (lineList[functionType])[condition] then
    local length = #(lineList[functionType])[condition]
    local id = (math.random)(1, length)
    return ((lineList[functionType])[condition])[id]
  else
    do
      do return 0 end
    end
  end
end

BM_Lover.GetFlowerEntry = function(self)
  -- function num : 0_8
  return (self._data).FlowerEntry
end

BM_Lover.GetRedPointWithState = function(self, state)
  -- function num : 0_9
  return ((self._data).redPoint)[state]
end

BM_Lover.SetRedPointWithState = function(self, state, flag)
  -- function num : 0_10 , upvalues : _ENV
  LogInfoFormat("BM_Lover", "set redPoint[%s] = %s", state, flag)
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self._data).redPoint)[state] = flag
end

BM_Lover.GetRedPointWithLocalKey = function(self, key)
  -- function num : 0_11 , upvalues : _ENV, PlayerPrefs, RedPointPrefix, RedPointStatus
  local userid = (((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()).userid
  local result = (PlayerPrefs.GetInt)((table.concat)({userid, RedPointPrefix, key}, "."), RedPointStatus.UNREAD) == RedPointStatus.UNREAD
  LogInfoFormat("BM_Lover", "get redPoint local key %s state %s", key, result)
  do return result end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

BM_Lover.SetRedPointWithLocalKey = function(self, key)
  -- function num : 0_12 , upvalues : _ENV, PlayerPrefs, RedPointPrefix, RedPointStatus
  LogInfoFormat("BM_Lover", "set redPoint local key %s", key)
  local userid = (((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()).userid
  ;
  (PlayerPrefs.SetInt)((table.concat)({userid, RedPointPrefix, key}, "."), RedPointStatus.READ)
end

return BM_Lover

