-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/mainline/resource/completelineupcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local DungeonInfoTable = (BeanManager.GetTableByName)("dungeonselect.cresourcedungeoninfo")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local HeadPhotoTable = (BeanManager.GetTableByName)("headphoto.cheadphotoconfig")
local HeadPhotoFrameTable = (BeanManager.GetTableByName)("headphoto.cheadphotoframeconfig")
local Role = require("logic.manager.experimental.types.role")
local CompleteLineupCell = class("CompleteLineupCell", Dialog)
CompleteLineupCell.AssetBundleName = "ui/layouts.mainline"
CompleteLineupCell.AssetName = "ResourceSelectTeamCell"
CompleteLineupCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : CompleteLineupCell
  ((CompleteLineupCell.super).Ctor)(self, ...)
  self._data = {}
end

CompleteLineupCell.OnCreate = function(self)
  -- function num : 0_1
  self._nameBtn = self:GetChild("Panel/PlayerInfo/Click")
  self._nameTxt = self:GetChild("Panel/PlayerInfo/NameBack/Name")
  self._headphotoImg = self:GetChild("Panel/PlayerInfo/CharFrame/Char")
  self._headFrameImg = self:GetChild("Panel/PlayerInfo/CharFrame")
  self._levelTxt = self:GetChild("Panel/PlayerInfo/LvBack/Level")
  self._teams = {}
  for i = 1, 2 do
    -- DECOMPILER ERROR at PC28: Confused about usage of register: R5 in 'UnsetPending'

    (self._teams)[i] = {}
    -- DECOMPILER ERROR at PC32: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self._teams)[i]).cellNode = {}
    -- DECOMPILER ERROR at PC36: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self._teams)[i])._frame = {}
    -- DECOMPILER ERROR at PC40: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self._teams)[i])._photo = {}
    -- DECOMPILER ERROR at PC44: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self._teams)[i])._downRankBack = {}
    -- DECOMPILER ERROR at PC48: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self._teams)[i])._level = {}
    -- DECOMPILER ERROR at PC52: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self._teams)[i])._rankBack = {}
    -- DECOMPILER ERROR at PC56: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self._teams)[i])._rank = {}
    -- DECOMPILER ERROR at PC60: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self._teams)[i])._job = {}
    -- DECOMPILER ERROR at PC64: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self._teams)[i])._breakLevelBackBlack = {}
    -- DECOMPILER ERROR at PC68: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self._teams)[i])._breakLevelBack = {}
    -- DECOMPILER ERROR at PC72: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self._teams)[i])._breakLevelNum = {}
    -- DECOMPILER ERROR at PC76: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self._teams)[i])._breakLevel = {}
    -- DECOMPILER ERROR at PC80: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self._teams)[i])._element = {}
    -- DECOMPILER ERROR at PC84: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self._teams)[i])._grey = {}
    -- DECOMPILER ERROR at PC88: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self._teams)[i])._select = {}
    for j = 1, 3 do
      -- DECOMPILER ERROR at PC103: Confused about usage of register: R9 in 'UnsetPending'

      (((self._teams)[i]).cellNode)[j] = self:GetChild("Panel/Team" .. i .. "/CharSmallCell" .. j)
      -- DECOMPILER ERROR at PC115: Confused about usage of register: R9 in 'UnsetPending'

      ;
      (((self._teams)[i])._frame)[j] = self:GetChild("Panel/Team" .. i .. "/CharSmallCell" .. j .. "/Frame")
      -- DECOMPILER ERROR at PC127: Confused about usage of register: R9 in 'UnsetPending'

      ;
      (((self._teams)[i])._photo)[j] = self:GetChild("Panel/Team" .. i .. "/CharSmallCell" .. j .. "/Photo")
      -- DECOMPILER ERROR at PC139: Confused about usage of register: R9 in 'UnsetPending'

      ;
      (((self._teams)[i])._downRankBack)[j] = self:GetChild("Panel/Team" .. i .. "/CharSmallCell" .. j .. "/DownRankBack")
      -- DECOMPILER ERROR at PC151: Confused about usage of register: R9 in 'UnsetPending'

      ;
      (((self._teams)[i])._level)[j] = self:GetChild("Panel/Team" .. i .. "/CharSmallCell" .. j .. "/Level/Num")
      -- DECOMPILER ERROR at PC163: Confused about usage of register: R9 in 'UnsetPending'

      ;
      (((self._teams)[i])._rankBack)[j] = self:GetChild("Panel/Team" .. i .. "/CharSmallCell" .. j .. "/RankBack")
      -- DECOMPILER ERROR at PC175: Confused about usage of register: R9 in 'UnsetPending'

      ;
      (((self._teams)[i])._rank)[j] = self:GetChild("Panel/Team" .. i .. "/CharSmallCell" .. j .. "/Rank")
      -- DECOMPILER ERROR at PC187: Confused about usage of register: R9 in 'UnsetPending'

      ;
      (((self._teams)[i])._job)[j] = self:GetChild("Panel/Team" .. i .. "/CharSmallCell" .. j .. "/Job")
      -- DECOMPILER ERROR at PC199: Confused about usage of register: R9 in 'UnsetPending'

      ;
      (((self._teams)[i])._breakLevelBackBlack)[j] = self:GetChild("Panel/Team" .. i .. "/CharSmallCell" .. j .. "/BreakLevelBackBlack")
      -- DECOMPILER ERROR at PC211: Confused about usage of register: R9 in 'UnsetPending'

      ;
      (((self._teams)[i])._breakLevelBack)[j] = self:GetChild("Panel/Team" .. i .. "/CharSmallCell" .. j .. "/BreakLevelBack")
      -- DECOMPILER ERROR at PC223: Confused about usage of register: R9 in 'UnsetPending'

      ;
      (((self._teams)[i])._breakLevelNum)[j] = self:GetChild("Panel/Team" .. i .. "/CharSmallCell" .. j .. "/BreakLevelNum")
      -- DECOMPILER ERROR at PC235: Confused about usage of register: R9 in 'UnsetPending'

      ;
      (((self._teams)[i])._breakLevel)[j] = self:GetChild("Panel/Team" .. i .. "/CharSmallCell" .. j .. "/BreakLevel")
      -- DECOMPILER ERROR at PC247: Confused about usage of register: R9 in 'UnsetPending'

      ;
      (((self._teams)[i])._element)[j] = self:GetChild("Panel/Team" .. i .. "/CharSmallCell" .. j .. "/Element")
      -- DECOMPILER ERROR at PC259: Confused about usage of register: R9 in 'UnsetPending'

      ;
      (((self._teams)[i])._grey)[j] = self:GetChild("Panel/Team" .. i .. "/CharSmallCell" .. j .. "/Grey")
      -- DECOMPILER ERROR at PC271: Confused about usage of register: R9 in 'UnsetPending'

      ;
      (((self._teams)[i])._select)[j] = self:GetChild("Panel/Team" .. i .. "/CharSmallCell" .. j .. "/Select")
      local index = (i - 1) * 3 + j
      do
        ((((self._teams)[i])._frame)[j]):Subscribe_PointerClickEvent(function()
    -- function num : 0_1_0 , upvalues : self, index
    self:OnCellClicked(index)
  end
, self)
      end
    end
  end
  ;
  (self._nameBtn):Subscribe_PointerClickEvent(self.OnNameBtnClicked, self)
