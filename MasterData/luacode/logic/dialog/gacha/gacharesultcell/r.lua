-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/gacha/gacharesultcell/r.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local RCardCell = class("RCardCell", Dialog)
RCardCell.AssetBundleName = "ui/layouts.gacha"
RCardCell.AssetName = "GachaResultCell1"
RCardCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : RCardCell
  ((RCardCell.super).Ctor)(self, ...)
  self._backEffectHandler = nil
end

RCardCell.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self._photo = self:GetChild("UI/Mask/Photo")
  self._new = self:GetChild("UI/New")
  self._new = self:GetChild("UI/New")
  self._star = self:GetChild("UI/Star")
  self._job = self:GetChild("UI/Job")
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnCellClick, self)
  local random = (math.random)(1, 3)
  ;
  (self:GetRootWindow()):SetAnimatorTrigger("New Trigger" .. random)
end

RCardCell.OnDestroy = function(self)
  -- function num : 0_2
end

RCardCell.RefreshCell = function(self, data)
  -- function num : 0_3
  self._data = data
  if data.role then
    local image = (data.role):GetGachaRoleImageRecord()
    ;
    (self._photo):SetSprite(image.assetBundle, image.assetName)
    ;
    (self._new):SetActive(data.isNew)
    ;
    (self._job):SetText((data.role):GetVocationName())
  end
end

RCardCell.OnCellClick = function(self, args)
  -- function num : 0_4
  if not self._cellData or not (self._cellData).keyTag then
    local keyTag = (self._data).keyTag
  end
  ;
  (self._delegate):CheckRoleInfo(keyTag)
end

RCardCell.OnEvent = function(self, name, args)
  -- function num : 0_5
  if name == "hidenew" then
    (self._new):SetActive(false)
  end
end

RCardCell.HideNew = function(self)
  -- function num : 0_6
  (self._new):SetActive(false)
end

return RCardCell

