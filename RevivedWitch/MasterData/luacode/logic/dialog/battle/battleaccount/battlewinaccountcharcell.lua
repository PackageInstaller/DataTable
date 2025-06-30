-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/battle/battleaccount/battlewinaccountcharcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CRoleLevelCfgTable = (BeanManager.GetTableByName)("role.crolelevelcfg")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local BattleWinAccountCharCell = class("BattleWinAccountCharCell", Dialog)
BattleWinAccountCharCell.AssetBundleName = "ui/layouts.battlewin"
BattleWinAccountCharCell.AssetName = "BattleWinAccountCharCell"
BattleWinAccountCharCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : BattleWinAccountCharCell
  ((BattleWinAccountCharCell.super).Ctor)(self, ...)
  self._taskData = {}
end

BattleWinAccountCharCell.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self._rankBack = self:GetChild("CharCell/Back")
  self._image = self:GetChild("CharCell/Photo")
  self._pinjiFrame = self:GetChild("CharCell/Frame")
  self._rank = self:GetChild("CharCell/Rank")
  self._jobImg = self:GetChild("CharCell/Job")
  self._lvNum = self:GetChild("CharCell/Level/Num")
  self._lvMaxNum = self:GetChild("CharCell/Level/MaxNum")
  self._breakLevel = self:GetChild("CharCell/BreakLevelNum")
  self._breakLevelBackBlack = self:GetChild("CharCell/BreakLevelBackBlack")
  self._breakLevelBack = self:GetChild("CharCell/BreakLevelBack")
  self._levelUpLabel = self:GetChild("Levelup")
  self._expProgress = self:GetChild("ProgressBack/Progress")
  self._exp = self:GetChild("Text")
  self._lvMax = self:GetChild("Max")
  ;
  (self._lvMax):SetActive(false)
  self._loveExp = self:GetChild("Love/Num")
  self._loveMaxTag = self:GetChild("Love/Max")
  self._lovePanel = self:GetChild("Love")
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnUpdate, Common.n_Update, nil)
end

BattleWinAccountCharCell.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  if self._timeTask then
    (GameTimer.RemoveTask)(self._timeTask)
    self._timeTask = nil
  end
  if self._allCharTimeTask then
    (GameTimer.RemoveTask)(self._allCharTimeTask)
    self._allCharTimeTask = nil
  end
  ;
  (LuaNotificationCenter.RemoveObserver)(self)
end

local GetLevelMaxExp = function(rarityId, level)
  -- function num : 0_3 , upvalues : CRoleLevelCfgTable
  local roleLevelRecord = CRoleLevelCfgTable:GetRecorder(level)
  if rarityId == 1 then
    return roleLevelRecord.Rexp
  end
  if rarityId == 2 then
    return roleLevelRecord.SRexp
  end
  if rarityId == 3 then
    return roleLevelRecord.SSRexp
  end
  if rarityId == 4 then
    return roleLevelRecord.URexp
  end
  if rarityId == 5 then
    return roleLevelRecord.EXexp
  end
end

local ExpShow = function(self, curLevel, beginExp, endExp, showLevel)
  -- function num : 0_4 , upvalues : GetLevelMaxExp, _ENV
  (self._lvNum):SetText(showLevel)
  local maxExp = GetLevelMaxExp(self._rarityId, curLevel)
  self._showDes = endExp / maxExp
  local first = {exp = beginExp / maxExp}
  local last = {exp = self._showDes}
  self._showTask = (Tween.new)(1, first, last, "linear")
end

