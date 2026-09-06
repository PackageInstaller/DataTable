local CGetSpringRedPacket = require("protocols.def.protocol.activity.cgetspringredpacket")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CTimedActivitySwitch = BeanManager.GetTableByName("activity.ctimedactivityswitch")
local SpringRedpacketUnlockRecord = CTimedActivitySwitch:GetRecorder(26001)
local timeutils = require("logic.utils.timeutils")
local RedPacketTabCell = class("RedPacketTabCell", Dialog)
RedPacketTabCell.AssetBundleName = "ui/layouts.activitynewyear"
RedPacketTabCell.AssetName = "ActivityNewYearRedBag"

function RedPacketTabCell:Ctor(...)
  RedPacketTabCell.super.Ctor(self, ...)
end

function RedPacketTabCell:OnCreate()
  self._activeTimeText = self:GetChild("ActiveTime")
  self._tips = self:GetChild("Tips")
  self._activeRefreshText = self:GetChild("UITips3")
  self._loginGetBtn = self:GetChild("ImageBack1/GetBtn")
  self._loginGetBtnText = self:GetChild("ImageBack1/GetBtn/_Text2")
  self._loginImage = self:GetChild("ImageBack1/Image")
  self._loginDot = self:GetChild("ImageBack1/GetBtn/Dot")
  self._tips = self:GetChild("Tips")
  self._tips:Subscribe_PointerClickEvent(self.OnTipBtnClicked, self)
  self._uitips = self:GetChild("UITips3")
  self._activeGetBtn = self:GetChild("ImageBack2/GetBtn")
  self._activeGetBtnText = self:GetChild("ImageBack2/GetBtn/_Text2")
  self._activeImage = self:GetChild("ImageBack2/Image")
  self._activeDot = self:GetChild("ImageBack2/GetBtn/Dot")
  self._loginGetBtn:Subscribe_PointerClickEvent(function()
    self:GetSpringRedPacket(CGetSpringRedPacket.FREE)
  end, self)
  self._activeGetBtn:Subscribe_PointerClickEvent(function()
    self:GetSpringRedPacket(CGetSpringRedPacket.ACTIVE)
  end, self)
  self._dm = NekoData.DataManager.DM_Activity:GetManager(DataCommon.SpringFestivalActivityManagerID)
  self._bm = NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.SpringFestivalActivityManagerID)
  self:RefreshRedDot()
  LuaNotificationCenter.AddObserver(self, self.SetData, Common.n_SGetSpringRedPacket, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshRedDot, Common.n_RefreshSpringFestivalRedDot, nil)
end

function RedPacketTabCell:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
end

function RedPacketTabCell:SetData()
  self._uitips:SetText(TextManager.GetText(701731))
  local daliyTaskProgress = NekoData.BehaviorManager.BM_Task:GetActiveInfo().current
  local redPacketState = self._bm:GetRedPacketState()
  local imageRecord
  if redPacketState[CGetSpringRedPacket.FREE] == 1 then
    self._loginGetBtn:SetInteractable(false)
    self._loginGetBtnText:SetText(TextManager.GetText(701617))
    imageRecord = CImagePathTable:GetRecorder(13834)
    self._loginImage:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  else
    self._loginGetBtn:SetInteractable(true)
    self._loginGetBtnText:SetText(TextManager.GetText(701690))
    imageRecord = CImagePathTable:GetRecorder(13913)
    self._loginImage:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  end
  if redPacketState[CGetSpringRedPacket.ACTIVE] == 1 then
    self._activeGetBtn:SetInteractable(false)
    self._activeGetBtnText:SetText(TextManager.GetText(701617))
    imageRecord = CImagePathTable:GetRecorder(13834)
    self._activeImage:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  else
    if 100 <= daliyTaskProgress then
      self._activeGetBtnText:SetText(TextManager.GetText(701690))
    else
      self._activeGetBtnText:SetText(TextManager.GetText(701749))
    end
    imageRecord = CImagePathTable:GetRecorder(13913)
    self._activeImage:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  end
  self._activeTimeText:SetText(TextManager.GetText(701676))
end

function RedPacketTabCell:RefreshRedDot()
  local redPacketState = self._bm:GetRedPacketState()
  self._activeDot:SetActive(redPacketState[CGetSpringRedPacket.ACTIVE] == 0 and NekoData.BehaviorManager.BM_Task:GetActiveInfo().current >= 100)
  self._loginDot:SetActive(redPacketState[CGetSpringRedPacket.FREE] == 0)
end

function RedPacketTabCell:GetSpringRedPacket(type)
  self._openTime = timeutils.GetConfigFormatTimeStamp(SpringRedpacketUnlockRecord.openTime)
  self._endTime = timeutils.GetConfigFormatTimeStamp(SpringRedpacketUnlockRecord.closeTime)
  if ServerGameTimer.GetServerTime() < self._openTime then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100443)
    return
  elseif ServerGameTimer.GetServerTime() > self._endTime then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100455)
    return
  end
  if NekoData.BehaviorManager.BM_Task:GetActiveInfo().current < 100 and type == CGetSpringRedPacket.ACTIVE then
    local dlg = DialogManager.CreateSingletonDialog("task.taskmaindialog")
    if dlg then
      dlg:ToPage(2)
    end
    return
  end
  local csend = LuaNetManager.CreateProtocol("protocol.activity.cgetspringredpacket")
  csend.redPacketType = type
  csend:Send()
end

function RedPacketTabCell:OnTipBtnClicked()
  DialogManager.CreateSingletonDialog("activity.springfestival.tipsdialog"):SetData(701660)
end

return RedPacketTabCell
