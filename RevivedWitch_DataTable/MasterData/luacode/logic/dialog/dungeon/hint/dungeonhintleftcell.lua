-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/dungeon/hint/dungeonhintleftcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local DungeonHintLeftCell = class("DungeonHintLeftCell", Dialog)
DungeonHintLeftCell.AssetBundleName = "ui/layouts.dungeon"
DungeonHintLeftCell.AssetName = "DungeonCharTalk1"
local cimagepath = (BeanManager.GetTableByName)("ui.cimagepath")
DungeonHintLeftCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : DungeonHintLeftCell
  ((DungeonHintLeftCell.super).Ctor)(self, ...)
  self._groupName = "Default"
end

DungeonHintLeftCell.OnCreate = function(self)
  -- function num : 0_1
  self._name = self:GetChild("Back/Name")
  self._icon = self:GetChild("Back/HeadPhoto/Photo")
  self._text = self:GetChild("Back/Txt")
  ;
  (self:GetRootWindow()):Subscribe_StateExitEvent(self.OnStateExit, self)
end

DungeonHintLeftCell.OnDestroy = function(self)
  -- function num : 0_2
end

DungeonHintLeftCell.SetData = function(self, delegate, role, textid, timeout)
  -- function num : 0_3
  self._delegate = delegate
  self._role = role
  self._textid = textid
  self._timeout = timeout
  self:Refresh()
end

DungeonHintLeftCell.Refresh = function(self)
  -- function num : 0_4 , upvalues : _ENV
  (self._name):SetText((self._role):GetRoleName())
  local icon = (self._role):GetDiamondHeadImageRecord()
  ;
  (self._icon):SetSprite(icon.assetBundle, icon.assetName)
  local text = ((TextManager.GetText)(self._textid)):gsub("%$heroine%$", (((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()).username)
  ;
  (self._text):SetText(text)
end

DungeonHintLeftCell.Appear = function(self)
  -- function num : 0_5
  (self:GetRootWindow()):SetAnimatorInteger("state", 1)
end

DungeonHintLeftCell.Disappear = function(self)
  -- function num : 0_6
  (self:GetRootWindow()):SetAnimatorInteger("state", 0)
end

DungeonHintLeftCell.OnStateExit = function(self, handler, stateName, normalizedTime)
  -- function num : 0_7
  if stateName ~= "DungeonCharTalkHold" or stateName == "DungeonCharTalkShow" then
    (self._delegate):OnCellAppear(self)
  else
    if stateName == "DungeonCharTalkHide" then
      (self._delegate):OnCellDisappear(self)
    end
  end
end

DungeonHintLeftCell.Reset = function(self)
  -- function num : 0_8
  (self:GetRootWindow()):SetYPosition(0, -1000)
  ;
  (self:GetRootWindow()):PlayAnimation("DungeonCharTalkHideHold")
end

return DungeonHintLeftCell

