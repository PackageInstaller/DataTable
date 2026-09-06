local TableFrame = require("framework.ui.frame.table.tableframe")
local UIManager = CS.PixelNeko.UI.UIManager
local MailDialog = class("MailDialog", Dialog)
MailDialog.AssetBundleName = "ui/layouts.mail"
MailDialog.AssetName = "MailMainNew"

function MailDialog:Ctor(...)
  MailDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
  self._allTypeMailList = {}
  self._deleteIndexlist = {}
  self._addNewMailList = {}
  self._mailInfo = {}
  self._getBtnTag = false
  self._deleteBtnTag = false
  self._mailDetailInfo = nil
end

function MailDialog:OnCreate()
  self._closeBtn = self:GetChild("CloseBtn")
  self._num = self:GetChild("NumPanel/Num")
  self._numMax = self:GetChild("NumPanel/NumMax")
  self._getBtn = self:GetChild("GetBtnAll")
  self._deleteBtn = self:GetChild("DeleteBtn")
  self._recordBtn = self:GetChild("RecordBtn")
  self._getAttaBtn = self:GetChild("GetBtn")
  self._deleteOneBtn = self:GetChild("DeleteBtnOne")
  self._surveyBtn = self:GetChild("SurveyBtn")
  self._leftMailPanel = self:GetChild("LeftPanel/mailPanel")
  self._empty = self:GetChild("LeftPanel/Empty")
  self._rightDetailPanel = self:GetChild("RightPanel/DetailPanel")
  self._rightEmpty = self:GetChild("RightPanel/Empty")
  self._backBtn = self:GetChild("BackBtn")
  self._menuBtn = self:GetChild("MenuBtn")
  self._backBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._menuBtn:Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
  self._getBtn:Subscribe_PointerClickEvent(self.OnClickGetBtn, self)
  self._deleteBtn:Subscribe_PointerClickEvent(self.OnClickDeleteBtn, self)
  self._recordBtn:Subscribe_PointerClickEvent(self.OnClickRecordBtn, self)
  self._closeBtn:Subscribe_PointerClickEvent(self.OnCloseBtn, self)
  self._getAttaBtn:Subscribe_PointerClickEvent(self.OnGetAttaBtn, self)
  self._deleteOneBtn:Subscribe_PointerClickEvent(self.OnDeleteOneBtn, self)
  self._surveyBtn:Subscribe_PointerClickEvent(self.OnSurbeyBtn, self)
  self:LoadLocalData()
  self._leftFrame = TableFrame.Create(self._leftMailPanel, self, true, true)
  self._leftFrame:SetMargin(20, 20)
  self._leftFrame:ReloadAllCell()
  self._rightFrame = TableFrame.Create(self._rightDetailPanel, self, true, false)
  self:Refresh()
  LuaNotificationCenter.AddObserver(self, self.OnDialogDestroy, Common.n_DialogWillDestroy, nil)
  LuaNotificationCenter.AddObserver(self, self.OnRefresh, Common.n_MailInfoChange, nil)
  self._task = ServerGameTimer.AddTask(3600, 3600, function()
    LuaNotificationCenter.PostNotification(Common.n_MailInfoChange, DM_Mail, nil)
  end, nil)
end

function MailDialog:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
  self._leftFrame:Destroy()
  self._rightFrame:Destroy()
  if self._task then
    ServerGameTimer.RemoveTask(self._task)
    self._task = nil
  end
  DialogManager.DestroySingletonDialog("bag.itemtipsdialog")
  DialogManager.DestroySingletonDialog("equip.equiptipsdialog")
  DialogManager.DestroySingletonDialog("equip.equiptipspreviewdialog")
end

function MailDialog:IndexOf(uniqueId)
  for i, v in ipairs(self._allTypeMailList) do
    if v.uniqueId == uniqueId then
      return i
    end
  end
end

function MailDialog:KeyOf(uniqueId)
  for type, mailList in pairs(self._mailInfo.list) do
    for i, mail in ipairs(mailList) do
      if mail.uniqueId == uniqueId then
        return true
      end
    end
  end
end

