local TypeEnum = DataCommon.StarMirage1[DataCommon.Activities.StarMirageCopy]
local CStarryMirrorDiffculty = BeanManager.GetTableByName("dungeonselect.cstarrymirrordiffculty")
local CopyBaseMainDialog = require("logic.dialog.activity.starmirage1.copybase.maindialog")
local MainDialog = class("MainDialog", CopyBaseMainDialog)
MainDialog.AssetBundleName = "ui/layouts.activitystar2"
MainDialog.AssetName = "ActivityStar2Main"

function MainDialog:Ctor(...)
  local args = {
    ...
  }
  args.TypeEnum = TypeEnum
  args.bm = NekoData.BehaviorManager.BM_StarMirageCopy
  args.LocalCacheOpenType = DataCommon.LocalCache.StarMirageCopyOpenType
  args.ActivityId = DataCommon.Activities.StarMirageCopy
  args.BGMEnum = {}
  args.DiffcultyRecords = {}
  local allIds = CStarryMirrorDiffculty:GetAllIds()
  for i = 1, #allIds do
    local record = CStarryMirrorDiffculty:GetRecorder(allIds[i])
    if record.eventid == args.ActivityId then
      args.DiffcultyRecords[record.diffculty] = record
      args.BGMEnum[record.diffculty] = record.bgm
    end
  end
  args.EndTipsStr = NekoData.BehaviorManager.BM_Message:GetString(2120)
  MainDialog.super.Ctor(self, args)
end

function MainDialog:OnCreate()
  MainDialog.super.OnCreate(self)
  self:GetChild("Title"):SetText(NekoData.BehaviorManager.BM_Message:GetString(2106))
  self._instructionsTipBtn = self:GetChild("Ibtn")
  self._instructionsTipBtn:Subscribe_PointerClickEvent(self.OnInstructionsTipBtnClicked, self)
  LuaNotificationCenter.AddObserver(self, self.RefreshOfflineSweepActive, Common.n_RefreshOfflineSweepActive, nil)
  self:RefreshOfflineSweepActive()
end

function MainDialog:OnDestroy()
  MainDialog.super.OnDestroy(self)
  if self._offlinesweepDialog then
    self._offlinesweepDialog:Destroy()
    self._offlinesweepDialog = nil
  end
end

function MainDialog:OnInstructionsTipBtnClicked()
  NekoData.BehaviorManager.BM_Message:OpenInstructionsTipDialog(11)
end

function MainDialog:NumberOfCell(frame, index)
  if frame == self._currencyFrame then
    return #self._currencyList
  end
end

function MainDialog:CellAtIndex(frame, index)
  if frame == self._currencyFrame then
    return "activity.starmirage1.currencycell"
  elseif frame == self._tabFrame then
    return "activity.starmirage1.leveldialog"
  end
end

function MainDialog:DataAtIndex(frame, index)
  if frame == self._currencyFrame then
    return self._currencyList[index]
  end
end

function MainDialog:RefreshOfflineSweepActive()
  local status = NekoData.BehaviorManager.BM_OfflineSweep:GetStatus()
  if status ~= 0 then
    if self._offlinesweepDialog == nil then
      self._offlinesweepDialog = DialogManager.CreateDialog("mainline.offlinesweep.offlinesweepshowbtndialog", self._rootWindow._uiObject)
    end
  elseif self._offlinesweepDialog then
    self._offlinesweepDialog:Destroy()
    self._offlinesweepDialog = nil
  end
end

return MainDialog
