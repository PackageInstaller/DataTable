-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/springfestival/redpackettabcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CGetSpringRedPacket = require("protocols.def.protocol.activity.cgetspringredpacket")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CTimedActivitySwitch = (BeanManager.GetTableByName)("activity.ctimedactivityswitch")
local SpringRedpacketUnlockRecord = CTimedActivitySwitch:GetRecorder(26001)
local timeutils = require("logic.utils.timeutils")
local RedPacketTabCell = class("RedPacketTabCell", Dialog)
RedPacketTabCell.AssetBundleName = "ui/layouts.activitynewyear"
RedPacketTabCell.AssetName = "ActivityNewYearRedBag"
RedPacketTabCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : RedPacketTabCell
  ((RedPacketTabCell.super).Ctor)(self, ...)
end

RedPacketTabCell.OnCreate = function(self)
  -- function num : 0_1 , upvalues : CGetSpringRedPacket, _ENV
  self._activeTimeText = self:GetChild("ActiveTime")
  self._tips = self:GetChild("Tips")
  self._activeRefreshText = self:GetChild("UITips3")
  self._loginGetBtn = self:GetChild("ImageBack1/GetBtn")
  self._loginGetBtnText = self:GetChild("ImageBack1/GetBtn/_Text2")
  self._loginImage = self:GetChild("ImageBack1/Image")
  self._loginDot = self:GetChild("ImageBack1/GetBtn/Dot")
  self._tips = self:GetChild("Tips")
  ;
  (self._tips):Subscribe_PointerClickEvent(self.OnTipBtnClicked, self)
  self._uitips = self:GetChild("UITips3")
  self._activeGetBtn = self:GetChild("ImageBack2/GetBtn")
  self._activeGetBtnText = self:GetChild("ImageBack2/GetBtn/_Text2")
  self._activeImage = self:GetChild("ImageBack2/Image")
  self._activeDot = self:GetChild("ImageBack2/GetBtn/Dot")
  ;
  (self._loginGetBtn):Subscribe_PointerClickEvent(function()
    -- function num : 0_1_0 , upvalues : self, CGetSpringRedPacket
    self:GetSpringRedPacket(CGetSpringRedPacket.FREE)
  end
, self)
  ;
  (self._activeGetBtn):Subscribe_PointerClickEvent(function()
    -- function num : 0_1_1 , upvalues : self, CGetSpringRedPacket
    self:GetSpringRedPacket(CGetSpringRedPacket.ACTIVE)
  end
, self)
  self._dm = ((NekoData.DataManager).DM_Activity):GetManager(DataCommon.SpringFestivalActivityManagerID)
  self._bm = ((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.SpringFestivalActivityManagerID)
  self:RefreshRedDot()
  ;
  (LuaNotificationCenter.AddObserver)(self, self.SetData, Common.n_SGetSpringRedPacket, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshRedDot, Common.n_RefreshSpringFestivalRedDot, nil)
end

RedPacketTabCell.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
end

RedPacketTabCell.SetData = function(self)
  -- function num : 0_3 , upvalues : _ENV, CGetSpringRedPacket, CImagePathTable
  (self._uitips):SetText((TextManager.GetText)(701731))
  local daliyTaskProgress = (((NekoData.BehaviorManager).BM_Task):GetActiveInfo()).current
  local redPacketState = ((self._bm):GetRedPacketState())
  -- DECOMPILER ERROR at PC16: Overwrote pending register: R3 in 'AssignReg'

  local imageRecord = .end
  if redPacketState[CGetSpringRedPacket.FREE] == 1 then
    (self._loginGetBtn):SetInteractable(false)
    ;
    (self._loginGetBtnText):SetText((TextManager.GetText)(701617))
    imageRecord = CImagePathTable:GetRecorder(13834)
    ;
    (self._loginImage):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  else
    ;
    (self._loginGetBtn):SetInteractable(true)
    ;
    (self._loginGetBtnText):SetText((TextManager.GetText)(701690))
    imageRecord = CImagePathTable:GetRecorder(13913)
    ;
    (self._loginImage):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  end
  if redPacketState[CGetSpringRedPacket.ACTIVE] == 1 then
    (self._activeGetBtn):SetInteractable(false)
    ;
    (self._activeGetBtnText):SetText((TextManager.GetText)(701617))
    imageRecord = CImagePathTable:GetRecorder(13834)
    ;
    (self._activeImage):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  else
    if daliyTaskProgress >= 100 then
      (self._activeGetBtnText):SetText((TextManager.GetText)(701690))
    else
      ;
      (self._activeGetBtnText):SetText((TextManager.GetText)(701749))
    end
    imageRecord = CImagePathTable:GetRecorder(13913)
    ;
    (self._activeImage):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  end
  ;
  (self._activeTimeText):SetText((TextManager.GetText)(701676))
end

RedPacketTabCell.RefreshRedDot = function(self)
  -- function num : 0_4 , upvalues : CGetSpringRedPacket, _ENV
  local redPacketState = (self._bm):GetRedPacketState()
  ;
  (self._activeDot):SetActive(redPacketState[CGetSpringRedPacket.ACTIVE] == 0 and (((NekoData.BehaviorManager).BM_Task):GetActiveInfo()).current >= 100)
  ;
  (self._loginDot):SetActive(redPacketState[CGetSpringRedPacket.FREE] == 0)
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

RedPacketTabCell.GetSpringRedPacket = function(self, type)
  -- function num : 0_5 , upvalues : timeutils, SpringRedpacketUnlockRecord, _ENV, CGetSpringRedPacket
  self._openTime = (timeutils.GetConfigFormatTimeStamp)(SpringRedpacketUnlockRecord.openTime)
  self._endTime = (timeutils.GetConfigFormatTimeStamp)(SpringRedpacketUnlockRecord.closeTime)
  if (ServerGameTimer.GetServerTime)() < self._openTime then
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100443)
    return 
  else
    if self._endTime < (ServerGameTimer.GetServerTime)() then
      ((NekoData.BehaviorManager).BM_Message):SendMessageById(100455)
      return 
    end
  end
  do
    if (((NekoData.BehaviorManager).BM_Task):GetActiveInfo()).current < 100 and type == CGetSpringRedPacket.ACTIVE then
      local dlg = (DialogManager.CreateSingletonDialog)("task.taskmaindialog")
      if dlg then
        dlg:ToPage(2)
      end
      return 
    end
    local csend = (LuaNetManager.CreateProtocol)("protocol.activity.cgetspringredpacket")
    csend.redPacketType = type
    csend:Send()
  end
end

RedPacketTabCell.OnTipBtnClicked = function(self)
  -- function num : 0_6 , upvalues : _ENV
  ((DialogManager.CreateSingletonDialog)("activity.springfestival.tipsdialog")):SetData(701660)
end

return RedPacketTabCell

