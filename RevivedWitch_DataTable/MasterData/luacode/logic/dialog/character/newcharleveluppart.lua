-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/character/newcharleveluppart.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CharLevelUpPart = class("CharLevelUpPart")
local CRoleLevelCfgTable = (BeanManager.GetTableByName)("role.crolelevelcfg")
local CMessagetipTable = (BeanManager.GetTableByName)("message.cmessagetip")
local AttrTypeEnum = (LuaNetManager.GetBeanDef)("protocol.login.attrtype")
local CAttrNameTable = (BeanManager.GetTableByName)("role.cattreffectidname")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CVarconfig = (BeanManager.GetTableByName)("var.cvarconfig")
local CPlayerLevel = (BeanManager.GetTableByName)("role.cplayerlevel")
local Time = 0.5
local ProgressFullMaxTotalTime = 2
local ProgressFullMinTotalTime = 0.2
local LongPressLevelUpLevelLimit = tonumber((CVarconfig:GetRecorder(38)).Value)
local LongPressLevelUpClickLimit = (tonumber((CVarconfig:GetRecorder(39)).Value))
local self = nil
CharLevelUpPart.OnCreate = function(delegate)
  -- function num : 0_0 , upvalues : self, CharLevelUpPart, _ENV
  self = delegate
  self._levelup_lvNum = self:GetChild("BackGround/Frame/CharLevelUp/Top/LevelBack/LevelNum")
  self._levelup_progress = self:GetChild("BackGround/Frame/CharLevelUp/Top/ProgressLevel/_BackGround/Progress")
  self._levelup_expTxt = self:GetChild("BackGround/Frame/CharLevelUp/Top/ProgressLevel/EXPNum")
  self._levelup_maxLevel = self:GetChild("BackGround/Frame/CharLevelUp/Top/LevelMax")
  self._levelup_healthName = self:GetChild("BackGround/Frame/CharLevelUp/Property/Health/Name")
  self._levelup_healthCur = self:GetChild("BackGround/Frame/CharLevelUp/Property/Health/Num")
  self._levelup_healthMax = self:GetChild("BackGround/Frame/CharLevelUp/Property/Health/Num2")
  self._levelup_phyAtkImg = self:GetChild("BackGround/Frame/CharLevelUp/Property/PhyAtk/Image")
  self._levelup_phyAtkName = self:GetChild("BackGround/Frame/CharLevelUp/Property/PhyAtk/Name")
  self._levelup_phyAtkCur = self:GetChild("BackGround/Frame/CharLevelUp/Property/PhyAtk/Num")
  self._levelup_phyAtkMax = self:GetChild("BackGround/Frame/CharLevelUp/Property/PhyAtk/Num2")
  self._levelup_phyDefName = self:GetChild("BackGround/Frame/CharLevelUp/Property/PhyDef/Name")
  self._levelup_phyDefCur = self:GetChild("BackGround/Frame/CharLevelUp/Property/PhyDef/Num")
  self._levelup_phyDefMax = self:GetChild("BackGround/Frame/CharLevelUp/Property/PhyDef/Num2")
  self._levelup_magDefName = self:GetChild("BackGround/Frame/CharLevelUp/Property/MagDef/Name")
  self._levelup_magDefCur = self:GetChild("BackGround/Frame/CharLevelUp/Property/MagDef/Num")
  self._levelup_magDefMax = self:GetChild("BackGround/Frame/CharLevelUp/Property/MagDef/Num2")
  self._levelup_healthArrow = self:GetChild("BackGround/Frame/CharLevelUp/Property/Health/Arrow2")
  self._levelup_phyAtkArrow = self:GetChild("BackGround/Frame/CharLevelUp/Property/PhyAtk/Arrow2")
  self._levelup_phyDefArrow = self:GetChild("BackGround/Frame/CharLevelUp/Property/PhyDef/Arrow2")
  self._levelup_magDefArrow = self:GetChild("BackGround/Frame/CharLevelUp/Property/MagDef/Arrow2")
  self._levelup_needMana = self:GetChild("BackGround/Frame/CharLevelUp/Need/Txt2")
  self._levelup_levelUpBtn = self:GetChild("BackGround/Frame/CharLevelUp/LevelUpBtn")
  self._levelup_quickLevelUpBtn = self:GetChild("BackGround/Frame/CharLevelUp/CharFastLevelUpBtn")
  self._levelup_quickLevelUpBtn_text = self:GetChild("BackGround/Frame/CharLevelUp/CharFastLevelUpBtn/_Text")
  self._levelUpEffect = self:GetChild("BackGround/Effect")
  self._levelUpLongPressEffect = self:GetChild("BackGround/Effect2")
  ;
  (self._levelup_levelUpBtn):Subscribe_PointerClickEvent(CharLevelUpPart.OnLevelUpBtnClick, self)
  ;
  (self._levelup_levelUpBtn):Subscribe_BeginLongPressEvent(CharLevelUpPart.OnLevelUpBtnBeginLongPress, self)
  ;
  (self._levelup_levelUpBtn):Subscribe_LongPressEvent(CharLevelUpPart.OnLevelUpBtnLongPress, self)
  ;
  (self._levelup_levelUpBtn):Subscribe_EndLongPressEvent(CharLevelUpPart.OnLevelUpBtnEndLongPress, self)
  ;
  (self._levelup_levelUpBtn):Subscribe_CancelLongPressEvent(CharLevelUpPart.OnLevelUpBtnCancelLongPress, self)
  ;
  (self._levelup_levelUpBtn):Subscribe_PointerDownEvent(CharLevelUpPart.OnLevelUpBtnPointerDown, self)
  ;
  (self._levelUpEffect):Subscribe_UIEffectEndEvent(self.OnEffectEnd, self)
  ;
  (self._levelup_quickLevelUpBtn):Subscribe_PointerClickEvent(CharLevelUpPart.OnQuickLevelUpBtnClick, self)
  ;
  (LuaNotificationCenter.AddObserver)(CharLevelUpPart, CharLevelUpPart.OnUpdate, Common.n_Update, nil)
  self._longPressLevelUp = false
  ;
  (self._levelup_quickLevelUpBtn):SetActive(((NekoData.BehaviorManager).BM_Game):IsUnlockFunction((DataCommon.Functions).RoleReset))
  ;
  (self._levelup_quickLevelUpBtn_text):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1745))
