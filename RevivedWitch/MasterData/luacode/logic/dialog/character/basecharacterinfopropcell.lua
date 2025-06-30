-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/character/basecharacterinfopropcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local GridFrame = require("framework.ui.frame.grid.gridframe")
local Role = require("logic.manager.experimental.types.role")
local Item = require("logic.manager.experimental.types.item")
local CRoleBreakCfgTable = (BeanManager.GetTableByName)("role.crolebreakcfg")
local CRoleLevelCfgTable = (BeanManager.GetTableByName)("role.crolelevelcfg")
local RoleConfigTable = (BeanManager.GetTableByName)("role.roleconfig")
local AttrTypeEnum = (LuaNetManager.GetBeanDef)("protocol.login.attrtype")
local BaseCharacterInfoPropCell = class("BaseCharacterInfoPropCell", Dialog)
BaseCharacterInfoPropCell.AssetBundleName = "ui/layouts.basecharacterinfo"
BaseCharacterInfoPropCell.AssetName = "BaseCharacterInfoProp"
BaseCharacterInfoPropCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : BaseCharacterInfoPropCell
  ((BaseCharacterInfoPropCell.super).Ctor)(self, ...)
  self._handler = 0
  self._attrList = {}
end

BaseCharacterInfoPropCell.OnCreate = function(self)
  -- function num : 0_1 , upvalues : GridFrame
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
  self._propertyFrame = (GridFrame.Create)(self._propertyPanel, self, true, 2, false)
end

