local CStringRes = BeanManager.GetTableByName("message.cstringres")
local CElementEffect = BeanManager.GetTableByName("role.celementeffect")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CElementCfgTable = BeanManager.GetTableByName("role.celementcfg")
local CBattleStartProtocol = require("protocols.def.protocol.battle.cbattlestart")
local UIManager = CS.PixelNeko.UI.UIManager
local TeamElementInfoDialog = class("TeamElementInfoDialog", Dialog)
TeamElementInfoDialog.AssetBundleName = "ui/layouts.basecharacterinfo"
TeamElementInfoDialog.AssetName = "ElementTips2"
local elementNum = 3

function TeamElementInfoDialog:Ctor(...)
  TeamElementInfoDialog.super.Ctor(self, ...)
  self._groupName = "Tip"
end

function TeamElementInfoDialog:OnCreate()
  self._back = self:GetChild("Back")
  self._elementImg = {}
  self._elementEffect = {}
  self._elementName = {}
  self._elementNameColor = {}
  for i = 1, elementNum do
    self._elementImg[i] = self:GetChild("Back/Element" .. i)
    self._elementEffect[i] = self:GetChild("Back/Element" .. i .. "/Effect")
    self._elementName[i] = self:GetChild("Back/Element" .. i .. "/Text")
    self._elementNameColor[i] = self:GetChild("Back/Element" .. i .. "/TextSelect")
  end
  self._downTips = self:GetChild("Back/Tips")
  self._stage1Img = self:GetChild("Back/Stage1/Element")
  self._stage1Title = self:GetChild("Back/Stage1/Txt1")
  self._stage1Content = self:GetChild("Back/Stage1/Txt2")
  self._stage1ContentHighlight = self:GetChild("Back/Stage1/Txt2Light")
  self._stage1Spring2Content = self:GetChild("Back/Stage1/NewYearBuff")
  self._stage1SpringContentHighlight = self:GetChild("Back/Stage1/NewYearBuffLight")
  self._stage1Spring2Content:SetActive(false)
  self._stage1SpringContentHighlight:SetActive(false)
  self._stage2 = self:GetChild("Back/Stage2")
  self._stage2Img = self:GetChild("Back/Stage2/Element")
  self._stage2Title = self:GetChild("Back/Stage2/Txt1")
  self._stage2Content = self:GetChild("Back/Stage2/Txt2")
  self._stage2ContentHighlight = self:GetChild("Back/Stage2/Txt2Light")
  self._stage2Spring2Content = self:GetChild("Back/Stage2/NewYearBuff")
  self._stage2SpringContentHighlight = self:GetChild("Back/Stage2/NewYearBuffLight")
  self._stage2SpringContentIcon = self:GetChild("Back/Stage2/Item")
  LuaNotificationCenter.AddObserver(self, self.OnGlobalPointerDown, Common.n_GlobalPointerWillDown, nil)
end

function TeamElementInfoDialog:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
end