end

CharLevelUpPart.OnDestroy = function()
  -- function num : 0_1 , upvalues : self, _ENV, CharLevelUpPart
  self = nil
  ;
  (LuaNotificationCenter.RemoveObserver)(CharLevelUpPart)
end

CharLevelUpPart.RefreshLevelUpInfo = function(notPlayTask)
  -- function num : 0_2 , upvalues : self, _ENV, LongPressLevelUpLevelLimit, CRoleLevelCfgTable, CStringRes, CAttrNameTable, AttrTypeEnum, CImagePathTable, CharLevelUpPart, Time
  self._data = ((NekoData.BehaviorManager).BM_AllRoles):GetRole((self._data):GetRoleId())
  self._lv = (self._data):GetLevel()
  if self._key and self._key ~= (self._data):GetRoleId() then
    self._sendProtocolTag = false
    self._progressTask = nil
    if self._lv < LongPressLevelUpLevelLimit then
      self._clickLevelUpBtnCount = 0
    else
      self._clickLevelUpBtnCount = nil
    end
  else
    if LongPressLevelUpLevelLimit <= self._lv then
      self._clickLevelUpBtnCount = nil
    else
      if not self._clickLevelUpBtnCount then
        self._clickLevelUpBtnCount = 0
      end
    end
  end
  self._key = (self._data):GetRoleId()
  self._rarityId = (self._data):GetRarityId()
  self._roleId = (((NekoData.BehaviorManager).BM_AllRoles):GetRole(self._key)):GetId()
  self._breakLv = (self._data):GetBreakLv()
  self._lastExp = nil
  self._exp = (self._data):GetExp()
  ;
  (self._levelup_lvNum):SetText(tostring((self._data):GetShowLv()))
  ;
  (self._levelup_maxLevel):SetText(tostring((self._data):GetShowMaxBreakLv()))
  local roleBreakRecord = ((self._data):GetBreakRecords())[(self._data):GetBreakLv()]
  local roleLevelRecord = (CRoleLevelCfgTable:GetRecorder((self._data):GetLevel()))
  -- DECOMPILER ERROR at PC97: Overwrote pending register: R3 in 'AssignReg'

  local maxExp = .end
  if self._rarityId == 1 then
    maxExp = roleLevelRecord.Rexp
  end
  if self._rarityId == 2 then
    maxExp = roleLevelRecord.SRexp
  end
  if self._rarityId == 3 then
    maxExp = roleLevelRecord.SSRexp
  end
  if self._rarityId == 4 then
    maxExp = roleLevelRecord.URexp
  end
  if self._rarityId == 5 then
    maxExp = roleLevelRecord.EXexp
  end
  local str = (CStringRes:GetRecorder(1111)).msgTextID
  str = (TextManager.GetText)(str)
  str = (string.gsub)(str, "%$parameter1%$", tostring((self._data):GetExp()))
  str = (string.gsub)(str, "%$parameter2%$", tostring(maxExp))
  ;
  (self._levelup_expTxt):SetText(str)
  ;
  (self._levelup_progress):SetFillAmount((self._data):GetExp() / maxExp)
  if (self._data):GetLevel() == (self._data):GetLevelMaxByBreakRecord(roleBreakRecord) then
    (self._levelup_healthArrow):SetActive(false)
    ;
    (self._levelup_phyAtkArrow):SetActive(false)
    ;
    (self._levelup_phyDefArrow):SetActive(false)
    ;
    (self._levelup_magDefArrow):SetActive(false)
    ;
    (self._levelup_healthMax):SetActive(false)
    ;
    (self._levelup_phyAtkMax):SetActive(false)
    ;
    (self._levelup_phyDefMax):SetActive(false)
    ;
    (self._levelup_magDefMax):SetActive(false)
    ;
    (self._levelup_needMana):SetText(0)
  else
    ;
    (self._levelup_healthArrow):SetActive(true)
    ;
    (self._levelup_phyAtkArrow):SetActive(true)
    ;
    (self._levelup_phyDefArrow):SetActive(true)
    ;
    (self._levelup_magDefArrow):SetActive(true)
    ;
    (self._levelup_healthMax):SetActive(true)
    ;
    (self._levelup_phyAtkMax):SetActive(true)
    ;
    (self._levelup_phyDefMax):SetActive(true)
    ;
    (self._levelup_magDefMax):SetActive(true)
    if maxExp - (self._data):GetExp() > 0 then
      (self._levelup_needMana):SetText(maxExp - (self._data):GetExp())
    else
      ;
      (self._levelup_needMana):SetText(0)
    end
  end
  if notPlayTask or (DialogManager.GetDialog)("character.quicklevelup.quicklevelupsuccessdialog") then
    self._lvUpper = false
  end
  if not self._lvUpper then
    self._propertyTable = {}
    local properties = (self._data):GetCurLvBasePro()
    ;
    (self._levelup_healthName):SetText((TextManager.GetText)((CAttrNameTable:GetRecorder(AttrTypeEnum.MAX_HP)).classnameTextID))
    ;
    (self._levelup_healthCur):SetText(tostring(properties[AttrTypeEnum.MAX_HP]))
    ;
    (table.insert)(self._propertyTable, 1, properties[AttrTypeEnum.MAX_HP])
    ;
    (self._levelup_phyDefName):SetText((TextManager.GetText)((CAttrNameTable:GetRecorder(AttrTypeEnum.DEFEND)).classnameTextID))
    ;
    (self._levelup_phyDefCur):SetText(tostring(properties[AttrTypeEnum.DEFEND]))
    ;
    (table.insert)(self._propertyTable, 2, properties[AttrTypeEnum.DEFEND])
    ;
    (self._levelup_magDefName):SetText((TextManager.GetText)((CAttrNameTable:GetRecorder(AttrTypeEnum.MAGIC_DEFEND)).classnameTextID))
    ;
    (self._levelup_magDefCur):SetText(tostring(properties[AttrTypeEnum.MAGIC_DEFEND]))
    ;
    (table.insert)(self._propertyTable, 3, properties[AttrTypeEnum.MAGIC_DEFEND])
    local record = nil
    if (self._data):GetDamageType() == 1 then
      record = CAttrNameTable:GetRecorder(AttrTypeEnum.ATTACK)
    else
      record = CAttrNameTable:GetRecorder(AttrTypeEnum.MAGIC_ATTACK)
    end
    if not CImagePathTable:GetRecorder(record.classIcon) then
      local imageRecord = DataCommon.DefaultImageAsset
    end
    ;
    (self._levelup_phyAtkImg):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    ;
    (self._levelup_phyAtkName):SetText((TextManager.GetText)(record.classnameTextID))
    ;
    (self._levelup_phyAtkCur):SetText(tostring(properties[AttrTypeEnum.ATTACK]))
    ;
    (table.insert)(self._propertyTable, 4, properties[AttrTypeEnum.ATTACK])
    if (self._data):GetLevel() ~= (self._data):GetLevelMaxByBreakRecord(roleBreakRecord) then
      properties = (self._data):GetNextLvBasePro()
      ;
      (self._levelup_healthMax):SetText(tostring(properties[AttrTypeEnum.MAX_HP]))
      ;
      (table.insert)(self._propertyTable, 5, properties[AttrTypeEnum.MAX_HP])
      ;
      (self._levelup_phyDefMax):SetText(tostring(properties[AttrTypeEnum.DEFEND]))
      ;
      (table.insert)(self._propertyTable, 6, properties[AttrTypeEnum.DEFEND])
      ;
      (self._levelup_magDefMax):SetText(tostring(properties[AttrTypeEnum.MAGIC_DEFEND]))
      ;
      (table.insert)(self._propertyTable, 7, properties[AttrTypeEnum.MAGIC_DEFEND])
      ;
      (self._levelup_phyAtkMax):SetText(tostring(properties[AttrTypeEnum.ATTACK]))
      ;
      (table.insert)(self._propertyTable, 8, properties[AttrTypeEnum.ATTACK])
    end
  else
    do
      self._lvUpper = false
      ;
      (CharLevelUpPart.PlayEffect)()
      do
        local properties = (self._data):GetCurLvBasePro()
        ;
        (table.insert)(self._levelup_task1, (Tween.new)(Time, {value = (self._propertyTable)[1]}, {value = properties[AttrTypeEnum.MAX_HP]}, "linear"))
        -- DECOMPILER ERROR at PC494: Confused about usage of register: R6 in 'UnsetPending'

        ;
        (self._propertyTable)[1] = properties[AttrTypeEnum.MAX_HP]
        ;
        (table.insert)(self._levelup_task1, (Tween.new)(Time, {value = (self._propertyTable)[2]}, {value = properties[AttrTypeEnum.DEFEND]}, "linear"))
        -- DECOMPILER ERROR at PC515: Confused about usage of register: R6 in 'UnsetPending'

        ;
        (self._propertyTable)[2] = properties[AttrTypeEnum.DEFEND]
        ;
        (table.insert)(self._levelup_task1, (Tween.new)(Time, {value = (self._propertyTable)[3]}, {value = properties[AttrTypeEnum.MAGIC_DEFEND]}, "linear"))
        -- DECOMPILER ERROR at PC536: Confused about usage of register: R6 in 'UnsetPending'

        ;
        (self._propertyTable)[3] = properties[AttrTypeEnum.MAGIC_DEFEND]
        ;
        (table.insert)(self._levelup_task1, (Tween.new)(Time, {value = (self._propertyTable)[4]}, {value = properties[AttrTypeEnum.ATTACK]}, "linear"))
        -- DECOMPILER ERROR at PC557: Confused about usage of register: R6 in 'UnsetPending'

        ;
        (self._propertyTable)[4] = properties[AttrTypeEnum.ATTACK]
        if (self._data):GetLevel() ~= (self._data):GetLevelMaxByBreakRecord(roleBreakRecord) then
          properties = (self._data):GetNextLvBasePro()
          ;
          (table.insert)(self._levelup_task1, (Tween.new)(Time, {value = (self._propertyTable)[5]}, {value = properties[AttrTypeEnum.MAX_HP]}, "linear"))
          -- DECOMPILER ERROR at PC591: Confused about usage of register: R6 in 'UnsetPending'

          ;
          (self._propertyTable)[5] = properties[AttrTypeEnum.MAX_HP]
          ;
          (table.insert)(self._levelup_task1, (Tween.new)(Time, {value = (self._propertyTable)[6]}, {value = properties[AttrTypeEnum.DEFEND]}, "linear"))
          -- DECOMPILER ERROR at PC612: Confused about usage of register: R6 in 'UnsetPending'

          ;
          (self._propertyTable)[6] = properties[AttrTypeEnum.DEFEND]
          ;
          (table.insert)(self._levelup_task1, (Tween.new)(Time, {value = (self._propertyTable)[7]}, {value = properties[AttrTypeEnum.MAGIC_DEFEND]}, "linear"))
          -- DECOMPILER ERROR at PC633: Confused about usage of register: R6 in 'UnsetPending'

          ;
          (self._propertyTable)[7] = properties[AttrTypeEnum.MAGIC_DEFEND]
          ;
          (table.insert)(self._levelup_task1, (Tween.new)(Time, {value = (self._propertyTable)[8]}, {value = properties[AttrTypeEnum.ATTACK]}, "linear"))
          -- DECOMPILER ERROR at PC654: Confused about usage of register: R6 in 'UnsetPending'

          ;
          (self._propertyTable)[8] = properties[AttrTypeEnum.ATTACK]
        end
        local str = nil
        self._mana = ((NekoData.BehaviorManager).BM_Currency):GetMoney()
        local dialog = (DialogManager.GetDialog)("character.basecharacterlistalldialog")
        if not dialog then
          dialog = (DialogManager.GetDialog)("character.basecharacterlistdialog")
        end
        local pos = nil
        if dialog then
          local roleList = dialog:ReturnRoleList()
          if #roleList > 0 then
            for i,v in pairs(roleList) do
              if v:GetRoleId() == self._key then
                pos = i
                break
              end
            end
          end
        end
      end
    end
  end
