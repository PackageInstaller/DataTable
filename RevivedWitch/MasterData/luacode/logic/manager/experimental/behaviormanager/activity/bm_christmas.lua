-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/behaviormanager/activity/bm_christmas.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local BM_Christmas = class("BM_Christmas")
local CInterfaceFunction = (BeanManager.GetTableByName)("dungeonselect.cinterfacefunction")
local CInterEntry = (BeanManager.GetTableByName)("dungeonselect.cinterentry")
local CChristmasActivityEvent = require("protocols.def.protocol.activity.cchristmasactivityevent")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local Item = require("logic.manager.experimental.types.item")
local CChriscorresponding = (BeanManager.GetTableByName)("dungeonselect.cchriscorresponding")
BM_Christmas.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self._data = ((NekoData.Data).activities).christmas
end

local DoorScoreLimit = function(Id)
  -- function num : 0_1 , upvalues : CInterEntry, _ENV, Item
  local recorder = CInterEntry:GetRecorder(Id)
  if not recorder then
    LogErrorFormat("BM_Christmas", "CInterEntry Cannt Find ID %s", Id)
  end
  local curNum = 0
  local locklist = {}
  local limit = 0
  local islock = false
  local outStr = ""
  for i,v in ipairs(recorder.itemID) do
    local params = {}
    local currencyItem = nil
    if v == DataCommon.ChristmasSing then
      curNum = (((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.ChristmasActivityManagerID)):GetScoreByType(DataCommon.ChristmasSing)
      currencyItem = (Item.Create)(DataCommon.ChristmasSing)
    else
      if v == DataCommon.ChristmasJump then
        curNum = (((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.ChristmasActivityManagerID)):GetScoreByType(DataCommon.ChristmasJump)
        currencyItem = (Item.Create)(DataCommon.ChristmasJump)
      else
        if v == DataCommon.ChristmasExpressiveForce then
          curNum = (((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.ChristmasActivityManagerID)):GetScoreByType(DataCommon.ChristmasExpressiveForce)
          currencyItem = (Item.Create)(DataCommon.ChristmasExpressiveForce)
        else
          LogErrorFormat("BM_Christmas", "CInterEntry itemID Exist Error ItemId:%s", v)
          return false
        end
      end
    end
    if curNum < (recorder.itemAmount)[i] then
      islock = true
      ;
      (table.insert)(params, currencyItem:GetName())
      ;
      (table.insert)(params, (recorder.itemAmount)[i])
      local msgRecord = ((BeanManager.GetTableByName)("message.cmessagetip")):GetRecorder(100435)
      local str = (TextManager.GetText)(msgRecord.msgTextID)
      if params then
        local num = 1
        for _,i in pairs(params) do
          str = (string.gsub)(str, "%$parameter1%$", params[num], 1)
          num = num + 1
        end
      end
      do
        do
          if outStr == "" then
            outStr = str
          else
            outStr = outStr .. "\n\n" .. str
          end
          -- DECOMPILER ERROR at PC149: LeaveBlock: unexpected jumping out DO_STMT

          -- DECOMPILER ERROR at PC149: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC149: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
  end
  if islock then
    ((NekoData.BehaviorManager).BM_Message):AddConfirmTip(outStr)
  end
  return islock
end

BM_Christmas.OnDoorClick = function(self, Id)
  -- function num : 0_2 , upvalues : DoorScoreLimit, _ENV, CInterfaceFunction, CChristmasActivityEvent, CChriscorresponding, Item
  local lock = DoorScoreLimit(Id)
  if lock then
    return 
  end
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
      LogErrorFormat("BM_Christmas", "Click Null Door :%s", Id)
      return 
    end
    local type = (CInterfaceFunction:GetRecorder(eventIds[1])).type
    if type == CChristmasActivityEvent.MAINLINE_BATTLE then
      local dialog = (DialogManager.CreateSingletonDialog)("activity.christmas.christmasstorybattledialog")
      dialog:SetData({functionID = eventIds[1], constructionID = Id})
    else
      do
        if type == CChristmasActivityEvent.COMMON_BATTLE then
          local dialog = (DialogManager.CreateSingletonDialog)("activity.christmas.christmasbattledialog")
          dialog:SetData({functionIDs = eventIds, constructionID = Id, locked = locked})
        else
          do
            if type == CChristmasActivityEvent.MAINLINE_PLOT then
              local dialog = (DialogManager.CreateSingletonDialog)("activity.christmas.christmasstorymaindialog")
              dialog:SetData({functionID = eventIds[1], constructionID = Id})
            else
              do
                if type == CChristmasActivityEvent.BRANCH_PLOT then
                  if #eventIds == 3 then
                    local dialog = (DialogManager.CreateSingletonDialog)("activity.christmas.christmasstorybranchdialog")
                    dialog:SetData({functionID = eventIds, constructionID = Id})
                  else
                    do
                      ;
                      ((NekoData.BehaviorManager).BM_Message):SendMessageById(100442)
                      if type == CChristmasActivityEvent.CHRISTMAS_DINNER then
                        local dialog = (DialogManager.CreateSingletonDialog)("activity.christmas.christmasfoodstallsshowdialog")
                        dialog:SetData({functionID = eventIds[1], constructionID = Id})
                      else
                        do
                          if type == CChristmasActivityEvent.TOP_LEVEL then
                            local csend = (LuaNetManager.CreateProtocol)("protocol.activity.cchristmasactivityevent")
                            csend.constructionID = Id
                            csend.eventID = eventIds[1]
                            csend:Send()
                          else
                            do
                              if type == CChristmasActivityEvent.END_PLOT then
                                local rec = CChriscorresponding:GetRecorder(Id)
                                if rec and rec.itemNum <= self:GetScoreByType(rec.itemId) then
                                  local dialog = (DialogManager.CreateSingletonDialog)("activity.christmas.christmasstoryendscoredialog")
                                  dialog:SetData({functionID = eventIds[1], constructionID = Id})
                                else
                                  do
                                    local currencyItem = (Item.Create)(rec.itemId)
                                    do
                                      local name = currencyItem:GetName()
                                      ;
                                      ((NekoData.BehaviorManager).BM_Message):SendMessageById(100437, {name, rec.itemNum})
                                      if type == CChristmasActivityEvent.COMMON_TOWER then
                                        local dialog = (DialogManager.CreateSingletonDialog)("activity.christmas.christmasstorybattledialog")
                                        dialog:SetData({functionID = eventIds[1], constructionID = Id})
                                      else
                                        do
                                          if type == CChristmasActivityEvent.COMMON_BOSS then
                                            local csend = (LuaNetManager.CreateProtocol)("protocol.activity.copenhardboss")
                                            csend:Send()
                                            local dialog = (DialogManager.CreateSingletonDialog)("activity.christmas.christmasbossdialog")
                                            dialog:SetData({functionIDs = eventIds, constructionID = Id, locked = locked})
                                          else
                                            do
                                              if type == CChristmasActivityEvent.RANKING_BOSS then
                                                local dialog = (DialogManager.CreateSingletonDialog)("activity.christmas.christmasbossdialog")
                                                dialog:SetData({functionIDs = eventIds, constructionID = Id, locked = locked})
                                              end
                                            end
                                          end
                                        end
                                      end
                                    end
                                  end
                                end
                              end
                            end
                          end
                        end
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end

BM_Christmas.GetExistConstructionsByID = function(self, doorId)
  -- function num : 0_3 , upvalues : _ENV
  for i,v in ipairs((self._data).constructions) do
    if doorId == v.doorID and next(v.event) ~= nil then
      return v
    end
  end
end

BM_Christmas.GetConstructions = function(self)
  -- function num : 0_4
  return (self._data).constructions
end

BM_Christmas.HasFinishBlockBattle = function(self, Id, EventID)
  -- function num : 0_5 , upvalues : _ENV
  for i,v in ipairs((self._data).constructions) do
    if Id == v.ID then
      return (table.contain)(v.autoExplore, EventID)
    end
  end
end

BM_Christmas.IsUnlockShop = function(self)
  -- function num : 0_6
  do return ((self._data).Function).Shop == 1 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

BM_Christmas.IsUnlockBag = function(self)
  -- function num : 0_7
  do return ((self._data).Function).Bag == 1 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

BM_Christmas.IsUnlockMail = function(self)
  -- function num : 0_8
  do return ((self._data).Function).Mail == 1 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

BM_Christmas.IsUnlockBook = function(self)
  -- function num : 0_9
  do return ((self._data).Function).Book == 1 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

BM_Christmas.GetSnackData = function(self)
  -- function num : 0_10
  return (self._data).foodStallsData
end

BM_Christmas.GetSnacRedpoint = function(self)
  -- function num : 0_11
  do return (self._data).snackRedpoint == 1 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

BM_Christmas.ShowMailRedDot = function(self)
  -- function num : 0_12
  return (self._data).showMailRedPoint
end

BM_Christmas.ShowScoreRedDot = function(self)
  -- function num : 0_13
  return (self._data).showScoreRedPoint
end

BM_Christmas.ShowRedDot = function(self)
  -- function num : 0_14
  if not self:ShowMailRedDot() and not self:ShowScoreRedDot() then
    return self:GetSnacRedpoint()
  end
end

BM_Christmas.GetScoreByType = function(self, type)
  -- function num : 0_15 , upvalues : _ENV
  local data = ((self._data).scoreData)[type]
  if data then
    return data.score
  else
    LogErrorFormat("BM_Christmas", "scoreType: %s is error.", type)
  end
end

BM_Christmas.GetScoreAwardListByType = function(self, type)
  -- function num : 0_16 , upvalues : _ENV
  local data = ((self._data).scoreData)[type]
  if data then
    local list = {}
    for k,v in pairs(data.awards) do
      (table.insert)(list, v)
    end
    ;
    (table.sort)(list, function(a, b)
    -- function num : 0_16_0
    do return (a.record).id < (b.record).id end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
    return list
  else
    do
      LogErrorFormat("BM_Christmas", "scoreType: %s is error.", type)
    end
  end
end

BM_Christmas.ShowRedDotByType = function(self, type)
  -- function num : 0_17 , upvalues : _ENV
  local data = ((self._data).scoreData)[type]
  if data then
    return data.showRedDot
  else
    LogErrorFormat("BM_Christmas", "scoreType: %s is error.", type)
  end
end

BM_Christmas.GetRolesStatusByRoleID = function(self, id)
  -- function num : 0_18
  return ((self._data).roleStatus)[id]
end

BM_Christmas.GetBuffInfo = function(self, id)
  -- function num : 0_19
  return (self._data).buffInfo
end

BM_Christmas.GetCanGetBuffNum = function(self)
  -- function num : 0_20 , upvalues : _ENV
  local ChrisFrameCfg = (BeanManager.GetTableByName)("dungeonselect.cchrisframeconfig")
  local result = {3, 3, 3}
  for k,v in pairs((self._data).buffInfo) do
    local recorder = ChrisFrameCfg:GetRecorder(k)
    if v == 1 and recorder then
      result[recorder.type] = result[recorder.type] - 1
    end
  end
  return result
end

BM_Christmas.GetSChristmasBossTimes = function(self)
  -- function num : 0_21
  return (self._data).bossTimes
end

BM_Christmas.GetCanEnterSecond = function(self)
  -- function num : 0_22
  return (self._data).canEnterSecond
end

return BM_Christmas

