-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/mainline/undecidedroad/undecidedroadbossrecordcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local UndecidedRoadBossRecordCell = class("UndecidedRoadBossRecordCell", Dialog)
UndecidedRoadBossRecordCell.AssetBundleName = "ui/layouts.activityroad"
UndecidedRoadBossRecordCell.AssetName = "ActivityRoadBossRecordCell"
local Role = require("logic.manager.experimental.types.role")
UndecidedRoadBossRecordCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : UndecidedRoadBossRecordCell
  ((UndecidedRoadBossRecordCell.super).Ctor)(self, ...)
  self._data = {}
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).roleIdList = {}
end

UndecidedRoadBossRecordCell.OnCreate = function(self)
  -- function num : 0_1
  self._teams = {}
  for i = 1, 2 do
    -- DECOMPILER ERROR at PC8: Confused about usage of register: R5 in 'UnsetPending'

    (self._teams)[i] = {}
    -- DECOMPILER ERROR at PC12: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self._teams)[i]).cellNode = {}
    -- DECOMPILER ERROR at PC16: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self._teams)[i])._frame = {}
    -- DECOMPILER ERROR at PC20: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self._teams)[i])._photo = {}
    -- DECOMPILER ERROR at PC24: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self._teams)[i])._downRankBack = {}
    -- DECOMPILER ERROR at PC28: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self._teams)[i])._level = {}
    -- DECOMPILER ERROR at PC32: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self._teams)[i])._rankBack = {}
    -- DECOMPILER ERROR at PC36: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self._teams)[i])._rank = {}
    -- DECOMPILER ERROR at PC40: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self._teams)[i])._job = {}
    -- DECOMPILER ERROR at PC44: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self._teams)[i])._breakLevelBackBlack = {}
    -- DECOMPILER ERROR at PC48: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self._teams)[i])._breakLevelBack = {}
    -- DECOMPILER ERROR at PC52: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self._teams)[i])._breakLevelNum = {}
    -- DECOMPILER ERROR at PC56: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self._teams)[i])._breakLevel = {}
    -- DECOMPILER ERROR at PC60: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self._teams)[i])._element = {}
    -- DECOMPILER ERROR at PC64: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self._teams)[i])._grey = {}
    -- DECOMPILER ERROR at PC68: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self._teams)[i])._select = {}
    for j = 1, 3 do
      -- DECOMPILER ERROR at PC83: Confused about usage of register: R9 in 'UnsetPending'

      (((self._teams)[i]).cellNode)[j] = self:GetChild("Panel/Team" .. i .. "/CharSmallCell" .. j)
      -- DECOMPILER ERROR at PC95: Confused about usage of register: R9 in 'UnsetPending'

      ;
      (((self._teams)[i])._frame)[j] = self:GetChild("Panel/Team" .. i .. "/CharSmallCell" .. j .. "/Frame")
      -- DECOMPILER ERROR at PC107: Confused about usage of register: R9 in 'UnsetPending'

      ;
      (((self._teams)[i])._photo)[j] = self:GetChild("Panel/Team" .. i .. "/CharSmallCell" .. j .. "/Photo")
      -- DECOMPILER ERROR at PC119: Confused about usage of register: R9 in 'UnsetPending'

      ;
      (((self._teams)[i])._downRankBack)[j] = self:GetChild("Panel/Team" .. i .. "/CharSmallCell" .. j .. "/DownRankBack")
      -- DECOMPILER ERROR at PC131: Confused about usage of register: R9 in 'UnsetPending'

      ;
      (((self._teams)[i])._level)[j] = self:GetChild("Panel/Team" .. i .. "/CharSmallCell" .. j .. "/Level/Num")
      -- DECOMPILER ERROR at PC143: Confused about usage of register: R9 in 'UnsetPending'

      ;
      (((self._teams)[i])._rankBack)[j] = self:GetChild("Panel/Team" .. i .. "/CharSmallCell" .. j .. "/RankBack")
      -- DECOMPILER ERROR at PC155: Confused about usage of register: R9 in 'UnsetPending'

      ;
      (((self._teams)[i])._rank)[j] = self:GetChild("Panel/Team" .. i .. "/CharSmallCell" .. j .. "/Rank")
      -- DECOMPILER ERROR at PC167: Confused about usage of register: R9 in 'UnsetPending'

      ;
      (((self._teams)[i])._job)[j] = self:GetChild("Panel/Team" .. i .. "/CharSmallCell" .. j .. "/Job")
      -- DECOMPILER ERROR at PC179: Confused about usage of register: R9 in 'UnsetPending'

      ;
      (((self._teams)[i])._breakLevelBackBlack)[j] = self:GetChild("Panel/Team" .. i .. "/CharSmallCell" .. j .. "/BreakLevelBackBlack")
      -- DECOMPILER ERROR at PC191: Confused about usage of register: R9 in 'UnsetPending'

      ;
      (((self._teams)[i])._breakLevelBack)[j] = self:GetChild("Panel/Team" .. i .. "/CharSmallCell" .. j .. "/BreakLevelBack")
      -- DECOMPILER ERROR at PC203: Confused about usage of register: R9 in 'UnsetPending'

      ;
      (((self._teams)[i])._breakLevelNum)[j] = self:GetChild("Panel/Team" .. i .. "/CharSmallCell" .. j .. "/BreakLevelNum")
      -- DECOMPILER ERROR at PC215: Confused about usage of register: R9 in 'UnsetPending'

      ;
      (((self._teams)[i])._breakLevel)[j] = self:GetChild("Panel/Team" .. i .. "/CharSmallCell" .. j .. "/BreakLevel")
      -- DECOMPILER ERROR at PC227: Confused about usage of register: R9 in 'UnsetPending'

      ;
      (((self._teams)[i])._element)[j] = self:GetChild("Panel/Team" .. i .. "/CharSmallCell" .. j .. "/Element")
      -- DECOMPILER ERROR at PC239: Confused about usage of register: R9 in 'UnsetPending'

      ;
      (((self._teams)[i])._grey)[j] = self:GetChild("Panel/Team" .. i .. "/CharSmallCell" .. j .. "/Grey")
      -- DECOMPILER ERROR at PC251: Confused about usage of register: R9 in 'UnsetPending'

      ;
      (((self._teams)[i])._select)[j] = self:GetChild("Panel/Team" .. i .. "/CharSmallCell" .. j .. "/Select")
      local index = (i - 1) * 3 + j
    end
  end
  self._title1 = self:GetChild("Panel/Title1")
  self._title2 = self:GetChild("Panel/Title2")
  self._scoreTxt = self:GetChild("Panel/Num")
  self._timeTxt = self:GetChild("Panel/NumTime")
  self._applyBtn = self:GetChild("Panel/ApplyBtn")
  ;
  (self._applyBtn):Subscribe_PointerClickEvent(self.OnApplyBtnClicked, self)