end

CharLevelUpPart.PlayEffect = function()
  -- function num : 0_3 , upvalues : _ENV, self
  (LuaAudioManager.PlayBGM)(227, true)
  local handler = (self._levelUpEffect):AddEffectSync((EffectUtil.GetAssetBundleNameAndAssetName)(1001))
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._effectHandlers)[handler] = true
end

CharLevelUpPart.OnEffectEnd = function(self, effectHandler, window)
  -- function num : 0_4
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R3 in 'UnsetPending'

  if (self._effectHandlers)[effectHandler] then
    (self._effectHandlers)[effectHandler] = nil
  end
end

CharLevelUpPart.PlayLongPressEffect = function()
  -- function num : 0_5 , upvalues : self, _ENV
  if self._effectHandler2 and self._effectHandler2 ~= 0 then
    (self._levelUpLongPressEffect):ReleaseEffect(self._effectHandler2)
    self._effectHandler2 = 0
  end
  self._effectHandler2 = (self._levelUpLongPressEffect):AddEffectSync((EffectUtil.GetAssetBundleNameAndAssetName)(1033))
end

CharLevelUpPart.ReleaseLongPressEffect = function()
  -- function num : 0_6 , upvalues : self
  if self._effectHandler2 and self._effectHandler2 ~= 0 then
    (self._levelUpLongPressEffect):ReleaseEffect(self._effectHandler2)
    self._effectHandler2 = 0
  end
