local GridFrame = require("framework.ui.frame.grid.gridframe")
local Role = require("logic.manager.experimental.types.role")
local Item = require("logic.manager.experimental.types.item")
local CRoleBreakCfgTable = BeanManager.GetTableByName("role.crolebreakcfg")
local CRoleLevelCfgTable = BeanManager.GetTableByName("role.crolelevelcfg")
local RoleConfigTable = BeanManager.GetTableByName("role.roleconfig")
local AttrTypeEnum = LuaNetManager.GetBeanDef("protocol.login.attrtype")
local BaseCharacterInfoPropCell = class("BaseCharacterInfoPropCell", Dialog)
BaseCharacterInfoPropCell.AssetBundleName = "ui/layouts.basecharacterinfo"
BaseCharacterInfoPropCell.AssetName = "BaseCharacterInfoProp"

function BaseCharacterInfoPropCell:Ctor(...)
  BaseCharacterInfoPropCell.super.Ctor(self, ...)
  self._handler = 0
  self._attrList = {}
end

function BaseCharacterInfoPropCell:OnCreate()
  self._model = self:GetChild("BackImg/Model")
  self._progressBackground = self:GetChild("Level/ProgressLevel/_BackGround")
  self._levelProgress = self:GetChild("Level/ProgressLevel/_BackGround/Progress")
  self._levelNum = self:GetChild("Level/LevelNum")
  self._levelMax = self:GetChild("Level/LevelMax")
  self._levelPoint = self:GetChild("Level/LevelPoint")
  self._relationNum = self:GetChild("Level/LevelNum3")
  self._relationMax = self:GetChild("Level/LevelMax3")
  self._propertyPanel = self:GetChild("Property")
  self._evolvePoint = self:GetChild("Level/EvolvePoint")
  self._fightNum = self:GetChild("Level/Fight/Num")
  self._propertyFrame = GridFrame.Create(self._propertyPanel, self, true, 2, false)
end

function BaseCharacterInfoPropCell:RefreshCell(data, tag)
  local image = data:GetModelRecord()
  if self._handler ~= 0 then
    self._model:ReleaseModel(self._handler)
    self._handler = 0
  end
  self._roleKey = data:GetRoleId()
  self._handler = self._model:AddModelSync(image.assetBundle, image.assetName)
  self._breakLv = data:GetBreakLv()
  local roleBreakRecord = CRoleBreakCfgTable:GetRecorder(data:GetBreakLv() + 1)
  self._level = data:GetLevel()
  self._exp = data:GetExp()
  if data:GetLevel() == roleBreakRecord.levelmax then
    self._levelProgress:SetFillAmount(1)
  else
    self._levelProgress:SetFillAmount(data:GetExp() / data:GetCurLvMaxExp())
  end
  self._relationMax:SetText(tostring(self._favorMaxLv))
  self._levelNum:SetText(tostring(data:GetLevel()))
  self._relationNum:SetText(tostring(NekoData.BehaviorManager.BM_AllRoles:GetRoleRelationLevelWithRoleId(data:GetId())))
  self._levelMax:SetText(tostring(roleBreakRecord.levelmax))
  self._maxBreakLv = data:GetMaxBreakLv()
  local str = ""
  for i = 1, data:GetBreakLv() do
    str = str .. "1"
  end
  for i = 1, self._maxBreakLv - data:GetBreakLv() do
    str = str .. "0"
  end
  self._levelPoint:SetText(str)
  while self._attrList[#self._attrList] do
    table.remove(self._attrList, #self._attrList)
  end
  for k, v in pairs(data:GetProperties()) do
    local temp = {}
    temp.attrId = k
    if self._delegate._openFromDungeon and k == 20 then
      temp.value = tostring(data:GetCurrentHp()) .. "/" .. tostring(v)
    else
      temp.value = v
    end
    table.insert(self._attrList, temp)
  end
  table.sort(self._attrList, function(a, b)
    return a.attrId < b.attrId
  end)
  self._propertyFrame:ReloadAllCell()
  local maxLv = data:GetEvolutionLimit()
  str = ""
  for i = 1, maxLv do
    if i <= data:GetEvolution() then
      str = str .. "1"
    else
      str = str .. "0"
    end
  end
  self._evolvePoint:SetText(str)
  self._fightNum:SetText(data:GetRolePower())
end

function BaseCharacterInfoPropCell:OnDestroy()
  self._propertyFrame:Destroy()
end

function BaseCharacterInfoPropCell:RefreshBreakLv(breaklv)
  self._breakLv = breaklv
  local roleBreakRecord = CRoleBreakCfgTable:GetRecorder(breaklv + 1)
  self._levelMax:SetText(tostring(roleBreakRecord.levelmax))
  local str = ""
  for i = 1, breaklv do
    str = str .. "1"
  end
  for i = 1, self._maxBreakLv - breaklv do
    str = str .. "0"
  end
  self._levelPoint:SetText(str)
  if self._level == roleBreakRecord.levelmax then
    self._levelProgress:SetFillAmount(1)
  else
    self._levelProgress:SetFillAmount(self._exp / self._delegate._data:GetCurLvMaxExp())
  end
end

function BaseCharacterInfoPropCell:RefreshProperties(userInfo)
  while self._attrList[#self._attrList] do
    table.remove(self._attrList, #self._attrList)
  end
  for k, v in pairs(self._delegate._data:GetProperties()) do
    local temp = {}
    temp.attrId = k
    if self._delegate._openFromDungeon and k == 20 then
      temp.value = tostring(self._delegate._data:GetCurrentHp()) .. "/" .. tostring(v)
    else
      temp.value = v
    end
    table.insert(self._attrList, temp)
  end
  table.sort(self._attrList, function(a, b)
    return a.attrId < b.attrId
  end)
  self._propertyFrame:ReloadAllCell()
end

function BaseCharacterInfoPropCell:RefreshLevel(levelandexp)
  self._level = levelandexp.level
  self._exp = levelandexp.exp
  self._levelNum:SetText(tostring(levelandexp.level))
  local roleBreakRecord = CRoleBreakCfgTable:GetRecorder(self._breakLv + 1)
  local width, height = self._progressBackground:GetRectSize()
  if levelandexp.level == roleBreakRecord.levelmax then
    self._levelProgress:SetFillAmount(1)
  else
    self._levelProgress:SetFillAmount(levelandexp.exp / self._delegate._data:GetCurLvMaxExp())
  end
end

function BaseCharacterInfoPropCell:RefreshFavorLevel(userInfo)
end

function BaseCharacterInfoPropCell:RefreshEvolution(userInfo)
  local maxLv = NekoData.BehaviorManager.BM_AllRoles:GetRole(userInfo.key):GetEvolutionLimit()
  local str = ""
  for i = 1, maxLv do
    if i <= userInfo.evolution then
      str = str .. "1"
    else
      str = str .. "0"
    end
  end
  self._evolvePoint:SetText(str)
end

function BaseCharacterInfoPropCell:RefreshPower(userInfo)
  local data = NekoData.BehaviorManager.BM_AllRoles:GetRole(userInfo.key)
  self._fightNum:SetText(data:GetRolePower())
end

function BaseCharacterInfoPropCell:NumberOfCell(frame)
  if frame == self._propertyFrame then
    return #self._attrList
  end
end

function BaseCharacterInfoPropCell:CellAtIndex(frame, index)
  if frame == self._propertyFrame then
    return "character.basecharacterinfopropattrcell"
  end
end

function BaseCharacterInfoPropCell:DataAtIndex(frame, index)
  if frame == self._propertyFrame then
    return self._attrList[index]
  end
end

return BaseCharacterInfoPropCell
