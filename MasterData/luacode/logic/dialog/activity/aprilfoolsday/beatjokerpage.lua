local CStringRes = BeanManager.GetTableByName("message.cstringres")
local CClownCfg = BeanManager.GetTableByName("activity.cclowncfg")
local CClownShowCfg = BeanManager.GetTableByName("activity.cclownshowcfg")
local ImageTable = BeanManager.GetTableByName("ui.cimagepath")
local CClownSpecialCfg = BeanManager.GetTableByName("activity.cclownspecialcfg")
local UIManager = CS.PixelNeko.UI.UIManager
local AnimatorStaticFunctions = CS.PixelNeko.Lua.AnimatorStaticFunctions
local TransformStaticFunctions = CS.PixelNeko.Lua.TransformStaticFunctions
local BeatJokerPage = class("BeatJokerPage", Dialog)
BeatJokerPage.AssetBundleName = "ui/layouts.activityaprilfools"
BeatJokerPage.AssetName = "ActivityAprilFoolsJoker"
local MaxCellNum = 10
local clickEffectCell = {
  AssetBundleName = "ui/layouts",
  AssetName = "ActivityAprilFoolsClickCell"
}

function BeatJokerPage:Ctor(...)
  BeatJokerPage.super.Ctor(self, ...)
  self._awardTime = 0
  self._canBeatJoker = true
  self._bm = NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.AprilFoolsDayActivityManagerID)
  self._key = 1
  self._cellList = {}
  self._canPlayAnimation = true
end

function BeatJokerPage:OnCreate()
  self._box = self:GetChild("AwardBtn")
  self._box:SetActive(false)
  self._boxTxt = self:GetChild("AwardBtn/_Text")
  self._model = self:GetChild("HitLimt/Model")
  self._animatorRoot = self:GetChild("HitLimt")
  self._joker = self:GetChild("HitLimt/Joker")
  self._activityTime = self:GetChild("Back/ActiveTime")
  self._title = self:GetChild("Title")
  self._tipsBtn = self:GetChild("Tips")
  self._talkTxt = self:GetChild("Talk2/Text")
  self._tipTxt = self:GetChild("TipsText")
  self._upperLimitTxt = self:GetChild("MaxTip")
  self._upperLimitBack = self:GetChild("MaxTipBack")
  self._box:Subscribe_PointerClickEvent(self.OnBoxClicked, self)
  self._tipsBtn:Subscribe_PointerClickEvent(self.OnTipsBtnClicked, self)
  self._animatorRoot:Subscribe_StateExitEvent(self.OnHitLitAnimatorExit, self)
  LuaNotificationCenter.AddObserver(self, self.OnSReceiveBeatClownReward, Common.n_SReceiveBeatClownReward, nil)
  self:Init()
end

