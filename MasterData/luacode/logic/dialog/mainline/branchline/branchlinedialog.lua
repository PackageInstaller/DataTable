local CSideStoryChapter = BeanManager.GetTableByName("dungeonselect.csidestorychapter")
local ImageTable = BeanManager.GetTableByName("ui.cimagepath")
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local TableFrame = require("framework.ui.frame.table.tableframe")
local BranchLineDialog = class("BranchLineDialog", Dialog)
BranchLineDialog.AssetBundleName = "ui/layouts.sidestory"
BranchLineDialog.AssetName = "SideStoryEntry"

local function HandleGuideStatusChanged(self, notification)
  local guideId = notification.userInfo.guideID
  if guideId == 46 and notification.userInfo.guideStatus ~= "Start" then
    self._frame:SetSlide(true)
  end
end

function BranchLineDialog:Ctor(...)
  BranchLineDialog.super.Ctor(self, ...)
end

function BranchLineDialog:OnCreate()
  self._field = self:GetChild("Frame")
  self._frame = TableFrame.Create(self._field, self, false)
  self._frame:SetMargin(40, 0)
  LuaNotificationCenter.AddObserver(self, HandleGuideStatusChanged, Common.n_GuideStatusChanged, nil)
end

function BranchLineDialog:OnDestroy()
  self._frame:Destroy()
  LuaNotificationCenter.RemoveObserver(self)
end

function BranchLineDialog:RefreshCell(data)
  self._data = {}
  local allIds = CSideStoryChapter:GetAllIds()
  for _, v in pairs(allIds) do
    local temp = {}
    temp.id = v
    if data[v] then
      temp.unlock = true
      if data[v].hasPassed == 1 then
        temp.passed = true
        if table.keyof(data[v].questInfo, 1) or table.keyof(data[v].questInfo, 2) then
          temp.reset = true
        end
      end
      for key, value in pairs(data[v].questInfo) do
        if value == 1 or value == 2 then
          if key == CSideStoryChapter:GetRecorder(v).floorlist[1] and value == 1 then
            temp.currentFirst = true
          end
          temp.current = key
          break
        end
      end
    end
    table.insert(self._data, temp)
  end
  self._frame:ReloadAllCell()
end

function BranchLineDialog:NumberOfCell(frame)
  return #self._data
end

function BranchLineDialog:CellAtIndex(frame, index)
  return "mainline.branchline.branchlinecell"
end

function BranchLineDialog:DataAtIndex(frame, index)
  return self._data[index]
end

return BranchLineDialog
