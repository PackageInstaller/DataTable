-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/traincamp/trainaccountcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SCompleteTrain = (LuaNetManager.GetProtocolDef)("protocol.yard.scompletetrain")
local Item = require("logic.manager.experimental.types.item")
local TrainAccountCell = class("TrainAccountCell", Dialog)
TrainAccountCell.AssetBundleName = "ui/layouts.yard"
TrainAccountCell.AssetName = "TrainFinishCell"
TrainAccountCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : TrainAccountCell
  ((TrainAccountCell.super).Ctor)(self, ...)
end

TrainAccountCell.OnCreate = function(self)
  -- function num : 0_1
  self._frame = self:GetChild("Panel/CharSmallCell/Frame")
  self._photo = self:GetChild("Panel/CharSmallCell/Photo")
  self._downRankBack = self:GetChild("Panel/CharSmallCell/DownRankBack")
  self._level = self:GetChild("Panel/CharSmallCell/Level/Num")
  self._rankBack = self:GetChild("Panel/CharSmallCell/RankBack")
  self._rank = self:GetChild("Panel/CharSmallCell/Rank")
  self._job = self:GetChild("Panel/CharSmallCell/Job")
  self._breakLevelBackBlack = self:GetChild("Panel/CharSmallCell/BreakLevelBackBlack")
  self._breakLevelBack = self:GetChild("Panel/CharSmallCell/BreakLevelBack")
  self._breakLevelNum = self:GetChild("Panel/CharSmallCell/BreakLevelNum")
  self._breakLevel = self:GetChild("Panel/CharSmallCell/BreakLevel")
  self._element = self:GetChild("Panel/CharSmallCell/Element")
  self._grey = self:GetChild("Panel/CharSmallCell/Grey")
  self._select = self:GetChild("Panel/CharSmallCell/Select")
  self._lvUpPanel = self:GetChild("Panel/LevelUp")
  self._lvUpPanel_exp = self:GetChild("Panel/LevelUp/Exp/Num")
  self._lvUpPanel_last_lv = self:GetChild("Panel/LevelUp/Lv/Txt2")
  self._lvUpPanel_last_breakLevelBackBlack = self:GetChild("Panel/LevelUp/BreakLevelBackBlack")
  self._lvUpPanel_last_breakLevelBack = self:GetChild("Panel/LevelUp/BreakLevelBack")
  self._lvUpPanel_last_breakLevelNum = self:GetChild("Panel/LevelUp/BreakLevelNumBefore")
  self._lvUpPanel_lv = self:GetChild("Panel/LevelUp/Lv/Txt3")
  self._lvUpPanel_breakLevelBackBlack = self:GetChild("Panel/LevelUp/BreakLevelBackBlack2")
  self._lvUpPanel_breakLevelBack = self:GetChild("Panel/LevelUp/BreakLevelBack2")
  self._lvUpPanel_breakLevelNum = self:GetChild("Panel/LevelUp/BreakLevelNumAfter")
  self._maxPanel = self:GetChild("Panel/Max")
  self._maxPanel_itemIcon = self:GetChild("Panel/Max/Num/Item")
  self._maxPanel_itemNum = self:GetChild("Panel/Max/Num/Num")
  self._expPanel = self:GetChild("Panel/Normal")
  self._expPanel_exp = self:GetChild("Panel/Normal/Exp/Num")
end

TrainAccountCell.OnDestroy = function(self)
  -- function num : 0_2
end

TrainAccountCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : _ENV, SCompleteTrain, Item
  local role = ((NekoData.BehaviorManager).BM_AllRoles):GetRole(data.roleId)
  if role then
    local image = role:GetShapeLittleHeadImageRecord()
    ;
    (self._photo):SetSprite(image.assetBundle, image.assetName)
    image = role:GetSmallRarityFrameRecord()
    ;
    (self._frame):SetSprite(image.assetBundle, image.assetName)
    image = role:GetRarityBottomBackRecord()
    ;
    (self._downRankBack):SetSprite(image.assetBundle, image.assetName)
    ;
    (self._level):SetText(role:GetShowLv())
    image = role:GetRarityImageRecord()
    ;
    (self._rank):SetSprite(image.assetBundle, image.assetName)
    image = role:GetVocationImageRecord()
    ;
    (self._job):SetSprite(image.assetBundle, image.assetName)
    local breakLv = role:GetBreakLv()
    ;
    (self._breakLevelBackBlack):SetActive(breakLv == 0)
    ;
    (self._breakLevelBack):SetActive(breakLv > 0)
    ;
    (self._breakLevelNum):SetActive(breakLv > 0)
    if breakLv > 0 then
      image = role:GetCurBreakFrame1ImageRecord()
      ;
      (self._breakLevelBack):SetSprite(image.assetBundle, image.assetName)
      ;
      (self._breakLevelNum):SetText(breakLv)
    end
    image = role:GetElementImageRecord()
    ;
    (self._element):SetSprite(image.assetBundle, image.assetName)
  else
    LogError("Data Error!")
  end
  if data.type == SCompleteTrain.ADD_EXP then
    (self._expPanel):SetActive(true)
    ;
    (self._lvUpPanel):SetActive(false)
    ;
    (self._maxPanel):SetActive(false)
    ;
    (self._expPanel_exp):SetText(data.award)
  elseif data.type == SCompleteTrain.ADD_LEVEL then
    (self._expPanel):SetActive(false)
    ;
    (self._lvUpPanel):SetActive(true)
    ;
    (self._maxPanel):SetActive(false)
    local strList = (string.split)(data.award, ";")
    ;
    (self._lvUpPanel_exp):SetText(strList[1])
    local breakLv, showLv = role:GetBreakLvAndShowLvByRoleLv(tonumber(strList[2]))
    ;
    (self._lvUpPanel_last_lv):SetText(showLv)
    ;
    (self._lvUpPanel_last_breakLevelBackBlack):SetActive(breakLv == 0)
    ;
    (self._lvUpPanel_last_breakLevelBack):SetActive(breakLv > 0)
    ;
    (self._lvUpPanel_last_breakLevelNum):SetActive(breakLv > 0)
    if breakLv > 0 then
      image = role:GetCurBreakFrame1ImageRecord()
      ;
      (self._lvUpPanel_last_breakLevelBack):SetSprite(image.assetBundle, image.assetName)
      ;
      (self._lvUpPanel_last_breakLevelNum):SetText(breakLv)
    end
    breakLv = role:GetBreakLvAndShowLvByRoleLv(tonumber(strList[3]))
    ;
    (self._lvUpPanel_lv):SetText(showLv)
    ;
    (self._lvUpPanel_breakLevelBackBlack):SetActive(breakLv == 0)
    ;
    (self._lvUpPanel_breakLevelBack):SetActive(breakLv > 0)
    ;
    (self._lvUpPanel_breakLevelNum):SetActive(breakLv > 0)
    if breakLv > 0 then
      image = role:GetCurBreakFrame1ImageRecord()
      ;
      (self._lvUpPanel_breakLevelBack):SetSprite(image.assetBundle, image.assetName)
      ;
      (self._lvUpPanel_breakLevelNum):SetText(breakLv)
    end
  elseif data.type == SCompleteTrain.ADD_MONEY then
    (self._expPanel):SetActive(false)
    ;
    (self._lvUpPanel):SetActive(false)
    ;
    (self._maxPanel):SetActive(true)
    local item = (Item.Create)(DataCommon.ManaID)
    local imgRecord = item:GetIcon()
    ;
    (self._maxPanel_itemIcon):SetSprite(imgRecord.assetBundle, imgRecord.assetName)
    ;
    (self._maxPanel_itemNum):SetText(data.award)
  end
  -- DECOMPILER ERROR: 16 unprocessed JMP targets
end

return TrainAccountCell

