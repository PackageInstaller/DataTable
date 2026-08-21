-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/mainline/branchline/branchlinedialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CSideStoryChapter = (BeanManager.GetTableByName)("dungeonselect.csidestorychapter")
local ImageTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local TableFrame = require("framework.ui.frame.table.tableframe")
local BranchLineDialog = class("BranchLineDialog", Dialog)
BranchLineDialog.AssetBundleName = "ui/layouts.sidestory"
BranchLineDialog.AssetName = "SideStoryEntry"
local HandleGuideStatusChanged = function(self, notification)
  -- function num : 0_0
  local guideId = (notification.userInfo).guideID
  if guideId == 46 and (notification.userInfo).guideStatus ~= "Start" then
    (self._frame):SetSlide(true)
  end
end

BranchLineDialog.Ctor = function(self, ...)
  -- function num : 0_1 , upvalues : BranchLineDialog
  ((BranchLineDialog.super).Ctor)(self, ...)
end

BranchLineDialog.OnCreate = function(self)
  -- function num : 0_2 , upvalues : TableFrame, _ENV, HandleGuideStatusChanged
  self._field = self:GetChild("Frame")
  self._frame = (TableFrame.Create)(self._field, self, false)
  ;
  (self._frame):SetMargin(40, 0)
  ;
  (LuaNotificationCenter.AddObserver)(self, HandleGuideStatusChanged, Common.n_GuideStatusChanged, nil)
end

BranchLineDialog.OnDestroy = function(self)
  -- function num : 0_3 , upvalues : _ENV
  (self._frame):Destroy()
  ;
  (LuaNotificationCenter.RemoveObserver)(self)
end

BranchLineDialog.RefreshCell = function(self, data)
  -- function num : 0_4 , upvalues : CSideStoryChapter, _ENV
  self._data = {}
  local allIds = CSideStoryChapter:GetAllIds()
  for _,v in pairs(allIds) do
    local temp = {}
    temp.id = v
    if data[v] then
      temp.unlock = true
      if (data[v]).hasPassed == 1 then
        temp.passed = true
        if (table.keyof)((data[v]).questInfo, 1) or (table.keyof)((data[v]).questInfo, 2) then
          temp.reset = true
        end
      end
      for key,value in pairs((data[v]).questInfo) do
        if value == 1 or value == 2 then
          if key == ((CSideStoryChapter:GetRecorder(v)).floorlist)[1] and value == 1 then
            temp.currentFirst = true
          end
          temp.current = key
          break
        end
      end
    end
    do
      do
        ;
        (table.insert)(self._data, temp)
        -- DECOMPILER ERROR at PC66: LeaveBlock: unexpected jumping out DO_STMT

      end
    end
  end
  ;
  (self._frame):ReloadAllCell()
end

BranchLineDialog.NumberOfCell = function(self, frame)
  -- function num : 0_5
  return #self._data
end

BranchLineDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_6
  return "mainline.branchline.branchlinecell"
end

BranchLineDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_7
  return (self._data)[index]
end

return BranchLineDialog

