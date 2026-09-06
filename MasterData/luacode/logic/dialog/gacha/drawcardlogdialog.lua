local TextStaticFunctions = CS.PixelNeko.Lua.UI.TextStaticFunctions
local CStringres = BeanManager.GetTableByName("message.cstringres")
local CVarConfig = BeanManager.GetTableByName("var.cvarconfig")
local CCardPool = BeanManager.GetTableByName("item.ccardpool")
local TableFrame = require("framework.ui.frame.table.tableframe")
local DrawCardLogDialog = class("DrawCardLogDialog", Dialog)
DrawCardLogDialog.AssetBundleName = "ui/layouts.gacha"
DrawCardLogDialog.AssetName = "GachaRecord"

function DrawCardLogDialog:Ctor(...)
  DrawCardLogDialog.super.Ctor(self, ...)
  self._groupName = "Tip"
  self._tab = nil
end

function DrawCardLogDialog:OnCreate()
  local transform = self:GetRootWindow()._uiObject.transform
  self._black = self:GetChild("Black")
  self._framePanel = self:GetChild("Back/Frame")
  self._remindTxt = transform:Find("Back/RemindTxt").gameObject
  self._empty = transform:Find("Back/Empty").gameObject
  self._closeBtn = self:GetChild("Back/CloseBtn")
  self._log = {}
  self._frame = TableFrame.Create(self._framePanel, self, true, true, false)
  self._closeBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  local str = ""
  str = TextManager.GetText(CStringres:GetRecorder(1154).msgTextID)
  str = string.gsub(str, "%$parameter1%$", CVarConfig:GetRecorder(31).Value)
  TextStaticFunctions.SetText(self._remindTxt, str)
end

function DrawCardLogDialog:OnDestroy()
  self._frame:Destroy()
end

function DrawCardLogDialog:OnBackBtnClicked()
  self:Destroy()
end

function DrawCardLogDialog:SetData(log)
  local poolId
  local dialog = DialogManager.GetDialog("gacha.gachamaindialog")
  if dialog and dialog:GetSelectedPool() then
    local pool = dialog:GetSelectedPool()
    if pool then
      poolId = pool.id
    end
  end
  if poolId then
    local cardPoolRecord = CCardPool:GetRecorder(poolId)
    local str = string.sub(poolId, 1, 2)
    if cardPoolRecord.cardpooltype == 2 then
      for i, v in ipairs(log) do
        cardPoolRecord = CCardPool:GetRecorder(v.poolId)
        if cardPoolRecord and cardPoolRecord.cardpooltype == 2 then
          table.insert(self._log, v)
        end
      end
    else
      for i, v in ipairs(log) do
        cardPoolRecord = CCardPool:GetRecorder(v.poolId)
        if cardPoolRecord and cardPoolRecord.cardpooltype == 1 then
          table.insert(self._log, v)
        end
      end
    end
  else
    for k, v in ipairs(log) do
      table.insert(self._log, v)
    end
  end
  if #self._log == 0 then
    local str = TextManager.GetText(CStringres:GetRecorder(1157).msgTextID)
    TextStaticFunctions.SetText(self._empty, str)
  else
    TextStaticFunctions.SetText(self._empty, "")
  end
end

function DrawCardLogDialog:OnRefreshPools()
  self._frame:ReloadAllCell()
end

function DrawCardLogDialog:NumberOfCell(frame)
  return #self._log
end

function DrawCardLogDialog:DataAtIndex(frame, index)
  return self._log[index]
end

function DrawCardLogDialog:CellAtIndex(frame, index)
  return "gacha.drawcardlogcell"
end

return DrawCardLogDialog
