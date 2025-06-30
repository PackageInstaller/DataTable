-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/activitycommon/maindialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TabFrame = require("framework.ui.frame.tab.tabframe")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local MainDialog = class("MainDialog", Dialog)
MainDialog.AssetBundleName = "ui/layouts.activitycommon"
MainDialog.AssetName = "ActivityCommonMain"
local ChildDialogs = {"activity.springfestival.itembuydialog", "activity.springfestival.roleopstiondialog", "activity.activitycommon.skinlistdialog"}
MainDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : MainDialog, _ENV
  ((MainDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
  self._bm = (NekoData.BehaviorManager).BM_CommonActivity
  self._cutBtnList = {}
end

MainDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TabFrame, _ENV
  self._backBtn = self:GetChild("BackBtn")
  ;
  (self._backBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._panel = self:GetChild("Frame")
  self._frame = (TabFrame.Create)(self._panel, self)
  self._imageBack = self:GetChild("ImageBack")
  self._pointList = {}
  for i = 1, 4 do
    -- DECOMPILER ERROR at PC34: Confused about usage of register: R5 in 'UnsetPending'

    (self._pointList)[i] = self:GetChild("CutBtnFrame/CutBtn" .. i)
  end
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshRedDot, Common.n_OnSActivityTasks, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshRedDot, Common.n_OnSRefreshActivityTask, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshRedDot, Common.n_BuyShopGood, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshRedDot, Common.n_RefreshShopInfo, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshRedDot, Common.n_RefreshCurrency, nil)
end

MainDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
  if self._frame then
    (self._frame):Destroy()
  end
  ;
  (DialogManager.DestroySingletonDialog)("bag.itemtipsdialog")
end

MainDialog.SetData = function(self, actId)
  -- function num : 0_3 , upvalues : _ENV
  self._actId = actId
  self._styleList = (self._bm):GetSubtabTypeCfgList(actId)
  for i,v in ipairs(self._styleList) do
    -- DECOMPILER ERROR at PC18: Confused about usage of register: R7 in 'UnsetPending'

    (self._cutBtnList)[i] = (DialogManager.CreateDialog)("activity.activitycommon.cutbtncell", ((self._pointList)[i])._uiObject)
    ;
    ((self._cutBtnList)[i]):Init(self, v)
  end
  self:ClickCutBtn(#self._cutBtnList)
  self:RefreshRedDot()
end

MainDialog.OnBackBtnClicked = function(self)
  -- function num : 0_4
  self:Destroy()
end

MainDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_5
  local data = (self._styleList)[index]
  if data then
    return (self._bm):GetPageName((data.cfg).tabType)
  end
end

MainDialog.DidToPage = function(self, frame, index)
  -- function num : 0_6
  if frame == self._frame then
    ((self._frame):GetCellAtIndex(index)):Refresh(self, (self._styleList)[index])
  end
end

MainDialog.AddNewModal = function(self, dialog)
  -- function num : 0_7 , upvalues : _ENV, ChildDialogs
  if (table.contain)(ChildDialogs, dialog._dialogName) then
    (self._rootWindow):SetActive(true)
  else
    ;
    (self._rootWindow):SetActive(false)
  end
end

MainDialog.OnDialogDestroy = function(self, notification)
  -- function num : 0_8
  if (notification.userInfo)._dialogName == "mainline.bossrush.checkotherroleinfodialog" then
    (self._rootWindow):SetActive(true)
  end
end

MainDialog.ClickCutBtn = function(self, id)
  -- function num : 0_9 , upvalues : _ENV, CImagePathTable
  (self._frame):ToPage(id)
  for i,v in ipairs(self._cutBtnList) do
    ((self._cutBtnList)[i]):SelectThisBtn(i == id)
  end
  local imageRecord = CImagePathTable:GetRecorder((((self._styleList)[id]).cfg).activeBackImg)
  if imageRecord then
    (self._imageBack):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  end
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

MainDialog.RefreshRedDot = function(self, info)
  -- function num : 0_10 , upvalues : _ENV
  if info and info.userInfo and info.userInfo == "close" then
    self:OnBackBtnClicked()
    return 
  end
  for i,v in ipairs(self._cutBtnList) do
    ((self._cutBtnList)[i]):CheckRedDot()
  end
end

return MainDialog

