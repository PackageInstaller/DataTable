-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/teamedit/teamelementinfodialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local CElementEffect = (BeanManager.GetTableByName)("role.celementeffect")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CElementCfgTable = (BeanManager.GetTableByName)("role.celementcfg")
local CBattleStartProtocol = require("protocols.def.protocol.battle.cbattlestart")
local UIManager = ((CS.PixelNeko).UI).UIManager
local TeamElementInfoDialog = class("TeamElementInfoDialog", Dialog)
TeamElementInfoDialog.AssetBundleName = "ui/layouts.basecharacterinfo"
TeamElementInfoDialog.AssetName = "ElementTips2"
local elementNum = 3
TeamElementInfoDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : TeamElementInfoDialog
  ((TeamElementInfoDialog.super).Ctor)(self, ...)
  self._groupName = "Tip"
end

TeamElementInfoDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : elementNum, _ENV
  self._back = self:GetChild("Back")
  self._elementImg = {}
  self._elementEffect = {}
  self._elementName = {}
  self._elementNameColor = {}
  for i = 1, elementNum do
    -- DECOMPILER ERROR at PC22: Confused about usage of register: R5 in 'UnsetPending'

    (self._elementImg)[i] = self:GetChild("Back/Element" .. i)
    -- DECOMPILER ERROR at PC30: Confused about usage of register: R5 in 'UnsetPending'

    ;
    (self._elementEffect)[i] = self:GetChild("Back/Element" .. i .. "/Effect")
    -- DECOMPILER ERROR at PC38: Confused about usage of register: R5 in 'UnsetPending'

    ;
    (self._elementName)[i] = self:GetChild("Back/Element" .. i .. "/Text")
    -- DECOMPILER ERROR at PC46: Confused about usage of register: R5 in 'UnsetPending'

    ;
    (self._elementNameColor)[i] = self:GetChild("Back/Element" .. i .. "/TextSelect")
  end
  self._downTips = self:GetChild("Back/Tips")
  self._stage1Img = self:GetChild("Back/Stage1/Element")
  self._stage1Title = self:GetChild("Back/Stage1/Txt1")
  self._stage1Content = self:GetChild("Back/Stage1/Txt2")
  self._stage1ContentHighlight = self:GetChild("Back/Stage1/Txt2Light")
  self._stage1Spring2Content = self:GetChild("Back/Stage1/NewYearBuff")
  self._stage1SpringContentHighlight = self:GetChild("Back/Stage1/NewYearBuffLight")
  ;
  (self._stage1Spring2Content):SetActive(false)
  ;
  (self._stage1SpringContentHighlight):SetActive(false)
  self._stage2 = self:GetChild("Back/Stage2")
  self._stage2Img = self:GetChild("Back/Stage2/Element")
  self._stage2Title = self:GetChild("Back/Stage2/Txt1")
  self._stage2Content = self:GetChild("Back/Stage2/Txt2")
  self._stage2ContentHighlight = self:GetChild("Back/Stage2/Txt2Light")
  self._stage2Spring2Content = self:GetChild("Back/Stage2/NewYearBuff")
  self._stage2SpringContentHighlight = self:GetChild("Back/Stage2/NewYearBuffLight")
  self._stage2SpringContentIcon = self:GetChild("Back/Stage2/Item")
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnGlobalPointerDown, Common.n_GlobalPointerWillDown, nil)
end

TeamElementInfoDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
end

