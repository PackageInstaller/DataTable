local CanvasGroupStaticFunction = CS.PixelNeko.Lua.CanvasGroupStaticFunction
local cGuideLinkConfing = BeanManager.GetTableByName("guide.cguidelinkconfig")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local GuideDialog = class("GuideDialog", Dialog)
GuideDialog.AssetBundleName = "ui/layouts.guide"
GuideDialog.AssetName = "GuideBlack"

function GuideDialog:Ctor(...)
  GuideDialog.super.Ctor(self, ...)
  self._groupName = "Guide"
  self._effectHandler = nil
  self._startTime = nil
  self._frameReduceTask = nil
  self._blackPanelShowTask = nil
  self._textFrameShowTask = nil
  self._frameReduceTaskTime = 0.6
  self._blackPanelShowTaskTime = 1
  self._textFrameShowTaskTime = 0.4
  self._blackPanelParmFunc = nil
end

function GuideDialog:OnCreate()
  self._blackPanel = self:GetChild("Black")
  self._leftUpPanel = self:GetChild("Black/Black1")
  self._leftDownPanel = self:GetChild("Black/Black3")
  self._rightUpPanel = self:GetChild("Black/Black2")
  self._righDownPanel = self:GetChild("Black/Black4")
  self._emptyPanel = self:GetChild("Empty")
  self._emptyFrame = self:GetChild("Empty/GuideFrame")
  self._skipBtn = self:GetChild("SkipBtn")
  self._effect = self:GetChild("Empty/Effect")
  self._textPanel = self:GetChild("GuideText")
  self._textUp = self:GetChild("GuideText/GuideBack")
  self._textUp_width, self._textUp_height = self._textUp:GetDeltaSize()
  self._textUp_txt = self:GetChild("GuideText/GuideBack/GuideTxt")
  self._textUp_txt_width, self._textUp_txt_height = self._textUp_txt:GetPreferredSize()
  self._textUp_icon = self:GetChild("GuideText/GuideBack/Image")
  self._textDown = self:GetChild("GuideText/GuideBack2")
  self._textDown_width, self._textDown_height = self._textDown:GetDeltaSize()
  self._textDown_txt = self:GetChild("GuideText/GuideBack2/GuideTxt")
  self._textDown_txt_width, self._textDown_txt_height = self._textDown_txt:GetPreferredSize()
  self._textDown_icon = self:GetChild("GuideText/GuideBack2/Image")
  self._textBack = self:GetChild("GuideText/GuideBack")
  self._blockPanel = self:GetChild("Panel")
  self._skipBtn:Subscribe_PointerClickEvent(self.OnSkipBtnClicked, self)
  self._width, self._height = self:GetRootWindow():GetRectSize()
  self._screenPosition = self:GetRootWindow():GetLocalPointInUiRootPanel()
  self._blackAlpha = self._leftUpPanel:GetColor().a
  self._emptyFrameAlpha = self._emptyFrame:GetColor().a
  self._textBackAlpha = self._textBack:GetColor().a
  self._leftUp = {}
  self._leftUp.anchorX, self._leftUp.offsetX, self._leftUp.anchorY, self._leftUp.offsetY = self._leftUpPanel:GetSize()
  self._leftUp.x, self._leftUp.y = self._leftUpPanel:GetAnchoredPosition()
  self._leftDown = {}
  self._leftDown.anchorX, self._leftDown.offsetX, self._leftDown.anchorY, self._leftDown.offsetY = self._leftDownPanel:GetSize()
  self._leftDown.x, self._leftDown.y = self._leftDownPanel:GetAnchoredPosition()
  self._rightUp = {}
  self._rightUp.anchorX, self._rightUp.offsetX, self._rightUp.anchorY, self._rightUp.offsetY = self._rightUpPanel:GetSize()
  self._rightUp.x, self._rightUp.y = self._rightUpPanel:GetAnchoredPosition()
  self._righDown = {}
  self._righDown.anchorX, self._righDown.offsetX, self._righDown.anchorY, self._righDown.offsetY = self._righDownPanel:GetSize()
  self._righDown.x, self._righDown.y = self._righDownPanel:GetAnchoredPosition()
  self._empty = {}
  self._empty.anchorX, self._empty.offsetX, self._empty.anchorY, self._empty.offsetY = self._emptyPanel:GetSize()
  LuaNotificationCenter.AddObserver(self, self.OnUpdate, Common.n_Update, nil)
  LuaNotificationCenter.AddObserver(self, self.OnMouseClicked, Common.n_GlobalPointerWillDown, nil)
  LuaNotificationCenter.AddObserver(self, self.OnMouseClicked, Common.n_NoTargetWindowClick, nil)
  LuaNotificationCenter.AddObserver(self, self.OnScreenPixelChanged, Common.n_ScreenPixelChanged, nil)
  LuaNotificationCenter.AddObserver(self, self.OnGuideFinished, Common.n_GuideStatusChanged, nil)
  LuaNotificationCenter.AddObserver(self, self.OnGuideStageFinished, Common.n_GuideStageFinished, nil)
