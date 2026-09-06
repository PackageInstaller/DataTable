local TableFrame = require("framework.ui.frame.table.tableframe")
local CVarconfig = BeanManager.GetTableByName("var.cvarconfig")
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local FirstGachaDetailDialog = class("FirstGachaDetailDialog", Dialog)
FirstGachaDetailDialog.AssetBundleName = "ui/layouts.gacha"
FirstGachaDetailDialog.AssetName = "FirstGachaDetail"

function FirstGachaDetailDialog:Ctor(...)
  FirstGachaDetailDialog.super.Ctor(self, ...)
end

function FirstGachaDetailDialog:OnCreate()
  self._tips = self:GetChild("Back/Page1/Tips")
  self._tips2 = self:GetChild("Back/Page1/Tips2")
  self._field = self:GetChild("Back/Page1/Frame")
  self._closeBtn = self:GetChild("Back/CloseBtn")
  self._remindTxt = self:GetChild("Back/RemindTxt")
  self._data = {}
  local upRoleId = string.split(CVarconfig:GetRecorder(77).Value, ";")
  local imgTable = string.split(CVarconfig:GetRecorder(83).Value, ";")
  if #upRoleId ~= #imgTable then
    LogErrorFormat("FirstGachaDetailDialog", "UpRoleId Length is No Equal imgTable Length")
  end
  for i = 1, #upRoleId do
    local temp = {}
    temp.roleId = tonumber(upRoleId[i])
    temp.imgId = tonumber(imgTable[i])
    table.insert(self._data, temp)
  end
  self._tips:SetText(TextManager.GetText(CStringRes:GetRecorder(1458).msgTextID))
  self._tips2:SetText(TextManager.GetText(CStringRes:GetRecorder(1525).msgTextID))
  self._remindTxt:SetText(TextManager.GetText(CStringRes:GetRecorder(1524).msgTextID))
  self._closeBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._frame = TableFrame.Create(self._field, self, false, false, false)
  self._frame:ReloadAllCell()
  self._frame:MoveToLeft()
  if DialogManager.GetDialog("guide.guidedialog") then
    local guideGroup = DialogManager.GetGroup("Guide")
    self._guideTag = guideGroup:GetObjectActive()
    guideGroup:SetObjectActive(false)
  end
end

function FirstGachaDetailDialog:OnDestroy()
  if self._guideTag then
    self._guideTag = false
    DialogManager.GetGroup("Guide"):SetObjectActive(true)
  end
  self._frame:Destroy()
end

function FirstGachaDetailDialog:NumberOfCell(frame)
  return #self._data
end

function FirstGachaDetailDialog:CellAtIndex(frame, index)
  return "gacha.firstgachaeetailcell"
end

function FirstGachaDetailDialog:DataAtIndex(frame, index)
  return self._data[index]
end

function FirstGachaDetailDialog:OnBackBtnClicked()
  DialogManager.DestroySingletonDialog("gacha.firstgachadetaildialog")
end

return FirstGachaDetailDialog
