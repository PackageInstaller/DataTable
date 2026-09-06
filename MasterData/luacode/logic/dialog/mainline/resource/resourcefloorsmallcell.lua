local ResourceFloorSmallCell = class("ResourceFloorSmallCell", Dialog)
ResourceFloorSmallCell.AssetBundleName = "ui/layouts.mainline"
ResourceFloorSmallCell.AssetName = "DungeonSelectCellSmall"

function ResourceFloorSmallCell:Ctor(...)
  ResourceFloorSmallCell.super.Ctor(self, ...)
end

function ResourceFloorSmallCell:OnCreate()
  self._finishNo = self:GetChild("FinishNo")
  self._finishNoSelect = self:GetChild("FinishNoSelect")
  self._finishNoSelect:SetActive(false)
  self._finish = self:GetChild("Finish")
  self._finishSelect = self:GetChild("FinishSelect")
  self._finishSelect:SetActive(false)
end

function ResourceFloorSmallCell:OnDestroy()
end

local function SetStatusActive(self, f1, f2, f3, f4)
  self._finish:SetActive(f1)
  self._finishNo:SetActive(f2)
  self._finishSelect:SetActive(f3)
  self._finishNoSelect:SetActive(f4)
end

function ResourceFloorSmallCell:RefreshCell(data)
  self._data = data
  if data.firstGet then
    SetStatusActive(self, true, false, false, false)
    self._assetName, self._effectName = EffectUtil.GetAssetBundleNameAndAssetName(1021)
  else
    SetStatusActive(self, false, true, false, false)
    self._assetName, self._effectName = EffectUtil.GetAssetBundleNameAndAssetName(1020)
  end
end

function ResourceFloorSmallCell:OnEvent(eventName, args)
  if eventName == "SetSelected" then
    if args == self._data.bigParentId then
      local finish = self._data.firstGet
      if finish then
        SetStatusActive(self, false, false, true, false)
      else
        SetStatusActive(self, false, false, false, true)
      end
    else
      local finish = self._data.firstGet
      if finish then
        SetStatusActive(self, true, false, false, false)
      else
        SetStatusActive(self, false, true, false, false)
      end
    end
  end
end

function ResourceFloorSmallCell:SetPosition(ax, x, ay, y)
  self:GetRootWindow():SetPosition(ax, x, ay, y)
end

return ResourceFloorSmallCell
