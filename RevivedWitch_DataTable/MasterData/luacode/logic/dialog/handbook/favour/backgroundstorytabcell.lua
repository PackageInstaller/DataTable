-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/handbook/favour/backgroundstorytabcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CCardRoleBookCfg = (BeanManager.GetTableByName)("handbook.ccardroleconfig_handbook")
local CFavourExp = (BeanManager.GetTableByName)("role.cfavourexp")
local CFavourPresent = (BeanManager.GetTableByName)("role.cfavourpresent")
local TableFrame = require("framework.ui.frame.table.tableframe")
local BackgroundStoryTabCell = class("BackgroundStoryTabCell", Dialog)
BackgroundStoryTabCell.AssetBundleName = "ui/layouts.tujian"
BackgroundStoryTabCell.AssetName = "CharStoryFrame2"
BackgroundStoryTabCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : BackgroundStoryTabCell
  ((BackgroundStoryTabCell.super).Ctor)(self, ...)
  self._storyList = {}
end

BackgroundStoryTabCell.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame
  self._frame = (TableFrame.Create)(self._rootWindow, self, true, true, true)
end

BackgroundStoryTabCell.OnDestroy = function(self)
  -- function num : 0_2
  (self._frame):Destroy()
end

BackgroundStoryTabCell.RefreshTabCell = function(self, refreshData, notChangePos)
  -- function num : 0_3 , upvalues : _ENV, CFavourExp, CCardRoleBookCfg, CFavourPresent
  local lastPos = (self._frame):GetCurrentPosition()
  if not self._init or refreshData then
    self._init = true
    local roleId = (((self._delegate)._delegate)._role):GetId()
    self._roleId = roleId
    self._favourLv = (((self._delegate)._delegate)._role):GetRelationLevel()
    local maxLv = (((self._delegate)._delegate)._role):GetRelationMaxLevel()
    self._maxHeartNum = (math.ceil)((CFavourExp:GetRecorder(maxLv)).heartnum / 10)
    local roleBookCfg = CCardRoleBookCfg:GetRecorder(roleId)
    local favourPresentRecord = CFavourPresent:GetRecorder(roleId)
    local giftList = (((self._delegate)._delegate)._role):GetRelationRewardList()
    while (self._storyList)[#self._storyList] do
      (table.remove)(self._storyList, #self._storyList)
    end
    for i,v in ipairs(giftList) do
      if v.rewardType == (DataCommon.Favour).BackgroundStory then
        (table.insert)(self._storyList, {reward = v, bookRecord = roleBookCfg, favourPresentRecord = favourPresentRecord})
      end
    end
    ;
    (self._frame):ReloadAllCell()
  end
  do
    if not notChangePos then
      (self._frame):MoveToTop()
    else
      if lastPos then
        (self._frame):MoveToAssignedPos(lastPos)
      end
    end
  end
end

BackgroundStoryTabCell.NumberOfCell = function(self, frame)
  -- function num : 0_4
  return #self._storyList
end

BackgroundStoryTabCell.CellAtIndex = function(self, frame, index)
  -- function num : 0_5
  return "handbook.favour.backgroundstorycell"
end

BackgroundStoryTabCell.DataAtIndex = function(self, frame, index)
  -- function num : 0_6
  return (self._storyList)[index]
end

return BackgroundStoryTabCell

