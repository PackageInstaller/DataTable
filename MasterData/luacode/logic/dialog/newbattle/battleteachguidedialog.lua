local CBattleGuideLinkConfig = BeanManager.GetTableByName("guide.cbattleguidelinkconfig")
local CBattleGuideConfig = BeanManager.GetTableByName("guide.cbattleguideconfig")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CDungeonBuffType = BeanManager.GetTableByName("sceneinteractive.cdungeonbufftype")
local GuidTypes = LuaNetManager.GetBeanDef("protocol.user.guidtypes")
local BattleTeachGuideDialog = class("BattleTeachGuideDialog", Dialog)
BattleTeachGuideDialog.AssetBundleName = "ui/layouts.guide"
BattleTeachGuideDialog.AssetName = "BattleGuideTips"

function BattleTeachGuideDialog:Ctor(...)
  BattleTeachGuideDialog.super.Ctor(self, ...)
  self._groupName = "Tip"
  self._stepList = {}
  self._curStep = nil
  self._maxStep = nil
end

function BattleTeachGuideDialog:OnCreate()
  self._currentStep = self:GetChild("Num1")
  self._currentStep:SetActive(false)
  self._totalStep = self:GetChild("Num2")
  self._totalStep:SetActive(false)
  self._guideImg = self:GetChild("GuideImgBack/GuideImg")
  self._text = self:GetChild("Tips")
  self._leftArrow = self:GetChild("LeftArrow")
  self._rightArrow = self:GetChild("RightArrow")
  self._closeBtn = self:GetChild("CloseBtn")
  self._titleTxt = self:GetChild("Title")
  self._leftArrow:Subscribe_PointerClickEvent(self.OnLeftArrowClick, self)
  self._rightArrow:Subscribe_PointerClickEvent(self.OnRightArrowClick, self)
  self._closeBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  local dialog = DialogManager.GetDialog("loadingdialog")
  if dialog then
    LuaNotificationCenter.AddObserver(self, self.OnDialogDestroy, Common.n_DialogWillDestroy, nil)
  end
end

function BattleTeachGuideDialog:OnDestroy()
  if self._isBattleGuide then
    self._isBattleGuide = false
    NekoData.DataManager.DM_TimeScale:CancelBattleGuidePause()
  end
  if self._buffGuide then
    self._buffGuide = false
    NekoData.DataManager.DM_TimeScale:CancelGamePause()
  end
  LuaNotificationCenter.RemoveObserver(self)
end

function BattleTeachGuideDialog:Init(guideId, isBattleGuide)
  self._guideId = guideId
  self._isBattleGuide = isBattleGuide
  if self._isBattleGuide then
    NekoData.DataManager.DM_TimeScale:SetBattleGuidePause()
  elseif NekoData.BehaviorManager.BM_Game:GetPlayBuffGuideId() then
    local allIds = CDungeonBuffType:GetAllIds()
    local len = #allIds
    for i = 1, len do
      local record = CDungeonBuffType:GetRecorder(allIds[i])
      if record.guideID and record.guideID == self._guideId then
        self._buffGuide = true
        NekoData.DataManager.DM_TimeScale:SetGamePause()
        break
      end
    end
  end
  for i, v in ipairs(CBattleGuideLinkConfig:GetRecorder(guideId).parm) do
    table.insert(self._stepList, tonumber(v))
  end
  local count = #self._stepList
  if 0 < count then
    self._maxStep = count
    self._totalStep:SetText(count)
    self:Refresh(1)
  else
    self._leftArrow:SetActive(false)
    self._rightArrow:SetActive(false)
    self._closeBtn:SetActive(false)
  end
end

function BattleTeachGuideDialog:Refresh(step)
  self._curStep = step
  if step == 1 then
    self._leftArrow:SetActive(false)
  else
    self._leftArrow:SetActive(true)
  end
  if step == self._maxStep then
    self._rightArrow:SetActive(false)
    self._closeBtn:SetActive(true)
  else
    self._rightArrow:SetActive(true)
    self._closeBtn:SetActive(false)
  end
  local record = CBattleGuideConfig:GetRecorder(self._stepList[step])
  self._titleTxt:SetText(TextManager.GetText(record.titlewordid))
  self._currentStep:SetText(step)
  local imageRecord = CImagePathTable:GetRecorder(record.imgid) or DataCommon.DefaultImageAsset
  self._guideImg:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._text:SetText(TextManager.GetText(record.wordid))
end

function BattleTeachGuideDialog:OnLeftArrowClick()
  self:Refresh(self._curStep - 1)
end

function BattleTeachGuideDialog:OnRightArrowClick()
  self:Refresh(self._curStep + 1)
end

function BattleTeachGuideDialog:OnBackBtnClicked()
  if self._guideId == 8 then
    local tag = NekoData.BehaviorManager.BM_Game:GetGuideTagByType(GuidTypes.SUPPORT_GUIDE)
    if tag and tag == 0 then
      NekoData.BehaviorManager.BM_Game:SetGuideTag(GuidTypes.SUPPORT_GUIDE, 1)
    end
  elseif self._guideId == 9 then
    local tag = NekoData.BehaviorManager.BM_Game:GetGuideTagByType(GuidTypes.BATTLE_RETREAT)
    if tag and tag == 0 then
      NekoData.BehaviorManager.BM_Game:SetGuideTag(GuidTypes.BATTLE_RETREAT, 1)
    end
  elseif self._guideId == 13 then
    if NekoData.BehaviorManager.BM_Guide:IsCurrentGuide(63) then
      NekoData.BehaviorManager.BM_Guide:FinishGuide(63)
    end
  elseif NekoData.BehaviorManager.BM_Game:GetPlayBuffGuideId() then
    local allIds = CDungeonBuffType:GetAllIds()
    local len = #allIds
    for i = 1, len do
      local record = CDungeonBuffType:GetRecorder(allIds[i])
      if record.guideID and record.guideID == self._guideId then
        NekoData.BehaviorManager.BM_Game:SetBuffGuideTag(allIds[i], 1)
        break
      end
    end
  end
  self:Destroy()
  LuaNotificationCenter.PostNotification(Common.n_DialogCloseBtnClick, nil, self)
end

function BattleTeachGuideDialog:OnDialogDestroy(notification)
  if notification.userInfo._dialogName == "loadingdialog" and DialogManager.GetDialog("dungeon.battlecrossdialog") then
    NekoData.DataManager.DM_TimeScale:SetBattleGuidePause()
  end
end

return BattleTeachGuideDialog