BattleWinAccountCharCell.OnUpdate = function(self, notification)
  -- function num : 0_5 , upvalues : _ENV, ExpShow
  if self._showTask then
    if (self._showTask):update((notification.userInfo).deltaTime) then
      (self._expProgress):SetFillAmount(self._showDes)
      self._showTask = nil
      if self._taskData and #self._taskData ~= 0 then
        local temp = (self._taskData)[#self._taskData]
        ;
        (table.remove)(self._taskData, #self._taskData)
        ExpShow(self, temp.curLevel, temp.beginExp, temp.endExp, temp.showLevel)
      else
        do
          ;
          (self._delegate):OnCharCellShowTaskOver(self._cellData)
          ;
          (self._expProgress):SetFillAmount(((self._showTask).subject).exp)
        end
      end
    end
  end
end

BattleWinAccountCharCell.RefreshCell = function(self, data)
  -- function num : 0_6 , upvalues : _ENV, GetLevelMaxExp, CStringRes
  if not (self._cellData).hasShow then
    (self:GetRootWindow()):SetActive(false)
  end
  local role = ((NekoData.BehaviorManager).BM_AllRoles):GetRole(data.roleKey)
  if role then
    local imageRecord = role:GetShapeLittleHeadImageRecord()
    if imageRecord ~= DataCommon.DefaultImageAsset then
      (self._image):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    else
      LogErrorFormat("BattleWinAccountCharCell", "wrong little head image id for role %d", data.roleKey)
    end
    imageRecord = role:GetSmallRarityFrameRecord()
    if imageRecord ~= DataCommon.DefaultImageAsset then
      (self._pinjiFrame):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    else
      LogErrorFormat("BattleWinAccountCharCell", "wrong rarity frame image id for role %d", data.roleKey)
    end
    if role:GetIsLeader() then
      (self._rank):SetActive(false)
    else
      ;
      (self._rank):SetActive(true)
      imageRecord = role:GetRarityImageRecord()
      if imageRecord ~= DataCommon.DefaultImageAsset then
        (self._rank):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      else
        LogErrorFormat("BattleWinAccountCharCell", "wrong rarity image id for role %d", data.roleKey)
      end
    end
    imageRecord = role:GetVocationImageRecord()
    if imageRecord ~= DataCommon.DefaultImageAsset then
      (self._jobImg):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    else
      LogErrorFormat("BattleWinAccountCharCell", "wrong vocation image id for role %d", data.roleKey)
    end
    imageRecord = role:GetSmallRarityBackRecord()
    if imageRecord ~= DataCommon.DefaultImageAsset then
      (self._rankBack):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    else
      LogErrorFormat("BattleWinAccountCharCell", "wrong back rank image id for role %d", data.roleKey)
    end
    local curLevel = role:GetLevel()
    local showLevel = role:GetShowLv()
    self._role = role
    if role:GetExp() < data.deltaExp then
      (self._levelUpLabel):SetActive(true)
    else
      ;
      (self._levelUpLabel):SetActive(false)
    end
    if data.deltaExp == 0 and curLevel == role:GetMaxLevel() then
      (self._exp):SetText((self._lvMax):GetText())
      ;
      (self._expProgress):SetFillAmount(1)
      ;
      (self._lvNum):SetText(showLevel)
      self._maxExpTag = true
    else
      self._maxExpTag = false
      self._rarityId = role:GetRarityId()
      local tExp = data.deltaExp
      local cExp = role:GetExp()
      local delta = tExp - cExp
      self._taskData = {}
      while 1 do
        while 1 do
          if delta > 0 then
            local temp = {curLevel = curLevel, beginExp = 0, endExp = cExp, showLevel = showLevel}
            curLevel = curLevel - 1
            showLevel = showLevel - 1
            tExp = tExp - cExp
            if curLevel > 0 then
              cExp = GetLevelMaxExp(self._rarityId, curLevel)
              delta = tExp - cExp
              ;
              (table.insert)(self._taskData, temp)
              -- DECOMPILER ERROR at PC194: LeaveBlock: unexpected jumping out IF_THEN_STMT

              -- DECOMPILER ERROR at PC194: LeaveBlock: unexpected jumping out IF_STMT

              -- DECOMPILER ERROR at PC194: LeaveBlock: unexpected jumping out IF_THEN_STMT

              -- DECOMPILER ERROR at PC194: LeaveBlock: unexpected jumping out IF_STMT

            end
          end
        end
        break
      end
      do
        do
          if curLevel > 0 then
            local temp = {curLevel = curLevel, beginExp = cExp - (tExp), endExp = cExp, showLevel = showLevel}
            ;
            (table.insert)(self._taskData, temp)
          end
          ;
          (self._lvNum):SetText(showLevel)
          if #self._taskData ~= 0 then
            local temp = (self._taskData)[#self._taskData]
            local maxExp = GetLevelMaxExp(self._rarityId, temp.curLevel)
            ;
            (self._expProgress):SetFillAmount(temp.beginExp / maxExp)
          end
          do
            if data.goodExp == 0 then
              (self._lovePanel):SetActive(false)
            else
              ;
              (self._lovePanel):SetActive(true)
              local maxLoveLv = role:GetRelationMaxLevel()
              local curLoveLv = role:GetRelationLevel()
              if curLoveLv == maxLoveLv then
                (self._loveMaxTag):SetActive(true)
                ;
                (self._loveExp):SetActive(false)
              else
                ;
                (self._loveMaxTag):SetActive(false)
                ;
                (self._loveExp):SetActive(true)
                ;
                (self._loveExp):SetText("+" .. data.goodExp)
              end
            end
            do
              ;
              (self._lvMaxNum):SetText(role:GetShowMaxBreakLv())
              local breakLv = role:GetBreakLv()
              ;
              (self._breakLevelBackBlack):SetActive(breakLv == 0)
              ;
              (self._breakLevelBack):SetActive(breakLv > 0)
              ;
              (self._breakLevel):SetActive(breakLv > 0)
              do
                if breakLv > 0 then
                  local imageRecord = role:GetCurBreakFrame1ImageRecord()
                  ;
                  (self._breakLevelBack):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
                  ;
                  (self._breakLevel):SetText(breakLv)
                end
                LogErrorFormat("BattleWinAccountCharCell", "wrong role key %d", data.roleKey)
                do
                  if not self._maxExpTag then
                    local str = (TextManager.GetText)((CStringRes:GetRecorder(1100)).msgTextID)
                    ;
                    (self._exp):SetText((string.gsub)(str, "%$parameter1%$", tostring(data.deltaExp)))
                  end
                  -- DECOMPILER ERROR: 6 unprocessed JMP targets
                end
              end
            end
          end
        end
      end
    end
  end
end

local StraightToShowEnd = function(self)
  -- function num : 0_7 , upvalues : GetLevelMaxExp
  if not self._maxExpTag then
    (self._lvNum):SetText((self._role):GetShowLv())
    ;
    (self._expProgress):SetFillAmount((self._role):GetExp() / GetLevelMaxExp(self._rarityId, (self._role):GetLevel()))
  end
  self._showTask = nil
  self._taskData = {}
end

BattleWinAccountCharCell.OnTimeTaskEnd = function(self, playNext)
  -- function num : 0_8 , upvalues : _ENV, ExpShow
  if playNext then
    if #self._taskData ~= 0 then
      local temp = (self._taskData)[#self._taskData]
      ;
      (table.remove)(self._taskData, #self._taskData)
      ExpShow(self, temp.curLevel, temp.beginExp, temp.endExp, temp.showLevel)
    else
      do
        ;
        (self._delegate):OnCharCellShowTaskOver(self._cellData)
        if (self._cellData).index then
          (self._delegate):OnCharCellAnimationEnd((self._cellData).index - 1)
        else
          self:PlayAllCharAnimation()
        end
      end
    end
  end
end

BattleWinAccountCharCell.OnEvent = function(self, eventName, arg)
  -- function num : 0_9 , upvalues : _ENV
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R3 in 'UnsetPending'

  if eventName == "PlayCharCellAnimation" and arg == (self._cellData).index then
    (self._cellData).hasShow = true
    ;
    (self:GetRootWindow()):SetActive(true)
    if self._timeTask then
      (GameTimer.RemoveTask)(self._timeTask)
      self._timeTask = nil
    end
    self._timeTask = (GameTimer.AddTask)(0.2, -1, function()
    -- function num : 0_9_0 , upvalues : self
    self:OnTimeTaskEnd(true)
  end
)
  else
    if eventName == "PlayAllCharAnimation" then
      self:PlayAllCharAnimation()
    end
  end
end

BattleWinAccountCharCell.PlayAllCharAnimation = function(self)
  -- function num : 0_10 , upvalues : _ENV, StraightToShowEnd
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R1 in 'UnsetPending'

  if not (self._cellData).hasShow then
    (self._cellData).hasShow = true
    ;
    (self:GetRootWindow()):SetActive(true)
  end
  if self._timeTask then
    (GameTimer.RemoveTask)(self._timeTask)
    self._timeTask = nil
  end
  if not self._allCharTimeTask then
    self._allCharTimeTask = (GameTimer.AddTask)(0.2, -1, function()
    -- function num : 0_10_0 , upvalues : self
    (self._delegate):OnCharCellShowTaskOver(self._cellData)
  end
)
    StraightToShowEnd(self)
  end
end

return BattleWinAccountCharCell

