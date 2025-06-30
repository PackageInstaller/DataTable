-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/handbook/monsterbookcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local MonsterBookCell = class("MonsterBookCell", Dialog)
MonsterBookCell.AssetBundleName = "ui/layouts.tujian"
MonsterBookCell.AssetName = "MonsterBookCell"
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local HandBookTypeEnum = (LuaNetManager.GetBeanDef)("protocol.user.handbooktype")
MonsterBookCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : MonsterBookCell
  ((MonsterBookCell.super).Ctor)(self, ...)
end

MonsterBookCell.OnCreate = function(self)
  -- function num : 0_1
  self._normal = self:GetChild("Normal")
  self._normalBack = self:GetChild("Normal/Back")
  self._icon = self:GetChild("Normal/Monster")
  self._select = self:GetChild("Select")
  self._lock = self:GetChild("Lock")
  self._lockMonsterIcon = self:GetChild("Lock/Monster_black")
  self._num = self:GetChild("Num")
  ;
  (self._normal):Subscribe_PointerClickEvent(self.OnCellClicked, self)
  ;
  (self:GetChild("Lock/Back")):Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

MonsterBookCell.OnDestroy = function(self)
  -- function num : 0_2
end

MonsterBookCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : CImagePathTable, _ENV, HandBookTypeEnum
  local imageRecord = CImagePathTable:GetRecorder(data.miniIcon)
  if data.forceUnlock or ((NekoData.BehaviorManager).BM_HandBook):IsBookUnLock(data.id, HandBookTypeEnum.MONSTER) then
    (self._lock):SetActive(false)
    ;
    (self._normal):SetActive(true)
    if imageRecord then
      (self._icon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    end
  else
    ;
    (self._lock):SetActive(true)
    ;
    (self._normal):SetActive(false)
    if imageRecord then
      (self._lockMonsterIcon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    end
  end
  ;
  (self._num):SetText(data.monsterNumber)
  ;
  (self._select):SetActive((self._delegate)._selectId == data.id)
  ;
  (self._normalBack):SetActive((self._delegate)._selectId ~= data.id)
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

MonsterBookCell.OnCellClicked = function(self)
  -- function num : 0_4
  if not self._cellData then
    return 
  end
  ;
  (self._delegate):OnSelectMonster(self._cellData)
end

MonsterBookCell.OnEvent = function(self, eventName, arg)
  -- function num : 0_5
  if self._cellData and eventName == "ChooseMonster" then
    if (self._cellData).id == arg then
      (self._select):SetActive(true)
      ;
      (self._normalBack):SetActive(false)
    else
      ;
      (self._select):SetActive(false)
      ;
      (self._normalBack):SetActive(true)
    end
  end
end

return MonsterBookCell

