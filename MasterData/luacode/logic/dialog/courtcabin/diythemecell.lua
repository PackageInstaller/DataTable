local FurnitureItem = require("logic.manager.experimental.types.furnitureitem")
local DIYThemeCell = class("DIYThemeCell", Dialog)
DIYThemeCell.AssetBundleName = "ui/layouts.yard"
DIYThemeCell.AssetName = "HouseThemeCell2"

function DIYThemeCell:Ctor(...)
  DIYThemeCell.super.Ctor(self, ...)
end

function DIYThemeCell:OnCreate()
  self._icon = self:GetChild("DIY/Img")
  self._comfortIcon = self:GetChild("DIY/ComfortableImg")
  self._comfortNum = self:GetChild("DIY/ComfortableNum")
  self._name = self:GetChild("DIY/Name")
  self._select = self:GetChild("DIY/Select")
  self._changeNameBtn = self:GetChild("DIY/ChangeBtn")
  self._deleteBtn = self:GetChild("DIY/DeleteBtn")
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnCellClicked, self)
  self._changeNameBtn:Subscribe_PointerClickEvent(self.OnChangeNameBtnClicked, self)
  self._deleteBtn:Subscribe_PointerClickEvent(self.OnDeleteBtnClicked, self)
end

function DIYThemeCell:OnDestroy()
end

function DIYThemeCell:RefreshCell(data)
  local comfort = 0
  for i, v in ipairs(data.furniturePositions) do
    local item = FurnitureItem.Create(v.itemId)
    comfort = comfort + item:GetComfort()
  end
  self._comfortNum:SetText(comfort)
  self._name:SetText(data.name)
  self._select:SetActive(data.key == self._delegate._themeInfo.key)
  local imgRecord = NekoData.BehaviorManager.BM_Cabin:GetComfortImageRecord()
  if imgRecord then
    self._comfortIcon:SetSprite(imgRecord.assetBundle, imgRecord.assetName)
  else
    LogError("comfort imgRecord is nil.")
  end
end

function DIYThemeCell:OnCellClicked()
  self._delegate:SelectTheme(self._cellData)
end

function DIYThemeCell:OnChangeNameBtnClicked()
  DialogManager.CreateSingletonDialog("courtcabin.changediythemenamedialog"):Init(self._cellData)
end

function DIYThemeCell:OnDeleteBtnClicked()
  NekoData.BehaviorManager.BM_Message:AddSecondConfirmDialog(46, nil, function()
    local cdeleteTheme = LuaNetManager.CreateProtocol("protocol.yard.cdeletetheme")
    cdeleteTheme.key = self._cellData.key
    cdeleteTheme:Send()
  end, {}, nil, {})
end

function DIYThemeCell:OnEvent(eventName, arg)
  if eventName == "SelectTheme" then
    self._select:SetActive(self._cellData.key == arg)
  elseif eventName == "ThemeNameChanged" and self._cellData.key == arg.key then
    self._name:SetText(arg.name)
  end
end

return DIYThemeCell
