local Role = require("logic.manager.experimental.types.role")
local Item = require("logic.manager.experimental.types.item")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CItemPinji = BeanManager.GetTableByName("item.citempinji")
local CSkinShopCfg = BeanManager.GetTableByName("activity.cskinshopcfg")
local TableFrame = require("framework.ui.frame.table.tableframe")
local SkillListDialog = class("SkillListDialog", Dialog)
SkillListDialog.AssetBundleName = "ui/layouts.activity1yearanniversary"
SkillListDialog.AssetName = "Activity1YearOtherShopFashion"

function SkillListDialog:Ctor(...)
  SkillListDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
  self._skinList = {}
end

function SkillListDialog:OnCreate()
  self._titleText = self:GetChild("Back/Title")
  self._titleText:SetText(NekoData.BehaviorManager.BM_Message:GetString(2068))
  self._panel = self:GetChild("Frame")
  self._frame = TableFrame.Create(self._panel, self, true, true, true)
  self._closeBtn = self:GetChild("CloseBtn")
  self._closeBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
end

function SkillListDialog:OnDestroy()
  if self._frame then
    self._frame:Destroy()
  end
end

function SkillListDialog:RefreshList()
  for i, v in ipairs(CSkinShopCfg:GetAllIds()) do
    local recorde = CSkinShopCfg:GetRecorder(v)
    table.insert(self._skinList, recorde)
  end
  self._frame:ReloadAllCell()
  self._frame:MoveToTop()
end

function SkillListDialog:OnBackBtnClicked()
  self:Destroy()
end

function SkillListDialog:NumberOfCell(frame)
  return #self._skinList
end

function SkillListDialog:CellAtIndex(frame, index)
  return "activity.anniversarypackage.skincell"
end

function SkillListDialog:DataAtIndex(frame, index)
  return self._skinList[index]
end

return SkillListDialog
