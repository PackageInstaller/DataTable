-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/towerv2/towerv2teamlargecharactercell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TowerV2TeamLargeCharacterCell = class("TowerV2TeamLargeCharacterCell", Dialog)
TowerV2TeamLargeCharacterCell.AssetBundleName = "ui/layouts.mainline"
TowerV2TeamLargeCharacterCell.AssetName = "TowerCharacterCellLarge"
TowerV2TeamLargeCharacterCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : TowerV2TeamLargeCharacterCell
  ((TowerV2TeamLargeCharacterCell.super).Ctor)(self, ...)
  self._groupName = "Cell"
  self._handler = 0
end

TowerV2TeamLargeCharacterCell.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self._cell = self:GetChild("_Cell")
  self._back = self:GetChild("_Cell/Back")
  self._gray = self:GetChild("_Cell/Grey")
  self._photo = self:GetChild("_Cell/Photo")
  self._rank = self:GetChild("_Cell/Rank")
  self._rankDownBackBottom = self:GetChild("_Cell/RankDownBack")
  self._lvNum = self:GetChild("_Cell/Level/Num")
  self._lvMaxNum = self:GetChild("_Cell/Level/MaxNum")
  self._breakLevelBackBlack = self:GetChild("_Cell/BreakLevelBackBlack")
  self._breakLevelBack = self:GetChild("_Cell/BreakLevelBack")
  self._breakLevel = self:GetChild("_Cell/BreakLevelNum")
  self._job = self:GetChild("_Cell/Job")
  self._model = self:GetChild("_Cell/Model")
  self._hpProgress = self:GetChild("_Cell/HpBack/Hp")
  self._element = self:GetChild("_Cell/Element")
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

TowerV2TeamLargeCharacterCell.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
end

TowerV2TeamLargeCharacterCell.OnUniqueEquipLevelUp = function(self, notification)
  -- function num : 0_3
  if self._cellData and (self._cellData).roleKey == (notification.userInfo).roleId then
    self:RefreshCell(self._cellData, self._delegate)
  end
end

TowerV2TeamLargeCharacterCell.RefreshCell = function(self, data, delegate)
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
    local role = ((NekoData.BehaviorManager).BM_AllRoles):GetRole(data.roleKey)
    ;
    (self._lvNum):SetText(role:GetShowLv())
    ;
    (self._lvMaxNum):SetText(role:GetShowMaxBreakLv())
    local breakLv = role:GetBreakLv()
    ;
    (self._breakLevelBackBlack):SetActive(breakLv == 0)
    ;
    (self._breakLevelBack):SetActive(breakLv > 0)
    ;
    (self._breakLevel):SetActive(breakLv > 0)
    do
      do
        if breakLv > 0 then
          local imageRecord = role:GetCurBreakFrame2ImageRecord()
          ;
          (self._breakLevelBack):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
          ;
          (self._breakLevel):SetText(breakLv)
        end
        image = (self._role):GetVocationImageRecord()
        ;
        (self._job):SetSprite(image.assetBundle, image.assetName)
        image = (self._role):GetModelRecord()
        if self._handler ~= 0 then
          (self._model):ReleaseModel(self._handler)
          self._handler = 0
        end
        self._handler = (self._model):AddModelSync(image.assetBundle, image.assetName)
        image = (self._role):GetElementImageRecord()
        ;
        (self._element):SetSprite(image.assetBundle, image.assetName)
        ;
        (self._hpProgress):SetActive(false)
        ;
        (self._gray):SetActive(false)
        -- DECOMPILER ERROR: 6 unprocessed JMP targets
      end
    end
  end
end

TowerV2TeamLargeCharacterCell.OnCellLongPress = function(self)
  -- function num : 0_5 , upvalues : _ENV
  if not (self._delegate)._inSwitchPositionState then
    local dialog = (DialogManager.GetDialog)("character.newcharacterinfodialog")
    if not dialog and self._role then
      dialog = (DialogManager.CreateSingletonDialog)("character.newcharacterinfodialog")
      dialog:Refresh(self._role)
    end
  end
end

TowerV2TeamLargeCharacterCell.OnCellClicked = function(self)
  -- function num : 0_6 , upvalues : _ENV
  if not (self._delegate)._inSwitchPositionState then
    local dialog = (DialogManager.CreateSingletonDialog)("teamedit.changeteamroledialog")
    dialog:SetFilterCondition(((NekoData.BehaviorManager).BM_Team):GetTeamFilterCondition())
    dialog:Init((self._delegate)._teamInfo, self._cellData, true)
    dialog:SetSupportVocationTable((self._delegate)._supportVocationTable)
  end
end

TowerV2TeamLargeCharacterCell.OnBeginDrag = function(self, args)
  -- function num : 0_7
  if (self._delegate)._inSwitchPositionState and not (self._delegate)._draging then
    self._draging = true
    ;
    (self._delegate):OnCharCellBeginDrag(args.position, self._cellData)
    local image = (self._role):GetModelRecord()
    if self._handler ~= 0 then
      (self._model):ReleaseModel(self._handler)
      self._handler = 0
    end
    self._handler = (self._model):AddModelSync(image.assetBundle, image.assetName)
  end
end

TowerV2TeamLargeCharacterCell.OnDrag = function(self, args)
  -- function num : 0_8
  if (self._delegate)._inSwitchPositionState and self._draging then
    (self._delegate):OnCharCellDrag(args.position, self._cellData)
  end
end

TowerV2TeamLargeCharacterCell.OnEndDrag = function(self, args)
  -- function num : 0_9
  if (self._delegate)._inSwitchPositionState and self._draging then
    (self._delegate):OnCharCellEndDrag(args.position, self._cellData)
    self._draging = false
  end
end

return TowerV2TeamLargeCharacterCell

