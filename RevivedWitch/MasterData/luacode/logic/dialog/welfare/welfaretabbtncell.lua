-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/welfare/welfaretabbtncell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local WelfareTabBtnCell = class("WelfareTabBtnCell", Dialog)
WelfareTabBtnCell.AssetBundleName = "ui/layouts.welfare"
WelfareTabBtnCell.AssetName = "WelfareMainGroupBtnCell"
WelfareTabBtnCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : WelfareTabBtnCell
  ((WelfareTabBtnCell.super).Ctor)(self, ...)
end

WelfareTabBtnCell.OnCreate = function(self)
  -- function num : 0_1
  self._groupBtn = self:GetChild("GroupBtn")
  self._img = self:GetChild("Img")
  self._name = self:GetChild("GroupBtn/Text")
  self._redDot = self:GetChild("GroupBtn/RedDot")
  ;
  (self._groupBtn):Subscribe_PointerClickEvent(self.OnGroupBtnClicked, self)
  ;
  (self._groupBtn):Subscribe_PointerDownEvent(self.OnGroupBtnPointerDown, self)
  ;
  (self._groupBtn):Subscribe_PointerUpEvent(self.OnGroupBtnPointerUp, self)
  ;
  (self._groupBtn):Subscribe_PointerCancelEvent(self.OnGroupBtnPointerUp, self)
end

WelfareTabBtnCell.OnDestroy = function(self)
  -- function num : 0_2
end

WelfareTabBtnCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : _ENV, CImagePathTable
  (self._name):SetText((TextManager.GetText)((data.record).name))
  local imageRecord = nil
  if (self._delegate)._selectedTab == (data.record).id then
    (self._groupBtn):SetSelected(true)
    if not CImagePathTable:GetRecorder((data.record).tabImgSelected) then
      imageRecord = DataCommon.DefaultImageAsset
      ;
      (self._groupBtn):SetSelected(false)
      if not CImagePathTable:GetRecorder((data.record).tabImg) then
        imageRecord = DataCommon.DefaultImageAsset
      end
      ;
      (self._img):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      ;
      (self._redDot):SetActive(data.showRedDot)
    end
  end
end

WelfareTabBtnCell.OnGroupBtnClicked = function(self)
  -- function num : 0_4 , upvalues : _ENV
  if ((self._cellData).record).id == (DataCommon.Activities).AccumulateCost and not ((NekoData.BehaviorManager).BM_Activity):IsActivityOpen((DataCommon.Activities).AccumulateCost) then
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100498)
    return 
  else
    ;
    (self._delegate):SetSelectedTab(((self._cellData).record).id)
  end
end

WelfareTabBtnCell.OnEvent = function(self, eventName, arg)
  -- function num : 0_5 , upvalues : CImagePathTable, _ENV
  if eventName == "SelectedTab" then
    local imageRecord = nil
    if (self._delegate)._selectedTab == ((self._cellData).record).id then
      (self._groupBtn):SetSelected(true)
      if not CImagePathTable:GetRecorder(((self._cellData).record).tabImgSelected) then
        do
          imageRecord = DataCommon.DefaultImageAsset
          ;
          (self._groupBtn):SetSelected(false)
          if not CImagePathTable:GetRecorder(((self._cellData).record).tabImg) then
            imageRecord = DataCommon.DefaultImageAsset
          end
          ;
          (self._img):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
          if eventName == "RefreshRedDot" and arg.tabId == ((self._cellData).record).id then
            (self._redDot):SetActive(arg.show)
          end
        end
      end
    end
  end
end

WelfareTabBtnCell.RefreshImgByPointer = function(self, pointerDown)
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

WelfareTabBtnCell.OnGroupBtnPointerDown = function(self)
  -- function num : 0_7
  self:RefreshImgByPointer(true)
end

WelfareTabBtnCell.OnGroupBtnPointerUp = function(self)
  -- function num : 0_8
  self:RefreshImgByPointer(false)
end

return WelfareTabBtnCell

