-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/aprilfoolsday/aprilfoolsdaymaindialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TabFrame = require("framework.ui.frame.tab.tabframe")
local CAprilFoolTalk = (BeanManager.GetTableByName)("activity.caprilfooltalk")
local CClownCfg = (BeanManager.GetTableByName)("activity.cclowncfg")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local SSendFoolsRedPoint = (LuaNetManager.GetProtocolDef)("protocol.activity.ssendfoolsredpoint")
local AprilFoolsDayMainDialog = class("AprilFoolsDayMainDialog", Dialog)
AprilFoolsDayMainDialog.AssetBundleName = "ui/layouts.activityaprilfools"
AprilFoolsDayMainDialog.AssetName = "ActivityAprilFoolsMain"
local BtnType = {Joker = 1, GardenParty = 2, Shop = 3}
AprilFoolsDayMainDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : AprilFoolsDayMainDialog, _ENV
  ((AprilFoolsDayMainDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
  self._bm = ((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.AprilFoolsDayActivityManagerID)
  self._shopId = ((DataCommon.AprilFoolsDayActivity).Shop).ShopID
end

AprilFoolsDayMainDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TabFrame, _ENV, CStringRes
  self._jokerBtn = self:GetChild("Cutbtn1")
  self._jokerBtnRedDot = self:GetChild("Cutbtn1/RedDot")
  self._jokerBtnTxt = self:GetChild("Cutbtn1/_Text")
  self._gardenPartyBtn = self:GetChild("Cutbtn2")
  self._gardenPartyBtnRedDot = self:GetChild("Cutbtn2/RedDot")
  ;
  (self._gardenPartyBtnRedDot):SetActive(false)
  self._gardenPartyBtnTxt = self:GetChild("Cutbtn2/_Text")
  self._shopBtn = self:GetChild("Cutbtn3")
  self._shopBtnRedDot = self:GetChild("Cutbtn3/RedDot")
  self._shopBtnTxt = self:GetChild("Cutbtn3/_Text")
  self._backBtn = self:GetChild("BackBtn")
  self._talkText = self:GetChild("Talk1/Text")
  self._fogBack = self:GetChild("FogBack")
  self._fog = self:GetChild("Fog")
  self._panel = self:GetChild("Frame")
  self._frame = (TabFrame.Create)(self._panel, self)
  ;
  (self._jokerBtn):Subscribe_PointerClickEvent(self.OnJokerBtnClicked, self)
  ;
  (self._gardenPartyBtn):Subscribe_PointerClickEvent(self.OnGardenPartyBtnClicked, self)
  ;
  (self._shopBtn):Subscribe_PointerClickEvent(self.OnShopBtnClicked, self)
  ;
  (self._backBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshBeatClownRedPoint, Common.n_SReceiveBeatClownReward, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshShopRedPoint, Common.n_BuyShopGood, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnSSendFoolsRedPoint, Common.n_SSendFoolsRedPoint, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnSBeatClownCrossDay, Common.n_SBeatClownCrossDay, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnSSendBeatClownActivity, Common.n_SSendBeatClownActivity, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnSSendFoolsShopActivity, Common.n_SSendFoolsShopActivity, nil)
  ;
  (self._jokerBtnTxt):SetText((TextManager.GetText)((CStringRes:GetRecorder(1838)).msgTextID))
  ;
  (self._gardenPartyBtnTxt):SetText((TextManager.GetText)((CStringRes:GetRecorder(1839)).msgTextID))
  ;
  (self._shopBtnTxt):SetText((TextManager.GetText)((CStringRes:GetRecorder(1840)).msgTextID))
  self:OnJokerBtnClicked()
  self:RefreshRedDot()
end

AprilFoolsDayMainDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
  if self._frame then
    (self._frame):Destroy()
  end
end

AprilFoolsDayMainDialog.RefreshRedDot = function(self)
  -- function num : 0_3 , upvalues : CClownCfg, SSendFoolsRedPoint
  (self._jokerBtnRedDot):SetActive(((self._bm):GetReceiveAwardTimes() < #CClownCfg:GetAllIds() and (self._bm):IsBeatClownOpen()))
  if (self._bm):GetRedDotStateWithType(SSendFoolsRedPoint.SHOP) then
    (self._shopBtnRedDot):SetActive((self._bm):IsShopOpen())
    -- DECOMPILER ERROR: 3 unprocessed JMP targets
  end
end

AprilFoolsDayMainDialog.RefreshBeatClownRedPoint = function(self, notification)
  -- function num : 0_4 , upvalues : CClownCfg
  (self._jokerBtnRedDot):SetActive(((notification.userInfo).times < #CClownCfg:GetAllIds() and (self._bm):IsBeatClownOpen()))
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

AprilFoolsDayMainDialog.RefreshShopRedPoint = function(self, notification)
  -- function num : 0_5 , upvalues : _ENV, SSendFoolsRedPoint
  if (notification.userInfo).shopId == self._shopId then
    local allFreeSoldOut = false
    for _,good in ipairs((notification.userInfo).refresh) do
      if good.discountPrice == 0 then
        allFreeSoldOut = true
        if good.goodRemain ~= 0 then
          allFreeSoldOut = false
          break
        end
      end
    end
    do
      if allFreeSoldOut then
        (self._bm):SetRedDotStateWithType(SSendFoolsRedPoint.SHOP, false)
        ;
        (self._shopBtnRedDot):SetActive(false)
      end
    end
  end
end

AprilFoolsDayMainDialog.OnSSendFoolsRedPoint = function(self, notification)
  -- function num : 0_6 , upvalues : SSendFoolsRedPoint
  if (self._bm):GetRedDotStateWithType(SSendFoolsRedPoint.SHOP) then
    (self._shopBtnRedDot):SetActive((self._bm):IsShopOpen())
  end
end

AprilFoolsDayMainDialog.OnSBeatClownCrossDay = function(self)
  -- function num : 0_7 , upvalues : BtnType
  if (self._frame):GetCurrentIndex() == BtnType.Joker then
    ((self._frame):GetCellAtIndex(BtnType.Joker)):Refresh()
  end
end

AprilFoolsDayMainDialog.OnSSendBeatClownActivity = function(self, notification)
  -- function num : 0_8 , upvalues : CClownCfg, BtnType
  (self._jokerBtnRedDot):SetActive(((notification.userInfo).receiveTimes < #CClownCfg:GetAllIds() and (self._bm):IsBeatClownOpen()))
  if (self._frame):GetCurrentIndex() == BtnType.Joker then
    ((self._frame):GetCellAtIndex(BtnType.Joker)):Refresh()
  end
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

AprilFoolsDayMainDialog.OnSSendFoolsShopActivity = function(self)
  -- function num : 0_9 , upvalues : SSendFoolsRedPoint
  if (self._bm):GetRedDotStateWithType(SSendFoolsRedPoint.SHOP) then
    (self._shopBtnRedDot):SetActive((self._bm):IsShopOpen())
  end
end

AprilFoolsDayMainDialog.OnJokerBtnClicked = function(self)
  -- function num : 0_10 , upvalues : BtnType
  (self._jokerBtn):SetSelected(true)
  ;
  (self._gardenPartyBtn):SetSelected(false)
  ;
  (self._shopBtn):SetSelected(false)
  ;
  (self._frame):ToPage(BtnType.Joker)
  self:OnTalkPanelClicked(BtnType.Joker)
  ;
  (self._fog):SetActive(true)
  ;
  (self._fogBack):SetActive(true)
end

AprilFoolsDayMainDialog.OnGardenPartyBtnClicked = function(self)
  -- function num : 0_11 , upvalues : BtnType
  (self._jokerBtn):SetSelected(false)
  ;
  (self._gardenPartyBtn):SetSelected(true)
  ;
  (self._shopBtn):SetSelected(false)
  ;
  (self._frame):ToPage(BtnType.GardenParty)
  self:OnTalkPanelClicked(BtnType.GardenParty)
  ;
  (self._fog):SetActive(true)
  ;
  (self._fogBack):SetActive(true)
end

AprilFoolsDayMainDialog.OnShopBtnClicked = function(self)
  -- function num : 0_12 , upvalues : _ENV, BtnType
  if (self._bm):IsShopOpen() then
    local protocol = (LuaNetManager.CreateProtocol)("protocol.shop.cgetshopinfo")
    protocol.shopId = ((DataCommon.AprilFoolsDayActivity).Shop).ShopID
    protocol:Send()
    ;
    (self._jokerBtn):SetSelected(false)
    ;
    (self._gardenPartyBtn):SetSelected(false)
    ;
    (self._shopBtn):SetSelected(true)
    ;
    (self._frame):ToPage(BtnType.Shop)
    self:OnTalkPanelClicked(BtnType.Shop)
    ;
    (self._fog):SetActive(false)
    ;
    (self._fogBack):SetActive(false)
  else
    do
      ;
      ((NekoData.BehaviorManager).BM_Message):SendMessageById(100461)
    end
  end
end

AprilFoolsDayMainDialog.OnBackBtnClicked = function(self)
  -- function num : 0_13
  self:Destroy()
end

AprilFoolsDayMainDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_14 , upvalues : BtnType
  if index == BtnType.Joker then
    return "activity.aprilfoolsday.beatjokerpage"
  else
    if index == BtnType.GardenParty then
      return "activity.aprilfoolsday.gardenpartypage"
    else
      if index == BtnType.Shop then
        return "activity.aprilfoolsday.shopmainpage"
      end
    end
  end
end

AprilFoolsDayMainDialog.DidToPage = function(self, frame, index)
  -- function num : 0_15 , upvalues : BtnType
  if frame == self._frame then
    if index == BtnType.Joker then
      local dialog = (self._frame):GetCellAtIndex(BtnType.Joker)
      dialog:Refresh()
      dialog:OnEnable()
    else
      do
        if index == BtnType.Shop then
          ((self._frame):GetCellAtIndex(BtnType.Shop)):RefreshGoodsData()
        end
      end
    end
  end
end

AprilFoolsDayMainDialog.OnTalkPanelClicked = function(self, index)
  -- function num : 0_16 , upvalues : CAprilFoolTalk, _ENV
  local record = CAprilFoolTalk:GetRecorder(index)
  local randomID = (math.random)(1, #record.textID)
  ;
  (self._talkText):SetText((TextManager.GetText)((record.textID)[randomID]))
end

return AprilFoolsDayMainDialog

