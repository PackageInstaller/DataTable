local ResourceLoader = CS.PixelNeko.Assets.ResourceLoader
local GridFrame = require("framework.ui.frame.grid.gridframe")
local ColumnNums = 2
local TopToBottom = 3
local CGMHideUIScene = BeanManager.GetTableByName("ui.cgmhideuiscene")
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local GMHideUIDialog = class("GMHideUIDialog", Dialog)
GMHideUIDialog.AssetBundleName = "ui/layouts.gm"
GMHideUIDialog.AssetName = "GMHideUI"

function GMHideUIDialog:Ctor(...)
  GMHideUIDialog.super.Ctor(self, ...)
  self._groupName = "Message"
  self._dataList = {}
end

function GMHideUIDialog:OnCreate()
  self._groupBtns = {}
  for i = 1, 3 do
    self._groupBtns[i] = self:GetChild("GroupBtn" .. i)
    self._groupBtns[i]:Subscribe_PointerClickEvent(function()
      self:OnGroupBtnClicked(i)
    end)
    local record = CGMHideUIScene:GetRecorder(i)
    local str = TextManager.GetText(CStringRes:GetRecorder(record.sceneName).msgTextID)
    local btnText = self:GetChild("GroupBtn" .. i .. "/Text")
    btnText:SetText(str)
  end
  self._assetsBtn = self:GetChild("GroupBtn4")
  self._assetsBtn:Subscribe_PointerClickEvent(self.LogAssetsInfo)
  self._closeBtn = self:GetChild("CloseBtn")
  self._scrollBar = self:GetChild("Scrollbar")
  self._scrollBar:SetScrollDirection(TopToBottom)
  self._panel = self:GetChild("Frame")
  self._frame = GridFrame.Create(self._panel, self, true, ColumnNums)
  self._width, self._height = self._panel:GetRectSize()
  self._closeBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._gmHideUIRecorderMap = NekoData.BehaviorManager.BM_Game:GetGMHideUIInfo()
  self:OnGroupBtnClicked(2)
end

function GMHideUIDialog:OnDestroy()
  self._frame:Destroy()
end

function GMHideUIDialog:OnGroupBtnClicked(index)
  if not self._tab or self._tab ~= index then
    self._tab = index
    while self._dataList[#self._dataList] do
      table.remove(self._dataList, #self._dataList)
    end
    local map = self._gmHideUIRecorderMap[index]
    for k, v in pairs(map) do
      table.insert(self._dataList, v)
    end
    self._frame:ReloadAllCell()
    for k, v in pairs(self._groupBtns) do
      v:SetSelected(k == index)
    end
  end
end

function GMHideUIDialog:NumberOfCell(frame)
  return #self._dataList
end

function GMHideUIDialog:CellAtIndex(frame)
  return "clickeffect.gmhideuicell"
end

function GMHideUIDialog:DataAtIndex(frame, index)
  return self._dataList[index]
end

function GMHideUIDialog:OnCurPosChange(frame, proportion)
  local total = self._frame:GetTotalLength()
  if total > self._height then
    self._scrollBar:SetActive(true)
    self._scrollBar:SetScrollSize(self._height / total)
    self._scrollBar:SetScrollValue(proportion)
  else
    self._scrollBar:SetActive(false)
  end
end

function GMHideUIDialog:OnBackBtnClicked()
  self:Destroy()
end

function GMHideUIDialog:LogAssetsInfo()
  local debugInfo = ResourceLoader.GetDebugInfo()
  LogInfoFormat("GMHideUIDialog", "------------ QueueLength:%s ", debugInfo.QueueLength)
  LogInfoFormat("GMHideUIDialog", "------------ AssetBundleCount:%s ", debugInfo.AssetBundleInfo.Count)
  for i = 0, debugInfo.AssetBundleInfo.Count - 1 do
    local assetBundleInfo = debugInfo.AssetBundleInfo[i]
    local AssetBundleName = assetBundleInfo.AssetBundleName
    local RefCount = assetBundleInfo.RefCount
    LogInfoFormat("GMHideUIDialog", "------------ AssetBundleName:%s ", AssetBundleName)
    if RefCount < 0 then
      LogErrorFormat("GMHideUIDialog", "------------ AssetBundleName:%s   RefCount:%s ", AssetBundleName, RefCount)
    end
  end
end

return GMHideUIDialog
