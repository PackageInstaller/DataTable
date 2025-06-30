-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/explore/detaillockcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CExploreLvUpCfg = (BeanManager.GetTableByName)("courtyard.cexplorelvup")
local CStringres = (BeanManager.GetTableByName)("message.cstringres")
local DetailLockCell = class("DetailLockCell", Dialog)
DetailLockCell.AssetBundleName = "ui/layouts.yard"
DetailLockCell.AssetName = "YardExploreTaskCell3"
DetailLockCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : DetailLockCell
  ((DetailLockCell.super).Ctor)(self, ...)
end

DetailLockCell.OnCreate = function(self)
  -- function num : 0_1
  self._index = self:GetChild("TopBack/LevelBack/Text")
  self._unlockCondition = self:GetChild("Txt")
end

DetailLockCell.OnDestroy = function(self)
  -- function num : 0_2
end

DetailLockCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : CExploreLvUpCfg, _ENV, CStringres
  local index = (self._delegate):GetSlotIndexBySlotId(data.slotId)
  ;
  (self._index):SetText(index)
  local unlockLevel = nil
  local allIds = CExploreLvUpCfg:GetAllIds()
  for i = 1, #allIds do
    local recorder = CExploreLvUpCfg:GetRecorder(allIds[i])
    if index <= recorder.teamNum then
      unlockLevel = recorder.id
      break
    end
  end
  do
    local str = (TextManager.GetText)((CStringres:GetRecorder(1124)).msgTextID)
    ;
    (self._unlockCondition):SetText((string.gsub)(str, "%$parameter1%$", unlockLevel))
  end
end

return DetailLockCell