BaseCharacterInfoPropCell.RefreshCell = function(self, data, tag)
  -- function num : 0_2 , upvalues : CRoleBreakCfgTable, _ENV
  local image = data:GetModelRecord()
  if self._handler ~= 0 then
    (self._model):ReleaseModel(self._handler)
    self._handler = 0
  end
  self._roleKey = data:GetRoleId()
  self._handler = (self._model):AddModelSync(image.assetBundle, image.assetName)
  self._breakLv = data:GetBreakLv()
  local roleBreakRecord = CRoleBreakCfgTable:GetRecorder(data:GetBreakLv() + 1)
  self._level = data:GetLevel()
  self._exp = data:GetExp()
  if data:GetLevel() == roleBreakRecord.levelmax then
    (self._levelProgress):SetFillAmount(1)
  else
    ;
    (self._levelProgress):SetFillAmount(data:GetExp() / data:GetCurLvMaxExp())
  end
  ;
  (self._relationMax):SetText(tostring(self._favorMaxLv))
  ;
  (self._levelNum):SetText(tostring(data:GetLevel()))
  ;
  (self._relationNum):SetText(tostring(((NekoData.BehaviorManager).BM_AllRoles):GetRoleRelationLevelWithRoleId(data:GetId())))
  ;
  (self._levelMax):SetText(tostring(roleBreakRecord.levelmax))
  self._maxBreakLv = data:GetMaxBreakLv()
  local str = ""
  for i = 1, data:GetBreakLv() do
    str = str .. "1"
  end
  for i = 1, self._maxBreakLv - data:GetBreakLv() do
    str = str .. "0"
  end
  ;
  (self._levelPoint):SetText(str)
  while (self._attrList)[#self._attrList] do
    (table.remove)(self._attrList, #self._attrList)
  end
  for k,v in pairs(data:GetProperties()) do
    local temp = {}
    temp.attrId = k
    if (self._delegate)._openFromDungeon and k == 20 then
      temp.value = tostring(data:GetCurrentHp()) .. "/" .. tostring(v)
    else
      temp.value = v
    end
    ;
    (table.insert)(self._attrList, temp)
  end
  ;
  (table.sort)(self._attrList, function(a, b)
    -- function num : 0_2_0
    do return a.attrId < b.attrId end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  ;
  (self._propertyFrame):ReloadAllCell()
  local maxLv = data:GetEvolutionLimit()
  str = ""
  for i = 1, maxLv do
    if i <= data:GetEvolution() then
      str = str .. "1"
    else
      str = str .. "0"
    end
  end
  ;
  (self._evolvePoint):SetText(str)
  ;
  (self._fightNum):SetText(data:GetRolePower())
end

BaseCharacterInfoPropCell.OnDestroy = function(self)
  -- function num : 0_3
  (self._propertyFrame):Destroy()
end

BaseCharacterInfoPropCell.RefreshBreakLv = function(self, breaklv)
  -- function num : 0_4 , upvalues : CRoleBreakCfgTable, _ENV
  self._breakLv = breaklv
  local roleBreakRecord = CRoleBreakCfgTable:GetRecorder(breaklv + 1)
  ;
  (self._levelMax):SetText(tostring(roleBreakRecord.levelmax))
  local str = ""
  for i = 1, breaklv do
    str = str .. "1"
  end
  for i = 1, self._maxBreakLv - breaklv do
    str = str .. "0"
  end
  ;
  (self._levelPoint):SetText(str)
  if self._level == roleBreakRecord.levelmax then
    (self._levelProgress):SetFillAmount(1)
  else
    ;
    (self._levelProgress):SetFillAmount(self._exp / ((self._delegate)._data):GetCurLvMaxExp())
  end
end

BaseCharacterInfoPropCell.RefreshProperties = function(self, userInfo)
  -- function num : 0_5 , upvalues : _ENV
  while (self._attrList)[#self._attrList] do
    (table.remove)(self._attrList, #self._attrList)
  end
  for k,v in pairs(((self._delegate)._data):GetProperties()) do
    local temp = {}
    temp.attrId = k
    if (self._delegate)._openFromDungeon and k == 20 then
      temp.value = tostring(((self._delegate)._data):GetCurrentHp()) .. "/" .. tostring(v)
    else
      temp.value = v
    end
    ;
    (table.insert)(self._attrList, temp)
  end
  ;
  (table.sort)(self._attrList, function(a, b)
    -- function num : 0_5_0
    do return a.attrId < b.attrId end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  ;
  (self._propertyFrame):ReloadAllCell()
end

BaseCharacterInfoPropCell.RefreshLevel = function(self, levelandexp)
  -- function num : 0_6 , upvalues : _ENV, CRoleBreakCfgTable
  self._level = levelandexp.level
  self._exp = levelandexp.exp
  ;
  (self._levelNum):SetText(tostring(levelandexp.level))
  local roleBreakRecord = CRoleBreakCfgTable:GetRecorder(self._breakLv + 1)
  local width, height = (self._progressBackground):GetRectSize()
  if levelandexp.level == roleBreakRecord.levelmax then
    (self._levelProgress):SetFillAmount(1)
  else
    ;
    (self._levelProgress):SetFillAmount(levelandexp.exp / ((self._delegate)._data):GetCurLvMaxExp())
  end
end

BaseCharacterInfoPropCell.RefreshFavorLevel = function(self, userInfo)
  -- function num : 0_7
end

BaseCharacterInfoPropCell.RefreshEvolution = function(self, userInfo)
  -- function num : 0_8 , upvalues : _ENV
  local maxLv = (((NekoData.BehaviorManager).BM_AllRoles):GetRole(userInfo.key)):GetEvolutionLimit()
  local str = ""
  for i = 1, maxLv do
    if i <= userInfo.evolution then
      str = str .. "1"
    else
      str = str .. "0"
    end
  end
  ;
  (self._evolvePoint):SetText(str)
end

BaseCharacterInfoPropCell.RefreshPower = function(self, userInfo)
  -- function num : 0_9 , upvalues : _ENV
  local data = ((NekoData.BehaviorManager).BM_AllRoles):GetRole(userInfo.key)
  ;
  (self._fightNum):SetText(data:GetRolePower())
end

BaseCharacterInfoPropCell.NumberOfCell = function(self, frame)
  -- function num : 0_10
  if frame == self._propertyFrame then
    return #self._attrList
  end
end

BaseCharacterInfoPropCell.CellAtIndex = function(self, frame, index)
  -- function num : 0_11
  if frame == self._propertyFrame then
    return "character.basecharacterinfopropattrcell"
  end
end

BaseCharacterInfoPropCell.DataAtIndex = function(self, frame, index)
  -- function num : 0_12
  if frame == self._propertyFrame then
    return (self._attrList)[index]
  end
end

return BaseCharacterInfoPropCell

