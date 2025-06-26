-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/welfare/returnwelfare/returnwelfaretabbtncell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local ReturnWelfareTabBtnCell = class("ReturnWelfareTabBtnCell", Dialog)
ReturnWelfareTabBtnCell.AssetBundleName = "ui/layouts.welfare"
ReturnWelfareTabBtnCell.AssetName = "ReturnWelfareGroupBtn"
ReturnWelfareTabBtnCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ReturnWelfareTabBtnCell
  ((ReturnWelfareTabBtnCell.super).Ctor)(self, ...)
end

ReturnWelfareTabBtnCell.OnCreate = function(self)
  -- function num : 0_1
  self._btnImg = self:GetChild("GroupBtn")
  self._name = self:GetChild("GroupBtn/Text")
  self._redDot = self:GetChild("GroupBtn/RedDot")
  ;
  (self._btnImg):Subscribe_PointerClickEvent(self.OnGroupBtnClicked, self)
  ;
  (self._btnImg):Subscribe_PointerDownEvent(self.OnGroupBtnPointerDown, self)
  ;
  (self._btnImg):Subscribe_PointerUpEvent(self.OnGroupBtnPointerUp, self)
  ;
  (self._btnImg):Subscribe_PointerCancelEvent(self.OnGroupBtnPointerUp, self)
end

ReturnWelfareTabBtnCell.OnDestroy = function(self)
  -- function num : 0_2
end

ReturnWelfareTabBtnCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : _ENV, CImagePathTable
  (self._redDot):SetActive(data.showRedDot)
  ;
  (self._name):SetText((TextManager.GetText)((data.record).name))
  local imageRecord = nil
  if (self._delegate)._selectedTab == (data.record).id then
    if not CImagePathTable:GetRecorder((data.record).tabImgSelected) then
      imageRecord = DataCommon.DefaultImageAsset
      if not CImagePathTable:GetRecorder((data.record).tabImg) then
        imageRecord = DataCommon.DefaultImageAsset
      end
      ;
      (self._btnImg):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    end
  end
end

ReturnWelfareTabBtnCell.OnGroupBtnClicked = function(self)
  -- function num : 0_4
  (self._delegate):SetSelectedTab(((self._cellData).record).id)
end

ReturnWelfareTabBtnCell.OnEvent = function(self, eventName, arg)
  -- function num : 0_5 , upvalues : CImagePathTable, _ENV
  if eventName == "SelectedTab" then
    local imageRecord = nil
    if (self._delegate)._selectedTab == ((self._cellData).record).id then
      if not CImagePathTable:GetRecorder(((self._cellData).record).tabImgSelected) then
        do
          imageRecord = DataCommon.DefaultImageAsset
          if not CImagePathTable:GetRecorder(((self._cellData).record).tabImg) then
            imageRecord = DataCommon.DefaultImageAsset
          end
          ;
          (self._btnImg):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
          if eventName == "RefreshReddot" and (arg.record).id == ((self._cellData).record).id then
            (self._redDot):SetActive(arg.showRedDot)
          end
        end
      end
    end
  end
end

ReturnWelfareTabBtnCell.RefreshImgByPointer = function(self, pointerDown)
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
            end
          end
        end
      end
    end
  end
end

ReturnWelfareTabBtnCell.OnGroupBtnPointerDown = function(self)
  -- function num : 0_7
  self:RefreshImgByPointer(true)
end

ReturnWelfareTabBtnCell.OnGroupBtnPointerUp = function(self)
  -- function num : 0_8
  self:RefreshImgByPointer(false)
end

return ReturnWelfareTabBtnCell