function MailDialog:OnRefresh(notification)
  self._mailInfo = NekoData.BehaviorManager.BM_Mail:GetMail()
  while self._deleteIndexlist[#self._deleteIndexlist] do
    table.remove(self._deleteIndexlist, #self._deleteIndexlist)
  end
  for i, v in ipairs(self._allTypeMailList) do
    if not self:KeyOf(v.uniqueId) then
      table.insert(self._deleteIndexlist, i)
    end
  end
  while self._deleteIndexlist[#self._deleteIndexlist] do
    self:OnRemoveCell(self._deleteIndexlist[#self._deleteIndexlist])
    table.remove(self._allTypeMailList, self._deleteIndexlist[#self._deleteIndexlist])
    table.remove(self._deleteIndexlist, #self._deleteIndexlist)
  end
  while self._addNewMailList[#self._addNewMailList] do
    table.remove(self._addNewMailList, #self._addNewMailList)
  end
  for type, mailList in pairs(self._mailInfo.list) do
    for i, mail in ipairs(mailList) do
      local index = self:IndexOf(mail.uniqueId)
      if not index then
        table.insert(self._addNewMailList, mail)
      end
    end
  end
  table.sort(self._addNewMailList, function(a, b)
    return a.receiveTime < b.receiveTime
  end)
  while self._addNewMailList[#self._addNewMailList] do
    table.insert(self._allTypeMailList, 1, self._addNewMailList[#self._addNewMailList])
    self:OnInsertCell(1)
    table.remove(self._addNewMailList, #self._addNewMailList)
  end
  self:Refresh()
  if notification and notification.userInfo then
    if notification.userInfo.tag == "sdeletemails" and notification.userInfo.result == 1 and self._mailDetailInfo ~= nil and self._mailDetailInfo.uniqueId == notification.userInfo.uniqueId then
      self._rightFrame:Destroy()
      self._mailDetailInfo = nil
      self._getAttaBtn:SetActive(false)
      self._deleteOneBtn:SetActive(false)
      self._rightEmpty:SetActive(true)
      self._rightDetailPanel:SetActive(false)
    end
    if notification.userInfo.tag == "sreceivemails" then
      for i, v in ipairs(notification.userInfo.info) do
        if v.result == 1 then
          if self._mailDetailInfo ~= nil and self._mailDetailInfo.uniqueId == v.uniqueId then
            self:AttaBtnChangeStatus(false)
            self._rightFrame:FireEvent("sreceivemails", v.uniqueId)
          end
          self:OnRefreshCellByUniqueId(v.uniqueId)
        end
      end
    end
  end
  if self._mailDetailInfo ~= nil then
    local tag = false
    for i, v in ipairs(self._allTypeMailList) do
      if v.uniqueId == self._mailDetailInfo.uniqueId then
        tag = true
        self._mailDetailInfo = v
        break
      end
    end
    if tag then
      self:ShowMailDetail(self._mailDetailInfo)
    else
      self._rightFrame:Destroy()
      self._mailDetailInfo = nil
      self._getAttaBtn:SetActive(false)
      self._deleteOneBtn:SetActive(false)
      self._rightEmpty:SetActive(true)
      self._rightDetailPanel:SetActive(false)
    end
  end
end

function MailDialog:OnRemoveCell(index)
  local list = {}
  table.insert(list, index)
  self._leftFrame:RemoveCellsAtIndex(list)
  table.remove(list, 1)
end

function MailDialog:OnInsertCell(index)
  local list = {}
  table.insert(list, index)
  self._leftFrame:InsertCellsAtIndex(list)
  table.remove(list, 1)
end

function MailDialog:OnRefreshCellByUniqueId(id)
  for i, v in ipairs(self._allTypeMailList) do
    if v.uniqueId == id then
      self._leftFrame:FireEvent("RefreshCell", v)
    end
  end
end

function MailDialog:AttaBtnChangeStatus(status)
  self._getAttaBtn:SetActive(status)
  self._deleteOneBtn:SetActive(not status)
end

function MailDialog:SurveytnChangeStatus(status)
  self._surveyBtn:SetActive(status)
  self._deleteOneBtn:SetActive(not status)
end

function MailDialog:LoadLocalData()
  while self._allTypeMailList[#self._allTypeMailList] do
    table.remove(self._allTypeMailList, #self._allTypeMailList)
  end
  self._mailInfo = NekoData.BehaviorManager.BM_Mail:GetMail()
  for type, mailList in pairs(self._mailInfo.list) do
    for i, mail in ipairs(mailList) do
      table.insert(self._allTypeMailList, mail)
    end
  end
  table.sort(self._allTypeMailList, function(a, b)
    return a.receiveTime < b.receiveTime
  end)
  local indexList1 = {}
  local indexList = {}
  for index, mail in ipairs(self._allTypeMailList) do
    if mail.status == 0 then
      table.insert(indexList1, mail)
    else
      table.insert(indexList, mail)
    end
  end
  while self._allTypeMailList[#self._allTypeMailList] do
    table.remove(self._allTypeMailList, #self._allTypeMailList)
  end
  for i, v in ipairs(indexList) do
    table.insert(self._allTypeMailList, v)
  end
  for i, v in ipairs(indexList1) do
    table.insert(self._allTypeMailList, v)
  end
end

function MailDialog:Refresh()
  self._num:SetText(tostring(self._mailInfo.currentNum))
  self._numMax:SetText(tostring(self._mailInfo.maxNum))
  self._getAttaBtn:SetActive(false)
  self._deleteOneBtn:SetActive(false)
  self._getBtnTag = false
  self._deleteBtnTag = false
  self._rightEmpty:SetActive(true)
  self._rightDetailPanel:SetActive(false)
  if #self._allTypeMailList > 0 then
    self._empty:SetActive(false)
    self._leftMailPanel:SetActive(true)
  else
    self._empty:SetActive(true)
    self._leftMailPanel:SetActive(false)
  end
  for i, mail in ipairs(self._allTypeMailList) do
    if not self._getBtnTag and mail.status == 0 then
      self._getBtnTag = true
    end
    if not self._deleteBtnTag and mail.status ~= 0 then
      self._deleteBtnTag = true
    end
    if self._getBtnTag and self._deleteBtnTag then
      break
    end
  end
end

function MailDialog:ShowMailDetail(data)
  if not self._mailDetailInfo or self._mailDetailInfo and data.uniqueId ~= self._mailDetailInfo.uniqueId then
    self:GetRootWindow():PlayAnimation("MailSwitch")
  end
  self._mailDetailInfo = data
  self._rightFrame:Destroy()
  self._rightDetailPanel:SetActive(true)
  self._rightFrame = TableFrame.Create(self._rightDetailPanel, self, true, false)
  self._rightFrame:ReloadAllCell()
  self._rightEmpty:SetActive(false)
end

function MailDialog:OnClickGetBtn()
  if self._getBtnTag then
    local creceiveAll = LuaNetManager.CreateProtocol("protocol.mail.creceiveall")
    if creceiveAll then
      creceiveAll:Send()
    end
  else
    NekoData.BehaviorManager.BM_Message:SendMessageById(100010)
  end
end

function MailDialog:OnClickDeleteBtn()
  if self._deleteBtnTag then
    NekoData.BehaviorManager.BM_Message:AddSecondConfirmDialog(6, nil, function()
      local cdelete = LuaNetManager.CreateProtocol("protocol.mail.cdeleteread")
      if cdelete then
        cdelete:Send()
      end
    end, {}, nil, {})
  else
    NekoData.BehaviorManager.BM_Message:SendMessageById(100008)
  end
end

function MailDialog:OnClickRecordBtn()
  local cget = LuaNetManager.CreateProtocol("protocol.mail.cgetreceivingrecords")
  if cget then
    cget:Send()
  end
end

function MailDialog:OnBackBtnClicked()
  self:Destroy()
end

function MailDialog:OnMenuBtnClicked()
  DialogManager.CreateSingletonDialog("fastmenu.fastmenudialog")
end

function MailDialog:OnGetAttaBtn()
  if self._mailDetailInfo.id == 2456 or self._mailDetailInfo.id == DataCommon.ReturnBattlePass_MailId then
    local dialogName = "mail.mailroleoptionaldialog"
    local dialog = DialogManager.CreateSingletonDialog(dialogName)
    if dialog then
      dialog:SetData(self._mailDetailInfo.id, self._mailDetailInfo.uniqueId)
    end
    return
  end
  local creceiveOne = LuaNetManager.CreateProtocol("protocol.mail.creceiveone")
  if creceiveOne then
    creceiveOne.uniqueId = self._mailDetailInfo.uniqueId
    creceiveOne:Send()
  end
end

function MailDialog:OnDeleteOneBtn()
  NekoData.BehaviorManager.BM_Message:AddSecondConfirmDialog(5, nil, function()
    local cdeleteOne = LuaNetManager.CreateProtocol("protocol.mail.cdeleteone")
    if cdeleteOne then
      cdeleteOne.uniqueId = self._mailDetailInfo.uniqueId
      cdeleteOne:Send()
    end
  end, {}, nil, {})
end

function MailDialog:OnSurbeyBtn()
  local dialog = DialogManager.CreateSingletonDialog("survey.surveymaindialog")
  if dialog then
    dialog:Init(self._mailDetailInfo)
  end
end

function MailDialog:SetSelectedID(args, state)
  self._selectedID = args
  self._leftFrame:FireEvent("ChangedSelected", self._selectedID)
end

function MailDialog:NumberOfCell(frame)
  if frame == self._leftFrame then
    return #self._allTypeMailList
  end
  if frame == self._rightFrame then
    return 1
  end
end

function MailDialog:CellAtIndex(frame)
  if frame == self._leftFrame then
    return "mail.mailcell"
  end
  if frame == self._rightFrame then
    if self._mailDetailInfo.questId == 0 then
      return "mail.maildetailcell"
    elseif self._mailDetailInfo.questId > 0 then
      return "mail.maildetailcell"
    end
  end
end

function MailDialog:DataAtIndex(frame, index)
  if frame == self._leftFrame then
    return self._allTypeMailList[index]
  end
  if frame == self._rightFrame then
    return self._mailDetailInfo
  end
end

function MailDialog:AddNewModal(dialog)
  if not self._hide_dialogName then
    self._hide_dialogName = dialog._dialogName
    UIManager.SetLayer(self._rootWindow._uiObject.transform, Layers.InvisibleLayerID)
  end
end

function MailDialog:OnDialogDestroy(notification)
  if self._hide_dialogName and self._hide_dialogName == notification.userInfo._dialogName then
    self._hide_dialogName = false
    UIManager.SetLayer(self._rootWindow._uiObject.transform, self._rootWindow._uiObject.transform.parent.gameObject.layer)
  end
end

return MailDialog
