local NewMainlineFloorLineCell = class("NewMainlineFloorLineCell", Dialog)
local CVarconfig = BeanManager.GetTableByName("var.cvarconfig")
NewMainlineFloorLineCell.AssetBundleName = "ui/layouts.mainline"
NewMainlineFloorLineCell.AssetName = "DungeonSelectCellLine"

function NewMainlineFloorLineCell:Ctor(...)
  NewMainlineFloorLineCell.super.Ctor(self, ...)
  self._alpha = tonumber(CVarconfig:GetRecorder(61).Value)
  self._fadeSpeed = tonumber(CVarconfig:GetRecorder(86).Value)
end

function NewMainlineFloorLineCell:OnCreate()
  self._select = self:GetChild("Select")
  self._img = self:GetChild("Line")
  self._canvasGroup = self:GetRootWindow():GetUIObject():GetComponent("CanvasGroup")
  local x, y = self._img:GetRectSize()
  self._img:SetAnchorAndOffset(0, 0.5, 1, 0.5, 0, -y / 2, 0, -y / 2)
  self._img:SetHeight(0.5, y)
  self:GetRootWindow():SetHeight(0, 0)
  LuaNotificationCenter.AddObserver(self, self.OnUpdate, Common.n_Update, nil)
end

function NewMainlineFloorLineCell:OnDestroy()
end

function NewMainlineFloorLineCell:RefreshCell(data)
  self._data = data
  self._select:SetActive(false)
end

function NewMainlineFloorLineCell:OnEvent(eventName, args, fatherKind, fadeIn, lastFloorID)
  if eventName == "SetSelected" then
    if self._data.bigParentId and args == self._data.bigParentId or args == self._data.parentId then
      self._select:SetActive(true)
      if fatherKind then
        self._canvasGroup.alpha = 1
      end
    else
      self._select:SetActive(false)
      if fatherKind then
        self._canvasGroup.alpha = self._alpha
      end
    end
    if fadeIn == true then
      if self._data.bigParentId and lastFloorID == self._data.bigParentId or lastFloorID == self._data.parentId then
        self._fadeIn = true
        self._widthHelper = self._widthHelperOri
        self._canvasGroup.alpha = 1
      else
        self._fadeIn = false
        self:GetRootWindow():SetWidth(0, self._width)
      end
    end
  end
end

function NewMainlineFloorLineCell:OnUpdate()
  if self._fadeIn then
    if self._widthHelper < self._width then
      self._widthHelper = self._widthHelper + self._fadeSpeed
    else
      self._widthHelper = self._width
      self:GetRootWindow():SetWidth(0, self._widthHelper)
      self._fadeIn = false
    end
    if self._widthHelper > 0 then
      self:GetRootWindow():SetWidth(0, self._widthHelper)
    else
      self:GetRootWindow():SetWidth(0, 0)
    end
  end
end

function NewMainlineFloorLineCell:SetPosition(ax, x, ay, y)
  self:GetRootWindow():SetPosition(ax, x, ay, y)
end

function NewMainlineFloorLineCell:SetZRotation(bx, by, ex, ey)
  self:GetRootWindow():SetZRotation(bx, by, ex, ey)
end

function NewMainlineFloorLineCell:SetWidth(width, widthHelper)
  self._width = width
  self._widthHelperOri = widthHelper
  self:GetRootWindow():SetWidth(0, width)
end

return NewMainlineFloorLineCell
