local BM_OfflineSweep = class("BM_OfflineSweep")
local CBattleStartProtocol = require("protocols.def.protocol.battle.cbattlestart")
local CResourceDungeonStage = BeanManager.GetTableByName("dungeonselect.cresourcedungeonstage")
local CSRResourceDungeonStage = BeanManager.GetTableByName("activity.csrresourcedungeonstage")
local CSRFunction = BeanManager.GetTableByName("activity.csrfunction")
local CStarrymirrorlevel = BeanManager.GetTableByName("dungeonselect.cstarrymirrorlevel")
local ItemTypeEnum = LuaNetManager.GetBeanDef("protocol.item.beans.item")
local Item = require("logic.manager.experimental.types.item")
local Equip = require("logic.manager.experimental.types.equip")
local Skill = require("logic.manager.experimental.types.skill")

local function GetDelTimeStr(ms)
  local sec = ms // 1000
  return string.format("%s:%s:%s", os.date("!%H", sec), os.date("!%M", sec), os.date("!%S", sec))
end

function BM_OfflineSweep:Ctor()
  self._data = NekoData.Data.offlineSweep
end

function BM_OfflineSweep:GetStatus()
  return self._data.status or 0
end

function BM_OfflineSweep:GetTimeStr()
  local ms = self._data.process.leftTime or 0
  return GetDelTimeStr(ms)
end

function BM_OfflineSweep:GetProcessNum()
  return {
    self._data.process.currentTime,
    self._data.process.totalNum
  }
end

function BM_OfflineSweep:GetLevelInfo()
  local result = {}
  if self._data.process.battleType == CBattleStartProtocol.RESOURCE then
    local record = CResourceDungeonStage:GetRecorder(self._data.process.id)
    result = {
      name = TextManager.GetText(record.typeNameTextID),
      littleImg = record.imageID
    }
  elseif self._data.process.battleType == CBattleStartProtocol.STARRY_MIRROR then
    local record = CStarrymirrorlevel:GetRecorder(self._data.process.id)
    result = {
      name = TextManager.GetText(record.leveltitle) .. " " .. TextManager.GetText(record.levelname)
    }
  elseif self._data.process.battleType == CBattleStartProtocol.SUMMER_ECHO then
    local tempRecord = CSRFunction:GetRecorder(self._data.process.id)
    local record = CSRResourceDungeonStage:GetRecorder(tempRecord.levelID)
    result = {
      name = TextManager.GetText(record.nameID)
    }
  end
  return result
end

function BM_OfflineSweep:GetAwardResult()
  return self._data.roleExp, self._data.roleGoodExp, self._data.rolesIndex, self._data.playerExp
end

function BM_OfflineSweep:GetAccountBag()
  if self._data.awardList then
    local itemList = {}
    local awardItems = self._data.awardList
    for _, itemInfo in ipairs(awardItems) do
      local item
      if itemInfo.gain == 1 then
        if itemInfo.itemtype == ItemTypeEnum.BASEITEM then
          item = NekoData.BehaviorManager.BM_BagInfo:GetItem(itemInfo.id)
        elseif itemInfo.itemtype == ItemTypeEnum.EQUIP then
          item = NekoData.BehaviorManager.BM_BagInfo:GetEquipItem(itemInfo.id)
        end
      else
        if itemInfo.itemtype == ItemTypeEnum.BASEITEM then
          item = Item.Create(itemInfo.id)
        elseif itemInfo.itemtype == ItemTypeEnum.EQUIP then
          item = Equip.Create(itemInfo.id)
        elseif itemInfo.itemtype == ItemTypeEnum.SKILL then
          item = Skill.Create(itemInfo.id)
        end
        item:InitWithItemInfo(itemInfo)
      end
      table.insert(itemList, {
        item = item,
        num = itemInfo.number
      })
    end
    return itemList
  end
  return {}
end

function BM_OfflineSweep:GetMoneyData()
  return self._data.currency or {}
end

function BM_OfflineSweep:GetRestituteReward()
  return self._data.restituteReward or {}
end

function BM_OfflineSweep:GetTodayLeftNum()
  return self._data.leftNum
end

function BM_OfflineSweep:IsCanReceive()
  return self._data.process.currentTime > self._data.process.receivedNum
end

return BM_OfflineSweep