end

function GuideDialog:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
  if self._effectHandler then
    self._effect:ReleaseEffect(self._effectHandler)
    self._effectHandler = nil
  end
end

function GuideDialog:OnGuideFinished(notification)
  if notification.userInfo.guideStatus ~= "Start" and notification.userInfo.guideID == self:GetGuideId() then
    self:Destroy()
  end
end

function GuideDialog:OnGuideStageFinished(notification)
  if notification.userInfo.guideID == self._guideId and notification.userInfo.stageID == self._stageId then
    self._blockPanel:SetActive(true)
  end
end

function GuideDialog:OnUpdate(notification)
  self._screenPosition = self:GetRootWindow():GetLocalPointInUiRootPanel()
  self._width, self._height = self:GetRootWindow():GetRectSize()
  if not self._startTime and self._blackPanelParmFunc then
    local blackPanelParm = self._blackPanelParmFunc()
    if blackPanelParm then
      self:SetGuidePoint(blackPanelParm.width, blackPanelParm.height, blackPanelParm.posX, blackPanelParm.posY)
    else
      self:Destroy()
      return
    end
  end
  local needUpdate
  if self._screenPixelChanged then
    needUpdate = true
    self._screenPixelChanged = false
  elseif self._frameReduceTask and self._blackPanelParmFunc then
    local blackPanelParm = self._blackPanelParmFunc()
    if blackPanelParm then
      needUpdate = self._frameReduceTask.target.width ~= blackPanelParm.width
    else
      self:Destroy()
      return
    end
  end
  if needUpdate and self._frameReduceTask then
    local blackPanelParm = self._blackPanelParmFunc()
    if blackPanelParm then
      local scale = self._frameReduceTask.subject.width / self._frameReduceTask.target.width
      self._frameReduceTask = Tween.new(self._frameReduceTaskTime - self._frameReduceTask.clock, {
        width = blackPanelParm.width * scale,
        height = blackPanelParm.height * scale,
        posX = blackPanelParm.posX,
        posY = blackPanelParm.posY
      }, {
        width = blackPanelParm.width,
        height = blackPanelParm.height,
        posX = blackPanelParm.posX,
        posY = blackPanelParm.posY
      }, "linear")
    else
      self:Destroy()
      return
    end
  end
  if self._startTime then
    self._startTime = self._startTime + notification.userInfo.unscaledDeltaTime
    if self._startTime >= self._blackPanelShowTaskTime then
      self._emptyFrame:SetRaycastTarget(false)
      self._startTime = nil
      self._blockPanel:SetActive(false)
    end
  end
  if self._frameReduceTask then
    if self._frameReduceTask:update(notification.userInfo.deltaTime) then
      self:SetGuidePoint(self._frameReduceTask.target.width, self._frameReduceTask.target.height, self._frameReduceTask.target.posX, self._frameReduceTask.target.posY)
      self._frameReduceTask = nil
      if self._textPanelParmFunc then
        self._textFrameShowTask = Tween.new(self._textFrameShowTaskTime, {alpha = 0}, {
          alpha = self._textBackAlpha
        }, "linear")
      end
    else
      self:SetGuidePoint(self._frameReduceTask.subject.width, self._frameReduceTask.subject.height, self._frameReduceTask.subject.posX, self._frameReduceTask.subject.posY)
    end
  end
  if self._blackPanelShowTask then
    if self._blackPanelShowTask:update(notification.userInfo.deltaTime) then
      local alpha = self._blackPanelShowTask.target.alpha
      self._leftUpPanel:SetAlpha(alpha)
      self._leftDownPanel:SetAlpha(alpha)
      self._rightUpPanel:SetAlpha(alpha)
      self._righDownPanel:SetAlpha(alpha)
      self._blackPanelShowTask = nil
    else
      local alpha = self._blackPanelShowTask.subject.alpha
      self._leftUpPanel:SetAlpha(alpha)
      self._leftDownPanel:SetAlpha(alpha)
      self._rightUpPanel:SetAlpha(alpha)
      self._righDownPanel:SetAlpha(alpha)
    end
  end
  if self._textFrameShowTask then
    if self._textFrameShowTask:update(notification.userInfo.deltaTime) then
      CanvasGroupStaticFunction.SetObjectAlpha(self._textBack._uiObject, self._textFrameShowTask.target.alpha, false)
      self._textFrameShowTask = nil
    else
      CanvasGroupStaticFunction.SetObjectAlpha(self._textBack._uiObject, self._textFrameShowTask.subject.alpha, false)
    end
  end
