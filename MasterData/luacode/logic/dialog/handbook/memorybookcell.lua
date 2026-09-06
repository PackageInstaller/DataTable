local HandBookTypeEnum = LuaNetManager.GetBeanDef("protocol.user.handbooktype")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local MemoryBookCell = class("MemoryBookCell", Dialog)
MemoryBookCell.AssetBundleName = "ui/layouts.tujianpuzzle"
MemoryBookCell.AssetName = "TuJianPuzzleMainCell"

function MemoryBookCell:Ctor(...)
  MemoryBookCell.super.Ctor(self, ...)
end

function MemoryBookCell:OnCreate()
  self._normal = self:GetChild("Normal")
  self._Img1 = self:GetChild("Normal/Image")
  self._name1 = self:GetChild("Normal/Name")
  self._lock = self:GetChild("Lock")
  self._Img2 = self:GetChild("Lock/Image")
  self._name2 = self:GetChild("Lock/Name")
  self._lockIcon = self:GetChild("Lock/Lock")
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

function MemoryBookCell:OnDestroy()
end

function MemoryBookCell:RefreshCell(data)
  self._normal:SetActive(false)
  self._lock:SetActive(false)
  local imageRecord = CImagePathTable:GetRecorder(data.picture) or DataCommon.DefaultImageAsset
  if NekoData.BehaviorManager.BM_HandBook:IsBookUnLock(data.id, HandBookTypeEnum.ACTIVITY) then
    self._normal:SetActive(true)
    self._Img1:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    self._name1:SetText(TextManager.GetText(data.name))
  else
    self._lock:SetActive(true)
    self._Img2:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    self._name2:SetText(TextManager.GetText(data.name))
  end
end

function MemoryBookCell:OnCellClicked()
  local event_id = self._cellData.event_id
  local id = self._cellData.id
  if NekoData.BehaviorManager.BM_HandBook:IsBookUnLock(id, HandBookTypeEnum.ACTIVITY) then
    DialogManager.CreateSingletonDialog("handbook.memoryshowdialog"):SetData(self._cellData)
  elseif NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.PuzzleActivityID):IsActivityOpen(event_id) then
    NekoData.BehaviorManager.BM_Message:AddSecondConfirmDialog(120, nil, function()
      NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.PuzzleActivityID):OpenActivityDialog(event_id)
      self._delegate._delegate:Destroy()
    end, {}, nil, {})
  else
    local num = NekoData.BehaviorManager.BM_HandBook:GetUnlockSoulNum(id)
    if num <= 0 then
      LogInfoFormat("MemoryBookCell", "ID:%s soulnum <= 0 EVENTID:%s", id, event_id)
      return
    end
    NekoData.BehaviorManager.BM_Message:AddSecondConfirmDialog(121, {
      num * 50
    }, function()
      local csend = LuaNetManager.CreateProtocol("protocol.user.crepairhandbook")
      csend.id = id
      csend:Send()
    end, {}, nil, {})
  end
end

function MemoryBookCell:OnEvent(eventName, arg)
  if eventName == "Refresh" then
    self:RefreshCell(self._cellData)
  end
end

return MemoryBookCell
