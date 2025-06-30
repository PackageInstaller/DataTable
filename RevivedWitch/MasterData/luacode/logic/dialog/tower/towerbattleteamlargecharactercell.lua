-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/tower/towerbattleteamlargecharactercell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TowerBattleTeamLargeCharacterCell = class("TowerBattleTeamLargeCharacterCell", Dialog)
TowerBattleTeamLargeCharacterCell.AssetBundleName = "ui/layouts.mainline"
TowerBattleTeamLargeCharacterCell.AssetName = "TowerCharacterCellLarge"
TowerBattleTeamLargeCharacterCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : TowerBattleTeamLargeCharacterCell
  ((TowerBattleTeamLargeCharacterCell.super).Ctor)(self, ...)
  self._groupName = "Cell"
  self._handler = 0
end

TowerBattleTeamLargeCharacterCell.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self._cell = self:GetChild("_Cell")
  self._back = self:GetChild("_Cell/Back")
  self._gray = self:GetChild("_Cell/Grey")
  self._photo = self:GetChild("_Cell/Photo")
  self._rank = self:GetChild("_Cell/Rank")
  self._rankDownBackBottom = self:GetChild("_Cell/RankDownBack")
  self._level = self:GetChild("_Cell/Level/Num")
  self._maxLevel = self:GetChild("_Cell/Level/MaxNum")
  self._job = self:GetChild("_Cell/Job")
  self._model = self:GetChild("_Cell/Model")
  self._hpProgress = self:GetChild("_Cell/HpBack/Hp")
  ;
  (self:GetRootWindow()):Subscribe_LongPressEvent(self.OnCellLongPress, self)
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnCellClicked, self)
  ;
  (self:GetRootWindow()):Subscribe_PointerDownEvent(self.OnBeginDrag, self)
  ;
  (self:GetRootWindow()):Subscribe_PointerMoveEvent(self.OnDrag, self)
  ;
  (self:GetRootWindow()):Subscribe_PointerUpEvent(self.OnEndDrag, self)
  ;
  (self:GetRootWindow()):Subscribe_PointerCancelEvent(self.OnEndDrag, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnUniqueEquipLevelUp, Common.n_UniqueEquipLevelUp, nil)
end

TowerBattleTeamLargeCharacterCell.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
end

TowerBattleTeamLargeCharacterCell.OnUniqueEquipLevelUp = function(self, notification)
  -- function num : 0_3
  if self._cellData and (self._cellData).roleKey == (notification.userInfo).roleId then
    self:RefreshCell(self._cellData, self._delegate)
  end
end

TowerBattleTeamLargeCharacterCell.RefreshCell = function(self, data, delegate)
  -- function num : 0_4 , upvalues : _ENV
  self._cellData = data
  self._delegate = delegate
  if data.roleKey == 0 then
    (self._cell):SetActive(false)
  else
    ;
    (self._cell):SetActive(true)
    self._role = ((NekoData.BehaviorManager).BM_AllRoles):GetRole(data.roleKey)
    local image = (self._role):GetShapeBigBustImageRecord()
    ;
    (self._photo):SetSprite(image.assetBundle, image.assetName)
    image = (self._role):GetTeamRarityBackRecord()
    ;
    (self._back):SetSprite(image.assetBundle, image.assetName)
    if (self._role):GetIsLeader() then
      (self._rank):SetActive(false)
      ;
      (self._rankDownBackBottom):SetActive(false)
    else
      ;
      (self._rank):SetActive(true)
      image = (self._role):GetTeamRarityImageRecord()
      ;
      (self._rank):SetSprite(image.assetBundle, image.assetName)
      image = (self._role):GetRarityRankDownRecord()
      ;
      (self._rankDownBackBottom):SetSprite(image.assetBundle, image.assetName)
    end
    ;
    (self._level):SetText((self._role):GetLevel())
    ;
    (self._maxLevel):SetText((self._role):GetMaxLevelIgnorePlayerLv())
    image = (self._role):GetVocationImageRecord()
    ;
    (self._job):SetSprite(image.assetBundle, image.assetName)
    image = (self._role):GetModelRecord()
    if self._handler ~= 0 then
      (self._model):ReleaseModel(self._handler)
      self._handler = 0
    end
    self._handler = (self._model):AddModelSync(image.assetBundle, image.assetName)
    ;
    (self._hpProgress):SetFillAmount(((NekoData.BehaviorManager).BM_Tower):GetRoleHP(data.roleKey))
    if ((NekoData.BehaviorManager).BM_Tower):GetRoleHP(data.roleKey) <= 0 then
      (self._gray):SetActive(true)
    else
      ;
      (self._gray):SetActive(false)
    end
  end
end

TowerBattleTeamLargeCharacterCell.OnCellLongPress = function(self)
  -- function num : 0_5 , upvalues : _ENV
  if not (self._delegate)._inSwitchPositionState then
    local dialog = (DialogManager.GetDialog)("character.newcharacterinfodialog")
    if not dialog and self._role then
      dialog = (DialogManager.CreateSingletonDialog)("character.newcharacterinfodialog")
      dialog:Refresh(self._role)
    end
  end
end

TowerBattleTeamLargeCharacterCell.OnCellClicked = function(self)
  -- function num : 0_6 , upvalues : _ENV
  if not (self._delegate)._inSwitchPositionState then
    ((DialogManager.CreateSingletonDialog)("teamedit.changeteamroledialog")):Init((self._delegate)._teamInfo, self._cellData, true)
  end
end

TowerBattleTeamLargeCharacterCell.OnBeginDrag = function(self, args)
  -- function num : 0_7
  if (self._delegate)._inSwitchPositionState then
    (self._delegate):OnCharCellBeginDrag(args.position, self._cellData)
    local image = (self._role):GetModelRecord()
    if self._handler ~= 0 then
      (self._model):ReleaseModel(self._handler)
      self._handler = 0
    end
    self._handler = (self._model):AddModelSync(image.assetBundle, image.assetName)
  end
end

TowerBattleTeamLargeCharacterCell.OnDrag = function(self, args)
  -- function num : 0_8
  if (self._delegate)._inSwitchPositionState then
    (self._delegate):OnCharCellDrag(args.position, self._cellData)
  end
end

TowerBattleTeamLargeCharacterCell.OnEndDrag = function(self, args)
  -- function num : 0_9
  if (self._delegate)._inSwitchPositionState then
    (self._delegate):OnCharCellEndDrag(args.position, self._cellData)
  end
end

return TowerBattleTeamLargeCharacterCell