end

UndecidedRoadBossRecordCell.OnDestroy = function(self)
  -- function num : 0_2
end

UndecidedRoadBossRecordCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : _ENV, Role
  self._data = data
  ;
  (self._title1):SetActive(data.type == 0)
  ;
  (self._title2):SetActive(data.type == 1)
  ;
  (self._scoreTxt):SetText(data.score)
  ;
  (self._timeTxt):SetText((os.date)("!%Y-%m-%d", data.time // 1000))
  for i = 1, 2 do
    for j = 1, 3 do
      local temp = j
      if i > 1 then
        j = 3 + j
      end
      local roleInfo = ((self._data).roleIdList)[j]
      j = temp
      if roleInfo then
        ((((self._teams)[i]).cellNode)[j]):SetActive(true)
        local tempRole = (Role.Create)(roleInfo.id)
        tempRole:SetLevel(roleInfo.lv)
        tempRole:SetBreakLv(roleInfo.breakLv)
        tempRole:SetFashionId(roleInfo.skin)
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
  -- DECOMPILER ERROR: 9 unprocessed JMP targets
end

UndecidedRoadBossRecordCell.OnApplyBtnClicked = function(self)
  -- function num : 0_4 , upvalues : _ENV
  ((NekoData.BehaviorManager).BM_Message):SendMessageById(100383)
  local LineUpStation = (LuaNetManager.GetBeanDef)("protocol.login.lineupstation")
  local req = (LuaNetManager.CreateProtocol)("protocol.login.cconfirmroles")
  req.lineupId = 7000
  req.roles = {}
  for k,v in pairs((self._data).roleIdList) do
    -- DECOMPILER ERROR at PC24: Confused about usage of register: R8 in 'UnsetPending'

    (req.roles)[k] = v.id
  end
  req:Send()
end

return UndecidedRoadBossRecordCell