function BeatJokerPage:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
  self._bm:SaveBeatClownNumber()
  DialogManager.DestroySingletonDialog("activity.aprilfoolsday.aprilfoolsdaytipsdialog")
  local cell
  while self._cellList[#self._cellList] do
    cell = self._cellList[#self._cellList]
    cell:Destroy()
    cell:RootWindowDestroy()
    table.remove(self._cellList, #self._cellList)
  end
  if self._baseCell then
    UIManager.Destroy(self._baseCell._uiObject)
    self._baseCell = nil
  end
  if self._handler then
    self._model:ReleaseModel(self._handler)
    self._handler = nil
  end
end

function BeatJokerPage:Init()
  self._activityTime:SetText(TextManager.GetText(CStringRes:GetRecorder(1756).msgTextID))
  self._tipTxt:SetText(TextManager.GetText(CStringRes:GetRecorder(1758).msgTextID))
  self._upperLimitTxt:SetText(TextManager.GetText(CStringRes:GetRecorder(1759).msgTextID))
  self._boxTxt:SetText(TextManager.GetText(CStringRes:GetRecorder(1841).msgTextID))
  self._upperLimitTxt:SetActive(false)
  self._upperLimitBack:SetActive(false)
  self._records = {}
  self._recordNum = 0
  for _, id in ipairs(CClownCfg:GetAllIds()) do
    self._records[id] = CClownCfg:GetRecorder(id)
    self._recordNum = self._recordNum + 1
  end
  if self._handler then
    self._model:ReleaseModel(self._handler)
    self._handler = nil
  end
  local assetName = CClownSpecialCfg:GetRecorder(7).Value
  local assetBundle = CClownSpecialCfg:GetRecorder(8).Value
  self._handler = self._model:AddModelSync(assetBundle, assetName)
  local modelObject = TransformStaticFunctions.GetChild(self._model._uiObject, "Model/" .. assetName .. "(Clone)")
  self._modelAnimator = AnimatorStaticFunctions.Get(modelObject)
  self._bm:InitBeatClownNumber()
  self:Refresh()
  if self._bm:IsBeatClownOpen() then
    if self._clickHandler then
      self._joker:Unsubscribe_PointerClickEvent(self._clickHandler)
      self._clickHandler = nil
    end
    self._clickHandler = self._joker:Subscribe_PointerClickEvent(self.OnBeatAreaClicked, self)
    if self._baseCell then
      UIManager.Destroy(self._baseCell._uiObject)
      self._baseCell = nil
    end
    self._baseCell = UIManager.CreateLuaWindow(clickEffectCell.AssetBundleName .. ".assetbundle", clickEffectCell.AssetName, self._rootWindow._uiObject)
    self._baseCell:SetActive(false)
    for i = 1, MaxCellNum do
      table.insert(self._cellList, DialogManager.CopyDialog("activity.aprilfoolsday.aprilfoolsdayclickeffectcell", self._baseCell._uiObject, self._rootWindow._uiObject))
    end
  end
end

function BeatJokerPage:Refresh()
  if self._bm:IsBeatClownOpen() then
    self:JudgeBeatNumber()
    local showRecord
    if self._beatNumber == 0 and self._awardTime == 0 then
      showRecord = CClownShowCfg:GetRecorder(1)
    end
    if self._awardTime >= self._recordNum then
      self._upperLimitTxt:SetActive(true)
      self._upperLimitBack:SetActive(true)
      showRecord = CClownShowCfg:GetRecorder(self._recordNum * 2 + 1)
    end
    if showRecord then
      self._talkTxt:SetText(TextManager.GetText(showRecord.text))
      self._modelAnimator:Play(showRecord.clowntype)
    end
  else
    if self._clickHandler then
      self._joker:Unsubscribe_PointerClickEvent(self._clickHandler)
      self._clickHandler = nil
    end
    if self._baseCell then
      UIManager.Destroy(self._baseCell._uiObject)
      self._baseCell = nil
    end
    local cell
    while self._cellList[#self._cellList] do
      cell = self._cellList[#self._cellList]
      cell:Destroy()
      cell:RootWindowDestroy()
      table.remove(self._cellList, #self._cellList)
    end
    local allIds = CClownShowCfg:GetAllIds()
    local showRecord = CClownShowCfg:GetRecorder(allIds[#allIds])
    if showRecord then
      self._talkTxt:SetText(TextManager.GetText(showRecord.text))
      self._modelAnimator:Play(showRecord.clowntype)
    end
  end
end

function BeatJokerPage:OnBeatAreaClicked(args)
  if self._canBeatJoker then
    self._bm:BeatClown()
    if self._canPlayAnimation then
      self._animatorRoot:SetAnimatorTrigger("play")
    end
  end
  self:JudgeBeatNumber()
  local x, y = UIManager.ScreenPointToLocalPointInRectangle(self:GetRootWindow()._uiObject, args.position.x, args.position.y)
  local cell = self._cellList[self._key]
  if cell then
    cell:SetActive(true)
    cell:GetRootWindow():SetAnchoredPosition(x, y)
    cell:PlayEffect()
    self._key = self._key % MaxCellNum + 1
  end
end

function BeatJokerPage:OnBoxClicked()
  if not self._sendProtocol then
    local csend = LuaNetManager.CreateProtocol("protocol.activity.creceivebeatclownreward")
    csend.times = self._awardTime + 1
    csend:Send()
    self._sendProtocol = true
  end
end

function BeatJokerPage:OnTipsBtnClicked()
  DialogManager.CreateSingletonDialog("activity.aprilfoolsday.aprilfoolsdaytipsdialog"):SetData(CStringRes:GetRecorder(1760).msgTextID)
end

function BeatJokerPage:OnHitLitAnimatorExit(handle, stateName, normalizedTime)
  if stateName == "Jokershake" then
    self._canPlayAnimation = true
  end
end

function BeatJokerPage:OnSReceiveBeatClownReward(notification)
  self._box:SetActive(false)
  self._sendProtocol = false
  local awardTime = notification.userInfo.times
  self._bm:SetReceiveAwardTimes(awardTime)
  self._bm:ClearBeatClownNumber()
  if awardTime >= self._recordNum then
    self._upperLimitTxt:SetActive(true)
    self._upperLimitBack:SetActive(true)
  end
end

function BeatJokerPage:JudgeBeatNumber()
  self._awardTime = self._bm:GetReceiveAwardTimes()
  self._beatNumber = self._bm:GetBeatClownNumber()
  self._box:SetActive(false)
  self._canBeatJoker = true
  for id, r in pairs(self._records) do
    if self._beatNumber >= r.hitcount and id > self._awardTime then
      self._box:SetActive(true)
      self._canBeatJoker = false
    end
    if self._beatNumber == r.hitcount and self._awardTime + 1 == id then
      local showRecord = CClownShowCfg:GetRecorder((self._awardTime + 1) * 2 + 1)
      if showRecord then
        self._talkTxt:SetText(TextManager.GetText(showRecord.text))
        self._modelAnimator:Play(showRecord.clowntype)
      else
        LogErrorFormat("beatjokerpage", "self._beatNumber %s self._awardTime %s get from CClownShowCfg wrong", self._beatNumber, self._awardTime)
      end
    elseif self._beatNumber > 0 and self._beatNumber < r.hitcount and self._awardTime + 1 == id then
      local showRecord = CClownShowCfg:GetRecorder((self._awardTime + 1) * 2)
      if showRecord then
        self._talkTxt:SetText(TextManager.GetText(showRecord.text))
        self._modelAnimator:Play(showRecord.clowntype)
      else
        LogErrorFormat("beatjokerpage", "self._beatNumber %s self._awardTime %s get from CClownShowCfg wrong", self._beatNumber, self._awardTime)
      end
    elseif self._beatNumber == 0 and self._awardTime == id then
      local showRecord = CClownShowCfg:GetRecorder(self._awardTime * 2 + 1)
      if showRecord then
        self._talkTxt:SetText(TextManager.GetText(showRecord.text))
        self._modelAnimator:Play(showRecord.clowntype)
      else
        LogErrorFormat("beatjokerpage", "self._beatNumber %s self._awardTime %s get from CClownShowCfg wrong", self._beatNumber, self._awardTime)
      end
    end
  end
end

function BeatJokerPage:OnEnable()
  if self._baseCell then
    local cell
    while self._cellList[#self._cellList] do
      cell = self._cellList[#self._cellList]
      cell:Destroy()
      cell:RootWindowDestroy()
      table.remove(self._cellList, #self._cellList)
    end
    for i = 1, MaxCellNum do
      table.insert(self._cellList, DialogManager.CopyDialog("activity.aprilfoolsday.aprilfoolsdayclickeffectcell", self._baseCell._uiObject, self._rootWindow._uiObject))
    end
  end
end

return BeatJokerPage
