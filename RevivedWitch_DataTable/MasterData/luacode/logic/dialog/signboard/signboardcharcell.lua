-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/signboard/signboardcharcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CPosterGirlNpc = (BeanManager.GetTableByName)("welfare.cpostergirlnpc")
local CNpcShapeTable = (BeanManager.GetTableByName)("npc.cnpcshape")
local SignboardCharCell = class("SignboardCharCell", Dialog)
SignboardCharCell.AssetBundleName = "ui/layouts.signboard"
SignboardCharCell.AssetName = "SignboardMainChar"
local ShowCharUpgrade = function(self, level)
  -- function num : 0_0
  ((self._charUpgrade).panel):SetActive(level ~= 0)
  for i = 1, 5 do
    (((self._charUpgrade).levelImage)[i]):SetActive(level == i)
  end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

SignboardCharCell.Ctor = function(self, ...)
  -- function num : 0_1 , upvalues : SignboardCharCell
  ((SignboardCharCell.super).Ctor)(self, ...)
end

SignboardCharCell.OnCreate = function(self)
  -- function num : 0_2
  self._jobIcon = self:GetChild("Cell/Job")
  self._rankIcon = self:GetChild("Cell/Rank")
  self._rankIconBack = self:GetChild("Cell/RankBack")
  self._photo = self:GetChild("Cell/Photo")
  self._frame = self:GetChild("Cell/Frame")
  self._levelPanel = self:GetChild("Cell/Level")
  self._level = self:GetChild("Cell/Level/Num")
  self._select = self:GetChild("Cell/Select")
  self._breakLevelBackBlack = self:GetChild("Cell/BreakLevelBackBlack")
  self._breakLevelBack = self:GetChild("Cell/BreakLevelBack")
  self._breakLevel = self:GetChild("Cell/BreakLevelNum")
  self._downRankBack = self:GetChild("Cell/DownRankBack")
  self._element = self:GetChild("Cell/Element")
  self._charUpgrade = {panel = self:GetChild("Cell/CharUpgrade"), 
levelImage = {}
}
  for i = 1, 5 do
    -- DECOMPILER ERROR at PC71: Confused about usage of register: R5 in 'UnsetPending'

    ((self._charUpgrade).levelImage)[i] = self:GetChild("Cell/CharUpgrade/Img" .. i)
  end
  ;
  (self._frame):Subscribe_PointerClickEvent(self.OnCellClick, self)
end

SignboardCharCell.OnDestroy = function(self)
  -- function num : 0_3
end

SignboardCharCell.RefreshCell = function(self, data)
  -- function num : 0_4 , upvalues : CPosterGirlNpc, CNpcShapeTable, CImagePathTable, ShowCharUpgrade
  (self._select):SetActive(false)
  if data == false then
    local aiLinNaRecorder = CPosterGirlNpc:GetRecorder(0)
    local shapeRecord = CNpcShapeTable:GetRecorder(aiLinNaRecorder.shapeId)
    local spriteRecord = CImagePathTable:GetRecorder(shapeRecord.headID)
    ;
    (self._photo):SetSprite(spriteRecord.assetBundle, spriteRecord.assetName)
    spriteRecord = CImagePathTable:GetRecorder(10145)
    ;
    (self._frame):SetSprite(spriteRecord.assetBundle, spriteRecord.assetName)
    ;
    (self._jobIcon):SetActive(false)
    ;
    (self._rankIcon):SetActive(false)
    ;
    (self._levelPanel):SetActive(false)
    ;
    (self._rankIconBack):SetActive(false)
    ;
    (self._breakLevelBackBlack):SetActive(false)
    ;
    (self._breakLevelBack):SetActive(false)
    ;
    (self._breakLevel):SetActive(false)
    ;
    (self._element):SetActive(false)
    ;
    (self._downRankBack):SetActive(false)
  else
    do
      local role = data
      local spriteRecord = role:GetVocationImageRecord()
      ;
      (self._jobIcon):SetSprite(spriteRecord.assetBundle, spriteRecord.assetName)
      spriteRecord = role:GetShapeLittleHeadImageRecord()
      ;
      (self._photo):SetSprite(spriteRecord.assetBundle, spriteRecord.assetName)
      spriteRecord = role:GetSmallRarityFrameRecord()
      ;
      (self._frame):SetSprite(spriteRecord.assetBundle, spriteRecord.assetName)
      spriteRecord = role:GetRarityImageRecord()
      ;
      (self._rankIcon):SetSprite(spriteRecord.assetBundle, spriteRecord.assetName)
      spriteRecord = role:GetElementImageRecord()
      ;
      (self._element):SetSprite(spriteRecord.assetBundle, spriteRecord.assetName)
      spriteRecord = data:GetRarityBottomBackRecord()
      ;
      (self._downRankBack):SetSprite(spriteRecord.assetBundle, spriteRecord.assetName)
      ;
      (self._level):SetText(role:GetShowLv())
      ;
      (self._jobIcon):SetActive(true)
      ;
      (self._frame):SetActive(true)
      ;
      (self._rankIcon):SetActive(true)
      ;
      (self._levelPanel):SetActive(true)
      ;
      (self._rankIconBack):SetActive(true)
      ;
      (self._element):SetActive(true)
      ;
      (self._downRankBack):SetActive(true)
      local breakLv = role:GetBreakLv()
      ;
      (self._breakLevelBackBlack):SetActive(breakLv == 0)
      ;
      (self._breakLevelBack):SetActive(breakLv > 0)
      ;
      (self._breakLevel):SetActive(breakLv > 0)
      do
        do
          if breakLv > 0 then
            local imageRecord = role:GetCurBreakFrame1ImageRecord()
            ;
            (self._breakLevelBack):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
            ;
            (self._breakLevel):SetText(breakLv)
          end
          ShowCharUpgrade(self, role:GetRuneLevel())
          -- DECOMPILER ERROR: 5 unprocessed JMP targets
        end
      end
    end
  end
end

SignboardCharCell.OnCellClick = function(self)
  -- function num : 0_5
  (self._delegate):OnCharCellClick(self._cellData)
end

SignboardCharCell.OnEvent = function(self, eventName, arg)
  -- function num : 0_6
  if self._cellData ~= arg then
    (self._select):SetActive(eventName ~= "ChangedSelected")
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
  end
end

return SignboardCharCell

