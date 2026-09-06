local TableFrame = require("framework.ui.frame.table.tableframe")
local CMonsterBookCfg = BeanManager.GetTableByName("handbook.cmonster_handbook")
local CNPCShape = BeanManager.GetTableByName("npc.cnpcshape")
local CHandBookPropertyImage = BeanManager.GetTableByName("handbook.chankbookpropertyimage")
local FragmentLevelInfoDialog = class("FragmentLevelInfoDialog", Dialog)
FragmentLevelInfoDialog.AssetBundleName = "ui/layouts.fragment"
FragmentLevelInfoDialog.AssetName = "fragmentlevelinfo"

function FragmentLevelInfoDialog:Ctor(...)
  FragmentLevelInfoDialog.super.Ctor(self, ...)
  self._groupName = "Tip"
  self._mosterInfoRecord = nil
  self._currentIndex = -1
  self._propList = {}
  self._tagList = {}
  self._skillList = {}
end

function FragmentLevelInfoDialog:OnCreate()
  self._icon = self:GetChild("Model/Model")
  self._name = self:GetChild("Back/Frame/Name")
  self._detailText = self:GetChild("Back/Frame/DetailTxt")
  self._propFrameUI = self:GetChild("Back/Frame/PropFrame")
  self._propFrame = TableFrame.Create(self._propFrameUI, self, true)
  self._keyFrameUI = self:GetChild("Back/Frame/KeyFrame")
  self._keyFrame = TableFrame.Create(self._keyFrameUI, self, true)
  self._skillPanel = self:GetChild("Back/Frame/SkillFrame")
  self._skillFrame = TableFrame.Create(self._skillPanel, self, true, true, true)
  self._skillFrame:SetMargin(15, 0)
  self._level = self:GetChild("Back/Frame/Lv")
  self._leftArrow = self:GetChild("LeftArrow")
  self._rightArrow = self:GetChild("RightArrow")
  self._closeBtn = self:GetChild("Back/CloseBtn")
  self._leftArrow:Subscribe_PointerClickEvent(self.OnLeftBtnPointerClick, self)
  self._rightArrow:Subscribe_PointerClickEvent(self.OnRightBtnPointerClick, self)
  self._closeBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
end

function FragmentLevelInfoDialog:OnDestroy()
  self._propFrame:Destroy()
  self._keyFrame:Destroy()
  self._skillFrame:Destroy()
end

function FragmentLevelInfoDialog:SetData(mosters, lv)
  self._mosters = mosters
  self._currentIndex = 1
  local firstId = self._mosters[self._currentIndex]
  self._mosterInfoRecord = CMonsterBookCfg:GetRecorder(firstId)
  self._leftArrow:SetActive(false)
  self._level:SetText(lv)
  if #mosters == 1 then
    self._rightArrow:SetActive(false)
  end
  self:RefrashInfo()
end

local properList = {
  "hpScore",
  "adScore",
  "apScore",
  "mixScore",
  "pdScore",
  "mdScore"
}

function FragmentLevelInfoDialog:RefrashInfo()
  self._detailText:SetText(TextManager.GetText(self._mosterInfoRecord.descriptionTextID))
  self._name:SetText(TextManager.GetText(self._mosterInfoRecord.nameTextID))
  local npcShapeRecorder = CNPCShape:GetRecorder(self._mosterInfoRecord.shapeID)
  if self._handler ~= nil then
    self._icon:ReleaseModel(self._handler)
    self._handler = nil
  end
  self._handler = self._icon:AddModelSync(npcShapeRecorder.assetBundleName, npcShapeRecorder.prefabNameUI)
  local list = string.split(npcShapeRecorder.position, ",")
  local position = {
    x = tonumber(list[1]),
    y = tonumber(list[2])
  }
  local scale = tonumber(npcShapeRecorder.live2DScale)
  self._icon:SetAnchoredPosition(position.x, position.y)
  self._icon:SetLocalScale(scale, scale, scale)
  local imgRec = CHandBookPropertyImage:GetRecorder(1)
  local book = self._mosterInfoRecord
  self._propList = {}
  for _, v in ipairs(properList) do
    if 0 < book[v] then
      table.insert(self._propList, {
        num = book[v],
        icon = imgRec[v .. "Image"]
      })
    end
  end
  self._tagList = book.tag
  self._skillList = book.skillid
  self._skillFrame:ReloadAllCell()
  self._skillFrame:MoveToTop()
  self._propFrame:ReloadAllCell()
  self._keyFrame:ReloadAllCell()
end

function FragmentLevelInfoDialog:OnLeftBtnPointerClick()
  if self._currentIndex > 1 then
    self._currentIndex = self._currentIndex - 1
    local id = self._mosters[self._currentIndex]
    self._mosterInfoRecord = CMonsterBookCfg:GetRecorder(id)
    self:RefrashInfo()
  end
  if self._currentIndex == 1 then
    self._leftArrow:SetActive(false)
  elseif self._currentIndex == #self._mosters - 1 then
    self._rightArrow:SetActive(true)
  end
end

function FragmentLevelInfoDialog:OnRightBtnPointerClick()
  if self._currentIndex < #self._mosters then
    self._currentIndex = self._currentIndex + 1
    local id = self._mosters[self._currentIndex]
    self._mosterInfoRecord = CMonsterBookCfg:GetRecorder(id)
    self:RefrashInfo()
  end
  if self._currentIndex == 2 then
    self._leftArrow:SetActive(true)
  elseif self._currentIndex == #self._mosters then
    self._rightArrow:SetActive(false)
  end
end

function FragmentLevelInfoDialog:OnBackBtnClicked()
  self:Destroy()
end

function FragmentLevelInfoDialog:NumberOfCell(frame, index)
  if frame == self._propFrame then
    return #self._propList
  elseif frame == self._keyFrame then
    return #self._tagList
  elseif frame == self._skillFrame then
    return #self._skillList
  end
end

function FragmentLevelInfoDialog:CellAtIndex(frame, index)
  if frame == self._keyFrame then
    return "mainline.fragment.monstertagcell"
  elseif frame == self._propFrame then
    return "mainline.fragment.monsterpropcell"
  elseif frame == self._skillFrame then
    return "mainline.fragment.monsterskillcell"
  end
end

function FragmentLevelInfoDialog:DataAtIndex(frame, index)
  if frame == self._keyFrame then
    return self._tagList[index]
  elseif frame == self._propFrame then
    return self._propList[index]
  elseif frame == self._skillFrame then
    return self._skillList[index]
  end
end

function FragmentLevelInfoDialog:OnCurPosChange(frame, proportion)
  if frame == self._skillFrame then
    local _, height = self._skillPanel:GetRectSize()
    local total = self._skillFrame:GetTotalLength()
    frame:SetSlide(height < total)
  elseif frame == self._keyFrame then
    local _, height = self._keyFrameUI:GetRectSize()
    local total = self._keyFrame:GetTotalLength()
    frame:SetSlide(height < total)
  elseif frame == self._propFrame then
    local _, height = self._propFrameUI:GetRectSize()
    local total = self._propFrame:GetTotalLength()
    frame:SetSlide(height < total)
  end
end

function FragmentLevelInfoDialog:ShouldLengthChange()
  return true
end

return FragmentLevelInfoDialog