end

function GuideDialog:OnMouseClicked()
  if not self._startTime then
    LuaNotificationCenter.PostNotification(Common.n_GuideResponseClick, self, nil)
  end
end

function GuideDialog:OnScreenPixelChanged()
  self._screenPixelChanged = true
end

function GuideDialog:SetGuideId(guideId, stageId)
  self._guideId = guideId
  self._stageId = stageId
  local guideInfo = cGuideLinkConfing:GetRecorder(guideId)
  self._skipBtn:SetActive(guideInfo and guideInfo.skip == 1 or NekoData.BehaviorManager.BM_Game:IsGM())
  LogInfoFormat("GuideDialog", "-SetGuideId-- guideId = %s, stageId = %s ---", guideId, stageId)
  self._startTime = 0
  self._emptyFrame:SetRaycastTarget(true)
  self._blockPanel:SetActive(true)
  self._blackPanelParmFunc = nil
  self._textPanelParmFunc = nil
end

function GuideDialog:GetGuideId()
  return self._guideId
end

function GuideDialog:SetGuidePoint(width, height, posX, posY)
  local leftUpPanel = {}
  leftUpPanel.width = math.floor(posX - width / 2 - (self._screenPosition.x - self._width / 2))
  leftUpPanel.height = math.floor(self._screenPosition.y + self._height / 2 - (posY - height / 2))
  self._leftUpPanel:SetSize(self._leftUp.anchorX, leftUpPanel.width, self._leftUp.anchorY, leftUpPanel.height)
  self._leftUpPanel:SetAnchoredPosition(self._leftUp.x, self._leftUp.y)
  local leftDownPanel = {}
  leftDownPanel.width = math.floor(posX + width / 2 - (self._screenPosition.x - self._width / 2))
  leftDownPanel.height = self._height - leftUpPanel.height
  self._leftDownPanel:SetSize(self._leftDown.anchorX, leftDownPanel.width, self._leftDown.anchorY, leftDownPanel.height)
  self._leftDownPanel:SetAnchoredPosition(self._leftDown.x, self._leftDown.y)
  local rightUpPanel = {}
  rightUpPanel.width = self._width - leftUpPanel.width
  rightUpPanel.height = math.floor(self._screenPosition.y + self._height / 2 - (posY + height / 2))
  self._rightUpPanel:SetSize(self._rightUp.anchorX, rightUpPanel.width, self._rightUp.anchorY, rightUpPanel.height)
  self._rightUpPanel:SetAnchoredPosition(self._rightUp.x, self._rightUp.y)
  local rightDownPanel = {}
  rightDownPanel.width = self._width - leftDownPanel.width
  rightDownPanel.height = self._height - rightUpPanel.height
  self._righDownPanel:SetSize(self._rightUp.anchorX, rightDownPanel.width, self._rightUp.anchorY, rightDownPanel.height)
  self._righDownPanel:SetAnchoredPosition(self._rightUp.x, self._rightUp.y)
  self._emptyPanel:SetSize(self._empty.anchorX, width, self._empty.anchorY, height)
  self._emptyPanel:SetAnchoredPosition(posX, posY)
  self._emptyPanel:SetActive(width ~= 0 and height ~= 0)
end

