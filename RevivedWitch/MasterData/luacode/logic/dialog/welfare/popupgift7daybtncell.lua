-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/welfare/popupgift7daybtncell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CommonAwardStatus = (LuaNetManager.GetBeanDef)("protocol.common.commonawardstatus")
local PopUpGift7DayBtnCell = class("PopUpGift7DayBtnCell", Dialog)
PopUpGift7DayBtnCell.AssetBundleName = "ui/layouts.welfare"
PopUpGift7DayBtnCell.AssetName = "Promotions7DaysCell"
PopUpGift7DayBtnCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : PopUpGift7DayBtnCell
  ((PopUpGift7DayBtnCell.super).Ctor)(self, ...)
end

PopUpGift7DayBtnCell.OnCreate = function(self)
  -- function num : 0_1
  self._button = self:GetChild("Day")
  self._lock_panel = self:GetChild("Day/Lock")
  self._lock_panel_day = self:GetChild("Day/Lock/Text (1)")
  self._unlock_panel = self:GetChild("Day/Normal")
  self._unlock_panel_day = self:GetChild("Day/Normal/Text (1)")
  self._select_panel = self:GetChild("Day/Select")
  self._select_panel_day = self:GetChild("Day/Select/Text (1)")
  self._redDot = self:GetChild("Day/RedDot")
  ;
  (self._button):Subscribe_PointerClickEvent(self.OnBtnClicked, self)
end

PopUpGift7DayBtnCell.OnDestroy = function(self)
  -- function num : 0_2
end

PopUpGift7DayBtnCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : CommonAwardStatus, _ENV
  if data.status == CommonAwardStatus.LOCKED then
    (self._lock_panel):SetActive(true)
    ;
    (self._unlock_panel):SetActive(false)
  else
    if data.status == CommonAwardStatus.UNLOCKED then
      (self._lock_panel):SetActive(false)
      ;
      (self._unlock_panel):SetActive(true)
    else
      if data.status == CommonAwardStatus.FETCHED then
        (self._lock_panel):SetActive(false)
        ;
        (self._unlock_panel):SetActive(true)
      end
    end
  end
  ;
  (self._select_panel):SetActive(data.id == (self._delegate)._selectId)
  ;
  (self._select_panel_day):SetText(((NekoData.BehaviorManager).BM_Message):GetString(2241, {(data.record).days}))
  ;
  (self._lock_panel_day):SetText(((NekoData.BehaviorManager).BM_Message):GetString(2241, {(data.record).days}))
  ;
  (self._unlock_panel_day):SetText(((NekoData.BehaviorManager).BM_Message):GetString(2241, {(data.record).days}))
  ;
  (self._redDot):SetActive(data.status == CommonAwardStatus.UNLOCKED)
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

PopUpGift7DayBtnCell.OnBtnClicked = function(self)
  -- function num : 0_4
  (self._delegate):SetSelectId((self._cellData).id)
end

PopUpGift7DayBtnCell.OnEvent = function(self, eventName, arg)
  -- function num : 0_5
  if (self._cellData).id ~= (self._delegate)._selectId then
    (self._select_panel):SetActive(eventName ~= "SetSelectId")
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
  end
end

PopUpGift7DayBtnCell.RefreshImgByPointer = function(self, pointerDown)
  -- function num : 0_6 , upvalues : CImagePathTable, _ENV
  local imageRecord = nil
  if pointerDown then
    if (self._delegate)._selectedTab == ((self._cellData).record).id then
      if not CImagePathTable:GetRecorder(((self._cellData).record).tabImgSelectedsmall) then
        imageRecord = DataCommon.DefaultImageAsset
        if not CImagePathTable:GetRecorder(((self._cellData).record).tabImgsmall) then
          imageRecord = DataCommon.DefaultImageAsset
          if (self._delegate)._selectedTab == ((self._cellData).record).id then
            if not CImagePathTable:GetRecorder(((self._cellData).record).tabImgSelected) then
              imageRecord = DataCommon.DefaultImageAsset
              if not CImagePathTable:GetRecorder(((self._cellData).record).tabImg) then
                imageRecord = DataCommon.DefaultImageAsset
              end
              ;
              (self._img):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
            end
          end
        end
      end
    end
  end
end

return PopUpGift7DayBtnCell

