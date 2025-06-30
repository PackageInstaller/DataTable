-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/activitycommon/cutbtncell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CutBtnCell = class("CutBtnCell", Dialog)
CutBtnCell.AssetBundleName = "ui/layouts.activitycommon"
CutBtnCell.AssetName = "ActivityCommonMainCutBtn"
CutBtnCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : CutBtnCell
  ((CutBtnCell.super).Ctor)(self, ...)
end

CutBtnCell.OnCreate = function(self)
  -- function num : 0_1
  self._text = self:GetChild("CutBtn/Text")
  self._redDot = self:GetChild("CutBtn/RedDot")
  self._textImg = self:GetChild("CutBtn/TextImg")
  self._cutBtn = self:GetChild("CutBtn")
  ;
  (self._cutBtn):Subscribe_PointerClickEvent(self.OnCutBtnClicked, self)
end

CutBtnCell.OnDestroy = function(self)
  -- function num : 0_2
end

CutBtnCell.Init = function(self, delegate, data)
  -- function num : 0_3 , upvalues : _ENV, CImagePathTable
  self._data = data
  self._delegate = delegate
  ;
  (self._text):SetText((TextManager.GetText)((data.cfg).tabName))
  local imageRecord = CImagePathTable:GetRecorder((data.cfg).tabImg)
  if imageRecord then
    (self._cutBtn):SetTextImgNormal(imageRecord.assetBundle, imageRecord.assetName)
  end
  local imageRecord = CImagePathTable:GetRecorder((data.cfg).tabImgPre)
  if imageRecord then
    (self._cutBtn):SetTextImgSelected(imageRecord.assetBundle, imageRecord.assetName)
  end
  self:CheckRedDot()
  self:SelectThisBtn(false)
end

CutBtnCell.CheckRedDot = function(self)
  -- function num : 0_4
  local state = ((self._delegate)._bm):GetRedDot((self._delegate)._actId, ((self._data).cfg).tabType)
  ;
  (self._redDot):SetActive(state)
end

CutBtnCell.SelectThisBtn = function(self, state)
  -- function num : 0_5
  (self._cutBtn):SetSelected(state)
end

CutBtnCell.OnCutBtnClicked = function(self)
  -- function num : 0_6 , upvalues : _ENV
  do
    if ((self._delegate)._bm):IsShopTabType(((self._data).cfg).tabType) then
      local protocol = (LuaNetManager.CreateProtocol)("protocol.shop.cgetshopinfo")
      protocol.shopId = 48
      protocol:Send()
    end
    ;
    (self._delegate):ClickCutBtn((self._data).id)
  end
end

return CutBtnCell

