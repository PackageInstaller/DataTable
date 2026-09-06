local DungeonHintLeftCell = class("DungeonHintLeftCell", Dialog)
DungeonHintLeftCell.AssetBundleName = "ui/layouts.dungeon"
DungeonHintLeftCell.AssetName = "DungeonCharTalk1"
local cimagepath = BeanManager.GetTableByName("ui.cimagepath")

function DungeonHintLeftCell:Ctor(...)
  DungeonHintLeftCell.super.Ctor(self, ...)
  self._groupName = "Default"
end

function DungeonHintLeftCell:OnCreate()
  self._name = self:GetChild("Back/Name")
  self._icon = self:GetChild("Back/HeadPhoto/Photo")
  self._text = self:GetChild("Back/Txt")
  self:GetRootWindow():Subscribe_StateExitEvent(self.OnStateExit, self)
end

function DungeonHintLeftCell:OnDestroy()
end

function DungeonHintLeftCell:SetData(delegate, role, textid, timeout)
  self._delegate = delegate
  self._role = role
  self._textid = textid
  self._timeout = timeout
  self:Refresh()
end

function DungeonHintLeftCell:Refresh()
  self._name:SetText(self._role:GetRoleName())
  local icon = self._role:GetDiamondHeadImageRecord()
  self._icon:SetSprite(icon.assetBundle, icon.assetName)
  local text = TextManager.GetText(self._textid):gsub("%$heroine%$", NekoData.BehaviorManager.BM_Game:GetMyRoleInfo().username)
  self._text:SetText(text)
end

function DungeonHintLeftCell:Appear()
  self:GetRootWindow():SetAnimatorInteger("state", 1)
end

function DungeonHintLeftCell:Disappear()
  self:GetRootWindow():SetAnimatorInteger("state", 0)
end

function DungeonHintLeftCell:OnStateExit(handler, stateName, normalizedTime)
  if stateName == "DungeonCharTalkHold" then
  elseif stateName == "DungeonCharTalkShow" then
    self._delegate:OnCellAppear(self)
  elseif stateName == "DungeonCharTalkHide" then
    self._delegate:OnCellDisappear(self)
  end
end

function DungeonHintLeftCell:Reset()
  self:GetRootWindow():SetYPosition(0, -1000)
  self:GetRootWindow():PlayAnimation("DungeonCharTalkHideHold")
end

return DungeonHintLeftCell
