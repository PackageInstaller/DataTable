local Item = require("logic.manager.experimental.types.item")
local UIManager = CS.PixelNeko.UI.UIManager
local TableFrame = require("framework.ui.frame.table.tableframe")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local Num = 3
local QuickLevelUpConfirmDialog = class("QuickLevelUpConfirmDialog", Dialog)
QuickLevelUpConfirmDialog.AssetBundleName = "ui/layouts.basecharacterinfo"
QuickLevelUpConfirmDialog.AssetName = "CharFastLevelUpSecond"

function QuickLevelUpConfirmDialog:Ctor(...)
  QuickLevelUpConfirmDialog.super.Ctor(self, ...)
  self._groupName = "SecondConfirm"
end

function QuickLevelUpConfirmDialog:OnCreate()
  self._cur_lv = self:GetChild("Tips/BreakLevelBack1/LevelNum")
  self._cur_breakLevelBackBlack = self:GetChild("Tips/BreakLevelBack1/BreakLevelBackBlack")
  self._cur_breakLvBack = self:GetChild("Tips/BreakLevelBack1/BreakLevelBack")
  self._cur_breakLv = self:GetChild("Tips/BreakLevelBack1/BreakLevelNum")
  self._next_lv = self:GetChild("Tips/BreakLevelBack2/LevelNum")
  self._next_breakLevelBackBlack = self:GetChild("Tips/BreakLevelBack2/BreakLevelBackBlack")
  self._next_breakLvBack = self:GetChild("Tips/BreakLevelBack2/BreakLevelBack")
  self._next_breakLv = self:GetChild("Tips/BreakLevelBack2/BreakLevelNum")
  self._roleName = self:GetChild("RoleName")
  self._cost_breakMaterial_panel = self:GetChild("Frame")
  self._cost_breakMaterial_frame = TableFrame.Create(self._cost_breakMaterial_panel, self, false, false)
  self._cost_breakMaterial_frame_width, self._cost_breakMaterial_frame_height = self._cost_breakMaterial_panel:GetRectSize()
  self._cost_breakMaterial_frame_anchoredx, self._cost_breakMaterial_frame_anchoredy = self._cost_breakMaterial_panel:GetAnchoredPosition()
  self._confirmBtn = self:GetChild("CommonBtn")
  self._cancelBtn = self:GetChild("CancelBtn")
  self._back = self:GetChild("Tips")
  self._confirmBtn:Subscribe_PointerClickEvent(self.OnConfirmBtnClicked, self)
  self._cancelBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  LuaNotificationCenter.AddObserver(self, self.OnGlobalPointerDown, Common.n_GlobalPointerWillDown, nil)
  LuaNotificationCenter.AddObserver(self, self.OnGlobalPointerDown, Common.n_NoTargetWindowClick, nil)
  self:GetChild("text"):SetText(NekoData.BehaviorManager.BM_Message:GetString(1747))
  local imageRecord = CImagePathTable:GetRecorder(14211) or DataCommon.DefaultImageAsset
  self._cur_breakLvBack:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._next_breakLvBack:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
end

function QuickLevelUpConfirmDialog:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
  self._cost_breakMaterial_frame:Destroy()
end

function QuickLevelUpConfirmDialog:SetData(role, curLv, nextLv, costData)
  self._role = role
  self._costData = costData
  self._nextLv = nextLv
  local breakLv, showLv = self._role:GetBreakLvAndShowLvByRoleLv(curLv)
  self._cur_lv:SetText(showLv)
  self._cur_breakLevelBackBlack:SetActive(breakLv == 0)
  self._cur_breakLvBack:SetActive(0 < breakLv)
  self._cur_breakLv:SetActive(0 < breakLv)
  if 0 < breakLv then
    self._cur_breakLv:SetText(breakLv)
  end
  breakLv, showLv = self._role:GetBreakLvAndShowLvByRoleLv(nextLv)
  self._next_lv:SetText(showLv)
  self._next_breakLevelBackBlack:SetActive(breakLv == 0)
  self._next_breakLvBack:SetActive(0 < breakLv)
  self._next_breakLv:SetActive(0 < breakLv)
  if 0 < breakLv then
    self._next_breakLv:SetText(breakLv)
  end
  self._roleName:SetText(NekoData.BehaviorManager.BM_Message:GetString(1748, {
    self._role:GetRoleName()
  }))
  local cellPanelWidth = self._cost_breakMaterial_frame_width / Num * #costData.breakMaterials
  self._cost_breakMaterial_panel:SetSize(0, cellPanelWidth, 0, self._cost_breakMaterial_frame_height)
  self._cost_breakMaterial_panel:SetAnchoredPosition(self._cost_breakMaterial_frame_anchoredx, self._cost_breakMaterial_frame_anchoredy)
  self._cost_breakMaterial_frame:ReloadAllCell()
end

function QuickLevelUpConfirmDialog:OnConfirmBtnClicked()
  local protocol = LuaNetManager.CreateProtocol("protocol.login.crolequicklevelup")
  protocol.roleId = self._role:GetId()
  protocol.level = self._nextLv
  protocol:Send()
end

function QuickLevelUpConfirmDialog:OnBackBtnClicked()
  self:Destroy()
end

function QuickLevelUpConfirmDialog:OnGlobalPointerDown(args)
  if not UIManager.RectangleContainsScreenPoint(self._back._uiObject, args.userInfo.eventData.position.x, args.userInfo.eventData.position.y) then
    self:OnBackBtnClicked()
  end
end

function QuickLevelUpConfirmDialog:NumberOfCell()
  if self._costData then
    return #self._costData.breakMaterials
  else
    return 0
  end
end

function QuickLevelUpConfirmDialog:CellAtIndex(frame, index)
  return "character.quicklevelup.costbreakmaterialitemcell"
end

function QuickLevelUpConfirmDialog:DataAtIndex(frame, index)
  if self._costData then
    return self._costData.breakMaterials[index]
  end
end

return QuickLevelUpConfirmDialog
