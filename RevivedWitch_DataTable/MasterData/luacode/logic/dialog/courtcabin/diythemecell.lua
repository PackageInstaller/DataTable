-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/courtcabin/diythemecell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local FurnitureItem = require("logic.manager.experimental.types.furnitureitem")
local DIYThemeCell = class("DIYThemeCell", Dialog)
DIYThemeCell.AssetBundleName = "ui/layouts.yard"
DIYThemeCell.AssetName = "HouseThemeCell2"
DIYThemeCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : DIYThemeCell
  ((DIYThemeCell.super).Ctor)(self, ...)
end

DIYThemeCell.OnCreate = function(self)
  -- function num : 0_1
  self._icon = self:GetChild("DIY/Img")
  self._comfortIcon = self:GetChild("DIY/ComfortableImg")
  self._comfortNum = self:GetChild("DIY/ComfortableNum")
  self._name = self:GetChild("DIY/Name")
  self._select = self:GetChild("DIY/Select")
  self._changeNameBtn = self:GetChild("DIY/ChangeBtn")
  self._deleteBtn = self:GetChild("DIY/DeleteBtn")
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnCellClicked, self)
  ;
  (self._changeNameBtn):Subscribe_PointerClickEvent(self.OnChangeNameBtnClicked, self)
  ;
  (self._deleteBtn):Subscribe_PointerClickEvent(self.OnDeleteBtnClicked, self)
end

DIYThemeCell.OnDestroy = function(self)
  -- function num : 0_2
end

DIYThemeCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : _ENV, FurnitureItem
  local comfort = 0
  for i,v in ipairs(data.furniturePositions) do
    local item = (FurnitureItem.Create)(v.itemId)
    comfort = comfort + item:GetComfort()
  end
  ;
  (self._comfortNum):SetText(comfort)
  ;
  (self._name):SetText(data.name)
  ;
  (self._select):SetActive(data.key == ((self._delegate)._themeInfo).key)
  local imgRecord = ((NekoData.BehaviorManager).BM_Cabin):GetComfortImageRecord()
  if imgRecord then
    (self._comfortIcon):SetSprite(imgRecord.assetBundle, imgRecord.assetName)
  else
    LogError("comfort imgRecord is nil.")
  end
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

DIYThemeCell.OnCellClicked = function(self)
  -- function num : 0_4
  (self._delegate):SelectTheme(self._cellData)
end

DIYThemeCell.OnChangeNameBtnClicked = function(self)
  -- function num : 0_5 , upvalues : _ENV
  ((DialogManager.CreateSingletonDialog)("courtcabin.changediythemenamedialog")):Init(self._cellData)
end

DIYThemeCell.OnDeleteBtnClicked = function(self)
  -- function num : 0_6 , upvalues : _ENV
  ((NekoData.BehaviorManager).BM_Message):AddSecondConfirmDialog(46, nil, function()
    -- function num : 0_6_0 , upvalues : _ENV, self
    local cdeleteTheme = (LuaNetManager.CreateProtocol)("protocol.yard.cdeletetheme")
    cdeleteTheme.key = (self._cellData).key
    cdeleteTheme:Send()
  end
, {}, nil, {})
end

DIYThemeCell.OnEvent = function(self, eventName, arg)
  -- function num : 0_7
  if (self._cellData).key ~= arg then
    (self._select):SetActive(eventName ~= "SelectTheme")
    if eventName == "ThemeNameChanged" and (self._cellData).key == arg.key then
      (self._name):SetText(arg.name)
    end
    -- DECOMPILER ERROR: 3 unprocessed JMP targets
  end
end

return DIYThemeCell

