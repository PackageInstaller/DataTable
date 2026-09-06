local FirstCellCard = class("FirstCellCard", Dialog)
FirstCellCard.AssetBundleName = "ui/layouts.gacha"
FirstCellCard.AssetName = "GachaResultFirstCell"

function FirstCellCard:Ctor(...)
  FirstCellCard.super.Ctor(self, ...)
  self._backEffectHandler = nil
end

function FirstCellCard:OnCreate()
  self._left = self:GetChild("FrameShort")
  self._right = self:GetChild("FrameTall")
end

function FirstCellCard:OnDestroy()
  if self._leftDlg then
    self._leftDlg:Destroy()
    self._leftDlg = nil
  end
  if self._rightDlg then
    self._rightDlg:Destroy()
    self._rightDlg = nil
  end
end

local cellList = {
  "gacha.gacharesultcell.r",
  "gacha.gacharesultcell.sr",
  "gacha.gacharesultcell.ssr",
  "gacha.gacharesultcell.ur",
  "gacha.gacharesultcell.ex"
}

function FirstCellCard:GetCellName(data)
  local rarity = data.role:GetRarityId()
  return cellList[rarity]
end

function FirstCellCard:RefreshCell(data)
  self._data = data
  if data and 0 < #data then
    local dlgName = self:GetCellName(data[1])
    self._leftDlg = DialogManager.CreateDialog(dlgName, self._left._uiObject)
    self._leftDlg._delegate = self
    self._leftDlg:RefreshCell(data[1])
    if data[2] then
      local dlgName = self:GetCellName(data[2])
      self._rightDlg = DialogManager.CreateDialog(dlgName, self._right._uiObject)
      self._rightDlg._delegate = self
      self._rightDlg:RefreshCell(data[2])
    end
  end
end

function FirstCellCard:CheckRoleInfo(args)
  self._delegate:CheckRoleInfo(args)
end

function FirstCellCard:OnEvent(name, args)
  if name == "hidenew" then
    self._leftDlg:HideNew()
    if self._rightDlg then
      self._rightDlg:HideNew()
    end
  end
end

return FirstCellCard
