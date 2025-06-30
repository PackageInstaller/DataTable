-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/mainline/branchline/branchlinefinishidialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CSideStoryChapter = (BeanManager.GetTableByName)("dungeonselect.csidestorychapter")
local CSideStoryStage = (BeanManager.GetTableByName)("dungeonselect.csidestorystage")
local CSideStoryRole = (BeanManager.GetTableByName)("dungeonselect.csidestoryrole")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local GridFrame = require("framework.ui.frame.grid.gridframe")
local Item = require("logic.manager.experimental.types.item")
local ItemTypeEnum = (LuaNetManager.GetBeanDef)("protocol.item.beans.item")
local MaxColumnNums = 5
local BranchLineFinishiDialog = class("BranchLineFinishiDialog", Dialog)
BranchLineFinishiDialog.AssetBundleName = "ui/layouts.sidestory"
BranchLineFinishiDialog.AssetName = "SideStoryFinish"
BranchLineFinishiDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : BranchLineFinishiDialog
  ((BranchLineFinishiDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
end

BranchLineFinishiDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : GridFrame, MaxColumnNums
  self._itemPanel = self:GetChild("Panel/Item")
  self._field = self:GetChild("Panel/Item/Frame")
  self._frame = (GridFrame.Create)(self._field, self, true, MaxColumnNums, false)
  self._emptyPanel = self:GetChild("Panel/ItemEmpty")
  self._emptyTips = self:GetChild("Panel/ItemEmpty/Txt")
  self._normalPanel = self:GetChild("Panel/Normal")
  self._normalTitle = self:GetChild("Panel/Normal/Title1")
  self._normalTxt = self:GetChild("Panel/Normal/Title2")
  self._lastPanel = self:GetChild("Panel/Last")
  self._lastStoryTxt = self:GetChild("Panel/Last/StoryTxt")
  self._lastStoryName = self:GetChild("Panel/Last/StoryName")
  self._lastTxt = self:GetChild("Panel/Last/Txt")
  self._width = (self._field):GetRectSize()
  self._rootWindowAnchoredx = (self:GetRootWindow()):GetAnchoredPosition()
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnNextClicked, self)
  self:Init()
end

BranchLineFinishiDialog.OnDestroy = function(self)
  -- function num : 0_2
  (self._frame):Destroy()
end

BranchLineFinishiDialog.Init = function(self)
  -- function num : 0_3 , upvalues : _ENV, Item, CStringRes, CSideStoryStage, CSideStoryChapter, CSideStoryRole
  self._data = {}
  local firstAwardList = ((NekoData.BehaviorManager).BM_Game):GetFirstAwardFromDungeon()
  local accountList = ((NekoData.BehaviorManager).BM_Game):GetAccountBag()
  local money = ((NekoData.BehaviorManager).BM_Game):GetDungeonObtainMoney()
  if firstAwardList and #firstAwardList > 0 then
    for i,v in ipairs(firstAwardList) do
      (table.insert)(self._data, {item = v})
    end
  end
  do
    if accountList then
      for i,v in ipairs(accountList) do
        (table.insert)(self._data, v)
      end
    end
    do
      for k,v in pairs(money) do
        local item = (Item.Create)(k)
        ;
        (table.insert)(self._data, {item = item, num = v})
      end
      local currentWordID = nil
      local currentFloorID = ((NekoData.BehaviorManager).BM_Game):GetCurPassZoneId()
      local nextFloorId = ((NekoData.BehaviorManager).BM_Game):GetNextFloorId()
      local list = ((NekoData.BehaviorManager).BM_Game):GetBranchLineList()
      for worldId,world in pairs(list) do
        for id,_ in pairs(world.questInfo) do
          if nextFloorId == id then
            currentWordID = worldId
            break
          end
        end
      end
      if #self._data ~= 0 then
        (self._emptyPanel):SetActive(false)
        ;
        (self._itemPanel):SetActive(true)
      else
        ;
        (self._itemPanel):SetActive(false)
        ;
        (self._emptyPanel):SetActive(true)
        local str = (TextManager.GetText)((CStringRes:GetRecorder(1106)).msgTextID)
        ;
        (self._emptyTips):SetText(str)
      end
      do
        self._isFinishi = ((NekoData.BehaviorManager).BM_Game):GetBranchLineIsFinishiByWordId(currentWordID)
        if not self._isFinishi then
          (self._normalPanel):SetActive(true)
          ;
          (self._lastPanel):SetActive(false)
          local str = (TextManager.GetText)((CSideStoryStage:GetRecorder(currentFloorID)).stagefinishnamenumid)
          ;
          (self._normalTitle):SetText(str)
          local name = (TextManager.GetText)((CSideStoryStage:GetRecorder(currentFloorID)).stagefinishnametxtid)
          ;
          (self._normalTxt):SetText(name)
        else
          do
            ;
            (self._normalPanel):SetActive(false)
            ;
            (self._lastPanel):SetActive(true)
            local worldRecorder = CSideStoryChapter:GetRecorder(currentWordID)
            local str = (TextManager.GetText)((CStringRes:GetRecorder(1200)).msgTextID)
            local roleid = worldRecorder.sidestoryroleid
            local roleName = (TextManager.GetText)((CSideStoryRole:GetRecorder(roleid)).rolenametxt)
            do
              local storyName = (TextManager.GetText)(worldRecorder.chapternumnametxt)
              str = (string.gsub)(str, "%$parameter1%$", roleName)
              str = (string.gsub)(str, "%$parameter2%$", storyName)
              ;
              (self._lastStoryName):SetText(str)
              str = (TextManager.GetText)(worldRecorder.sidestorytitletxt)
              ;
              (self._lastStoryTxt):SetText(str)
              ;
              (self._frame):ReloadAllCell()
              self:ChangeCellPosition()
            end
          end
        end
      end
    end
  end
end

BranchLineFinishiDialog.ChangeCellPosition = function(self)
  -- function num : 0_4 , upvalues : MaxColumnNums
  local num = #self._data
  local cellPanelWidth = nil
  if num < MaxColumnNums then
    cellPanelWidth = self._width / MaxColumnNums * num
  else
    cellPanelWidth = self._width
  end
  local cellPanelHeight = (self._frame):GetTotalLength()
  if self._height < cellPanelHeight then
    cellPanelHeight = self._height
  end
  ;
  (self._field):SetSize(0, cellPanelWidth, 0, cellPanelHeight)
  ;
  (self._field):SetAnchoredPosition(self._rootWindowAnchoredx, self._rootWindowAnchoredy)
  ;
  (self._itemPanel):SetAnchoredPosition(self._rootWindowAnchoredx, self._rootWindowAnchoredy)
  ;
  (self._frame):ReloadAllCell()
end

BranchLineFinishiDialog.NumberOfCell = function(self, frame)
  -- function num : 0_5
  return #self._data
end

BranchLineFinishiDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_6
  return "mainline.branchline.sidestoryfinishitemcell"
end

BranchLineFinishiDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_7
  return (self._data)[index]
end

BranchLineFinishiDialog.OnNextClicked = function(self)
  -- function num : 0_8 , upvalues : _ENV
  local controller = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).CommonDungeon)
  if not controller then
    ((NekoData.BehaviorManager).BM_Game):FinishDungeonReward()
  end
  self:Destroy()
end

return BranchLineFinishiDialog

