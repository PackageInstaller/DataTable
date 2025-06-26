-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/starmirage1/maindialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TypeEnum = (DataCommon.StarMirage1)[(DataCommon.Activities).StarMirageCopy]
local CStarryMirrorDiffculty = (BeanManager.GetTableByName)("dungeonselect.cstarrymirrordiffculty")
local CopyBaseMainDialog = require("logic.dialog.activity.starmirage1.copybase.maindialog")
local MainDialog = class("MainDialog", CopyBaseMainDialog)
MainDialog.AssetBundleName = "ui/layouts.activitystar2"
MainDialog.AssetName = "ActivityStar2Main"
MainDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : TypeEnum, _ENV, CStarryMirrorDiffculty, MainDialog
  local args = {...}
  args.TypeEnum = TypeEnum
  args.bm = (NekoData.BehaviorManager).BM_StarMirageCopy
  args.LocalCacheOpenType = (DataCommon.LocalCache).StarMirageCopyOpenType
  args.ActivityId = (DataCommon.Activities).StarMirageCopy
  args.BGMEnum = {}
  args.DiffcultyRecords = {}
  local allIds = CStarryMirrorDiffculty:GetAllIds()
  for i = 1, #allIds do
    local record = CStarryMirrorDiffculty:GetRecorder(allIds[i])
    -- DECOMPILER ERROR at PC38: Confused about usage of register: R8 in 'UnsetPending'

    if record.eventid == args.ActivityId then
      (args.DiffcultyRecords)[record.diffculty] = record
      -- DECOMPILER ERROR at PC42: Confused about usage of register: R8 in 'UnsetPending'

      ;
      (args.BGMEnum)[record.diffculty] = record.bgm
    end
  end
  args.EndTipsStr = ((NekoData.BehaviorManager).BM_Message):GetString(2120)
  ;
  ((MainDialog.super).Ctor)(self, args)
end

MainDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : MainDialog, _ENV
  ((MainDialog.super).OnCreate)(self)
  ;
  (self:GetChild("Title")):SetText(((NekoData.BehaviorManager).BM_Message):GetString(2106))
  self._instructionsTipBtn = self:GetChild("Ibtn")
  ;
  (self._instructionsTipBtn):Subscribe_PointerClickEvent(self.OnInstructionsTipBtnClicked, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshOfflineSweepActive, Common.n_RefreshOfflineSweepActive, nil)
  self:RefreshOfflineSweepActive()
end

MainDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : MainDialog
  ((MainDialog.super).OnDestroy)(self)
  if self._offlinesweepDialog then
    (self._offlinesweepDialog):Destroy()
    self._offlinesweepDialog = nil
  end
end

MainDialog.OnInstructionsTipBtnClicked = function(self)
  -- function num : 0_3 , upvalues : _ENV
  ((NekoData.BehaviorManager).BM_Message):OpenInstructionsTipDialog(11)
end

MainDialog.NumberOfCell = function(self, frame, index)
  -- function num : 0_4
  if frame == self._currencyFrame then
    return #self._currencyList
  end
end

MainDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_5
  if frame == self._currencyFrame then
    return "activity.starmirage1.currencycell"
  else
    if frame == self._tabFrame then
      return "activity.starmirage1.leveldialog"
    end
  end
end

MainDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_6
  if frame == self._currencyFrame then
    return (self._currencyList)[index]
  end
end

MainDialog.RefreshOfflineSweepActive = function(self)
  -- function num : 0_7 , upvalues : _ENV
  local status = ((NekoData.BehaviorManager).BM_OfflineSweep):GetStatus()
  -- DECOMPILER ERROR at PC16: Unhandled construct in 'MakeBoolean' P1

  if status ~= 0 and self._offlinesweepDialog == nil then
    self._offlinesweepDialog = (DialogManager.CreateDialog)("mainline.offlinesweep.offlinesweepshowbtndialog", (self._rootWindow)._uiObject)
  end
  if self._offlinesweepDialog then
    (self._offlinesweepDialog):Destroy()
    self._offlinesweepDialog = nil
  end
end

return MainDialog

