local CStringRes = BeanManager.GetTableByName("message.cstringres")
local NewMainlineFloorBigCell = class("NewMainlineFloorBigCell", Dialog)
local CVarconfig = BeanManager.GetTableByName("var.cvarconfig")
NewMainlineFloorBigCell.AssetBundleName = "ui/layouts.mainline"
NewMainlineFloorBigCell.AssetName = "DungeonSelectCellBig"

function NewMainlineFloorBigCell:Ctor(...)
  NewMainlineFloorBigCell.super.Ctor(self, ...)
  self._trueAlpha = 1
  self._alpha = tonumber(CVarconfig:GetRecorder(61).Value)
  self._fadeSpeed = tonumber(CVarconfig:GetRecorder(86).Value)
end

function NewMainlineFloorBigCell:OnCreate()
  self._finishNo = self:GetChild("FinishNo")
  self._finishNoSelect = self:GetChild("FinishNoSelect")
  self._finishNoSelect:SetActive(false)
  self._finish = self:GetChild("Finish")
  self._finishSelect = self:GetChild("FinishSelect")
  self._finishSelect:SetActive(false)
  self._finishNoBoss = self:GetChild("FinishNoBoss")
  self._finishNoSelectBoss = self:GetChild("FinishNoSelectBoss")
  self._finishNoSelectBoss:SetActive(false)
  self._finishBoss = self:GetChild("FinishBoss")
  self._finishSelectBoss = self:GetChild("FinishSelectBoss")
  self._finishSelectBoss:SetActive(false)
  self._chapterNum = self:GetChild("Txt")
  self._redDot = self:GetChild("RedDot")
  self._boxOpen = self:GetChild("BoxOpen")
  self._boxClose = self:GetChild("BoxClose")
  self._bossIcon = self:GetChild("Boss")
  self._bossIcon:SetActive(false)
  self._selectEffect = self:GetChild("Effect")
  self._levelLimit = self:GetChild("LevelLimit")
  self._levelLimitTxt = self:GetChild("LevelLimit/Txt")
  self._canvasGroup = self:GetRootWindow():GetUIObject():GetComponent("CanvasGroup")
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnCellClicked, self)
  self._animator = self:GetRootWindow():GetUIObject():GetComponent("Animator")
  LuaNotificationCenter.AddObserver(self, self.OnReceiveDungeonPointAward, Common.n_ReceiveDungeonPointAward, nil)
  LuaNotificationCenter.AddObserver(self, self.OnUpdate, Common.n_Update, nil)
end

function NewMainlineFloorBigCell:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
end

local function SetStatusActive(self, f1, f2, f3, f4)
  if self._data.bossFlag == 1 then
    self._finish:SetActive(false)
    self._finishNo:SetActive(false)
    self._finishSelect:SetActive(false)
    self._finishNoSelect:SetActive(false)
    self._finishBoss:SetActive(f1)
    self._finishNoBoss:SetActive(f2)
    self._finishSelectBoss:SetActive(f3)
    self._finishNoSelectBoss:SetActive(f4)
  else
    self._finishBoss:SetActive(false)
    self._finishNoBoss:SetActive(false)
    self._finishSelectBoss:SetActive(false)
    self._finishNoSelectBoss:SetActive(false)
    self._finish:SetActive(f1)
    self._finishNo:SetActive(f2)
    self._finishSelect:SetActive(f3)
    self._finishNoSelect:SetActive(f4)
  end
end

