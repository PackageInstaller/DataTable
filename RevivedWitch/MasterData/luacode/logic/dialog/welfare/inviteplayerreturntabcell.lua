-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/welfare/inviteplayerreturntabcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TableFrame = require("framework.ui.frame.table.tableframe")
local GridFrame = require("framework.ui.frame.grid.gridframe")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local CTotalLoginActivity = (BeanManager.GetTableByName)("welfare.ctotalloginactivity")
local CInvitationGit = (BeanManager.GetTableByName)("welfare.cinvitationgit")
local Item = require("logic.manager.experimental.types.item")
local InvitePlayerReturnTabCell = class("InvitePlayerReturnTabCell", Dialog)
InvitePlayerReturnTabCell.AssetBundleName = "ui/layouts.welfare"
InvitePlayerReturnTabCell.AssetName = "ReturnWelfareInvite"
local GoodStatusType = {CannotBuy = 0, CanBuy = 1, BuyOver = 2}
InvitePlayerReturnTabCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : InvitePlayerReturnTabCell
  ((InvitePlayerReturnTabCell.super).Ctor)(self, ...)
  self._leftTime = nil
  self._shareCode = nil
  self._itemInfo = {}
  self._sendProtocol = false
end

InvitePlayerReturnTabCell.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self._itemName = {}
  self._itemImg = {}
  self._itemDiamondBtn = {}
  self._itemDiamondPrice = {}
  self._itemRMBBtn = {}
  self._itemRMBPrice = {}
  self._invitePlayerProgress = {}
  for i = 1, 2 do
    do
      -- DECOMPILER ERROR at PC25: Confused about usage of register: R5 in 'UnsetPending'

      (self._itemName)[i] = self:GetChild("BackImage/AwardBack" .. i .. "/ItemName")
      -- DECOMPILER ERROR at PC33: Confused about usage of register: R5 in 'UnsetPending'

      ;
      (self._itemImg)[i] = self:GetChild("BackImage/AwardBack" .. i .. "/Item")
      -- DECOMPILER ERROR at PC41: Confused about usage of register: R5 in 'UnsetPending'

      ;
      (self._itemDiamondBtn)[i] = self:GetChild("BackImage/AwardBack" .. i .. "/DiamondBtn")
      -- DECOMPILER ERROR at PC49: Confused about usage of register: R5 in 'UnsetPending'

      ;
      (self._itemDiamondPrice)[i] = self:GetChild("BackImage/AwardBack" .. i .. "/DiamondBtn/num")
      -- DECOMPILER ERROR at PC57: Confused about usage of register: R5 in 'UnsetPending'

      ;
      (self._itemRMBBtn)[i] = self:GetChild("BackImage/AwardBack" .. i .. "/RMBBtn")
      -- DECOMPILER ERROR at PC65: Confused about usage of register: R5 in 'UnsetPending'

      ;
      (self._itemRMBPrice)[i] = self:GetChild("BackImage/AwardBack" .. i .. "/RMBBtn/_Text")
      ;
      ((self._itemImg)[i]):Subscribe_PointerClickEvent(function()
    -- function num : 0_1_0 , upvalues : self, i
    self:OnItemImgClicked(i)
  end
, self)
      ;
      ((self._itemDiamondBtn)[i]):Subscribe_PointerClickEvent(function()
    -- function num : 0_1_1 , upvalues : self, i
    self:OnItemDiamondClicked(i)
  end
, self)
      ;
      ((self._itemRMBBtn)[i]):Subscribe_PointerClickEvent(function()
    -- function num : 0_1_2 , upvalues : self, i
    self:OnItemRMBClicked(i)
  end
, self)
      -- DECOMPILER ERROR at PC86: Confused about usage of register: R5 in 'UnsetPending'

      ;
      (self._invitePlayerProgress)[i] = {}
    end
  end
  -- DECOMPILER ERROR at PC94: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self._invitePlayerProgress)[1]).progressPanel = self:GetChild("ProgressBack")
  -- DECOMPILER ERROR at PC100: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self._invitePlayerProgress)[1]).progress = self:GetChild("ProgressBack/Progress")
  -- DECOMPILER ERROR at PC106: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self._invitePlayerProgress)[1]).num = self:GetChild("ProgressBack/Num/Num")
  -- DECOMPILER ERROR at PC112: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self._invitePlayerProgress)[1]).showTxt = self:GetChild("ProgressBack/Text")
  -- DECOMPILER ERROR at PC118: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self._invitePlayerProgress)[2]).progressPanel = self:GetChild("ProgressBack (1)")
  -- DECOMPILER ERROR at PC124: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self._invitePlayerProgress)[2]).progress = self:GetChild("ProgressBack (1)/Progress")
  -- DECOMPILER ERROR at PC130: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self._invitePlayerProgress)[2]).num = self:GetChild("ProgressBack (1)/Num/Num")
  -- DECOMPILER ERROR at PC136: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self._invitePlayerProgress)[2]).showTxt = self:GetChild("ProgressBack (1)/Text")
  self._inviteCodeTxt = self:GetChild("BackImage/InviteNum")
  self._invitePlayerNumTxt = self:GetChild("BackImage/InviteManNum")
  self._shareBtn = self:GetChild("BackImage/TnviteBtn")
  self._lastTimeTxt = self:GetChild("BackImage/Txt")
  self._manualTips = self:GetChild("BackImage/Tips")
  ;
  (self._shareBtn):Subscribe_PointerClickEvent(self.OnShareBtnClick, self)
  ;
  (self._manualTips):Subscribe_PointerClickEvent(self.OnManualTipsClicked, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRefreshData, Common.n_OpenInviteReturnPlayer, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnBuyResult, Common.n_BuyReturnGiftResult, nil)
