-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/handbook/memorybookcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local HandBookTypeEnum = (LuaNetManager.GetBeanDef)("protocol.user.handbooktype")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local MemoryBookCell = class("MemoryBookCell", Dialog)
MemoryBookCell.AssetBundleName = "ui/layouts.tujianpuzzle"
MemoryBookCell.AssetName = "TuJianPuzzleMainCell"
MemoryBookCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : MemoryBookCell
  ((MemoryBookCell.super).Ctor)(self, ...)
end

MemoryBookCell.OnCreate = function(self)
  -- function num : 0_1
  self._normal = self:GetChild("Normal")
  self._Img1 = self:GetChild("Normal/Image")
  self._name1 = self:GetChild("Normal/Name")
  self._lock = self:GetChild("Lock")
  self._Img2 = self:GetChild("Lock/Image")
  self._name2 = self:GetChild("Lock/Name")
  self._lockIcon = self:GetChild("Lock/Lock")
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

MemoryBookCell.OnDestroy = function(self)
  -- function num : 0_2
end

MemoryBookCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : CImagePathTable, _ENV, HandBookTypeEnum
  (self._normal):SetActive(false)
  ;
  (self._lock):SetActive(false)
  if not CImagePathTable:GetRecorder(data.picture) then
    local imageRecord = DataCommon.DefaultImageAsset
  end
  if ((NekoData.BehaviorManager).BM_HandBook):IsBookUnLock(data.id, HandBookTypeEnum.ACTIVITY) then
    (self._normal):SetActive(true)
    ;
    (self._Img1):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    ;
    (self._name1):SetText((TextManager.GetText)(data.name))
  else
    ;
    (self._lock):SetActive(true)
    ;
    (self._Img2):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    ;
    (self._name2):SetText((TextManager.GetText)(data.name))
  end
end

MemoryBookCell.OnCellClicked = function(self)
  -- function num : 0_4 , upvalues : _ENV, HandBookTypeEnum
  local event_id = (self._cellData).event_id
  local id = (self._cellData).id
  if ((NekoData.BehaviorManager).BM_HandBook):IsBookUnLock(id, HandBookTypeEnum.ACTIVITY) then
    ((DialogManager.CreateSingletonDialog)("handbook.memoryshowdialog")):SetData(self._cellData)
  else
    if (((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.PuzzleActivityID)):IsActivityOpen(event_id) then
      ((NekoData.BehaviorManager).BM_Message):AddSecondConfirmDialog(120, nil, function()
    -- function num : 0_4_0 , upvalues : _ENV, event_id, self
    (((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.PuzzleActivityID)):OpenActivityDialog(event_id)
    ;
    ((self._delegate)._delegate):Destroy()
  end
, {}, nil, {})
    else
      local num = ((NekoData.BehaviorManager).BM_HandBook):GetUnlockSoulNum(id)
      if num <= 0 then
        LogInfoFormat("MemoryBookCell", "ID:%s soulnum <= 0 EVENTID:%s", id, event_id)
        return 
      end
      ;
      ((NekoData.BehaviorManager).BM_Message):AddSecondConfirmDialog(121, {num * 50}, function()
    -- function num : 0_4_1 , upvalues : _ENV, id
    local csend = (LuaNetManager.CreateProtocol)("protocol.user.crepairhandbook")
    csend.id = id
    csend:Send()
  end
, {}, nil, {})
    end
  end
end

MemoryBookCell.OnEvent = function(self, eventName, arg)
  -- function num : 0_5
  if eventName == "Refresh" then
    self:RefreshCell(self._cellData)
  end
end

return MemoryBookCell