function TeamElementInfoDialog:SetData(element, stage, extraElemenEffect)
  for i = 1, elementNum do
    local imgRecord = CImagePathTable:GetRecorder(CElementCfgTable:GetRecorder(i).image) or DataCommon.DefaultImageAsset
    self._elementImg[i]:SetSprite(imgRecord.assetBundle, imgRecord.assetName)
    if element == i then
      self._elementEffect[i]:SetActive(true)
      self._elementName[i]:SetActive(false)
      self._elementNameColor[i]:SetActive(true)
    else
      self._elementEffect[i]:SetActive(false)
      self._elementName[i]:SetActive(true)
      self._elementNameColor[i]:SetActive(false)
    end
  end
  self._downTips:SetText(TextManager.GetText(CStringRes:GetRecorder(1493).msgTextID))
  local element1Record = CElementEffect:GetRecorder(1)
  local element2Record = CElementEffect:GetRecorder(2)
  self._stage2Spring2Content:SetActive(false)
  self._stage2SpringContentHighlight:SetActive(false)
  local effect1 = element1Record.effect
  local effect2 = element2Record.effect
  if extraElemenEffect then
    if extraElemenEffect.type == CBattleStartProtocol.SPRING_FESTIVAL then
      if extraElemenEffect.enable then
        self._stage2Spring2Content:SetActive(false)
        self._stage2SpringContentHighlight:SetActive(true)
        self._stage2SpringContentHighlight:SetText(extraElemenEffect.str)
        self._stage2SpringContentIcon:SetActive(true)
        local imgRecord = CImagePathTable:GetRecorder(extraElemenEffect.icon) or DataCommon.DefaultImageAsset
        self._stage2SpringContentIcon:SetSprite(imgRecord.assetBundle, imgRecord.assetName)
      elseif extraElemenEffect.str then
        self._stage2Spring2Content:SetActive(true)
        self._stage2SpringContentHighlight:SetActive(false)
        self._stage2Spring2Content:SetText(extraElemenEffect.str)
        self._stage2SpringContentIcon:SetActive(true)
        local imgRecord = CImagePathTable:GetRecorder(extraElemenEffect.icon) or DataCommon.DefaultImageAsset
        self._stage2SpringContentIcon:SetSprite(imgRecord.assetBundle, imgRecord.assetName)
      else
        self._stage2Spring2Content:SetActive(false)
        self._stage2SpringContentHighlight:SetActive(false)
      end
    elseif extraElemenEffect.type == CBattleStartProtocol.WEEK_BOSS then
      effect1 = element1Record.weekBossEffect
      effect2 = element2Record.weekBossEffect
    end
  end
  local imgRecord = CImagePathTable:GetRecorder(element1Record.image) or DataCommon.DefaultImageAsset
  self._stage1Img:SetSprite(imgRecord.assetBundle, imgRecord.assetName)
  self._stage1Title:SetText(TextManager.GetText(element1Record.describe))
  local str = TextManager.GetText(CStringRes:GetRecorder(1492).msgTextID)
  if stage == 1 then
    self._stage1Content:SetActive(false)
    self._stage1ContentHighlight:SetActive(true)
    self._stage1ContentHighlight:SetText(str .. tostring(math.floor(effect1 / 1000 * 100)) .. "%")
  else
    self._stage1Content:SetActive(true)
    self._stage1ContentHighlight:SetActive(false)
    self._stage1Content:SetText(str .. tostring(math.floor(effect1 / 1000 * 100)) .. "%")
  end
  imgRecord = CImagePathTable:GetRecorder(element2Record.image) or DataCommon.DefaultImageAsset
  self._stage2Img:SetSprite(imgRecord.assetBundle, imgRecord.assetName)
  self._stage2Title:SetText(TextManager.GetText(element2Record.describe))
  local str = TextManager.GetText(CStringRes:GetRecorder(1492).msgTextID)
  if stage == 2 then
    self._stage2Content:SetActive(false)
    self._stage2ContentHighlight:SetActive(true)
    self._stage2ContentHighlight:SetText(str .. tostring(math.floor(effect2 / 1000 * 100)) .. "%")
  else
    self._stage2Content:SetActive(true)
    self._stage2ContentHighlight:SetActive(false)
    self._stage2Content:SetText(str .. tostring(math.floor(effect2 / 1000 * 100)) .. "%")
  end
end

function TeamElementInfoDialog:HideStage2()
  self._stage2:SetActive(false)
end

function TeamElementInfoDialog:OnGlobalPointerDown(args)
  if not UIManager.RectangleContainsScreenPoint(self._back._uiObject, args.userInfo.eventData.position.x, args.userInfo.eventData.position.y) then
    self:OnBackBtnClicked()
  end
end

function TeamElementInfoDialog:OnBackBtnClicked()
  self:Destroy()
end

return TeamElementInfoDialog