end

InvitePlayerReturnTabCell.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
  if self._activityTask then
    (GameTimer.RemoveTask)(self._activityTask)
    self._activityTask = nil
  end
end

InvitePlayerReturnTabCell.RefreshTabCell = function(self)
  -- function num : 0_3 , upvalues : _ENV
  local protocol = ((NekoData.BehaviorManager).BM_ReturnWelfare):GetOpenBackInviteProtocolData()
  if protocol then
    self:OnRefreshData(protocol)
  end
end

InvitePlayerReturnTabCell.OnRefreshData = function(self, notification)
  -- function num : 0_4 , upvalues : _ENV, GoodStatusType, Item
  self._shareCode = (notification.userInfo).invitationCode
  ;
  (self._inviteCodeTxt):SetText(self._shareCode)
  local invitedPlayerNum = (notification.userInfo).inviteeNum
  ;
  (self._invitePlayerNumTxt):SetText(invitedPlayerNum)
  self._leftTime = ((NekoData.BehaviorManager).BM_Activity):GetOtherActivityLeftTimeWithActivityId((((NekoData.BehaviorManager).BM_ReturnWelfare).DisplayType).invitePlayerReturn)
  self:RefreshTime()
  if (notification.userInfo).returnTime > 0 then
    local str = (TextManager.GetText)(701723)
    ;
    (((self._invitePlayerProgress)[1]).showTxt):SetText(str)
    str = (TextManager.GetText)(701723)
    ;
    (((self._invitePlayerProgress)[2]).showTxt):SetText(str)
  else
    do
      if (notification.userInfo).discountTime > 0 then
        local str = (TextManager.GetText)(701732)
        local time = (notification.userInfo).discountTime / 1000
        local day = (math.floor)(time / 86400)
        str = (string.gsub)(str, "%$parameter1%$", tostring(day))
        ;
        (((self._invitePlayerProgress)[1]).showTxt):SetText(str)
        str = (TextManager.GetText)(701732)
        str = (string.gsub)(str, "%$parameter1%$", tostring(day))
        ;
        (((self._invitePlayerProgress)[2]).showTxt):SetText(str)
      else
        do
          local str = (TextManager.GetText)(701733)
          local time = self._leftTime / 1000
          do
            local day = (math.floor)(time / 86400)
            str = (string.gsub)(str, "%$parameter1%$", tostring(day))
            ;
            (((self._invitePlayerProgress)[1]).showTxt):SetText(str)
            str = (TextManager.GetText)(701733)
            str = (string.gsub)(str, "%$parameter1%$", tostring(day))
            ;
            (((self._invitePlayerProgress)[2]).showTxt):SetText(str)
            if self._activityTask then
              (GameTimer.RemoveTask)(self._activityTask)
              self._activityTask = nil
            end
            if not self._activityTask then
              self._activityTask = (GameTimer.AddTask)(0, 60, function()
    -- function num : 0_4_0 , upvalues : self
    self:RefreshTime()
  end
)
            end
            self._itemInfo = {}
            self._rmbGitCorrespondingDiamondGit = {}
            local index = 1
            for _,g in ipairs((notification.userInfo).goodInfo) do
              -- DECOMPILER ERROR at PC185: Confused about usage of register: R9 in 'UnsetPending'

              if g.correspondGift ~= 0 then
                (self._rmbGitCorrespondingDiamondGit)[g.goodId] = {diamondGit = g.correspondGift, index = index}
                index = index + 1
              end
            end
            self._gitStatus = {}
            local price = {}
            for i,g in ipairs((notification.userInfo).goodInfo) do
              -- DECOMPILER ERROR at PC200: Confused about usage of register: R10 in 'UnsetPending'

              (self._gitStatus)[g.goodId] = g.goodStatus
              price[g.goodId] = g.price
            end
            for _,g in ipairs((notification.userInfo).goodInfo) do
              if (self._rmbGitCorrespondingDiamondGit)[g.goodId] then
                local i = ((self._rmbGitCorrespondingDiamondGit)[g.goodId]).index
                local temp = {giftPackId = g.goodId, itemId = g.itemId, itemNum = g.itemNum, chargeId = g.chargeId}
                -- DECOMPILER ERROR at PC230: Confused about usage of register: R12 in 'UnsetPending'

                ;
                (self._itemInfo)[i] = temp
                ;
                ((self._itemRMBPrice)[i]):SetText(g.price)
                ;
                ((self._itemDiamondPrice)[i]):SetText(price[((self._rmbGitCorrespondingDiamondGit)[g.goodId]).diamondGit])
                LogInfoFormat("InvitePlayerReturnTabCell", "packgoodid %s diamond status %s rmb status %s", g.goodId, (self._gitStatus)[((self._rmbGitCorrespondingDiamondGit)[g.goodId]).diamondGit], g.goodStatus)
                if (self._gitStatus)[((self._rmbGitCorrespondingDiamondGit)[g.goodId]).diamondGit] == GoodStatusType.BuyOver then
                  ((self._itemDiamondBtn)[i]):SetActive(false)
                end
                if g.goodStatus == GoodStatusType.CannotBuy then
                  ((self._itemRMBBtn)[i]):SetInteractable(false)
                else
                  if g.goodStatus == GoodStatusType.CanBuy then
                    ((self._itemRMBBtn)[i]):SetInteractable(true)
                  else
                    if g.goodStatus == GoodStatusType.BuyOver then
                      ((self._itemRMBBtn)[i]):SetActive(false)
                    end
                  end
                end
                if (self._gitStatus)[((self._rmbGitCorrespondingDiamondGit)[g.goodId]).diamondGit] == GoodStatusType.BuyOver or g.goodStatus == GoodStatusType.BuyOver then
                  (((self._invitePlayerProgress)[i]).progressPanel):SetActive(false)
                else
                  ;
                  (((self._invitePlayerProgress)[i]).progressPanel):SetActive(true)
                end
                local giftPackItem = (Item.Create)(g.goodId)
                ;
                ((self._itemName)[i]):SetText(giftPackItem:GetName())
                local imageRecord = giftPackItem:GetIcon()
                ;
                ((self._itemImg)[i]):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
                local inviteeLimit = ((notification.userInfo).inviteeLimit)[i]
                local str = (TextManager.GetText)(701725)
                str = (string.gsub)(str, "%$parameter1%$", invitedPlayerNum)
                str = (string.gsub)(str, "%$parameter2%$", inviteeLimit)
                ;
                (((self._invitePlayerProgress)[i]).num):SetText(str)
                ;
                (((self._invitePlayerProgress)[i]).progress):SetFillAmount(invitedPlayerNum / inviteeLimit)
              end
            end
          end
        end
      end
    end
  end
