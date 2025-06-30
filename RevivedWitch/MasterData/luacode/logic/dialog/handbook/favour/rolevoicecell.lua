-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/handbook/favour/rolevoicecell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CFavourExp = (BeanManager.GetTableByName)("role.cfavourexp")
local RoleVoiceCell = class("RoleVoiceCell", Dialog)
RoleVoiceCell.AssetBundleName = "ui/layouts.tujian"
RoleVoiceCell.AssetName = "CharVoiceCell"
RoleVoiceCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : RoleVoiceCell
  ((RoleVoiceCell.super).Ctor)(self, ...)
end

RoleVoiceCell.OnCreate = function(self)
  -- function num : 0_1
  self._normal = self:GetChild("Normal")
  self._normal_name = self:GetChild("Normal/VoiceBack/Txt")
  self._playBtn = self:GetChild("Normal/VoiceBtn")
  self._canUnlockPanel = self:GetChild("UnLock")
  self._canUnlockPanel_btn = self:GetChild("UnLock/UnLockBtn")
  self._lockPanel = self:GetChild("Lock")
  self._lockPanel_heartInfo = {}
  for i = 1, 5 do
    -- DECOMPILER ERROR at PC32: Confused about usage of register: R5 in 'UnsetPending'

    (self._lockPanel_heartInfo)[i] = {}
    -- DECOMPILER ERROR at PC41: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self._lockPanel_heartInfo)[i]).back = self:GetChild("Lock/Heart" .. i .. "Back")
    -- DECOMPILER ERROR at PC49: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self._lockPanel_heartInfo)[i]).light = self:GetChild("Lock/Heart" .. i)
  end
  self._unlockCondition = self:GetChild("Lock/Detail")
  ;
  (self._rootWindow):Subscribe_PointerClickEvent(self.OnPlayBtnClick, self)
  ;
  (self._canUnlockPanel_btn):Subscribe_PointerClickEvent(self.OnUnlockBtnClick, self)
end

RoleVoiceCell.OnDestroy = function(self)
  -- function num : 0_2
end

RoleVoiceCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : _ENV, CFavourExp
  if data.tag == "Favour" then
    if (data.reward).received then
      (self._normal):SetActive(true)
      ;
      (self._playBtn):SetActive(true)
      ;
      (self._canUnlockPanel):SetActive(false)
      ;
      (self._lockPanel):SetActive(false)
      ;
      (self._normal_name):SetText((TextManager.GetText)(data.titleId))
    else
      if (data.reward).favourLv <= (self._delegate)._favourLv then
        (self._normal):SetActive(true)
        ;
        (self._playBtn):SetActive(false)
        ;
        (self._canUnlockPanel):SetActive(true)
        ;
        (self._lockPanel):SetActive(false)
        ;
        (self._normal_name):SetText((TextManager.GetText)(data.titleId))
      else
        ;
        (self._normal):SetActive(false)
        ;
        (self._canUnlockPanel):SetActive(false)
        ;
        (self._lockPanel):SetActive(true)
        ;
        (self._unlockCondition):SetText((string.gsub)((TextManager.GetText)(502721), "%$parameter1%$", (data.reward).favourLv))
        local maxHeartNum = (self._delegate)._maxHeartNum
        local record = CFavourExp:GetRecorder((data.reward).favourLv)
        local curHeartNum = record.heartnum / 10
        local integer, decimal = (math.modf)(curHeartNum)
        for i,v in ipairs(self._lockPanel_heartInfo) do
          if maxHeartNum < i then
            (v.back):SetActive(false)
            ;
            (v.light):SetActive(false)
          else
            if i - 1 < curHeartNum and curHeartNum < i then
              (v.light):SetFillAmount(decimal)
            else
              if i <= curHeartNum then
                (v.light):SetFillAmount(1)
              else
                ;
                (v.light):SetFillAmount(0)
              end
            end
          end
        end
      end
    end
  else
    do
      ;
      (self._normal):SetActive(true)
      ;
      (self._playBtn):SetActive(true)
      ;
      (self._canUnlockPanel):SetActive(false)
      ;
      (self._lockPanel):SetActive(false)
      ;
      (self._normal_name):SetText((TextManager.GetText)(data.titleId))
    end
  end
end

RoleVoiceCell.OnPlayBtnClick = function(self)
  -- function num : 0_4 , upvalues : _ENV
  if ((self._cellData).tag == "Favour" and ((self._cellData).reward).received) or (self._cellData).tag == "Other" then
    if not (DialogManager.GetDialog)("handbook.roledetailinfodialog") then
      local dialog = (DialogManager.GetDialog)("handbook.handbooksceneroledetailinfodialog")
    end
    if dialog then
      if (self._cellData).tag == "Favour" then
        dialog:SetVoiceAndLines2((self._delegate)._roleId, nil, (((NekoData.BehaviorManager).BM_Voice).HandbookVoiceType).relationVoice, (self._cellData).voiceIndex, (self._cellData).contentId, (self._cellData).animation, true)
      else
        dialog:SetVoiceAndLines2((self._delegate)._roleId, nil, (((NekoData.BehaviorManager).BM_Voice).HandbookVoiceType).otherVoice, (self._cellData).voiceIndex, (self._cellData).contentId, (self._cellData).animation, true)
      end
    end
  end
end

RoleVoiceCell.OnUnlockBtnClick = function(self)
  -- function num : 0_5 , upvalues : _ENV
  local csend = (LuaNetManager.CreateProtocol)("protocol.good.creceiveaward")
  csend.roleId = (self._delegate)._roleId
  csend.level = ((self._cellData).reward).favourLv
  csend:Send()
end

return RoleVoiceCell

