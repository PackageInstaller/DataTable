local CharacterLargeCell = class("CharacterLargeCell", Dialog)
CharacterLargeCell.AssetBundleName = "ui/widgets"
CharacterLargeCell.AssetName = "CharacterCellLargeTeam"

local function ShowCharUpgrade(self, level)
  self._charUpgrade.panel:SetActive(level ~= 0)
  for i = 1, 5 do
    self._charUpgrade.levelImage[i]:SetActive(level == i)
  end
end

function CharacterLargeCell:Ctor(...)
  CharacterLargeCell.super.Ctor(self, ...)
  self._handler = 0
end

function CharacterLargeCell:OnCreate()
  self._empty = self:GetChild("_Empty")
  self._cell = self:GetChild("_Cell")
  self._back = self:GetChild("_Cell/Back")
  self._photo = self:GetChild("_Cell/Photo")
  self._rank = self:GetChild("_Cell/Rank")
  self._rankDownBackBottom = self:GetChild("_Cell/RankDownBack")
  self._level = self:GetChild("_Cell/Level/Num")
  self._maxLevel = self:GetChild("_Cell/Level/MaxNum")
  self._breakLevelBackBlack = self:GetChild("_Cell/BreakLevelBackBlack")
  self._breakLevelBack = self:GetChild("_Cell/BreakLevelBack")
  self._breakLevel = self:GetChild("_Cell/BreakLevelNum")
  self._job = self:GetChild("_Cell/Job")
  self._model = self:GetChild("_Cell/Model")
  self._guide = self:GetChild("Guide")
  self._jobLimit = self:GetChild("_Cell/JobLimit")
  self._starMirageUpPanel = self:GetChild("_Cell/ActivityStarUp")
  self._starMirageUpPanel_txt = self:GetChild("_Cell/ActivityStarUp/Text")
  self._detailBtn = self:GetChild("_Cell/DetailBtn")
  self._elementImg = self:GetChild("_Cell/Element")
  self._detailBtn:Subscribe_PointerClickEvent(self.OnCellLongPress, self)
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnCellClicked, self)
  self:GetRootWindow():Subscribe_PointerDownEvent(self.OnBeginDrag, self)
  self:GetRootWindow():Subscribe_PointerMoveEvent(self.OnDrag, self)
  self:GetRootWindow():Subscribe_PointerUpEvent(self.OnEndDrag, self)
  self:GetRootWindow():Subscribe_PointerCancelEvent(self.OnEndDrag, self)
  LuaNotificationCenter.AddObserver(self, self.OnUniqueEquipLevelUp, Common.n_UniqueEquipLevelUp, nil)
  self._charUpgrade = {
    panel = self:GetChild("_Cell/CharUpgrade"),
    levelImage = {}
  }
  for i = 1, 5 do
    self._charUpgrade.levelImage[i] = self:GetChild("_Cell/CharUpgrade/Img" .. i)
  end
end

function CharacterLargeCell:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
end

function CharacterLargeCell:OnUniqueEquipLevelUp(notification)
  if self._cellData and self._cellData.roleKey == notification.userInfo.roleId then
    self:RefreshCell(self._cellData, self._delegate)
  end
end

