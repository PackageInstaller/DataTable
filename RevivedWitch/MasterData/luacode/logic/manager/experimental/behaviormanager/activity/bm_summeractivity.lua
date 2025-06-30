-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/behaviormanager/activity/bm_summeractivity.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CHexagonland = (BeanManager.GetTableByName)("activity.chexagonland")
local CSwimSuitTimeCfg = (BeanManager.GetTableByName)("activity.cswimsuittimecfg")
local CHexagonFunction = (BeanManager.GetTableByName)("activity.chexagonfunction")
local CSummerActivityEvent = require("protocols.def.protocol.activity.csummeractivityevent")
local BM_SummerActivity = class("BM_SummerActivity")
BM_SummerActivity.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self._data = ((NekoData.Data).activities).summerActivity
end

BM_SummerActivity.OnBlockClick = function(self, Id)
  -- function num : 0_1 , upvalues : _ENV, CHexagonland, CHexagonFunction, CSummerActivityEvent
  if Id == 0 or (DialogManager.GetDialog)("dungeon.battlecrossdialog") then
    return 
  end
  local recorder = CHexagonland:GetRecorder(Id)
  if not recorder then
    LogErrorFormat("BM_SummerActivity", "CHexagonland Cannt Find ID %s", Id)
  end
  local eventIds, constructionLevel, canlvup, event2lock, locked = nil, nil, nil, nil, nil
  for i,v in ipairs((self._data).constructions) do
    if v.ID == Id then
      eventIds = v.event
      constructionLevel = v.level
      canlvup = v.canlvup == 1
      event2lock = v.event2lock
      locked = v.locked
      break
    end
  end
  if #eventIds < 1 then
    return 
  end
  local type = (CHexagonFunction:GetRecorder(eventIds[1])).type
  if type == CSummerActivityEvent.MAINLINE_DRAMA then
    local dialog = (DialogManager.CreateSingletonDialog)("activity.swimsuit.swimsuitstorymiandialog")
    dialog:SetData({functionID = eventIds[1], constructionID = Id})
  elseif type == CSummerActivityEvent.MAINLINE_BATTLE then
    local dialog = (DialogManager.CreateSingletonDialog)("activity.swimsuit.swimsuitstorybattledialog")
    dialog:SetData({functionID = eventIds[1], constructionID = Id})
  elseif type == CSummerActivityEvent.SIDE_DRAMA then
    local dialog = (DialogManager.CreateSingletonDialog)("activity.swimsuit.swimsuitstorybranchdialog")
    dialog:SetData({functionID = eventIds[1], constructionID = Id})
  elseif type == CSummerActivityEvent.FREEDOM_BATTLE then
    local dialog = (DialogManager.CreateSingletonDialog)("activity.swimsuit.swimsuitbattledialog")
    dialog:SetData({functionIDs = eventIds, constructionID = Id, event2lock = event2lock, locked = locked, constructionLevel = constructionLevel})
  elseif type == CSummerActivityEvent.SUMMER_SHOP then
    local dialogName = "activity.swimsuit.buydialog"
    local dialog = (DialogManager.GetDialog)(dialogName)
    if not dialog then
      dialog = (DialogManager.CreateSingletonDialog)(dialogName)
    end
    dialog:SetData({functionID = eventIds[1], constructionID = Id, constructionLevel = constructionLevel, canLevelUp = canlvup})
  elseif type == CSummerActivityEvent.SUMMER_SNACK then
    local dialog = (DialogManager.CreateSingletonDialog)("activity.swimsuit.swimsuitfoodstallsshowdialog")
    dialog:SetData({functionID = eventIds[1], constructionID = Id})
  elseif type == CSummerActivityEvent.WATERMELON then
    local dialogName = "activity.swimsuit.xiguadialog"
    local dialog = (DialogManager.GetDialog)(dialogName)
    if not dialog then
      dialog = (DialogManager.CreateSingletonDialog)(dialogName)
    end
    dialog:SetData({functionIDs = eventIds, constructionID = Id, constructionLevel = constructionLevel, canLevelUp = canlvup})
  elseif type == CSummerActivityEvent.DISPLAY_ROOM then
    local dialogName = "activity.swimsuit.showdialog"
    local dialog = (DialogManager.GetDialog)(dialogName)
    if not dialog then
      dialog = (DialogManager.CreateSingletonDialog)(dialogName)
    end
    dialog:SetData({functionID = eventIds[1], constructionID = Id, constructionLevel = constructionLevel})
  end
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_COnBlockClick, nil, Id)
  -- DECOMPILER ERROR: 15 unprocessed JMP targets