TeamElementInfoDialog.SetData = function(self, element, stage, extraElemenEffect)
  -- function num : 0_3 , upvalues : elementNum, CImagePathTable, CElementCfgTable, _ENV, CStringRes, CElementEffect, CBattleStartProtocol
  for i = 1, elementNum do
    if not CImagePathTable:GetRecorder((CElementCfgTable:GetRecorder(i)).image) then
      local imgRecord = DataCommon.DefaultImageAsset
    end
    ;
    ((self._elementImg)[i]):SetSprite(imgRecord.assetBundle, imgRecord.assetName)
    if element == i then
      ((self._elementEffect)[i]):SetActive(true)
      ;
      ((self._elementName)[i]):SetActive(false)
      ;
      ((self._elementNameColor)[i]):SetActive(true)
    else
      ;
      ((self._elementEffect)[i]):SetActive(false)
      ;
      ((self._elementName)[i]):SetActive(true)
      ;
      ((self._elementNameColor)[i]):SetActive(false)
    end
  end
  ;
  (self._downTips):SetText((TextManager.GetText)((CStringRes:GetRecorder(1493)).msgTextID))
  local element1Record = CElementEffect:GetRecorder(1)
  local element2Record = CElementEffect:GetRecorder(2)
  ;
  (self._stage2Spring2Content):SetActive(false)
  ;
  (self._stage2SpringContentHighlight):SetActive(false)
  local effect1 = element1Record.effect
  local effect2 = element2Record.effect
  if extraElemenEffect then
    if extraElemenEffect.type == CBattleStartProtocol.SPRING_FESTIVAL then
      if extraElemenEffect.enable then
        (self._stage2Spring2Content):SetActive(false)
        ;
        (self._stage2SpringContentHighlight):SetActive(true)
        ;
        (self._stage2SpringContentHighlight):SetText(extraElemenEffect.str)
        ;
        (self._stage2SpringContentIcon):SetActive(true)
        if not CImagePathTable:GetRecorder(extraElemenEffect.icon) then
          local imgRecord = DataCommon.DefaultImageAsset
        end
        ;
        (self._stage2SpringContentIcon):SetSprite(imgRecord.assetBundle, imgRecord.assetName)
      else
        do
          if extraElemenEffect.str then
            (self._stage2Spring2Content):SetActive(true)
            ;
            (self._stage2SpringContentHighlight):SetActive(false)
            ;
            (self._stage2Spring2Content):SetText(extraElemenEffect.str)
            ;
            (self._stage2SpringContentIcon):SetActive(true)
            if not CImagePathTable:GetRecorder(extraElemenEffect.icon) then
              local imgRecord = DataCommon.DefaultImageAsset
            end
            ;
            (self._stage2SpringContentIcon):SetSprite(imgRecord.assetBundle, imgRecord.assetName)
          else
            do
              ;
              (self._stage2Spring2Content):SetActive(false)
              ;
              (self._stage2SpringContentHighlight):SetActive(false)
              if extraElemenEffect.type == CBattleStartProtocol.WEEK_BOSS then
                effect1 = element1Record.weekBossEffect
                effect2 = element2Record.weekBossEffect
              end
              if not CImagePathTable:GetRecorder(element1Record.image) then
                local imgRecord = DataCommon.DefaultImageAsset
              end
              ;
              (self._stage1Img):SetSprite(imgRecord.assetBundle, imgRecord.assetName)
              ;
              (self._stage1Title):SetText((TextManager.GetText)(element1Record.describe))
              local str = (TextManager.GetText)((CStringRes:GetRecorder(1492)).msgTextID)
              if stage == 1 then
                (self._stage1Content):SetActive(false)
                ;
                (self._stage1ContentHighlight):SetActive(true)
                ;
                (self._stage1ContentHighlight):SetText(str .. tostring((math.floor)(effect1 / 1000 * 100)) .. "%")
              else
                ;
                (self._stage1Content):SetActive(true)
                ;
                (self._stage1ContentHighlight):SetActive(false)
                ;
                (self._stage1Content):SetText(str .. tostring((math.floor)(effect1 / 1000 * 100)) .. "%")
              end
              if not CImagePathTable:GetRecorder(element2Record.image) then
                imgRecord = DataCommon.DefaultImageAsset
              end
              ;
              (self._stage2Img):SetSprite(imgRecord.assetBundle, imgRecord.assetName)
              ;
              (self._stage2Title):SetText((TextManager.GetText)(element2Record.describe))
              local str = (TextManager.GetText)((CStringRes:GetRecorder(1492)).msgTextID)
              if stage == 2 then
                (self._stage2Content):SetActive(false)
                ;
                (self._stage2ContentHighlight):SetActive(true)
                ;
                (self._stage2ContentHighlight):SetText(str .. tostring((math.floor)(effect2 / 1000 * 100)) .. "%")
              else
                ;
                (self._stage2Content):SetActive(true)
                ;
                (self._stage2ContentHighlight):SetActive(false)
                ;
                (self._stage2Content):SetText(str .. tostring((math.floor)(effect2 / 1000 * 100)) .. "%")
              end
            end
          end
        end
      end
    end
  end
end

TeamElementInfoDialog.HideStage2 = function(self)
  -- function num : 0_4
  (self._stage2):SetActive(false)
end

TeamElementInfoDialog.OnGlobalPointerDown = function(self, args)
  -- function num : 0_5 , upvalues : UIManager
  if not (UIManager.RectangleContainsScreenPoint)((self._back)._uiObject, (((args.userInfo).eventData).position).x, (((args.userInfo).eventData).position).y) then
    self:OnBackBtnClicked()
  end
end

TeamElementInfoDialog.OnBackBtnClicked = function(self)
  -- function num : 0_6
  self:Destroy()
end

return TeamElementInfoDialog

