local TabFrame = require("framework.ui.frame.tab.tabframe")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local MainDialog = class("MainDialog", Dialog)
MainDialog.AssetBundleName = "ui/layouts.activitycommon"
MainDialog.AssetName = "ActivityCommonMain"
local ChildDialogs = {
  "activity.springfestival.itembuydialog",
  "activity.springfestival.roleopstiondialog",
  "activity.activitycommon.skinlistdialog"
}

function MainDialog:Ctor(...)
  MainDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
  self._bm = NekoData.BehaviorManager.BM_CommonActivity
  self._cutBtnList = {}
end

function MainDialog:OnCreate()
  self._backBtn = self:GetChild("BackBtn")
  self._backBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._panel = self:GetChild("Frame")
  self._frame = TabFrame.Create(self._panel, self)
  self._imageBack = self:GetChild("ImageBack")
  self._pointList = {}
  for i = 1, 4 do
    self._pointList[i] = self:GetChild("CutBtnFrame/CutBtn" .. i)
  end
  LuaNotificationCenter.AddObserver(self, self.RefreshRedDot, Common.n_OnSActivityTasks, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshRedDot, Common.n_OnSRefreshActivityTask, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshRedDot, Common.n_BuyShopGood, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshRedDot, Common.n_RefreshShopInfo, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshRedDot, Common.n_RefreshCurrency, nil)
end

function MainDialog:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
  if self._frame then
    self._frame:Destroy()
  end
  DialogManager.DestroySingletonDialog("bag.itemtipsdialog")
end

function MainDialog:SetData(actId)
  self._actId = actId
  self._styleList = self._bm:GetSubtabTypeCfgList(actId)
  for i, v in ipairs(self._styleList) do
    self._cutBtnList[i] = DialogManager.CreateDialog("activity.activitycommon.cutbtncell", self._pointList[i]._uiObject)
    self._cutBtnList[i]:Init(self, v)
  end
  self:ClickCutBtn(#self._cutBtnList)
  self:RefreshRedDot()
end

function MainDialog:OnBackBtnClicked()
  self:Destroy()
end

function MainDialog:CellAtIndex(frame, index)
  local data = self._styleList[index]
  if data then
    return self._bm:GetPageName(data.cfg.tabType)
  end
end

function MainDialog:DidToPage(frame, index)
  if frame == self._frame then
    self._frame:GetCellAtIndex(index):Refresh(self, self._styleList[index])
  end
end

function MainDialog:AddNewModal(dialog)
  if table.contain(ChildDialogs, dialog._dialogName) then
    self._rootWindow:SetActive(true)
  else
    self._rootWindow:SetActive(false)
  end
end

function MainDialog:OnDialogDestroy(notification)
  if notification.userInfo._dialogName == "mainline.bossrush.checkotherroleinfodialog" then
    self._rootWindow:SetActive(true)
  end
end

function MainDialog:ClickCutBtn(id)
  self._frame:ToPage(id)
  for i, v in ipairs(self._cutBtnList) do
    self._cutBtnList[i]:SelectThisBtn(i == id)
  end
  local imageRecord = CImagePathTable:GetRecorder(self._styleList[id].cfg.activeBackImg)
  if imageRecord then
    self._imageBack:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  end
end

function MainDialog:RefreshRedDot(info)
  if info and info.userInfo and info.userInfo == "close" then
    self:OnBackBtnClicked()
    return
  end
  for i, v in ipairs(self._cutBtnList) do
    self._cutBtnList[i]:CheckRedDot()
  end
end

return MainDialog