end

BM_SummerActivity.GetTimeProgress = function(self)
  -- function num : 0_2
  return (self._data).timeProgress
end

BM_SummerActivity.GetTimeProgressMax = function(self)
  -- function num : 0_3
  return ((self._data).timeRecorder).timePointMax
end

BM_SummerActivity.GetState = function(self)
  -- function num : 0_4
  return (self._data).state
end

BM_SummerActivity.GetPreState = function(self)
  -- function num : 0_5
  return (self._data).state_Old
end

BM_SummerActivity.GetMissions = function(self)
  -- function num : 0_6 , upvalues : _ENV
  (table.sort)((self._data).missions, function(a, b)
    -- function num : 0_6_0
    do return b.ID < a.ID end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  return (self._data).missions
end

BM_SummerActivity.GetConstructions = function(self)
  -- function num : 0_7
  return (self._data).constructions
end

BM_SummerActivity.HasFinishBlockBattle = function(self, Id, EventID)
  -- function num : 0_8 , upvalues : _ENV
  for i,v in ipairs((self._data).constructions) do
    if Id == v.ID then
      return (table.contain)(v.autoExplore, EventID)
    end
  end
end

BM_SummerActivity.GetShopConstructionList = function(self)
  -- function num : 0_9
  return (self._data).shopConstructionList
end

BM_SummerActivity.GetStorageConstructionList = function(self)
  -- function num : 0_10
  return (self._data).storageConstructionList
end

BM_SummerActivity.IsDayTime = function(self)
  -- function num : 0_11
  do return ((self._data).timeRecorder).dayOrNight == 1 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

BM_SummerActivity.BlockHasEvent = function(self, ID)
  -- function num : 0_12 , upvalues : _ENV
  for i,v in ipairs((self._data).constructions) do
    -- DECOMPILER ERROR at PC17: Unhandled construct in 'MakeBoolean' P1

    if v.event and #v.event <= 0 then
      do
        do return v.ID ~= ID end
        -- DECOMPILER ERROR at PC18: LeaveBlock: unexpected jumping out IF_THEN_STMT

        -- DECOMPILER ERROR at PC18: LeaveBlock: unexpected jumping out IF_STMT

      end
    end
  end
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

BM_SummerActivity.CanBuyBuildings = function(self)
  -- function num : 0_13
  do return (self._data).constructionRedpoint == 1 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

BM_SummerActivity.GetSnackData = function(self)
  -- function num : 0_14
  return (self._data).foodStallsData
end

BM_SummerActivity.GetSnacRedpoint = function(self)
  -- function num : 0_15 , upvalues : _ENV
  if (self._data).snackRedpoint ~= 1 then
    do return next((self._data).foodStallsData) ~= nil end
    do return ((self._data).foodStallsData).isOpen == 1 and ((self._data).foodStallsData).used == 0 end
    -- DECOMPILER ERROR: 5 unprocessed JMP targets
  end
end

BM_SummerActivity.GetIsOpen = function(self)
  -- function num : 0_16 , upvalues : _ENV
  return ((NekoData.BehaviorManager).BM_Activity):IsActivityOpenById(21)
end

BM_SummerActivity.GetFreeRedDot = function(self)
  -- function num : 0_17
  return (self._data).freeReddot
end

BM_SummerActivity.KillFreeRedDot = function(self)
  -- function num : 0_18
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R1 in 'UnsetPending'

  (self._data).freeReddot = false
end

BM_SummerActivity.HaveRedDot = function(self)
  -- function num : 0_19
  return (self._data).freeReddot
end

BM_SummerActivity.ShowRedDot = function(self)
  -- function num : 0_20
  if not self:GetIsOpen() then
    return false
  end
  return self:HaveRedDot()
end

return BM_SummerActivity

