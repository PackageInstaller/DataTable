local CCardRoleBookCfg = BeanManager.GetTableByName("handbook.ccardroleconfig_handbook")
local CFavourExp = BeanManager.GetTableByName("role.cfavourexp")
local CFavourPresent = BeanManager.GetTableByName("role.cfavourpresent")
local TableFrame = require("framework.ui.frame.table.tableframe")
local BackgroundStoryTabCell = class("BackgroundStoryTabCell", Dialog)
BackgroundStoryTabCell.AssetBundleName = "ui/layouts.tujian"
BackgroundStoryTabCell.AssetName = "CharStoryFrame2"

function BackgroundStoryTabCell:Ctor(...)
  BackgroundStoryTabCell.super.Ctor(self, ...)
  self._storyList = {}
end

function BackgroundStoryTabCell:OnCreate()
  self._frame = TableFrame.Create(self._rootWindow, self, true, true, true)
end

function BackgroundStoryTabCell:OnDestroy()
  self._frame:Destroy()
end

function BackgroundStoryTabCell:RefreshTabCell(refreshData, notChangePos)
  local lastPos = self._frame:GetCurrentPosition()
  if not self._init or refreshData then
    self._init = true
    local roleId = self._delegate._delegate._role:GetId()
    self._roleId = roleId
    self._favourLv = self._delegate._delegate._role:GetRelationLevel()
    local maxLv = self._delegate._delegate._role:GetRelationMaxLevel()
    self._maxHeartNum = math.ceil(CFavourExp:GetRecorder(maxLv).heartnum / 10)
    local roleBookCfg = CCardRoleBookCfg:GetRecorder(roleId)
    local favourPresentRecord = CFavourPresent:GetRecorder(roleId)
    local giftList = self._delegate._delegate._role:GetRelationRewardList()
    while self._storyList[#self._storyList] do
      table.remove(self._storyList, #self._storyList)
    end
    for i, v in ipairs(giftList) do
      if v.rewardType == DataCommon.Favour.BackgroundStory then
        table.insert(self._storyList, {
          reward = v,
          bookRecord = roleBookCfg,
          favourPresentRecord = favourPresentRecord
        })
      end
    end
    self._frame:ReloadAllCell()
  end
  if not notChangePos then
    self._frame:MoveToTop()
  elseif lastPos then
    self._frame:MoveToAssignedPos(lastPos)
  end
end

function BackgroundStoryTabCell:NumberOfCell(frame)
  return #self._storyList
end

function BackgroundStoryTabCell:CellAtIndex(frame, index)
  return "handbook.favour.backgroundstorycell"
end

function BackgroundStoryTabCell:DataAtIndex(frame, index)
  return self._storyList[index]
end

return BackgroundStoryTabCell
