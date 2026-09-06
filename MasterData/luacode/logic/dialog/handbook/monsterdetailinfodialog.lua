local UIManager = CS.PixelNeko.UI.UIManager
local TableFrame = require("framework.ui.frame.table.tableframe")
local CMonsterBookCfg = BeanManager.GetTableByName("handbook.cmonster_handbook")
local MonsterDetailInfoDialog = class("MonsterDetailInfoDialog", Dialog)
MonsterDetailInfoDialog.AssetBundleName = "ui/layouts.tujian"
MonsterDetailInfoDialog.AssetName = "MonsterBookDetail"

function MonsterDetailInfoDialog:Ctor(...)
  MonsterDetailInfoDialog.super.Ctor(self, ...)
  self._groupName = "Tip"
  self._skillIDs = {}
end

function MonsterDetailInfoDialog:OnCreate()
  self._back = self:GetChild("Back2")
  self._skillPanel = self:GetChild("Back2/Frame")
  self._skillframe = TableFrame.Create(self._skillPanel, self, true, true, true)
  self._skillframe:SetMargin(15, 0)
  self._hpScore = self:GetChild("Back2/Frame2/Detail1/Num")
  self._adScore = self:GetChild("Back2/Frame2/Detail2/Num")
  self._apScore = self:GetChild("Back2/Frame2/Detail3/Num")
  self._pdScore = self:GetChild("Back2/Frame2/Detail4/Num")
  self._mdScore = self:GetChild("Back2/Frame2/Detail5/Num")
  LuaNotificationCenter.AddObserver(self, self.OnGlobalPointerDown, Common.n_GlobalPointerWillDown, nil)
end

function MonsterDetailInfoDialog:OnDestroy()
  self._skillframe:Destroy()
  LuaNotificationCenter.RemoveObserver(self)
end

function MonsterDetailInfoDialog:SetMonsterInfo(monsterid)
  local bookcfg = CMonsterBookCfg:GetRecorder(monsterid)
  self._hpScore:SetText(bookcfg.hpScore)
  self._adScore:SetText(bookcfg.adScore)
  self._apScore:SetText(bookcfg.apScore)
  self._pdScore:SetText(bookcfg.pdScore)
  self._mdScore:SetText(bookcfg.mdScore)
  self._skillIDs = {}
  for _, skillid in pairs(bookcfg.skillid) do
    table.insert(self._skillIDs, skillid)
  end
  self._skillframe:ReloadAllCell()
  self._skillframe:MoveToTop()
end

function MonsterDetailInfoDialog:NumberOfCell(frame, index)
  if frame == self._skillframe then
    return #self._skillIDs
  end
end

function MonsterDetailInfoDialog:CellAtIndex(frame, index)
  if frame == self._skillframe then
    return "handbook.monsterskillcell"
  end
end

function MonsterDetailInfoDialog:DataAtIndex(frame, index)
  if frame == self._skillframe then
    return self._skillIDs[index]
  end
end

function MonsterDetailInfoDialog:OnGlobalPointerDown(args)
  if not UIManager.RectangleContainsScreenPoint(self._back._uiObject, args.userInfo.eventData.position.x, args.userInfo.eventData.position.y) then
    self:OnBackBtnClicked()
  end
end

function MonsterDetailInfoDialog:OnBackBtnClicked()
  self:Destroy()
end

function MonsterDetailInfoDialog:ShouldLengthChange()
  return true
end

return MonsterDetailInfoDialog
