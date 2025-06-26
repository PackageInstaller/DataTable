-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/behaviormanager/bm_offlinesweep.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local BM_OfflineSweep = class("BM_OfflineSweep")
local CBattleStartProtocol = require("protocols.def.protocol.battle.cbattlestart")
local CResourceDungeonStage = (BeanManager.GetTableByName)("dungeonselect.cresourcedungeonstage")
local CSRResourceDungeonStage = (BeanManager.GetTableByName)("activity.csrresourcedungeonstage")
local CSRFunction = (BeanManager.GetTableByName)("activity.csrfunction")
local CStarrymirrorlevel = (BeanManager.GetTableByName)("dungeonselect.cstarrymirrorlevel")
local ItemTypeEnum = (LuaNetManager.GetBeanDef)("protocol.item.beans.item")
local Item = require("logic.manager.experimental.types.item")
local Equip = require("logic.manager.experimental.types.equip")
local Skill = require("logic.manager.experimental.types.skill")
local GetDelTimeStr = function(ms)
  -- function num : 0_0 , upvalues : _ENV
  local sec = ms // 1000
  return (string.format)("%s:%s:%s", (os.date)("!%H", sec), (os.date)("!%M", sec), (os.date)("!%S", sec))
end

BM_OfflineSweep.Ctor = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self._data = (NekoData.Data).offlineSweep
end

BM_OfflineSweep.GetStatus = function(self)
  -- function num : 0_2
  return (self._data).status or 0
end

BM_OfflineSweep.GetTimeStr = function(self)
  -- function num : 0_3 , upvalues : GetDelTimeStr
  local ms = ((self._data).process).leftTime or 0
  return GetDelTimeStr(ms)
end

BM_OfflineSweep.GetProcessNum = function(self)
  -- function num : 0_4
  return {((self._data).process).currentTime, ((self._data).process).totalNum}
end

BM_OfflineSweep.GetLevelInfo = function(self)
  -- function num : 0_5 , upvalues : CBattleStartProtocol, CResourceDungeonStage, _ENV, CStarrymirrorlevel, CSRFunction, CSRResourceDungeonStage
  local result = {}
  if ((self._data).process).battleType == CBattleStartProtocol.RESOURCE then
    local record = CResourceDungeonStage:GetRecorder(((self._data).process).id)
    result = {name = (TextManager.GetText)(record.typeNameTextID), littleImg = record.imageID}
  else
    do
      if ((self._data).process).battleType == CBattleStartProtocol.STARRY_MIRROR then
        local record = CStarrymirrorlevel:GetRecorder(((self._data).process).id)
        result = {name = (TextManager.GetText)(record.leveltitle) .. " " .. (TextManager.GetText)(record.levelname)}
      else
        do
          if ((self._data).process).battleType == CBattleStartProtocol.SUMMER_ECHO then
            local tempRecord = CSRFunction:GetRecorder(((self._data).process).id)
            local record = CSRResourceDungeonStage:GetRecorder(tempRecord.levelID)
            result = {name = (TextManager.GetText)(record.nameID)}
          end
          do
            return result
          end
        end
      end
    end
  end
end

BM_OfflineSweep.GetAwardResult = function(self)
  -- function num : 0_6
  return (self._data).roleExp, (self._data).roleGoodExp, (self._data).rolesIndex, (self._data).playerExp
end

BM_OfflineSweep.GetAccountBag = function(self)
  -- function num : 0_7 , upvalues : _ENV, ItemTypeEnum, Item, Equip, Skill
  if (self._data).awardList then
    local itemList = {}
    local awardItems = (self._data).awardList
    for _,itemInfo in ipairs(awardItems) do
      local item = nil
      if itemInfo.gain == 1 then
        if itemInfo.itemtype == ItemTypeEnum.BASEITEM then
          item = ((NekoData.BehaviorManager).BM_BagInfo):GetItem(itemInfo.id)
        else
          if itemInfo.itemtype == ItemTypeEnum.EQUIP then
            item = ((NekoData.BehaviorManager).BM_BagInfo):GetEquipItem(itemInfo.id)
          end
        end
      else
        if itemInfo.itemtype == ItemTypeEnum.BASEITEM then
          item = (Item.Create)(itemInfo.id)
        else
          if itemInfo.itemtype == ItemTypeEnum.EQUIP then
            item = (Equip.Create)(itemInfo.id)
          else
            if itemInfo.itemtype == ItemTypeEnum.SKILL then
              item = (Skill.Create)(itemInfo.id)
            end
          end
        end
        item:InitWithItemInfo(itemInfo)
      end
      ;
      (table.insert)(itemList, {item = item, num = itemInfo.number})
    end
    return itemList
  end
  do
    return {}
  end
end

BM_OfflineSweep.GetMoneyData = function(self)
  -- function num : 0_8
  if not (self._data).currency then
    return {}
  end
end

BM_OfflineSweep.GetRestituteReward = function(self)
  -- function num : 0_9
  if not (self._data).restituteReward then
    return {}
  end
end

BM_OfflineSweep.GetTodayLeftNum = function(self)
  -- function num : 0_10
  return (self._data).leftNum
end

BM_OfflineSweep.IsCanReceive = function(self)
  -- function num : 0_11
  do return ((self._data).process).receivedNum < ((self._data).process).currentTime end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

return BM_OfflineSweep

