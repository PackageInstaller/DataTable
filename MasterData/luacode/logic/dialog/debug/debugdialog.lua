local TableFrame = require("framework.ui.frame.table.tableframe")
local ResourceLoader = CS.PixelNeko.Assets.ResourceLoader
local DebugDialog = class("DebugDialog", Dialog)
DebugDialog.AssetBundleName = "ui/layouts"
DebugDialog.AssetName = "Debug"

function DebugDialog:Ctor(...)
  DebugDialog.super.Ctor(self, ...)
  self._groupName = "ClickEffect"
  self._info = nil
  self._task = true
end

function DebugDialog:OnCreate()
  self._btn2 = self:GetChild("Btn2")
  self._btn2Text = self:GetChild("Btn2/_Text")
  self._btn3 = self:GetChild("Btn3")
  self._text = self:GetChild("Text")
  self._text2 = self:GetChild("Text2")
  self._cellFrame = self:GetChild("Frame")
  self._frame = TableFrame.Create(self._cellFrame, self, true, true)
  self._btn2Text:SetText("暂停")
  self._btn2:Subscribe_PointerClickEvent(self.OnBtn2Click, self)
  self._btn3:Subscribe_PointerClickEvent(self.OnBtn3Click, self)
  LuaNotificationCenter.AddObserver(self, self.OnUpdate, Common.n_Update, nil)
  self:Refresh()
end

function DebugDialog:OnDestroy()
  self._frame:Destroy()
  LuaNotificationCenter.RemoveObserver(self)
end

function DebugDialog:LoadLocalData()
  self._info = {}
  self._info.QueueLength = ResourceLoader.GetDebugInfo().QueueLength
  self._info.AssetBundleInfo = {}
  for _, v in pairs(ResourceLoader.GetDebugInfo().AssetBundleInfo) do
    table.insert(self._info.AssetBundleInfo, v)
  end
end

function DebugDialog:Refresh()
  self:LoadLocalData()
  self._frame:ReloadAllCell()
  self._text2:SetText(tostring("QueueLength: " .. self._info.QueueLength))
end

function DebugDialog:NumberOfCell(frame)
  return #self._info.AssetBundleInfo
end

function DebugDialog:CellAtIndex(frame)
  return "debug.debugcell"
end

function DebugDialog:DataAtIndex(frame, index)
  return self._info.AssetBundleInfo[index]
end

function DebugDialog:OnBtn2Click()
  if self._task then
    self._btn2Text:SetText("逐帧刷新")
  else
    self._btn2Text:SetText("暂停")
  end
  self._task = not self._task
end

function DebugDialog:OnBtn3Click()
  self:Destroy()
end

function DebugDialog:OnUpdate()
  if self._task then
    self:Refresh()
  end
end

function DebugDialog:OnBackBtnClicked()
  return DataCommon.BackPressed_SkipResponse
end

return DebugDialog
