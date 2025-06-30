-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/character/characterelementinfodialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local CElementEffect = (BeanManager.GetTableByName)("role.celementeffect")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local Role = require("logic.manager.experimental.types.role")
local UIManager = ((CS.PixelNeko).UI).UIManager
local CharacterElementInfoDialog = class("CharacterElementInfoDialog", Dialog)
CharacterElementInfoDialog.AssetBundleName = "ui/layouts.basecharacterinfo"
CharacterElementInfoDialog.AssetName = "ElementTips"
CharacterElementInfoDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : CharacterElementInfoDialog
  ((CharacterElementInfoDialog.super).Ctor)(self, ...)
  self._groupName = "Tip"
end

CharacterElementInfoDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self._back = self:GetChild("Back")
  self._elementImg = self:GetChild("Back/Element")
  self._titleTxt = self:GetChild("Back/PropTxt")
  self._elementName = self:GetChild("Back/Prop")
  self._downTips = self:GetChild("Back/Tips")
  self._stage1Img = self:GetChild("Back/Stage1/Element")
  self._stage1Title = self:GetChild("Back/Stage1/Txt1")
  self._stage1Content = self:GetChild("Back/Stage1/Txt2")
  self._stage2Img = self:GetChild("Back/Stage2/Element")
  self._stage2Title = self:GetChild("Back/Stage2/Txt1")
  self._stage2Content = self:GetChild("Back/Stage2/Txt2")
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnGlobalPointerDown, Common.n_GlobalPointerWillDown, nil)
end

CharacterElementInfoDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
end

CharacterElementInfoDialog.SetData = function(self, roleId)
  -- function num : 0_3 , upvalues : Role, _ENV, CStringRes, CElementEffect, CImagePathTable
  local role = (Role.Create)(roleId)
  ;
  (self._elementImg):SetSprite((role:GetElementImageRecord()).assetBundle, (role:GetElementImageRecord()).assetName)
  ;
  (self._titleTxt):SetText((TextManager.GetText)((CStringRes:GetRecorder(1491)).msgTextID))
  ;
  (self._elementName):SetText(role:GetElementName())
  ;
  (self._downTips):SetText((TextManager.GetText)((CStringRes:GetRecorder(1493)).msgTextID))
  local elementRecord = CElementEffect:GetRecorder(1)
  if not CImagePathTable:GetRecorder(elementRecord.image) then
    local imgRecord = DataCommon.DefaultImageAsset
  end
  ;
  (self._stage1Img):SetSprite(imgRecord.assetBundle, imgRecord.assetName)
  ;
  (self._stage1Title):SetText((TextManager.GetText)(elementRecord.describe))
  local str = (TextManager.GetText)((CStringRes:GetRecorder(1492)).msgTextID)
  ;
  (self._stage1Content):SetText(str .. tostring((math.floor)(elementRecord.effect / 1000 * 100)) .. "%")
  elementRecord = CElementEffect:GetRecorder(2)
  if not CImagePathTable:GetRecorder(elementRecord.image) then
    imgRecord = DataCommon.DefaultImageAsset
  end
  ;
  (self._stage2Img):SetSprite(imgRecord.assetBundle, imgRecord.assetName)
  ;
  (self._stage2Title):SetText((TextManager.GetText)(elementRecord.describe))
  local str = (TextManager.GetText)((CStringRes:GetRecorder(1492)).msgTextID)
  ;
  (self._stage2Content):SetText(str .. tostring((math.floor)(elementRecord.effect / 1000 * 100)) .. "%")
end

CharacterElementInfoDialog.OnGlobalPointerDown = function(self, args)
  -- function num : 0_4 , upvalues : UIManager
  if not (UIManager.RectangleContainsScreenPoint)((self._back)._uiObject, (((args.userInfo).eventData).position).x, (((args.userInfo).eventData).position).y) then
    self:OnBackBtnClicked()
  end
end

CharacterElementInfoDialog.OnBackBtnClicked = function(self)
  -- function num : 0_5
  self:Destroy()
end

return CharacterElementInfoDialog

