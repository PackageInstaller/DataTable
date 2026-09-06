local CStringRes = BeanManager.GetTableByName("message.cstringres")
local CNpcHandBookCfg = BeanManager.GetTableByName("handbook.cnpcconfig_handbook")
local TableFrame = require("framework.ui.frame.table.tableframe")
local NpcStoryPart = class("NpcStoryPart", Dialog)
NpcStoryPart.AssetBundleName = "ui/layouts.tujian"
NpcStoryPart.AssetName = "CharBookStory"

function NpcStoryPart:Ctor(...)
  NpcStoryPart.super.Ctor(self, ...)
  self._storyList = {}
end

function NpcStoryPart:OnCreate()
  self._title = self:GetChild("Back1/Title")
  self._storyPanel = self:GetChild("Back1/Frame")
  self._storyframe = TableFrame.Create(self._storyPanel, self, true, true, true)
  self._storyframe:SetMargin(15, 0)
  self._title:SetText(TextManager.GetText(CStringRes:GetRecorder(1289).msgTextID))
end

function NpcStoryPart:OnDestroy()
  self._storyframe:Destroy()
end

function NpcStoryPart:Refresh(npcid)
  local npcBookCfg = CNpcHandBookCfg:GetRecorder(npcid)
  self._storyList = {}
  local mainProgress = NekoData.BehaviorManager.BM_Game:GetMainLineProgress()
  local curFloor = mainProgress.floor
  local index = 0
  for k, v in ipairs(npcBookCfg.unlockCondition) do
    if v < curFloor then
      index = k
    end
  end
  if index == 0 then
    index = 1
  end
  local info = {}
  info.npcid = npcid
  info.backStory = TextManager.GetText(npcBookCfg.backStoryTextID[index])
  info.floorId = npcBookCfg.unlockCondition[index]
  table.insert(self._storyList, info)
  self._storyframe:ReloadAllCell()
  self._storyframe:MoveToTop()
end

function NpcStoryPart:NumberOfCell(frame, index)
  return #self._storyList
end

function NpcStoryPart:CellAtIndex(frame, index)
  return "handbook.npcstorycell"
end

function NpcStoryPart:DataAtIndex(frame, index)
  return self._storyList[index]
end

return NpcStoryPart