end

CompleteLineupCell.OnDestroy = function(self)
  -- function num : 0_2
end

CompleteLineupCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : HeadPhotoTable, CImagePathTable, _ENV, HeadPhotoFrameTable, Role
  self._data = data
  ;
  (self._nameTxt):SetText((self._data).userName)
  ;
  (self._levelTxt):SetText((self._data).userLv)
  local headPhotoRecord = HeadPhotoTable:GetRecorder((self._data).avatarId)
  if headPhotoRecord then
    if not CImagePathTable:GetRecorder(headPhotoRecord.photoid) then
      local imageRecord = DataCommon.DefaultImageAsset
    end
    ;
    (self._headphotoImg):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  else
    do
      ;
      (self._headphotoImg):SetSprite((DataCommon.DefaultImageAsset).assetBundle, (DataCommon.DefaultImageAsset).assetName)
      LogErrorFormat("CompleteLineupCell", "headPhotoRecord not found. avatarId = %s", (self._data).avatarId)
      local headPhotoFrameRecord = HeadPhotoFrameTable:GetRecorder((self._data).frameId)
      if headPhotoFrameRecord then
        if not CImagePathTable:GetRecorder(headPhotoFrameRecord.photoid) then
          local imageRecord = DataCommon.DefaultImageAsset
        end
        ;
        (self._headFrameImg):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      else
        do
          ;
          (self._headFrameImg):SetSprite((DataCommon.DefaultImageAsset).assetBundle, (DataCommon.DefaultImageAsset).assetName)
          LogErrorFormat("CompleteLineupCell", "headPhotoFrameRecord not found. frameId = %s", (self._data).frameId)
          for i = 1, 2 do
            for j = 1, 3 do
              local temp = j
              if i > 1 then
                j = 3 + j
              end
              local roleInfo = ((self._data).roles)[j]
              j = temp
              if roleInfo then
                ((((self._teams)[i]).cellNode)[j]):SetActive(true)
                local tempRole = (Role.Create)(roleInfo.id)
                tempRole:SetLevel(roleInfo.lv)
                tempRole:SetBreakLv(roleInfo.breakLv)
                local image = tempRole:GetShapeLittleHeadImageRecord()
                ;
                ((((self._teams)[i])._photo)[j]):SetSprite(image.assetBundle, image.assetName)
                image = tempRole:GetSmallRarityFrameRecord()
                ;
                ((((self._teams)[i])._frame)[j]):SetSprite(image.assetBundle, image.assetName)
                image = tempRole:GetRarityBottomBackRecord()
                ;
                ((((self._teams)[i])._downRankBack)[j]):SetSprite(image.assetBundle, image.assetName)
                ;
                ((((self._teams)[i])._level)[j]):SetText(tempRole:GetShowLv())
                image = tempRole:GetRarityImageRecord()
                ;
                ((((self._teams)[i])._rank)[j]):SetSprite(image.assetBundle, image.assetName)
                image = tempRole:GetVocationImageRecord()
                ;
                ((((self._teams)[i])._job)[j]):SetSprite(image.assetBundle, image.assetName)
                local breakLv = tempRole:GetBreakLv()
                ;
                ((((self._teams)[i])._breakLevelBackBlack)[j]):SetActive(breakLv == 0)
                ;
                ((((self._teams)[i])._breakLevelBack)[j]):SetActive(breakLv > 0)
                ;
                ((((self._teams)[i])._breakLevelNum)[j]):SetActive(breakLv > 0)
                if breakLv > 0 then
                  image = tempRole:GetCurBreakFrame1ImageRecord()
                  ;
                  ((((self._teams)[i])._breakLevelBack)[j]):SetSprite(image.assetBundle, image.assetName)
                  ;
                  ((((self._teams)[i])._breakLevelNum)[j]):SetText(breakLv)
                end
                image = tempRole:GetElementImageRecord()
                ;
                ((((self._teams)[i])._element)[j]):SetSprite(image.assetBundle, image.assetName)
              else
                ((((self._teams)[i]).cellNode)[j]):SetActive(false)
              end
            end
          end
          -- DECOMPILER ERROR: 6 unprocessed JMP targets
        end
      end
    end
  end
end

CompleteLineupCell.OnCellClicked = function(self, index)
  -- function num : 0_4 , upvalues : _ENV
  if ((self._data).roles)[index] then
    local roleList = (self._data).roles
    local dlg = (DialogManager.CreateSingletonDialog)("mainline.bossrush.checkotherroleinfodialog")
    if dlg then
      dlg:Init({index = index, roleList = roleList}, (dlg.ShowType).CompleteLineup)
    end
  end
end

CompleteLineupCell.OnNameBtnClicked = function(self)
  -- function num : 0_5 , upvalues : _ENV
  local protocol = (LuaNetManager.CreateProtocol)("protocol.chat.clookotherinfo")
  protocol.userId = (self._data).userId
  protocol:Send()
end

return CompleteLineupCell

