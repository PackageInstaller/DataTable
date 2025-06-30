-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/handbook/npcstorycell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CstringCfg = (BeanManager.GetTableByName)("message.cstringres")
local CDungeonSelectMainline = (BeanManager.GetTableByName)("dungeonselect.cdungeonselectmainline")
local NpcStoryCell = class("NpcStoryCell", Dialog)
NpcStoryCell.AssetBundleName = "ui/layouts.tujian"
NpcStoryCell.AssetName = "CharBookStoryCell"
NpcStoryCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : NpcStoryCell
  ((NpcStoryCell.super).Ctor)(self, ...)
end

NpcStoryCell.OnCreate = function(self)
  -- function num : 0_1
  self._storyBack = self:GetChild("Normal")
  self._storyTxt = self:GetChild("Normal/Txt")
  self._title = self:GetChild("Normal/Title")
  self._lockBack = self:GetChild("Lock")
  self._lockTxt = self:GetChild("Lock/Txt")
end

NpcStoryCell.OnDestroy = function(self)
  -- function num : 0_2
end

NpcStoryCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : _ENV, CstringCfg, CDungeonSelectMainline
  if data.floorId == 0 or ((NekoData.BehaviorManager).BM_Game):GetFloorIsPassWithMainLineId(data.floorId) then
    (self._storyBack):SetActive(true)
    ;
    (self._lockBack):SetActive(false)
    local str = data.backStory
    str = (string.gsub)(str, "%$heroine%$", (((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()).username)
    ;
    (self._storyTxt):SetText(str)
  else
    do
      ;
      (self._storyBack):SetActive(false)
      ;
      (self._lockBack):SetActive(true)
      local str = (TextManager.GetText)((CstringCfg:GetRecorder(1120)).msgTextID)
      local stageName = (TextManager.GetText)((CDungeonSelectMainline:GetRecorder(data.floorId)).nameTextID)
      ;
      (self._lockTxt):SetText((string.gsub)(str, "%$parameter1%$", stageName))
    end
  end
end

return NpcStoryCell