function GuideDialog:SetEmptyPoint(blackPanelParmFunc)
  self._blackPanelParmFunc = blackPanelParmFunc
  if self._frameReduceTask then
    self._frameReduceTask = nil
  end
  if self._blackPanelShowTask then
    self._blackPanelShowTask = nil
  end
  if self._blackPanelParmFunc then
    local blackPanelParm = blackPanelParmFunc()
    if blackPanelParm.alpha then
      self._lastAlpha = blackPanelParm.alpha
      self._leftUpPanel:SetAlpha(0)
      self._leftDownPanel:SetAlpha(0)
      self._rightUpPanel:SetAlpha(0)
      self._righDownPanel:SetAlpha(0)
      self._emptyFrame:SetAlpha(0)
    elseif self._lastAlpha then
      self._lastAlpha = nil
      self._leftUpPanel:SetAlpha(self._blackAlpha)
      self._leftDownPanel:SetAlpha(self._blackAlpha)
      self._rightUpPanel:SetAlpha(self._blackAlpha)
      self._righDownPanel:SetAlpha(self._blackAlpha)
      self._emptyFrame:SetAlpha(self._emptyFrameAlpha)
    end
    if not self._lastAlpha then
      self._frameReduceTask = Tween.new(self._frameReduceTaskTime, {
        width = blackPanelParm.width * 3,
        height = blackPanelParm.height * 3,
        posX = blackPanelParm.posX,
        posY = blackPanelParm.posY
      }, {
        width = blackPanelParm.width,
        height = blackPanelParm.height,
        posX = blackPanelParm.posX,
        posY = blackPanelParm.posY
      }, "linear")
      self._blackPanelShowTask = Tween.new(self._blackPanelShowTaskTime, {alpha = 0}, {
        alpha = self._blackAlpha
      }, "linear")
      self:OnUpdate({
        userInfo = {deltaTime = 0, unscaledDeltaTime = 0}
      })
    else
      self:SetGuidePoint(blackPanelParm.width, blackPanelParm.height, blackPanelParm.posX, blackPanelParm.posY)
    end
  else
    self._emptyPanel:SetActive(false)
    self:SetGuidePoint(0, 0, 0, 0)
  end
end

function GuideDialog:SetTextPoint(textPanelParmFunc, direction, wordId, profileId, raycastTarget)
  self._textPanelParmFunc = textPanelParmFunc
  if self._textFrameShowTask then
    self._textFrameShowTask = nil
  end
  if self._textPanelParmFunc then
    self._text_direction = direction
    self._text_raycastTarget = raycastTarget
    self._textPanel:SetActive(true)
    self._textPanel:SetRaycastTarget(self._text_raycastTarget)
    local str = TextManager.GetText(wordId)
    local imageRecord = CImagePathTable:GetRecorder(profileId) or DataCommon.DefaultImageAsset
    if self._text_direction == "Up" then
      self._textUp:SetActive(true)
      self._textDown:SetActive(false)
      self._textBack = self._textUp
      self._textUp_txt:SetText(str)
      local _, textheight = self._textUp_txt:GetPreferredSize()
      if textheight > self._textUp_txt_height then
        self._textUp:SetDeltaSize(self._textUp_width, self._textUp_height + (textheight - self._textUp_txt_height))
      else
        self._textUp:SetDeltaSize(self._textUp_width, self._textUp_height)
      end
      self._textUp_icon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    else
      self._textUp:SetActive(false)
      self._textDown:SetActive(true)
      self._textBack = self._textDown
      self._textDown_txt:SetText(str)
      local _, textheight = self._textDown_txt:GetPreferredSize()
      if textheight > self._textDown_txt_height then
        self._textDown:SetDeltaSize(self._textDown_width, self._textDown_height + (textheight - self._textDown_txt_height))
      else
        self._textDown:SetDeltaSize(self._textDown_width, self._textDown_height)
      end
      self._textDown_icon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    end
    self._textBackAlpha = self._textBack:GetColor().a
    local textPanelParm = textPanelParmFunc()
    if self._frameReduceTask then
      CanvasGroupStaticFunction.SetObjectAlpha(self._textBack._uiObject, 0, false)
    else
      CanvasGroupStaticFunction.SetObjectAlpha(self._textBack._uiObject, self._textBackAlpha, false)
    end
  else
    self._textPanel:SetActive(false)
  end
end

function GuideDialog:OnSkipBtnClicked()
  local currentGuide = NekoData.DataManager.DM_Guide:GetCurrentGuide()
  if currentGuide then
    NekoData.BehaviorManager.BM_Guide:FinishGuide(currentGuide:GetID())
  end
  DialogManager.DestroySingletonDialog("guide.guidenextdialog")
  self:Destroy()
end

return GuideDialog