function CharacterLargeCell:RefreshCell(data, delegate)
  self._cellData = data
  self._delegate = delegate
  if data.roleKey == 0 then
    self._cell:SetActive(false)
    self._role = nil
  else
    self._cell:SetActive(true)
    self._role = NekoData.BehaviorManager.BM_AllRoles:GetRole(data.roleKey)
    local image = self._role:GetShapeBigBustImageRecord()
    self._photo:SetSprite(image.assetBundle, image.assetName)
    image = self._role:GetTeamRarityBackRecord()
    self._back:SetSprite(image.assetBundle, image.assetName)
    if self._role:GetIsLeader() then
      self._rank:SetActive(false)
      self._rankDownBackBottom:SetActive(false)
    else
      self._rank:SetActive(true)
      image = self._role:GetTeamRarityImageRecord()
      self._rank:SetSprite(image.assetBundle, image.assetName)
      image = self._role:GetRarityRankDownRecord()
      self._rankDownBackBottom:SetSprite(image.assetBundle, image.assetName)
    end
    self._level:SetText(self._role:GetShowLv())
    self._maxLevel:SetText(self._role:GetShowMaxBreakLv())
    local breakLv = self._role:GetBreakLv()
    self._breakLevelBackBlack:SetActive(breakLv == 0)
    self._breakLevelBack:SetActive(0 < breakLv)
    self._breakLevel:SetActive(0 < breakLv)
    if 0 < breakLv then
      local imageRecord = self._role:GetCurBreakFrame2ImageRecord()
      self._breakLevelBack:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      self._breakLevel:SetText(breakLv)
    end
    image = self._role:GetVocationImageRecord()
    self._job:SetSprite(image.assetBundle, image.assetName)
    image = self._role:GetElementImageRecord()
    self._elementImg:SetSprite(image.assetBundle, image.assetName)
    image = self._role:GetModelRecord()
    if self._handler ~= 0 then
      self._model:ReleaseModel(self._handler)
      self._handler = 0
    end
    self._handler = self._model:AddModelSync(image.assetBundle, image.assetName)
    self._jobLimit:SetActive(not NekoData.BehaviorManager.BM_Vocation:GetVocationIsSupport(self._role, self._delegate._supportVocationTable))
    local value = self._role:IsBoost()
    if not value then
      self._starMirageUpPanel:SetActive(false)
    else
      self._starMirageUpPanel:SetActive(true)
      self._starMirageUpPanel_txt:SetText(value.characterLargeCellStr)
    end
    ShowCharUpgrade(self, self._role:GetRuneLevel())
  end
end

function CharacterLargeCell:OnCellLongPress()
  if not self._delegate._inSwitchPositionState and not self._delegate._noResponse then
    local dialog = DialogManager.GetDialog("character.newcharacterinfodialog")
    if not dialog and self._role then
      dialog = DialogManager.CreateSingletonDialog("character.newcharacterinfodialog")
      dialog:Refresh(self._role)
    end
  end
end

function CharacterLargeCell:OnCellClicked()
  if not self._delegate._inSwitchPositionState and not self._delegate._noResponse then
    local dialog
    if self._delegate._isChristmasPart2CommonBattled then
      dialog = DialogManager.CreateSingletonDialog("activity.christmas.christmaspart2commonbattlechangeteamdialog")
    else
      dialog = DialogManager.CreateSingletonDialog("teamedit.changeteamroledialog")
    end
    dialog:SetFilterCondition(NekoData.BehaviorManager.BM_Team:GetTeamFilterCondition())
    dialog:Init(self._delegate._teamInfo, self._cellData)
    dialog._teamType = self._delegate._teamType
    dialog:SetSupportVocationTable(self._delegate._supportVocationTable)
  end
end

function CharacterLargeCell:OnBeginDrag(args)
  if self._delegate._inSwitchPositionState and not self._delegate._draging and not self._delegate._noResponse then
    self._draging = true
    self._delegate:OnCharCellBeginDrag(args.position, self._cellData)
    local image = self._role:GetModelRecord()
    if self._handler ~= 0 then
      self._model:ReleaseModel(self._handler)
      self._handler = 0
    end
    self._handler = self._model:AddModelSync(image.assetBundle, image.assetName)
  end
end

function CharacterLargeCell:OnDrag(args)
  if self._delegate._inSwitchPositionState and self._draging and not self._delegate._noResponse then
    self._delegate:OnCharCellDrag(args.position, self._cellData)
  end
end

function CharacterLargeCell:OnEndDrag(args)
  if self._delegate._inSwitchPositionState and self._draging and not self._delegate._noResponse then
    self._delegate:OnCharCellEndDrag(args.position, self._cellData)
    self._draging = false
  end
end

function CharacterLargeCell:PlayTwinkleByVocationLimit()
  if not NekoData.BehaviorManager.BM_Vocation:GetVocationIsSupport(self._role, self._delegate._supportVocationTable) then
    self:GetRootWindow():PlayAnimation("CharacterCellLargeTwinkle")
  end
end

return CharacterLargeCell
