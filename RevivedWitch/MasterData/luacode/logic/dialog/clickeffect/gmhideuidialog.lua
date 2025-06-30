-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/clickeffect/gmhideuidialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ResourceLoader = ((CS.PixelNeko).Assets).ResourceLoader
local GridFrame = require("framework.ui.frame.grid.gridframe")
local ColumnNums = 2
local TopToBottom = 3
local CGMHideUIScene = (BeanManager.GetTableByName)("ui.cgmhideuiscene")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local GMHideUIDialog = class("GMHideUIDialog", Dialog)
GMHideUIDialog.AssetBundleName = "ui/layouts.gm"
GMHideUIDialog.AssetName = "GMHideUI"
GMHideUIDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : GMHideUIDialog
  ((GMHideUIDialog.super).Ctor)(self, ...)
  self._groupName = "Message"
  self._dataList = {}
end

GMHideUIDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : CGMHideUIScene, _ENV, CStringRes, TopToBottom, GridFrame, ColumnNums
  self._groupBtns = {}
  for i = 1, 3 do
    do
      -- DECOMPILER ERROR at PC12: Confused about usage of register: R5 in 'UnsetPending'

      (self._groupBtns)[i] = self:GetChild("GroupBtn" .. i)
      ;
      ((self._groupBtns)[i]):Subscribe_PointerClickEvent(function()
    -- function num : 0_1_0 , upvalues : self, i
    self:OnGroupBtnClicked(i)
  end
)
      local record = CGMHideUIScene:GetRecorder(i)
      local str = (TextManager.GetText)((CStringRes:GetRecorder(record.sceneName)).msgTextID)
      local btnText = self:GetChild("GroupBtn" .. i .. "/Text")
      btnText:SetText(str)
    end
  end
  self._assetsBtn = self:GetChild("GroupBtn4")
  ;
  (self._assetsBtn):Subscribe_PointerClickEvent(self.LogAssetsInfo)
  self._closeBtn = self:GetChild("CloseBtn")
  self._scrollBar = self:GetChild("Scrollbar")
  ;
  (self._scrollBar):SetScrollDirection(TopToBottom)
  self._panel = self:GetChild("Frame")
  self._frame = (GridFrame.Create)(self._panel, self, true, ColumnNums)
  self._width = (self._panel):GetRectSize()
  ;
  (self._closeBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._gmHideUIRecorderMap = ((NekoData.BehaviorManager).BM_Game):GetGMHideUIInfo()
  self:OnGroupBtnClicked(2)
end

GMHideUIDialog.OnDestroy = function(self)
  -- function num : 0_2
  (self._frame):Destroy()
end

GMHideUIDialog.OnGroupBtnClicked = function(self, index)
  -- function num : 0_3 , upvalues : _ENV
  if not self._tab or self._tab ~= index then
    self._tab = index
    while (self._dataList)[#self._dataList] do
      (table.remove)(self._dataList, #self._dataList)
    end
    local map = (self._gmHideUIRecorderMap)[index]
    for k,v in pairs(map) do
      (table.insert)(self._dataList, v)
    end
    ;
    (self._frame):ReloadAllCell()
    for k,v in pairs(self._groupBtns) do
      v:SetSelected(k == index)
    end
  end
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

GMHideUIDialog.NumberOfCell = function(self, frame)
  -- function num : 0_4
  return #self._dataList
end

GMHideUIDialog.CellAtIndex = function(self, frame)
  -- function num : 0_5
  return "clickeffect.gmhideuicell"
end

GMHideUIDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_6
  return (self._dataList)[index]
end

GMHideUIDialog.OnCurPosChange = function(self, frame, proportion)
  -- function num : 0_7
  local total = (self._frame):GetTotalLength()
  if self._height < total then
    (self._scrollBar):SetActive(true)
    ;
    (self._scrollBar):SetScrollSize(self._height / total)
    ;
    (self._scrollBar):SetScrollValue(proportion)
  else
    ;
    (self._scrollBar):SetActive(false)
  end
end

GMHideUIDialog.OnBackBtnClicked = function(self)
  -- function num : 0_8
  self:Destroy()
end

GMHideUIDialog.LogAssetsInfo = function(self)
  -- function num : 0_9 , upvalues : ResourceLoader, _ENV
  local debugInfo = (ResourceLoader.GetDebugInfo)()
  LogInfoFormat("GMHideUIDialog", "------------ QueueLength:%s ", debugInfo.QueueLength)
  LogInfoFormat("GMHideUIDialog", "------------ AssetBundleCount:%s ", (debugInfo.AssetBundleInfo).Count)
  for i = 0, (debugInfo.AssetBundleInfo).Count - 1 do
    local assetBundleInfo = (debugInfo.AssetBundleInfo)[i]
    local AssetBundleName = assetBundleInfo.AssetBundleName
    local RefCount = assetBundleInfo.RefCount
    LogInfoFormat("GMHideUIDialog", "------------ AssetBundleName:%s ", AssetBundleName)
    if RefCount < 0 then
      LogErrorFormat("GMHideUIDialog", "------------ AssetBundleName:%s   RefCount:%s ", AssetBundleName, RefCount)
    end
  end
end

return GMHideUIDialog