end

InvitePlayerReturnTabCell.OnBuyResult = function(self, notification)
  -- function num : 0_5 , upvalues : _ENV
  local ResultType = {Failed = 0, Success = 1}
  local protocolGiftId = (notification.userInfo).giftID
  LogInfoFormat("InvitePlayerReturnTabCell", "OnBuyResult notification.userInfo.result %s notification.userInfo.giftID %s", (notification.userInfo).result, protocolGiftId)
  if (notification.userInfo).result == ResultType.Success then
    for i,v in ipairs(self._itemInfo) do
      if v.giftPackId == protocolGiftId or ((self._rmbGitCorrespondingDiamondGit)[v.giftPackId]).diamondGit == protocolGiftId then
        ((self._itemDiamondBtn)[i]):SetActive(false)
        ;
        ((self._itemRMBBtn)[i]):SetActive(false)
        ;
        (((self._invitePlayerProgress)[i]).progressPanel):SetActive(false)
      end
    end
  end
  do
    self._sendProtocol = false
  end
end

InvitePlayerReturnTabCell.RefreshTime = function(self)
  -- function num : 0_6 , upvalues : _ENV
  if self._leftTime then
    local time = self._leftTime / 1000
    local day = (math.floor)(time / 86400)
    local hour = (math.floor)((time - day * 24 * 60 * 60) / 3600)
    local min = (math.floor)((time - day * 24 * 60 * 60 - hour * 60 * 60) / 60)
    local sec = (math.floor)(time - day * 24 * 60 * 60 - hour * 60 * 60 - min * 60)
    local str = (TextManager.GetText)(701592)
    str = (string.gsub)(str, "%$parameter1%$", tostring(day))
    ;
    (self._lastTimeTxt):SetText(str)
  end
