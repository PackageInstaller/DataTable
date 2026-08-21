-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/handbook/npcstorypart.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local CNpcHandBookCfg = (BeanManager.GetTableByName)("handbook.cnpcconfig_handbook")
local TableFrame = require("framework.ui.frame.table.tableframe")
local NpcStoryPart = class("NpcStoryPart", Dialog)
NpcStoryPart.AssetBundleName = "ui/layouts.tujian"
NpcStoryPart.AssetName = "CharBookStory"
NpcStoryPart.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : NpcStoryPart
  ((NpcStoryPart.super).Ctor)(self, ...)
  self._storyList = {}
end

NpcStoryPart.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame, _ENV, CStringRes
  self._title = self:GetChild("Back1/Title")
  self._storyPanel = self:GetChild("Back1/Frame")
  self._storyframe = (TableFrame.Create)(self._storyPanel, self, true, true, true)
  ;
  (self._storyframe):SetMargin(15, 0)
  ;
  (self._title):SetText((TextManager.GetText)((CStringRes:GetRecorder(1289)).msgTextID))
end

NpcStoryPart.OnDestroy = function(self)
  -- function num : 0_2
  (self._storyframe):Destroy()
end

NpcStoryPart.Refresh = function(self, npcid)
  -- function num : 0_3 , upvalues : CNpcHandBookCfg, _ENV
  local npcBookCfg = CNpcHandBookCfg:GetRecorder(npcid)
  self._storyList = {}
  local mainProgress = ((NekoData.BehaviorManager).BM_Game):GetMainLineProgress()
  local curFloor = mainProgress.floor
  local index = 0
  for k,v in ipairs(npcBookCfg.unlockCondition) do
    if v < curFloor then
      index = k
    end
  end
  if index == 0 then
    index = 1
  end
  local info = {}
  info.npcid = npcid
  info.backStory = (TextManager.GetText)((npcBookCfg.backStoryTextID)[index])
  info.floorId = (npcBookCfg.unlockCondition)[index]
  ;
  (table.insert)(self._storyList, info)
  ;
  (self._storyframe):ReloadAllCell()
  ;
  (self._storyframe):MoveToTop()
end

NpcStoryPart.NumberOfCell = function(self, frame, index)
  -- function num : 0_4
  return #self._storyList
end

NpcStoryPart.CellAtIndex = function(self, frame, index)
  -- function num : 0_5
  return "handbook.npcstorycell"
end

NpcStoryPart.DataAtIndex = function(self, frame, index)
  -- function num : 0_6
  return (self._storyList)[index]
end

return NpcStoryPart

