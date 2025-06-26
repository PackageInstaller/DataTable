-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/character/basecharacterlistcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local BaseCharacterListCell = class("BaseCharacterListCell", Dialog)
BaseCharacterListCell.AssetBundleName = "ui/layouts.basecharacterinfo"
BaseCharacterListCell.AssetName = "BaseCharacterListCell"
BaseCharacterListCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : BaseCharacterListCell
  ((BaseCharacterListCell.super).Ctor)(self, ...)
  self._data = nil
end

BaseCharacterListCell.OnCreate = function(self)
  -- function num : 0_1
  self._back = self:GetChild("CharacterCell/_Back")
  self._photo = self:GetChild("CharacterCell/_Photo")
  self._rank = self:GetChild("CharacterCell/_Rank")
  self._lock = self:GetChild("CharacterCell/_Lock")
  self._level = self:GetChild("CharacterCell/_Level/Num")
  self._maxLevel = self:GetChild("CharacterCell/_Level/MaxNum")
  self._select = self:GetChild("CharacterCell/_Select")
  self._job = self:GetChild("CharacterCell/_Job")
  self._team = self:GetChild("CharacterCell/_Team")
  self._frame = self:GetChild("CharacterCell/_Frame")
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

BaseCharacterListCell.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
end

BaseCharacterListCell.RefreshCell = function(self, data)
  -- function num : 0_3
  self._data = data
  ;
  (self._back):SetSprite((data:GetRarityBackRecord()).assetBundle, (data:GetRarityBackRecord()).assetName)
  ;
  (self._photo):SetSprite((data:GetShapeBustImageRecord()).assetBundle, (data:GetShapeBustImageRecord()).assetName)
  if data:GetIsLeader() then
    (self._rank):SetActive(false)
  else
    ;
    (self._rank):SetActive(true)
    ;
    (self._rank):SetSprite((data:GetRarityImageRecord()).assetBundle, (data:GetRarityImageRecord()).assetName)
  end
  ;
  (self._job):SetSprite((data:GetVocationImageRecord()).assetBundle, (data:GetVocationImageRecord()).assetName)
  ;
  (self._frame):SetSprite((data:GetRarityFrameRecord()).assetBundle, (data:GetRarityFrameRecord()).assetName)
  ;
  (self._lock):SetActive(data:GetIsLock())
  ;
  (self._select):SetActive((self._delegate):GetSelectRole() == data:GetRoleId())
  ;
  (self._level):SetText(data:GetLevel())
  ;
  (self._maxLevel):SetText(data:GetMaxLevelIgnorePlayerLv())
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

BaseCharacterListCell.OnCellClicked = function(self)
  -- function num : 0_4 , upvalues : _ENV
  if (self._delegate):GetSelectRole() ~= (self._cellData):GetRoleId() then
    (self._select):SetActive(true)
    ;
    (self._delegate):SetSelectRole((self._cellData):GetRoleId())
  else
    local dialog = (DialogManager.CreateSingletonDialog)("character.newcharacterinfodialog")
    if dialog then
      dialog:Refresh(self._data)
    end
  end
end

BaseCharacterListCell.OnEvent = function(self, eventName, arg)
  -- function num : 0_5
  if eventName == "ChangedSelected" then
    if (self._cellData):GetRoleId() == arg then
      (self._select):SetActive(true)
      ;
      (self._delegate):Refresh(self._cellData)
    else
      ;
      (self._select):SetActive(false)
    end
  else
  end
  if eventName == "RemoveAll" then
  end
end

return BaseCharacterListCell