function NewMainlineFloorBigCell:RefreshCell(data)
  if NekoData.BehaviorManager.BM_Game:GetIfDungeonWorldZoneAwardReceiveByFloorId(data.id) or GlobalGameFSM and GlobalGameFSM:GetCurrentState() == "Dungeon" then
    self._redDot:SetActive(false)
  else
    self._redDot:SetActive(true)
  end
  self._data = data
  if not self._data.delegate.OnCellClicked then
    self._redDot:SetActive(false)
  end
  if self._selectEffectHandler then
    self._selectEffect:ReleaseEffect(self._selectEffectHandler)
    self._selectEffectHandler = nil
  end
  local finish = data.firstGet
  local box = false
  if data.checkPointOpenBoxex == data.checkPointTotalBoxes then
    box = true
  end
  if finish then
    SetStatusActive(self, true, false, false, false)
    self._assetName, self._effectName = nil, nil
  else
    SetStatusActive(self, false, true, false, false)
    if data.bossFlag == 1 then
      self._assetName, self._effectName = EffectUtil.GetAssetBundleNameAndAssetName(1096)
    else
      self._assetName, self._effectName = EffectUtil.GetAssetBundleNameAndAssetName(1097)
    end
  end
  self._chapterNum:SetText(data.floor)
  if data.chestAward.totalBoxes == 0 then
    self._boxOpen:SetActive(false)
    self._boxClose:SetActive(false)
  elseif data.chestAward.openedBoxes == data.chestAward.totalBoxes then
    self._boxOpen:SetActive(true)
    self._boxClose:SetActive(false)
  elseif data.chestAward.openedBoxes < data.chestAward.totalBoxes then
    self._boxOpen:SetActive(false)
    self._boxClose:SetActive(true)
  else
    LogErrorFormat("NewMainlineFloorBigCell", "floorid %s chestAward openedBoxes %s totalBoxes %s state is wrong", data.id, data.chestAward.openedBoxes, data.chestAward.totalBoxes)
  end
  self._unlockLv = data.unlockLv
  self._lock = data.unlockLv > NekoData.BehaviorManager.BM_Game:GetMyRoleInfo().userlevel
  if self._lock then
    self._levelLimit:SetActive(true)
    local str = CStringRes:GetRecorder(1374).msgTextID
    str = TextManager.GetText(str)
    str = string.gsub(str, "%$parameter1%$", data.unlockLv)
    self._levelLimitTxt:SetText(str)
  else
    self._levelLimit:SetActive(false)
  end
end

function NewMainlineFloorBigCell:OnEvent(eventName, args, fatherKind, fadeIn)
  if eventName == "SetSelected" then
    if args == self._data.id then
      local finish = self._data.firstGet
      if finish then
        SetStatusActive(self, false, false, true, false)
      else
        SetStatusActive(self, false, false, false, true)
      end
      if fatherKind then
        self._canvasGroup.alpha = 1
        self._trueAlpha = 1
      end
    else
      local finish = self._data.firstGet
      if finish then
        SetStatusActive(self, true, false, false, false)
      else
        SetStatusActive(self, false, true, false, false)
      end
      if fatherKind then
        self._canvasGroup.alpha = self._alpha
        self._trueAlpha = self._alpha
      end
    end
    if fadeIn == true then
      if args == self._data.id then
        self._canvasGroup.alpha = 0
        self._fadeIn = true
        self._widthHelper = self._widthHelperOri
      else
        self._fadeIn = false
        self._canvasGroup.alpha = self._trueAlpha
      end
    end
  elseif eventName == "StartEffect" then
    if self._selectEffectHandler then
      self._selectEffect:ReleaseEffect(self._selectEffectHandler)
      self._selectEffectHandler = nil
    end
    if args == self._data.id then
      local finish = self._data.firstGet
      if not finish then
        self._selectEffectHandler = self._selectEffect:AddEffectSync(self._assetName, self._effectName)
      end
    end
  end
end

function NewMainlineFloorBigCell:OnCellClicked()
  if self._data.delegate.OnCellClicked then
    self._data.delegate:OnCellClicked(self._data.id)
  end
end

function NewMainlineFloorBigCell:OnUpdate()
  if self._fadeIn then
    if self._widthHelper == nil then
      self._widthHelper = 0
    end
    if self._widthHelper < 0 then
      self._widthHelper = self._widthHelper + self._fadeSpeed
    else
      self._widthHelper = 0
      self._canvasGroup.alpha = self._trueAlpha
      self._animator:Play("CellBigShow", 0, 0)
      self._fadeIn = false
    end
  end
end

function NewMainlineFloorBigCell:SetPosition(ax, x, ay, y)
  self:GetRootWindow():SetPosition(ax, x, ay, y)
end

function NewMainlineFloorBigCell:OnReceiveDungeonPointAward(notification)
  if NekoData.BehaviorManager.BM_Game:GetIfDungeonWorldZoneAwardReceiveByFloorId(self._data.id) then
    self._redDot:SetActive(false)
  else
    self._redDot:SetActive(true)
  end
end

function NewMainlineFloorBigCell:SetWidthOri(widthHelper)
  self._widthHelperOri = widthHelper
end

return NewMainlineFloorBigCell
