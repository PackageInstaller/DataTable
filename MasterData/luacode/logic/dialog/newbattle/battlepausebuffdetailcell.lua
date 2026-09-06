local Role = require("logic.manager.experimental.types.role")
local TableFrame = require("framework.ui.frame.table.tableframe")
local CMonsterConfig = BeanManager.GetTableByName("npc.cmonsterconfig")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CCBuffConfig = BeanManager.GetTableByName("buff.ccbuffconfig")
local BattlePauseBuffDetailCell = class("BattlePauseBuffDetailCell", Dialog)
BattlePauseBuffDetailCell.AssetBundleName = "ui/layouts.battlenew"
BattlePauseBuffDetailCell.AssetName = "BattlePauseCellBuff"
local ImgIdType = {Monster = 12233, Boss = 12232}
local OneLineBuffNum = 3

function BattlePauseBuffDetailCell:Ctor(...)
  BattlePauseBuffDetailCell.super.Ctor(self, ...)
end

function BattlePauseBuffDetailCell:OnCreate()
  self._charImg = self:GetChild("CharBack/Image")
  self._charName = self:GetChild("Name")
  self._buffPanel = self:GetChild("BuffFrame")
  self._empty = self:GetChild("Empty")
  self._buffFrame = TableFrame.Create(self._buffPanel, self, true, false)
  self._rootWindowHeigthAnchor, self._rootWindowHeigthOffset = self:GetRootWindow():GetHeight()
  self._buffPanelRectX, self._buffPanelRectY = self._buffPanel:GetRectSize()
  self._theBuffCell = DialogManager.CreateDialog("newbattle.battlepausebuffdetailcellcellbuffcell", self._buffPanel:GetUIObject())
  self._theBuffCell:GetRootWindow():SetPosition(0, 100000, 0, 0)
end

function BattlePauseBuffDetailCell:OnDestroy()
  if self._buffFrame then
    self._buffFrame:Destroy()
    self._buffFrame = nil
  end
  self._theBuffCell:Destroy()
  self._theBuffCell:RootWindowDestroy()
end

function BattlePauseBuffDetailCell:RefreshCell(data)
  local nameTextId = data.battler:GetNameTextId()
  if data.battler:IsLeftCamp() then
    if 0 < nameTextId then
      local name = TextManager.GetText(nameTextId)
      self._charName:SetText(string.gsub(name, "%$heroine%$", NekoData.BehaviorManager.BM_Game:GetMyRoleInfo().username))
    end
    if data.battler:IsRole() then
      local role = Role.Create(data.battler:GetConfigId())
      local imgRecord = role:GetSkillHeadImageRecord()
      if imgRecord then
        self._charImg:SetSprite(imgRecord.assetBundle, imgRecord.assetName)
      end
    else
      local recorder = CMonsterConfig:GetRecorder(data.battler:GetConfigId())
      if recorder then
        local imageId = ImgIdType.Monster
        if recorder.bossOrNot == 1 then
          imageId = ImgIdType.Boss
        end
        local imageRecord = CImagePathTable:GetRecorder(imageId) or DataCommon.DefaultImageAsset
        self._charImg:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      end
    end
  else
    if 0 < nameTextId then
      local name = TextManager.GetText(nameTextId)
      local protocol = NekoData.BehaviorManager.BM_SBattleStart:GetProtocol()
      local userName = NekoData.BehaviorManager.BM_Battle:GetArenaEnemyNameByBattleID(protocol.battleid) or ""
      name = string.gsub(name, "%$heroine%$", userName)
      self._charName:SetText(name)
    end
    local recorder = CMonsterConfig:GetRecorder(data.battler:GetConfigId())
    if recorder then
      local imageId = ImgIdType.Monster
      if recorder.bossOrNot == 1 then
        imageId = ImgIdType.Boss
      end
      local imageRecord = CImagePathTable:GetRecorder(imageId) or DataCommon.DefaultImageAsset
      self._charImg:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    else
      local role = Role.Create(data.battler:GetConfigId())
      local imgRecord = role:GetSkillHeadImageRecord()
      if imgRecord then
        self._charImg:SetSprite(imgRecord.assetBundle, imgRecord.assetName)
      end
    end
  end
  self._buffList = {}
  for buffId, _ in pairs(data.buffList) do
    local recorder = CCBuffConfig:GetRecorder(buffId)
    if recorder.buffTextID ~= -1 then
      table.insert(self._buffList, buffId)
    end
  end
  table.sort(self._buffList, function(a, b)
    return a < b
  end)
  local data = {}
  local i = 1
  local oneLineLength = 0
  for _, v in ipairs(self._buffList) do
    local recorder = CCBuffConfig:GetRecorder(v)
    local thisLength = self._theBuffCell:GetCellActualWidth(TextManager.GetText(recorder.buffTextID))
    oneLineLength = oneLineLength + thisLength
    if data[i] then
      if oneLineLength > self._buffPanelRectX then
        i = i + 1
        data[i] = {}
        oneLineLength = thisLength
      end
      table.insert(data[i], v)
    else
      data[i] = {}
      table.insert(data[i], v)
    end
  end
  self._data = {}
  for i = #data, 1, -1 do
    table.insert(self._data, data[i])
  end
  self._buffFrame:ReloadAllCell()
  local totalLength = self._buffFrame:GetTotalLength()
  if totalLength > self._buffPanelRectY then
    self:GetRootWindow():SetHeight(self._rootWindowHeigthAnchor, self._rootWindowHeigthOffset + totalLength - self._buffPanelRectY)
  else
    self:GetRootWindow():SetHeight(self._rootWindowHeigthAnchor, self._rootWindowHeigthOffset)
  end
  self._buffFrame:ReloadAllCell()
  if #self._data == 0 then
    self._empty:SetActive(true)
  else
    self._empty:SetActive(false)
  end
end

function BattlePauseBuffDetailCell:NumberOfCell(frame)
  if frame == self._buffFrame then
    return #self._data
  end
end

function BattlePauseBuffDetailCell:CellAtIndex(frame)
  if frame == self._buffFrame then
    return "newbattle.battlepausebuffdetailcellcell"
  end
end

function BattlePauseBuffDetailCell:DataAtIndex(frame, index)
  if frame == self._buffFrame then
    return self._data[index]
  end
end

return BattlePauseBuffDetailCell
