local NewMainlineFloorLittleCell = class("NewMainlineFloorLittleCell", Dialog)
local CVarconfig = BeanManager.GetTableByName("var.cvarconfig")
NewMainlineFloorLittleCell.AssetBundleName = "ui/layouts.mainline"
NewMainlineFloorLittleCell.AssetName = "DungeonSelectCellSmall"

function NewMainlineFloorLittleCell:Ctor(...)
  NewMainlineFloorLittleCell.super.Ctor(self, ...)
  self._trueAlpha = 1
  self._alpha = tonumber(CVarconfig:GetRecorder(61).Value)
  self._fadeSpeed = tonumber(CVarconfig:GetRecorder(86).Value)
end

function NewMainlineFloorLittleCell:OnCreate()
  self._finishNo = self:GetChild("FinishNo")
  self._finishNoSelect = self:GetChild("FinishNoSelect")
  self._finishNoSelect:SetActive(false)
  self._finish = self:GetChild("Finish")
  self._finishSelect = self:GetChild("FinishSelect")
  self._finishSelect:SetActive(false)
  self._canvasGroup = self:GetRootWindow():GetUIObject():GetComponent("CanvasGroup")
  LuaNotificationCenter.AddObserver(self, self.OnUpdate, Common.n_Update, nil)
end

function NewMainlineFloorLittleCell:OnDestroy()
end

local function SetStatusActive(self, f1, f2, f3, f4)
  self._finish:SetActive(f1)
  self._finishNo:SetActive(f2)
  self._finishSelect:SetActive(f3)
  self._finishNoSelect:SetActive(f4)
end

function NewMainlineFloorLittleCell:RefreshCell(data)
  self._data = data
  local finish = false
  local box = false
  if data.isPass == 1 then
    finish = true
  end
  if data.openedBoxes == data.totalBoxes then
    box = true
  end
  if finish then
    SetStatusActive(self, true, false, false, false)
    self._assetName, self._effectName = EffectUtil.GetAssetBundleNameAndAssetName(1021)
  else
    SetStatusActive(self, false, true, false, false)
    self._assetName, self._effectName = EffectUtil.GetAssetBundleNameAndAssetName(1020)
  end
end

function NewMainlineFloorLittleCell:OnEvent(eventName, args, fatherKind, fadeIn, lastFloorID)
  if eventName == "SetSelected" then
    if args == self._data.bigParentId then
      local finish = false
      if self._data.isPass == 1 then
        finish = true
      end
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
      local finish = false
      if self._data.isPass == 1 then
        finish = true
      end
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
      if lastFloorID == self._data.bigParentId then
        self._canvasGroup.alpha = 0
        self._fadeIn = true
        self._widthHelper = self._widthHelperOri
        self._trueAlpha = 1
      else
        self._fadeIn = false
        self._canvasGroup.alpha = self._trueAlpha
      end
    end
  end
end

function NewMainlineFloorLittleCell:OnUpdate()
  if self._fadeIn then
    if self._widthHelper == nil then
      self._widthHelper = 0
    end
    if self._widthHelper < 0 then
      self._widthHelper = self._widthHelper + self._fadeSpeed
    else
      self._widthHelper = 0
      self._canvasGroup.alpha = self._trueAlpha
      self._fadeIn = false
    end
  end
end

function NewMainlineFloorLittleCell:SetPosition(ax, x, ay, y)
  self:GetRootWindow():SetPosition(ax, x, ay, y)
end

function NewMainlineFloorLittleCell:SetWidthOri(widthHelper)
  self._widthHelperOri = widthHelper
end

return NewMainlineFloorLittleCell
