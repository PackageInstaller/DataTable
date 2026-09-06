local TableFrame = require("framework.ui.frame.table.tableframe")
local TabFrame = require("framework.ui.frame.tab.tabframe")
local GridFrame = require("framework.ui.frame.grid.gridframe")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CalbumConfig = BeanManager.GetTableByName("handbook.calbumconfig")
local HandBookTypeEnum = LuaNetManager.GetBeanDef("protocol.user.handbooktype")
local MemoryBookDialog = class("MemoryBookDialog", Dialog)
MemoryBookDialog.AssetBundleName = "ui/layouts.tujianpuzzle"
MemoryBookDialog.AssetName = "TuJianPuzzleMain"

function MemoryBookDialog:Ctor(...)
  MemoryBookDialog.super.Ctor(self, ...)
  self._pageindex = 1
end

function MemoryBookDialog:OnCreate()
  self._title = self:GetChild("Back/TitleBack/Title")
  self._panel = self:GetChild("Back/Frame")
  self._leftArrowBtn = self:GetChild("Back/LeftArrow")
  self._rightArrowBtn = self:GetChild("Back/RightArrow")
  self._pageTxt = self:GetChild("Back/Page")
  self._frame = GridFrame.Create(self._panel, self, true, 2, false)
  self._leftArrowBtn:Subscribe_PointerClickEvent(function()
    self:ToPage(self._pageindex - 1)
  end)
  self._rightArrowBtn:Subscribe_PointerClickEvent(function()
    self:ToPage(self._pageindex + 1)
  end)
  LuaNotificationCenter.AddObserver(self, self.RefreshState, Common.n_RefreshAcitivityHandBook, nil)
end

function MemoryBookDialog:OnDestroy()
  if self._frame then
    self._frame:Destroy()
  end
  LuaNotificationCenter.RemoveObserver(self)
end

function MemoryBookDialog:Refresh()
  self._data = {}
  for _, v in ipairs(CalbumConfig:GetAllIds()) do
    local record = CalbumConfig:GetRecorder(v)
    if record then
      table.insert(self._data, record)
    end
  end
  self._pageindex = 1
  self:ToPage(1)
end

function MemoryBookDialog:ToPage(index)
  if index < 1 then
    index = 1
  end
  if index > math.ceil(#self._data / 4) then
    index = math.ceil(#self._data / 4)
  end
  local start = (index - 1) * 4
  self._shwoData = {}
  for i = 1, 4 do
    if self._data[start + i] then
      table.insert(self._shwoData, self._data[start + i])
    end
  end
  self._pageindex = index
  self._pageTxt:SetText(index)
  self._frame:ReloadAllCell()
end

function MemoryBookDialog:NumberOfCell(frame)
  return #self._shwoData
end

function MemoryBookDialog:CellAtIndex(frame, index)
  return "handbook.memorybookcell"
end

function MemoryBookDialog:DataAtIndex(frame, index)
  return self._shwoData[index]
end

function MemoryBookDialog:RefreshState()
  self._frame:FireEvent("Refresh", nil)
end

return MemoryBookDialog