end

CharLevelUpPart.RefreshExp = function(levelandexp)
  -- function num : 0_7 , upvalues : self, _ENV, LongPressLevelUpLevelLimit, CRoleLevelCfgTable, CStringRes, ProgressFullMinTotalTime, CharLevelUpPart
  self._mana = ((NekoData.BehaviorManager).BM_Currency):GetMoney()
  local lv = self._lv
  self._key = levelandexp.key
  self._lv = levelandexp.level
  if LongPressLevelUpLevelLimit <= self._lv then
    self._clickLevelUpBtnCount = nil
  end
  self._exp = levelandexp.exp
  local roleLevelRecord = CRoleLevelCfgTable:GetRecorder(levelandexp.level)
  if not roleLevelRecord then
    LogErrorFormat("CharLevelUpPart.RefreshExp", "roleLevel with id %s is not exist in crolelevelcfg", levelandexp.level)
  end
  local maxExp = nil
  if self._rarityId == 1 then
    maxExp = roleLevelRecord.Rexp
  end
  if self._rarityId == 2 then
    maxExp = roleLevelRecord.SRexp
  end
  if self._rarityId == 3 then
    maxExp = roleLevelRecord.SSRexp
  end
  if self._rarityId == 4 then
    maxExp = roleLevelRecord.URexp
  end
  if self._rarityId == 5 then
    maxExp = roleLevelRecord.EXexp
  end
  ;
  (self._levelup_progress):SetFillAmount(levelandexp.exp / maxExp)
  local str = (CStringRes:GetRecorder(1111)).msgTextID
  str = (TextManager.GetText)(str)
  str = (string.gsub)(str, "%$parameter1%$", tostring(levelandexp.exp))
  str = (string.gsub)(str, "%$parameter2%$", tostring(maxExp))
  ;
  (self._levelup_expTxt):SetText(str)
  self._sendProtocolTag = false
  local roleBreakRecord = ((self._data):GetBreakRecords())[self._breakLv]
  if not ((NekoData.BehaviorManager).BM_Guide):HasFinished(25) and self._lv == (self._data):GetLevelMaxByBreakRecord(roleBreakRecord) then
    self._longPress = false
    if not self._levelup_hasTriggerGuideTag1 then
      self._levelup_hasTriggerGuideTag1 = true
      ;
      (LuaNotificationCenter.PostNotification)(Common.n_TriggerGuide, self, nil)
    end
  else
    if not self._progressTask and self._startTag and self._longPress then
      if lv < self._lv and ProgressFullMinTotalTime <= self._progressFullTime / 2 then
        self._progressFullTime = self._progressFullTime * 3 / 4
      end
      ;
      (CharLevelUpPart.OnLevelUpBtnBeginLongPress)()
    end
  end
  self._lvUpper = lv < self._lv
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

CharLevelUpPart.OnLevelUpBtnPointerDown = function()
  -- function num : 0_8 , upvalues : _ENV
  if ((NekoData.BehaviorManager).BM_Guide):IsCurrentGuide(2) and ((NekoData.BehaviorManager).BM_Currency):GetMoney() <= 0 then
    ((NekoData.BehaviorManager).BM_Guide):FinishGuide(2)
  end
end

