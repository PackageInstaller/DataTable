-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/dungeon/hint/dungeonhintrightcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local DungeonHintRightCell = class("DungeonHintRightCell", Dialog)
DungeonHintRightCell.AssetBundleName = "ui/layouts.dungeon"
DungeonHintRightCell.AssetName = "DungeonCharTalk2"
local cimagepath = (BeanManager.GetTableByName)("ui.cimagepath")
DungeonHintRightCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : DungeonHintRightCell
  ((DungeonHintRightCell.super).Ctor)(self, ...)
  self._groupName = "Default"
end

DungeonHintRightCell.OnCreate = function(self)
  -- function num : 0_1
  self._name = self:GetChild("Back/Name")
  self._icon = self:GetChild("Back/HeadPhoto/Photo")
  self._text = self:GetChild("Back/Txt")
  ;
  (self:GetRootWindow()):Subscribe_StateExitEvent(self.OnStateExit, self)
end

DungeonHintRightCell.OnDestroy = function(self)
  -- function num : 0_2
end

DungeonHintRightCell.SetData = function(self, delegate, role, textid, timeout)
  -- function num : 0_3
  self._delegate = delegate
  self._role = role
  self._textid = textid
  self._timeout = timeout
  self:Refresh()
end

DungeonHintRightCell.Refresh = function(self)
  -- function num : 0_4 , upvalues : _ENV
  (self._name):SetText((self._role):GetRoleName())
  local icon = (self._role):GetDiamondHeadImageRecord()
  ;
  (self._icon):SetSprite(icon.assetBundle, icon.assetName)
  local text = ((TextManager.GetText)(self._textid)):gsub("%$heroine%$", (((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()).username)
  ;
  (self._text):SetText(text)
end

DungeonHintRightCell.Appear = function(self)
  -- function num : 0_5
  (self:GetRootWindow()):SetAnimatorInteger("state", 1)
end

DungeonHintRightCell.Disappear = function(self)
  -- function num : 0_6
  (self:GetRootWindow()):SetAnimatorInteger("state", 0)
end

DungeonHintRightCell.OnStateExit = function(self, handler, stateName, normalizedTime)
  -- function num : 0_7
  if stateName ~= "DungeonCharTalkHold" or stateName == "DungeonCharTalkShow" then
    (self._delegate):OnCellAppear(self._textid)
  else
    if stateName == "DungeonCharTalkHide" then
      (self._delegate):OnCellDisappear(self._textid)
    end
  end
end

DungeonHintRightCell.Reset = function(self)
  -- function num : 0_8
  (self:GetRootWindow()):SetYPosition(0, -1000)
  ;
  (self:GetRootWindow()):PlayAnimation("DungeonCharTalkHideHold")
end

return DungeonHintRightCell

