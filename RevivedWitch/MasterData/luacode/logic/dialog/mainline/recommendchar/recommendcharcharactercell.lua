-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/mainline/recommendchar/recommendcharcharactercell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local RecommendCharCharacterCell = class("RecommendCharCharacterCell", Dialog)
local Role = require("logic.manager.experimental.types.role")
RecommendCharCharacterCell.AssetBundleName = "ui/layouts.mainline"
RecommendCharCharacterCell.AssetName = "RecommendCharCharacterCell"
RecommendCharCharacterCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : RecommendCharCharacterCell
  ((RecommendCharCharacterCell.super).Ctor)(self, ...)
end

RecommendCharCharacterCell.OnCreate = function(self, data)
  -- function num : 0_1
  self._back = self:GetChild("Back")
  self._icon = self:GetChild("Photo")
  self._rank = self:GetChild("Rank")
  self._job = self:GetChild("Job")
  self._select = self:GetChild("Select")
  self._element = self:GetChild("Element")
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

RecommendCharCharacterCell.OnDestroy = function(self)
  -- function num : 0_2
end

RecommendCharCharacterCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : Role
  if data == (((self._delegate)._delegate)._select).id and (self._delegate)._index == (((self._delegate)._delegate)._select).index then
    (self._select):SetActive(true)
  else
    ;
    (self._select):SetActive(false)
  end
  local role = (Role.Create)(data, nil, true)
  if role then
    local imageRecord = role:GetShapeHeadImageRecord()
    ;
    (self._icon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    imageRecord = role:GetRarityImageRecord()
    ;
    (self._rank):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    imageRecord = role:GetVocationImageRecord()
    ;
    (self._job):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    imageRecord = role:GetSmallRarityBackRecord()
    ;
    (self._back):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    imageRecord = role:GetElementImageRecord()
    ;
    (self._element):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  end
end

RecommendCharCharacterCell.OnCellClicked = function(self)
  -- function num : 0_4
  if self._cellData then
    (self._delegate):OnCellClicked(self._cellData)
  end
end

RecommendCharCharacterCell.OnEvent = function(self, eventName, arg)
  -- function num : 0_5
  if self._cellData and eventName == "SetSelectedRole" then
    if arg.id == self._cellData and (((self._delegate)._delegate)._select).index == (self._delegate)._index then
      (self._select):SetActive(true)
    else
      ;
      (self._select):SetActive(false)
    end
  end
end

return RecommendCharCharacterCell