CharLevelUpPart.OnLevelUpBtnClick = function()
  -- function num : 0_9 , upvalues : self, _ENV, LongPressLevelUpClickLimit, CRoleLevelCfgTable, CMessagetipTable, CharLevelUpPart, Time
  if self._clickLevelUpBtnCount and not ((NekoData.BehaviorManager).BM_Game):GetPromptLongPressLevelUp() then
    self._clickLevelUpBtnCount = self._clickLevelUpBtnCount + 1
    if self._clickLevelUpBtnCount == LongPressLevelUpClickLimit then
      ((NekoData.DataManager).DM_Game):SetPromptLongPressLevelUp()
      ;
      ((DialogManager.CreateSingletonDialog)("newbattle.battleteachguidedialog")):Init(7)
      if ((NekoData.BehaviorManager).BM_Guide):IsCurrentGuide(2) then
        ((DialogManager.GetGroup)("Guide")):SetObjectActive(false)
      end
    end
  end
  if self._lastExp ~= self._exp and not self._sendProtocolTag and not self._progressTask then
    self._startTag = false
    local roleBreakRecord = ((self._data):GetBreakRecords())[self._breakLv]
    ;
    (CRoleLevelCfgTable:GetRecorder(self._lv))
    local roleLevelRecord = nil
    local maxExp = nil
    if self._rarityId == 1 then
      maxExp = roleLevelRecord.Rexp
    end
    if self._rarityId == 2 then
      maxExp = roleLevelRecord.SRexp
    end
    if self._rarityId == 3 then
      maxExp = roleLevelRecord.SSRexp
    end
    if self._rarityId == 4 then
      maxExp = roleLevelRecord.URexp
    end
    if self._rarityId == 5 then
      maxExp = roleLevelRecord.EXexp
    end
    local levelMax = (self._data):GetLevelMaxByBreakRecord(((self._data):GetBreakRecordList())[#(self._data):GetBreakRecordList()])
    if self._lv == (self._data):GetLevelMaxByBreakRecord(roleBreakRecord) then
      if self._lv < levelMax then
        ((NekoData.BehaviorManager).BM_Message):AddSecondConfirmDialog(9, nil, function()
    -- function num : 0_9_0 , upvalues : self
    self:OnBreakPanelClick()
  end
)
      else
        local msgRecord = CMessagetipTable:GetRecorder(100007)
        local dialog = (DialogManager.CreateSingletonDialog)("character.levelupmsgtipdialog")
        dialog:AddMessageTip((TextManager.GetText)(msgRecord.msgTextID))
      end
    else
      do
        if (self._data):GetMaxLevel() <= self._lv then
          (CharLevelUpPart.PopMagicLvNotEnoughTip)()
        else
          if self._mana <= 0 then
            local msgRecord = CMessagetipTable:GetRecorder(100006)
            local dialog = (DialogManager.CreateSingletonDialog)("character.levelupmsgtipdialog")
            dialog:AddMessageTip((TextManager.GetText)(msgRecord.msgTextID))
          else
            do
              self._soul = maxExp // 20
              if self._soul < 2 then
                self._soul = 2
              end
              local levelUpNeedExp = maxExp - self._exp
              if levelUpNeedExp < self._soul then
                self._soul = levelUpNeedExp
              end
              if self._mana < self._soul then
                self._soul = self._mana
              end
              local endExp = self._exp + self._soul
              self._lastExp = self._exp
              self._progressTask = (Tween.new)(Time, {exp = self._exp}, {exp = endExp}, "linear")
            end
          end
        end
      end
    end
  end
end

CharLevelUpPart.OnLevelUpBtnBeginLongPress = function()
  -- function num : 0_10 , upvalues : self, _ENV, CMessagetipTable, CharLevelUpPart, CRoleLevelCfgTable
  self:SetDragEnable(false)
  self._canChangeRole = false
  self._longPress = false
  local roleBreakRecord = ((self._data):GetBreakRecords())[self._breakLv]
  local levelMax = (self._data):GetLevelMaxByBreakRecord(((self._data):GetBreakRecordList())[#(self._data):GetBreakRecordList()])
  if self._lv == (self._data):GetLevelMaxByBreakRecord(roleBreakRecord) then
    if self._lv < levelMax then
      ((NekoData.BehaviorManager).BM_Message):AddSecondConfirmDialog(9, nil, function()
    -- function num : 0_10_0 , upvalues : self
    self:OnBreakPanelClick()
  end
)
    else
      local msgRecord = CMessagetipTable:GetRecorder(100007)
      local dialog = (DialogManager.CreateSingletonDialog)("character.levelupmsgtipdialog")
      dialog:AddMessageTip((TextManager.GetText)(msgRecord.msgTextID))
    end
  else
    do
      if (self._data):GetMaxLevel() <= self._lv then
        (CharLevelUpPart.PopMagicLvNotEnoughTip)()
      else
        if self._mana <= 0 then
          local msgRecord = CMessagetipTable:GetRecorder(100006)
          local dialog = (DialogManager.CreateSingletonDialog)("character.levelupmsgtipdialog")
          dialog:AddMessageTip((TextManager.GetText)(msgRecord.msgTextID))
        else
          do
            ;
            (CharLevelUpPart.PlayLongPressEffect)()
            self._startTag = true
            local roleLevelRecord = (CRoleLevelCfgTable:GetRecorder(self._lv))
            -- DECOMPILER ERROR at PC90: Overwrote pending register: R3 in 'AssignReg'

            local maxExp = .end
            if self._rarityId == 1 then
              maxExp = roleLevelRecord.Rexp
            end
            if self._rarityId == 2 then
              maxExp = roleLevelRecord.SRexp
            end
            if self._rarityId == 3 then
              maxExp = roleLevelRecord.SSRexp
            end
            if self._rarityId == 4 then
              maxExp = roleLevelRecord.URexp
            end
            if self._rarityId == 5 then
              maxExp = roleLevelRecord.EXexp
            end
            self._growthRate = maxExp / self._progressFullTime
            self._beginLongPressTime = 0
          end
        end
      end
    end
  end
end

CharLevelUpPart.OnLevelUpBtnLongPress = function()
  -- function num : 0_11 , upvalues : self, CRoleLevelCfgTable
  if self._startTag and not self._longPress then
    local roleBreakRecord = ((self._data):GetBreakRecords())[self._breakLv]
    local roleLevelRecord = CRoleLevelCfgTable:GetRecorder(self._lv)
    if self._lv < (self._data):GetLevelMaxByBreakRecord(roleBreakRecord) and self._lv < (self._data):GetMaxLevel() and self._mana > 0 then
      self._longPress = true
    end
  end
end

CharLevelUpPart.OnLevelUpBtnEndLongPress = function()
  -- function num : 0_12 , upvalues : self, _ENV, CharLevelUpPart, ProgressFullMaxTotalTime, CRoleLevelCfgTable, CStringRes
  if self._longPressLevelUp then
    ((NekoData.BehaviorManager).BM_Voice):Play((self._data):GetId(), (((NekoData.BehaviorManager).BM_Voice).VoiceType).LevelUp, nil)
    self._longPressLevelUp = false
  end
  self:SetDragEnable(true)
  self._canChangeRole = true
  if self._startTag then
    (CharLevelUpPart.ReleaseLongPressEffect)()
    self._progressFullTime = ProgressFullMaxTotalTime
    self._startTag = false
    local roleLevelRecord = (CRoleLevelCfgTable:GetRecorder(self._lv))
    local maxExp = nil
    if self._rarityId == 1 then
      maxExp = roleLevelRecord.Rexp
    end
    if self._rarityId == 2 then
      maxExp = roleLevelRecord.SRexp
    end
    if self._rarityId == 3 then
      maxExp = roleLevelRecord.SSRexp
    end
    if self._rarityId == 4 then
      maxExp = roleLevelRecord.URexp
    end
    if self._rarityId == 5 then
      maxExp = roleLevelRecord.EXexp
    end
    if self._longPress and not self._sendProtocolTag then
      local exp = (math.floor)(self._exp + self._beginLongPressTime * self._growthRate)
      local needSoul = (math.ceil)(self._beginLongPressTime * self._growthRate)
      if needSoul <= self._mana then
        if exp < maxExp then
          (self._levelup_progress):SetFillAmount(exp / maxExp)
        else
          if maxExp <= exp then
            (self._levelup_progress):SetFillAmount(1)
            needSoul = maxExp - self._exp
          end
        end
        if needSoul < 2 then
          needSoul = 2
        end
        local str = (CStringRes:GetRecorder(1111)).msgTextID
        str = (TextManager.GetText)(str)
        str = (string.gsub)(str, "%$parameter1%$", tostring(exp))
        str = (string.gsub)(str, "%$parameter2%$", tostring(maxExp))
        ;
        (self._levelup_expTxt):SetText(str)
      else
        do
          ;
          (self._levelup_progress):SetFillAmount((self._exp + self._mana) / maxExp)
          do
            local str = (CStringRes:GetRecorder(1111)).msgTextID
            str = (TextManager.GetText)(str)
            str = (string.gsub)(str, "%$parameter1%$", tostring(self._exp + self._mana))
            str = (string.gsub)(str, "%$parameter2%$", tostring(maxExp))
            ;
            (self._levelup_expTxt):SetText(str)
            needSoul = self._mana
            self._sendProtocolTag = true
            local CAddSoul = (LuaNetManager.CreateProtocol)("protocol.login.caddsoul")
            if CAddSoul then
              CAddSoul.roleId = self._key
              CAddSoul.soul = needSoul
              CAddSoul:Send()
            end
            self._longPress = false
          end
        end
      end
    end
  end
end

CharLevelUpPart.OnLevelUpBtnCancelLongPress = function()
  -- function num : 0_13 , upvalues : self, _ENV, CharLevelUpPart, ProgressFullMaxTotalTime, CRoleLevelCfgTable, CStringRes
  if self._longPressLevelUp then
    ((NekoData.BehaviorManager).BM_Voice):Play((self._data):GetId(), (((NekoData.BehaviorManager).BM_Voice).VoiceType).LevelUp, nil)
    self._longPressLevelUp = false
  end
  self:SetDragEnable(true)
  self._canChangeRole = true
  if self._startTag then
    (CharLevelUpPart.ReleaseLongPressEffect)()
    self._progressFullTime = ProgressFullMaxTotalTime
    self._startTag = false
    local roleLevelRecord = (CRoleLevelCfgTable:GetRecorder(self._lv))
    local maxExp = nil
    if self._rarityId == 1 then
      maxExp = roleLevelRecord.Rexp
    end
    if self._rarityId == 2 then
      maxExp = roleLevelRecord.SRexp
    end
    if self._rarityId == 3 then
      maxExp = roleLevelRecord.SSRexp
    end
    if self._rarityId == 4 then
      maxExp = roleLevelRecord.URexp
    end
    if self._rarityId == 5 then
      maxExp = roleLevelRecord.EXexp
    end
    if self._longPress and not self._sendProtocolTag then
      local exp = (math.floor)(self._exp + self._beginLongPressTime * self._growthRate)
      local needSoul = (math.ceil)(self._beginLongPressTime * self._growthRate)
      if needSoul <= self._mana then
        if exp < maxExp then
          (self._levelup_progress):SetFillAmount(exp / maxExp)
        else
          if maxExp <= exp then
            (self._levelup_progress):SetFillAmount(1)
            needSoul = maxExp - self._exp
          end
        end
        if needSoul < 2 then
          needSoul = 2
        end
        local str = (CStringRes:GetRecorder(1111)).msgTextID
        str = (TextManager.GetText)(str)
        str = (string.gsub)(str, "%$parameter1%$", tostring(exp))
        str = (string.gsub)(str, "%$parameter2%$", tostring(maxExp))
        ;
        (self._levelup_expTxt):SetText(str)
      else
        do
          ;
          (self._levelup_progress):SetFillAmount((self._exp + self._mana) / maxExp)
          do
            local str = (CStringRes:GetRecorder(1111)).msgTextID
            str = (TextManager.GetText)(str)
            str = (string.gsub)(str, "%$parameter1%$", tostring(self._exp + self._mana))
            str = (string.gsub)(str, "%$parameter2%$", tostring(maxExp))
            ;
            (self._levelup_expTxt):SetText(str)
            needSoul = self._mana
            self._sendProtocolTag = true
            local CAddSoul = (LuaNetManager.CreateProtocol)("protocol.login.caddsoul")
            if CAddSoul then
              CAddSoul.roleId = self._key
              CAddSoul.soul = needSoul
              CAddSoul:Send()
            end
            self._longPress = false
          end
        end
      end
    end
  end
end

CharLevelUpPart.OnUpdate = function(a, notification)
  -- function num : 0_14 , upvalues : self, _ENV, CRoleLevelCfgTable, CStringRes, CharLevelUpPart
  if #self._levelup_task1 ~= 0 then
    for i,v in pairs(self._levelup_task1) do
      if v:update((notification.userInfo).deltaTime) then
        self._levelup_task1 = {}
        ;
        (self._levelup_healthCur):SetText((self._propertyTable)[1])
        ;
        (self._levelup_phyDefCur):SetText((self._propertyTable)[2])
        ;
        (self._levelup_magDefCur):SetText((self._propertyTable)[3])
        ;
        (self._levelup_phyAtkCur):SetText((self._propertyTable)[4])
        ;
        (self._levelup_healthMax):SetText((self._propertyTable)[5])
        ;
        (self._levelup_phyDefMax):SetText((self._propertyTable)[6])
        ;
        (self._levelup_magDefMax):SetText((self._propertyTable)[7])
        ;
        (self._levelup_phyAtkMax):SetText((self._propertyTable)[8])
        break
      else
        if i == 1 then
          (self._levelup_healthCur):SetText((math.ceil)((v.subject).value))
        else
          if i == 2 then
            (self._levelup_phyDefCur):SetText((math.ceil)((v.subject).value))
          else
            if i == 3 then
              (self._levelup_magDefCur):SetText((math.ceil)((v.subject).value))
            else
              if i == 4 then
                (self._levelup_phyAtkCur):SetText((math.ceil)((v.subject).value))
              else
                if i == 5 then
                  (self._levelup_healthMax):SetText((math.ceil)((v.subject).value))
                else
                  if i == 6 then
                    (self._levelup_phyDefMax):SetText((math.ceil)((v.subject).value))
                  else
                    if i == 7 then
                      (self._levelup_magDefMax):SetText((math.ceil)((v.subject).value))
                    else
                      if i == 8 then
                        (self._levelup_phyAtkMax):SetText((math.ceil)((v.subject).value))
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
  do
    if self._progressTask then
      local roleLevelRecord = (CRoleLevelCfgTable:GetRecorder(self._lv))
      -- DECOMPILER ERROR at PC154: Overwrote pending register: R3 in 'AssignReg'

      local maxExp = .end
      if self._rarityId == 1 then
        maxExp = roleLevelRecord.Rexp
      end
      if self._rarityId == 2 then
        maxExp = roleLevelRecord.SRexp
      end
      if self._rarityId == 3 then
        maxExp = roleLevelRecord.SSRexp
      end
      if self._rarityId == 4 then
        maxExp = roleLevelRecord.URexp
      end
      if self._rarityId == 5 then
        maxExp = roleLevelRecord.EXexp
      end
      if (self._progressTask):update((notification.userInfo).deltaTime) then
        (self._levelup_progress):SetFillAmount(((self._progressTask).subject).exp / maxExp)
        local str = (CStringRes:GetRecorder(1111)).msgTextID
        str = (TextManager.GetText)(str)
        str = (string.gsub)(str, "%$parameter1%$", tostring((math.ceil)(((self._progressTask).subject).exp)))
        str = (string.gsub)(str, "%$parameter2%$", tostring(maxExp))
        ;
        (self._levelup_expTxt):SetText(str)
        if maxExp - (math.ceil)(((self._progressTask).subject).exp) > 0 then
          (self._levelup_needMana):SetText(maxExp - (math.ceil)(((self._progressTask).subject).exp))
        else
          ;
          (self._levelup_needMana):SetText(0)
          ;
          ((NekoData.BehaviorManager).BM_Voice):Play((self._data):GetId(), (((NekoData.BehaviorManager).BM_Voice).VoiceType).LevelUp, nil)
        end
        local mana = self._mana - self._soul
        self._progressTask = nil
        self._sendProtocolTag = true
        local CAddSoul = (LuaNetManager.CreateProtocol)("protocol.login.caddsoul")
        if CAddSoul then
          CAddSoul.roleId = self._key
          CAddSoul.soul = self._soul
          CAddSoul:Send()
        end
      else
        do
          local mana = self._mana - ((math.ceil)(((self._progressTask).subject).exp) - self._exp)
          ;
          (self._levelup_progress):SetFillAmount(((self._progressTask).subject).exp / maxExp)
          do
            local str = (CStringRes:GetRecorder(1111)).msgTextID
            str = (TextManager.GetText)(str)
            str = (string.gsub)(str, "%$parameter1%$", tostring((math.ceil)(((self._progressTask).subject).exp)))
            str = (string.gsub)(str, "%$parameter2%$", tostring(maxExp))
            ;
            (self._levelup_expTxt):SetText(str)
            if maxExp - (math.ceil)(((self._progressTask).subject).exp) > 0 then
              (self._levelup_needMana):SetText(maxExp - (math.ceil)(((self._progressTask).subject).exp))
            else
              ;
              (self._levelup_needMana):SetText(0)
            end
            if self._startTag and self._longPress and not self._sendProtocolTag then
              self._beginLongPressTime = self._beginLongPressTime + (notification.userInfo).deltaTime
              local roleLevelRecord = (CRoleLevelCfgTable:GetRecorder(self._lv))
              -- DECOMPILER ERROR at PC378: Overwrote pending register: R3 in 'AssignReg'

              local maxExp = .end
              if self._rarityId == 1 then
                maxExp = roleLevelRecord.Rexp
              end
              if self._rarityId == 2 then
                maxExp = roleLevelRecord.SRexp
              end
              if self._rarityId == 3 then
                maxExp = roleLevelRecord.SSRexp
              end
              if self._rarityId == 4 then
                maxExp = roleLevelRecord.URexp
              end
              if self._rarityId == 5 then
                maxExp = roleLevelRecord.EXexp
              end
              local exp = (math.ceil)(self._exp + self._beginLongPressTime * self._growthRate)
              local needSoul = (math.ceil)(self._beginLongPressTime * self._growthRate)
              if needSoul <= self._mana then
                if exp < maxExp then
                  (self._levelup_progress):SetFillAmount(exp / maxExp)
                else
                  if maxExp <= exp then
                    (self._levelup_progress):SetFillAmount(1)
                    self._sendProtocolTag = true
                    local soul = maxExp - self._exp
                    if soul < 2 then
                      soul = 2
                    end
                    local CAddSoul = (LuaNetManager.CreateProtocol)("protocol.login.caddsoul")
                    if CAddSoul then
                      CAddSoul.roleId = self._key
                      CAddSoul.soul = soul
                      CAddSoul:Send()
                    end
                    self._longPressLevelUp = true
                  end
                end
                do
                  do
                    local str = (CStringRes:GetRecorder(1111)).msgTextID
                    str = (TextManager.GetText)(str)
                    str = (string.gsub)(str, "%$parameter1%$", tostring(exp))
                    str = (string.gsub)(str, "%$parameter2%$", tostring(maxExp))
                    ;
                    (self._levelup_expTxt):SetText(str)
                    ;
                    (self._levelup_progress):SetFillAmount((self._exp + self._mana) / maxExp)
                    do
                      local str = (CStringRes:GetRecorder(1111)).msgTextID
                      str = (TextManager.GetText)(str)
                      str = (string.gsub)(str, "%$parameter1%$", tostring(self._exp + self._mana))
                      str = (string.gsub)(str, "%$parameter2%$", tostring(maxExp))
                      ;
                      (self._levelup_expTxt):SetText(str)
                      exp = self._exp + self._mana
                      ;
                      (CharLevelUpPart.OnLevelUpBtnEndLongPress)()
                      if maxExp - (exp) > 0 then
                        (self._levelup_needMana):SetText(maxExp - (exp))
                      else
                        ;
                        (self._levelup_needMana):SetText(0)
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end

CharLevelUpPart.PopMagicLvNotEnoughTip = function()
  -- function num : 0_15 , upvalues : CPlayerLevel, _ENV, self, CMessagetipTable
  local playerLevel = nil
  local allIds = CPlayerLevel:GetAllIds()
  for i,v in ipairs(allIds) do
    local recorder = CPlayerLevel:GetRecorder(v)
    if self._lv < recorder.roleMaxLv then
      playerLevel = recorder.id
      break
    end
  end
  do
    local msgRecord = CMessagetipTable:GetRecorder(100255)
    local dialog = (DialogManager.CreateSingletonDialog)("character.levelupmsgtipdialog")
    dialog:AddMessageTip((string.gsub)((TextManager.GetText)(msgRecord.msgTextID), "%$parameter1%$", playerLevel))
  end
end

CharLevelUpPart.OnQuickLevelUpBtnClick = function()
  -- function num : 0_16 , upvalues : self, CMessagetipTable, _ENV, CPlayerLevel, CharLevelUpPart, CRoleLevelCfgTable
  local roleBreakRecord = ((self._data):GetBreakRecords())[self._breakLv]
  local allBreakRecordList = (self._data):GetBreakRecordList()
  local levelMax = (self._data):GetLevelMaxByBreakRecord(allBreakRecordList[#allBreakRecordList])
  if self._lv == levelMax then
    local msgRecord = CMessagetipTable:GetRecorder(100007)
    local dialog = (DialogManager.CreateSingletonDialog)("character.levelupmsgtipdialog")
    dialog:AddMessageTip((TextManager.GetText)(msgRecord.msgTextID))
  else
    do
      local userLevel = (((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()).userlevel
      local maxLevel = (CPlayerLevel:GetRecorder(userLevel)).roleMaxLv
      if maxLevel <= self._lv then
        (CharLevelUpPart.PopMagicLvNotEnoughTip)()
      else
        local enough = true
        local nextLv = self._lv + 1
        local record = CRoleLevelCfgTable:GetRecorder(nextLv)
        if record.clientBreakLevel == self._breakLv then
          local maxExp = nil
          local roleLevelRecord = CRoleLevelCfgTable:GetRecorder(self._lv)
          if self._rarityId == 1 then
            maxExp = roleLevelRecord.Rexp
          end
          if self._rarityId == 2 then
            maxExp = roleLevelRecord.SRexp
          end
          if self._rarityId == 3 then
            maxExp = roleLevelRecord.SSRexp
          end
          if self._rarityId == 4 then
            maxExp = roleLevelRecord.URexp
          end
          if self._rarityId == 5 then
            maxExp = roleLevelRecord.EXexp
          end
          local needMana = maxExp - (self._data):GetExp()
          if ((NekoData.BehaviorManager).BM_Currency):GetCurrencyNum(DataCommon.ManaID) < needMana then
            enough = false
          end
        else
          do
            local allBreakRecords = (self._data):GetBreakRecords()
            local breakRecord = allBreakRecords[record.clientBreakLevel - 1]
            local needMana = breakRecord.goldcost
            if ((NekoData.BehaviorManager).BM_Currency):GetCurrencyNum(DataCommon.ManaID) < needMana then
              enough = false
            else
              for i,v in ipairs(breakRecord.itemId) do
                if v ~= 0 then
                  local num = (breakRecord.itemNum)[i]
                  if ((NekoData.BehaviorManager).BM_BagInfo):GetItemCountById(v) < num then
                    enough = false
                    break
                  end
                end
              end
            end
            do
              if enough then
                ((DialogManager.CreateSingletonDialog)("character.quicklevelup.quicklevelupmaindialog")):SetRoleId((self._data):GetRoleId())
              else
                local msgRecord = CMessagetipTable:GetRecorder(100460)
                local dialog = (DialogManager.CreateSingletonDialog)("character.levelupmsgtipdialog")
                dialog:AddMessageTip((TextManager.GetText)(msgRecord.msgTextID))
              end
            end
          end
        end
      end
    end
  end
end

return CharLevelUpPart

