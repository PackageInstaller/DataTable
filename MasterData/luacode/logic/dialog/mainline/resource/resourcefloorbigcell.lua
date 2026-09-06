local DungeonInfoTable = BeanManager.GetTableByName("dungeonselect.cresourcedungeoninfo")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local ResourceFloorBigCell = class("ResourceFloorBigCell", Dialog)
ResourceFloorBigCell.AssetBundleName = "ui/layouts.mainline"
ResourceFloorBigCell.AssetName = "ResourceSelectCellBig"

function ResourceFloorBigCell:Ctor(...)
  ResourceFloorBigCell.super.Ctor(self, ...)
end

function ResourceFloorBigCell:OnCreate()
  self._finishNo = self:GetChild("FinishNo")
  self._finishNoSelect = self:GetChild("FinishNoSelect")
  self._finish = self:GetChild("Finish")
  self._finishSelect = self:GetChild("FinishSelect")
  self._chapterNum = self:GetChild("Txt")
  self._lock = self:GetChild("Lock")
  self._lock_txt = self:GetChild("Lock/Txt")
  self._lock_txt1 = self:GetChild("Lock/Txt2")
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

function ResourceFloorBigCell:OnDestroy()
end

local function SetStatusActive(self, f1, f2, f3, f4, f5)
  self._finish:SetActive(f1)
  self._finishNo:SetActive(f2)
  self._finishSelect:SetActive(f3)
  self._finishNoSelect:SetActive(f4)
  self._lock:SetActive(f5)
end

local function RefreshSelected(self)
  local select = self._data.delegate._select
  if select == self._data.id then
    local finish = self._data.firstGet
    if finish then
      SetStatusActive(self, false, false, true, false, false)
    else
      SetStatusActive(self, false, false, false, true, self._data.lock or NekoData.BehaviorManager.BM_Game:GetUserLevel() < self._data.levelLimit)
    end
  else
    local finish = self._data.firstGet
    if finish then
      SetStatusActive(self, true, false, false, false, false)
    else
      SetStatusActive(self, false, true, false, false, self._data.lock or NekoData.BehaviorManager.BM_Game:GetUserLevel() < self._data.levelLimit)
    end
  end
end

function ResourceFloorBigCell:RefreshCell(data)
  self._data = data
  local delegate = self._data.delegate
  local delegateData = delegate._data.detailInfo[delegate._selectLittleTypeId or 1]
  local isHighestLV = data.id == delegateData.curStage
  if isHighestLV then
    self:GetRootWindow():PlayAnimation("LevelMax")
  else
    self:GetRootWindow():PlayAnimation("New State")
  end
  local userLevel = NekoData.BehaviorManager.BM_Game:GetUserLevel()
  if data.lock or userLevel < data.levelLimit then
    self._chapterNum:SetActive(false)
    if data.lock then
      self._lock_txt:SetActive(true)
      self._lock_txt1:SetActive(false)
      self._lock_txt:SetText(NekoData.BehaviorManager.BM_Message:GetString(1053))
    elseif userLevel < data.levelLimit then
      self._lock_txt:SetActive(false)
      self._lock_txt1:SetActive(true)
      self._lock_txt1:SetText(NekoData.BehaviorManager.BM_Message:GetString(1057, {
        data.levelLimit
      }))
    end
  else
    self._chapterNum:SetActive(true)
    self._chapterNum:SetText(data.name)
  end
  local dungeonInfoRecord = DungeonInfoTable:GetRecorder(delegateData.id)
  local imageRecord = CImagePathTable:GetRecorder(dungeonInfoRecord.nodeImage) or DataCommon.DefaultImageAsset
  self._finishNo:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._finishNoSelect:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._finish:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._finishSelect:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  RefreshSelected(self)
end

function ResourceFloorBigCell:OnEvent(eventName, args)
  if eventName == "SetSelected" then
    RefreshSelected(self)
  end
end

function ResourceFloorBigCell:OnCellClicked()
  local userLevel = NekoData.BehaviorManager.BM_Game:GetUserLevel()
  if self._data.lock then
    NekoData.BehaviorManager.BM_Message:AddMessageTip(NekoData.BehaviorManager.BM_Message:GetString(1053))
  elseif userLevel < self._data.levelLimit then
    NekoData.BehaviorManager.BM_Message:AddMessageTip(NekoData.BehaviorManager.BM_Message:GetString(1057, {
      self._data.levelLimit
    }))
  else
    self._data.delegate:OnCellClicked(self._data.id)
  end
end

function ResourceFloorBigCell:SetPosition(ax, x, ay, y)
  self:GetRootWindow():SetPosition(ax, x, ay, y)
end

return ResourceFloorBigCell