end

InvitePlayerReturnTabCell.OnItemImgClicked = function(self, i)
  -- function num : 0_7 , upvalues : _ENV
  local dialog = (DialogManager.CreateSingletonDialog)("welfare.returnwelfare.giftpackageitemshowdialog")
  if dialog then
    dialog:SetData((self._itemInfo)[i])
  end
end

InvitePlayerReturnTabCell.OnItemDiamondClicked = function(self, i)
  -- function num : 0_8 , upvalues : GoodStatusType, _ENV
  local giftPackId = ((self._rmbGitCorrespondingDiamondGit)[((self._itemInfo)[i]).giftPackId]).diamondGit
  if (self._gitStatus)[giftPackId] == GoodStatusType.CannotBuy then
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100454)
  else
    if (self._gitStatus)[giftPackId] == GoodStatusType.CanBuy then
      local protocol = (LuaNetManager.CreateProtocol)("protocol.shop.cbuyreturngift")
      if protocol and not self._sendProtocol then
        self._sendProtocol = true
        protocol.giftID = giftPackId
        protocol.giftType = protocol.INVITATE
        protocol:Send()
      end
    end
  end
end

InvitePlayerReturnTabCell.OnItemRMBClicked = function(self, i)
  -- function num : 0_9 , upvalues : _ENV
  local cmd = (LuaNetManager.CreateProtocol)("protocol.charge.cbuydiamond")
  cmd.goodId = ((self._itemInfo)[i]).chargeId
  cmd:Send()
  if SdkManager.IsOverseas then
    local d = {goodId = tostring(((self._itemInfo)[i]).goodId), cashPrice = (SdkManager.GetPrice)(((self._itemInfo)[i]).chargeNum), diamondPrice = "0"}
    ;
    (SdkManager.Report)("purchase_click", d)
    ;
    (SdkManager.Report)("purchase_click_GP_ONCE", d)
    ;
    (SdkManager.Report)((string.format)("purchase_click_%s", d.goodId), d)
  end
end

InvitePlayerReturnTabCell.OnShareBtnClick = function(self)
  -- function num : 0_10 , upvalues : _ENV
  if not self._shareCode then
    return 
  end
  local dlg = (DialogManager.CreateSingletonDialog)("welfare.inviteshareresultdlg")
  local showShare = true
  local shared = true
  dlg:Init(showShare, self._shareCode, shared)
  local msg = (TextManager.GetText)(((NekoData.BehaviorManager).BM_Gacha):GetShareTextID())
  msg = (string.gsub)(msg, "%$parameter1%$", self._shareCode)
  ;
  (self:GetRootWindow()):CopyToClipBoard(msg)
  if (DialogManager.GetDialog)("welfare.welfaremaindialog") then
    (DialogManager.DestroySingletonDialog)("welfare.welfaremaindialog")
  end
end

InvitePlayerReturnTabCell.OnManualTipsClicked = function(self)
  -- function num : 0_11 , upvalues : _ENV
  local dialog = (DialogManager.CreateSingletonDialog)("welfare.returnwelfare.returnruletipsdialog")
  if dialog then
    dialog:Init((dialog.TipsType).InvitePlayer)
  end
end

return InvitePlayerReturnTabCell

