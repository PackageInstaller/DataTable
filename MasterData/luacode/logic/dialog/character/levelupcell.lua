local CRoleBreakCfgTable = BeanManager.GetTableByName("role.crolebreakcfg")
local CRoleLevelCfgTable = BeanManager.GetTableByName("role.crolelevelcfg")
local CMessagetipTable = BeanManager.GetTableByName("message.cmessagetip")
local RoleConfigTable = BeanManager.GetTableByName("role.roleconfig")
local AttrTypeEnum = LuaNetManager.GetBeanDef("protocol.login.attrtype")
local CAttrNameTable = BeanManager.GetTableByName("role.cattreffectidname")
local Time = 0.5
local ProgressFullMaxTotalTime = 2
local ProgressFullMinTotalTime = 0.2
local LevelUpCell = class("LevelUpCell", Dialog)
LevelUpCell.AssetBundleName = "ui/layouts.basecharacterinfo"
LevelUpCell.AssetName = "BaseCharacterInfoLevelUpCell"

local function HandleHandleStage(self, notification)
  local userInfo = notification.userInfo
  if userInfo == nil then
    return
  end
  if userInfo.guideID == 1 then
    if userInfo.stageRefCountTable[3] > 0 or 0 < userInfo.stageRefCountTable[5] or 0 < userInfo.stageRefCountTable[7] then
      self._guideTag = true
      local width, height = self._bottomLevelUpBtn:GetRectSize()
      local screenPos = self._bottomLevelUpBtn:GetLocalPointInUiRootPanel()
      local dialog = DialogManager.CreateSingletonDialog("guide.guidedialog")
      dialog:SetGuideId(userInfo.guideID)
      dialog:SetGuidePoint(width, height, screenPos.x, screenPos.y)
      DialogManager.CreateSingletonDialog("guide.guide1_3dialog"):SetTextPoint(width, height, screenPos.x, screenPos.y)
    elseif self._guideTag then
      self._guideTag = false
      DialogManager.DestroySingletonDialog("guide.guide1_3dialog")
      DialogManager.DestroySingletonDialog("guide.guidedialog")
    end
  end
end

function LevelUpCell:Ctor(...)
  LevelUpCell.super.Ctor(self, ...)
  self._list = {}
  self._task = false
  self._task1 = {}
  self._tag = false
  self._sendProtocolTag = false
  self._beginLongPressTime = nil
  self._progressTask = nil
  self._rarityId = nil
  self._propertyTable = {}
  self._levelUpButtonGuideEffectHandler = nil
  self._hasTriggerGuide = false
  self._progressFullTime = ProgressFullMaxTotalTime
end

function LevelUpCell:OnCreate()
  self._beforeLevel = self:GetChild("TopBack/Up/LeftPanel/LevelNum")
  self._beforeLevelMax = self:GetChild("TopBack/Up/LeftPanel/LevelMax")
  self._afterLevel = self:GetChild("TopBack/Up/RightPanel/LevelNum")
  self._afterLevelMax = self:GetChild("TopBack/Up/RightPanel/LevelMax")
  self._propertyPanel = self:GetChild("TopBack/Property")
  self._leftHealthNum = self:GetChild("TopBack/Property/Health/Num")
  self._healthName = self:GetChild("TopBack/Property/Health/Name")
  self._leftPhyDefNum = self:GetChild("TopBack/Property/PhyDef/Num")
  self._phyDefName = self:GetChild("TopBack/Property/PhyDef/Name")
  self._leftMagDefNum = self:GetChild("TopBack/Property/MagDef/Num")
  self._magDefName = self:GetChild("TopBack/Property/MagDef/Name")
  self._leftAtkNum = self:GetChild("TopBack/Property/PhyAtk/Num")
  self._atkName = self:GetChild("TopBack/Property/PhyAtk/Name")
  self._rightHealthNum = self:GetChild("TopBack/Property/Health/Num2")
  self._rightPhyDefNum = self:GetChild("TopBack/Property/PhyDef/Num2")
  self._rightMagDefNum = self:GetChild("TopBack/Property/MagDef/Num2")
  self._rightAtkNum = self:GetChild("TopBack/Property/PhyAtk/Num2")
  self._rightLv = self:GetChild("TopBack/Up/RightPanel/LV")
  self._rightDiv = self:GetChild("TopBack/Up/RightPanel/Div")
  self._arrow1 = self:GetChild("TopBack/Up/Arrow1")
  self._arrow2 = self:GetChild("TopBack/Property/Health/Arrow2")
  self._arrow3 = self:GetChild("TopBack/Property/PhyAtk/Arrow2")
  self._arrow4 = self:GetChild("TopBack/Property/PhyDef/Arrow2")
  self._arrow5 = self:GetChild("TopBack/Property/MagDef/Arrow2")
  table.insert(self._list, self._afterLevel)
  table.insert(self._list, self._afterLevelMax)
  table.insert(self._list, self._rightHealthNum)
  table.insert(self._list, self._rightPhyDefNum)
  table.insert(self._list, self._rightMagDefNum)
  table.insert(self._list, self._rightAtkNum)
  table.insert(self._list, self._rightLv)
  table.insert(self._list, self._rightDiv)
  table.insert(self._list, self._arrow1)
  table.insert(self._list, self._arrow2)
  table.insert(self._list, self._arrow3)
  table.insert(self._list, self._arrow4)
  table.insert(self._list, self._arrow5)
  self._bottomLevelUpBtn = self:GetChild("Cost/CommonButton2")
  self._levelUpButtonEffect = self:GetChild("Cost/CommonButton2/Effect")
  self._restSoulForce = self:GetChild("Cost/Txt4")
  self._progress = self:GetChild("Cost/Progress/BackGround/Progress")
  self._expMaxPanel = self:GetChild("Cost/MaxTxt")
  self._expNumPanel = self:GetChild("Cost/NumPanel")
  self._curExp = self:GetChild("Cost/NumPanel/Num")
  self._maxExp = self:GetChild("Cost/NumPanel/Max")
  LuaNotificationCenter.AddObserver(self, self.OnUpdate, Common.n_Update, nil)
  self._bottomLevelUpBtn:Subscribe_PointerClickEvent(self.OnLevelUpBtnPointerClick, self)
  self._bottomLevelUpBtn:Subscribe_BeginLongPressEvent(self.OnLevelUpBtnBeginLongPress, self)
  self._bottomLevelUpBtn:Subscribe_LongPressEvent(self.OnLevelUpBtnLongPress, self)
  self._bottomLevelUpBtn:Subscribe_EndLongPressEvent(self.OnLevelUpBtnEndLongPress, self)
  self._bottomLevelUpBtn:Subscribe_CancelLongPressEvent(self.OnLevelUpBtnCancelLongPress, self)
  LuaNotificationCenter.AddObserver(self, self.OnRefreshCurrency, Common.n_RefreshCurrency, nil)
  LuaNotificationCenter.AddObserver(self, HandleHandleStage, Common.n_HandleStage, nil)
end

function LevelUpCell:OnDestroy()
  self._progressTask = nil
  LuaNotificationCenter.RemoveObserver(self)
end

function LevelUpCell:OnRefreshCurrency(notification)
  local str
  self._mana = NekoData.BehaviorManager.BM_Currency:GetMoney()
  self._restSoulForce:SetNumber(self._mana)
end

function LevelUpCell:RefreshExp(levelandexp)
  local lv = self._lv
  self._key = levelandexp.key
  self._lv = levelandexp.level
  self._exp = levelandexp.exp
  local roleLevelRecord = CRoleLevelCfgTable:GetRecorder(levelandexp.level)
  local maxExp
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
  self._progress:SetFillAmount(levelandexp.exp / maxExp)
  self._curExp:SetText(tostring(levelandexp.exp))
  self._maxExp:SetText(tostring(maxExp))
  self._sendProtocolTag = false
  if self._hasTriggerGuide and (NekoData.BehaviorManager.BM_Guide:IsCurrentStage(1, 3) or NekoData.BehaviorManager.BM_Guide:IsCurrentStage(1, 5) or NekoData.BehaviorManager.BM_Guide:IsCurrentStage(1, 7)) and self._lv == 10 then
    self._hasTriggerGuide = false
    self._startTag = false
    self._longPress = false
    self._progressFullTime = ProgressFullMaxTotalTime
  elseif not self._progressTask and self._startTag and self._longPress then
    if lv < self._lv and self._progressFullTime / 2 >= ProgressFullMinTotalTime then
      self._progressFullTime = self._progressFullTime * 3 / 4
    end
    self:OnLevelUpBtnBeginLongPress()
  end
  self._task = lv < self._lv
end

function LevelUpCell:RefreshCell(data)
  if self._key and self._key ~= data:GetRoleId() then
    self._sendProtocolTag = false
    self._progressTask = nil
  end
  self._key = data:GetRoleId()
  self._rarityId = data:GetRarityId()
  self._roleId = NekoData.BehaviorManager.BM_AllRoles:GetRole(self._key):GetId()
  self._breakLv = data:GetBreakLv()
  self._lv = data:GetLevel()
  self._lastExp = nil
  self._exp = data:GetExp()
  self._beforeLevel:SetText(tostring(data:GetLevel()))
  local roleBreakRecord = CRoleBreakCfgTable:GetRecorder(data:GetBreakLv() + 1)
  self._beforeLevelMax:SetText(tostring(roleBreakRecord.levelmax))
  local roleLevelRecord = CRoleLevelCfgTable:GetRecorder(data:GetLevel())
  local maxExp
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
  if data:GetLevel() == roleBreakRecord.levelmax then
    self._expMaxPanel:SetActive(true)
    self._expNumPanel:SetActive(false)
    self._progress:SetFillAmount(1)
    self._afterLevel:SetText(tostring(data:GetLevel()))
    self._afterLevelMax:SetText(tostring(data:GetLevel()))
    for _, v in pairs(self._list) do
      v:SetActive(false)
    end
  else
    self._expMaxPanel:SetActive(false)
    self._expNumPanel:SetActive(true)
    self._curExp:SetText(tostring(data:GetExp()))
    self._maxExp:SetText(tostring(maxExp))
    self._progress:SetFillAmount(data:GetExp() / maxExp)
    self._afterLevel:SetText(tostring(data:GetLevel() + 1))
    self._afterLevelMax:SetText(tostring(roleBreakRecord.levelmax))
    for _, v in pairs(self._list) do
      v:SetActive(true)
    end
  end
  if not self._task then
    self._propertyTable = {}
    local properties = data:GetCurLvBasePro()
    self._healthName:SetText(TextManager.GetText(CAttrNameTable:GetRecorder(AttrTypeEnum.MAX_HP).classnameTextID))
    self._leftHealthNum:SetText(tostring(properties[AttrTypeEnum.MAX_HP]))
    table.insert(self._propertyTable, 1, properties[AttrTypeEnum.MAX_HP])
    self._phyDefName:SetText(TextManager.GetText(CAttrNameTable:GetRecorder(AttrTypeEnum.DEFEND).classnameTextID))
    self._leftPhyDefNum:SetText(tostring(properties[AttrTypeEnum.DEFEND]))
    table.insert(self._propertyTable, 2, properties[AttrTypeEnum.DEFEND])
    self._magDefName:SetText(TextManager.GetText(CAttrNameTable:GetRecorder(AttrTypeEnum.MAGIC_DEFEND).classnameTextID))
    self._leftMagDefNum:SetText(tostring(properties[AttrTypeEnum.MAGIC_DEFEND]))
    table.insert(self._propertyTable, 3, properties[AttrTypeEnum.MAGIC_DEFEND])
    self._atkName:SetText(TextManager.GetText(CAttrNameTable:GetRecorder(AttrTypeEnum.ATTACK).classnameTextID))
    self._leftAtkNum:SetText(tostring(properties[AttrTypeEnum.ATTACK]))
    table.insert(self._propertyTable, 4, properties[AttrTypeEnum.ATTACK])
    if data:GetLevel() ~= roleBreakRecord.levelmax then
      properties = data:GetNextLvBasePro()
      self._rightHealthNum:SetText(tostring(properties[AttrTypeEnum.MAX_HP]))
      table.insert(self._propertyTable, 5, properties[AttrTypeEnum.MAX_HP])
      self._rightPhyDefNum:SetText(tostring(properties[AttrTypeEnum.DEFEND]))
      table.insert(self._propertyTable, 6, properties[AttrTypeEnum.DEFEND])
      self._rightMagDefNum:SetText(tostring(properties[AttrTypeEnum.MAGIC_DEFEND]))
      table.insert(self._propertyTable, 7, properties[AttrTypeEnum.MAGIC_DEFEND])
      self._rightAtkNum:SetText(tostring(properties[AttrTypeEnum.ATTACK]))
      table.insert(self._propertyTable, 8, properties[AttrTypeEnum.ATTACK])
    end
  else
    self._task = false
    self._delegate._delegate:PlayEffect()
    local properties = data:GetCurLvBasePro()
    table.insert(self._task1, Tween.new(Time, {
      value = self._propertyTable[1]
    }, {
      value = properties[AttrTypeEnum.MAX_HP]
    }, "linear"))
    self._propertyTable[1] = properties[AttrTypeEnum.MAX_HP]
    table.insert(self._task1, Tween.new(Time, {
      value = self._propertyTable[2]
    }, {
      value = properties[AttrTypeEnum.DEFEND]
    }, "linear"))
    self._propertyTable[2] = properties[AttrTypeEnum.DEFEND]
    table.insert(self._task1, Tween.new(Time, {
      value = self._propertyTable[3]
    }, {
      value = properties[AttrTypeEnum.MAGIC_DEFEND]
    }, "linear"))
    self._propertyTable[3] = properties[AttrTypeEnum.MAGIC_DEFEND]
    table.insert(self._task1, Tween.new(Time, {
      value = self._propertyTable[4]
    }, {
      value = properties[AttrTypeEnum.ATTACK]
    }, "linear"))
    self._propertyTable[4] = properties[AttrTypeEnum.ATTACK]
    if data:GetLevel() ~= roleBreakRecord.levelmax then
      properties = data:GetNextLvBasePro()
      table.insert(self._task1, Tween.new(Time, {
        value = self._propertyTable[5]
      }, {
        value = properties[AttrTypeEnum.MAX_HP]
      }, "linear"))
      self._propertyTable[5] = properties[AttrTypeEnum.MAX_HP]
      table.insert(self._task1, Tween.new(Time, {
        value = self._propertyTable[6]
      }, {
        value = properties[AttrTypeEnum.DEFEND]
      }, "linear"))
      self._propertyTable[6] = properties[AttrTypeEnum.DEFEND]
      table.insert(self._task1, Tween.new(Time, {
        value = self._propertyTable[7]
      }, {
        value = properties[AttrTypeEnum.MAGIC_DEFEND]
      }, "linear"))
      self._propertyTable[7] = properties[AttrTypeEnum.MAGIC_DEFEND]
      table.insert(self._task1, Tween.new(Time, {
        value = self._propertyTable[8]
      }, {
        value = properties[AttrTypeEnum.ATTACK]
      }, "linear"))
      self._propertyTable[8] = properties[AttrTypeEnum.ATTACK]
    end
  end
  local str
  self._mana = NekoData.BehaviorManager.BM_Currency:GetMoney()
  self._restSoulForce:SetNumber(self._mana)
  local dialog = DialogManager.GetDialog("character.basecharacterlistalldialog")
  dialog = dialog or DialogManager.GetDialog("character.basecharacterlistdialog")
  local pos
  if dialog then
    local roleList = dialog:ReturnRoleList()
    if 0 < #roleList then
      for i, v in pairs(roleList) do
        if v:GetRoleId() == self._key then
          pos = i
          break
        end
      end
    end
  end
  if self._hasTriggerGuide == false then
    self._hasTriggerGuide = true
    if NekoData.BehaviorManager.BM_Guide:IsCurrentStage(1, 2) and pos == 1 then
      LuaNotificationCenter.PostNotification(Common.n_StopGuideStage, self, {
        [1] = 2
      })
      LuaNotificationCenter.PostNotification(Common.n_StartGuideStage, self, {
        [1] = 3
      })
    end
    if NekoData.BehaviorManager.BM_Guide:IsCurrentStage(1, 3) and self._lv == 10 then
      LuaNotificationCenter.PostNotification(Common.n_StopGuideStage, self, {
        [1] = 3
      })
      LuaNotificationCenter.PostNotification(Common.n_StartGuideStage, self, {
        [1] = 4
      })
    end
    if NekoData.BehaviorManager.BM_Guide:IsCurrentStage(1, 4) and pos == 2 then
      LuaNotificationCenter.PostNotification(Common.n_StopGuideStage, self, {
        [1] = 4
      })
      LuaNotificationCenter.PostNotification(Common.n_StartGuideStage, self, {
        [1] = 5
      })
    end
    if NekoData.BehaviorManager.BM_Guide:IsCurrentStage(1, 5) and self._lv == 10 then
      LuaNotificationCenter.PostNotification(Common.n_StopGuideStage, self, {
        [1] = 5
      })
      LuaNotificationCenter.PostNotification(Common.n_StartGuideStage, self, {
        [1] = 6
      })
    end
    if NekoData.BehaviorManager.BM_Guide:IsCurrentStage(1, 6) and pos == 3 then
      LuaNotificationCenter.PostNotification(Common.n_StopGuideStage, self, {
        [1] = 6
      })
      LuaNotificationCenter.PostNotification(Common.n_StartGuideStage, self, {
        [1] = 7
      })
    end
    if NekoData.BehaviorManager.BM_Guide:IsCurrentStage(1, 7) and self._lv == 10 then
      LuaNotificationCenter.PostNotification(Common.n_StopGuideStage, self, {
        [1] = 7
      })
      LuaNotificationCenter.PostNotification(Common.n_StartGuideStage, self, {
        [1] = 8
      })
    end
  end
end

function LevelUpCell:OnLevelUpBtnPointerClick()
  if NekoData.BehaviorManager.BM_Guide:IsCurrentGuide(1) then
    local GuideType = LuaNetManager.GetBeanDef("protocol.user.guidtypes")
    local csend = LuaNetManager.CreateProtocol("protocol.user.crecordguide")
    csend.guide = GuideType.NEW_GUIDE_5
    csend:Send()
  end
  if self._lastExp ~= self._exp and not self._sendProtocolTag and not self._progressTask then
    self._startTag = false
    local roleBreakRecord = CRoleBreakCfgTable:GetRecorder(self._breakLv + 1)
    local roleLevelRecord = CRoleLevelCfgTable:GetRecorder(self._lv)
    local maxExp
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
    if self._lv == roleBreakRecord.levelmax then
      if self._lv < CRoleBreakCfgTable:GetRecorder(#CRoleBreakCfgTable:GetAllIds()).levelmax then
        NekoData.BehaviorManager.BM_Message:AddSecondConfirmDialog(9, nil, function()
          self._delegate:ToBreakThroughCell()
        end)
      else
        local msgRecord = CMessagetipTable:GetRecorder(100007)
        local dialog = DialogManager.CreateSingletonDialog("character.levelupmsgtipdialog")
        dialog:AddMessageTip(TextManager.GetText(msgRecord.msgTextID))
      end
    elseif self._mana == 0 then
      local msgRecord = CMessagetipTable:GetRecorder(100006)
      local dialog = DialogManager.CreateSingletonDialog("character.levelupmsgtipdialog")
      dialog:AddMessageTip(TextManager.GetText(msgRecord.msgTextID))
    else
      self._soul = maxExp // 20
      if 2 > self._soul then
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
      self._progressTask = Tween.new(Time, {
        exp = self._exp
      }, {exp = endExp}, "linear")
    end
  end
end

function LevelUpCell:OnLevelUpBtnBeginLongPress()
  if NekoData.BehaviorManager.BM_Guide:IsCurrentGuide(1) then
    local GuideType = LuaNetManager.GetBeanDef("protocol.user.guidtypes")
    local csend = LuaNetManager.CreateProtocol("protocol.user.crecordguide")
    csend.guide = GuideType.NEW_GUIDE_5
    csend:Send()
  end
  local roleBreakRecord = CRoleBreakCfgTable:GetRecorder(self._breakLv + 1)
  if self._lv == roleBreakRecord.levelmax then
    self._longPress = false
    if self._lv < CRoleBreakCfgTable:GetRecorder(#CRoleBreakCfgTable:GetAllIds()).levelmax then
      NekoData.BehaviorManager.BM_Message:AddSecondConfirmDialog(9, nil, function()
        self._delegate:ToBreakThroughCell()
      end)
    else
      local msgRecord = CMessagetipTable:GetRecorder(100007)
      local dialog = DialogManager.CreateSingletonDialog("character.levelupmsgtipdialog")
      dialog:AddMessageTip(TextManager.GetText(msgRecord.msgTextID))
    end
  elseif self._mana == 0 then
    local msgRecord = CMessagetipTable:GetRecorder(100006)
    local dialog = DialogManager.CreateSingletonDialog("character.levelupmsgtipdialog")
    dialog:AddMessageTip(TextManager.GetText(msgRecord.msgTextID))
  else
    self._delegate._delegate:PlayLongPressEffect()
    self._startTag = true
    local roleLevelRecord = CRoleLevelCfgTable:GetRecorder(self._lv)
    local maxExp
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
    self._longPress = false
    self._beginLongPressTime = ServerGameTimer.GetServerTimeForecast()
  end
end

function LevelUpCell:OnLevelUpBtnLongPress()
  if not self._longPress then
    local roleBreakRecord = CRoleBreakCfgTable:GetRecorder(self._breakLv + 1)
    local roleLevelRecord = CRoleLevelCfgTable:GetRecorder(self._lv)
    if self._lv < roleBreakRecord.levelmax and self._mana > 0 then
      self._longPress = true
    end
  end
end

function LevelUpCell:OnLevelUpBtnEndLongPress()
  if self._startTag then
    self._delegate._delegate:ReleaseLongPressEffect()
    self._progressFullTime = ProgressFullMaxTotalTime
    self._startTag = false
    local roleLevelRecord = CRoleLevelCfgTable:GetRecorder(self._lv)
    local maxExp
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
    local longPressDeltaTime = (ServerGameTimer.GetServerTimeForecast() - self._beginLongPressTime) / 1000
    if self._longPress and not self._sendProtocolTag then
      local longPressDeltaTime = (ServerGameTimer.GetServerTimeForecast() - self._beginLongPressTime) / 1000
      local exp = math.floor(self._exp + longPressDeltaTime * self._growthRate)
      local needSoul = math.ceil(longPressDeltaTime * self._growthRate)
      if needSoul <= self._mana then
        if maxExp > exp then
          self._progress:SetFillAmount(exp / maxExp)
        elseif maxExp <= exp then
          self._progress:SetFillAmount(1)
          needSoul = maxExp - self._exp
        end
        if needSoul < 2 then
          needSoul = 2
        end
        self._curExp:SetText(tostring(exp))
      else
        self._progress:SetFillAmount((self._exp + self._mana) / maxExp)
        self._curExp:SetText(tostring(self._exp + self._mana))
        needSoul = self._mana
      end
      self._sendProtocolTag = true
      local CAddSoul = LuaNetManager.CreateProtocol("protocol.login.caddsoul")
      if CAddSoul then
        CAddSoul.roleId = self._key
        CAddSoul.soul = needSoul
        CAddSoul:Send()
      end
    end
  end
end

function LevelUpCell:OnLevelUpBtnCancelLongPress()
  if self._startTag then
    self._delegate._delegate:ReleaseLongPressEffect()
    self._progressFullTime = ProgressFullMaxTotalTime
    self._startTag = false
    local roleLevelRecord = CRoleLevelCfgTable:GetRecorder(self._lv)
    local maxExp
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
    local longPressDeltaTime = (ServerGameTimer.GetServerTimeForecast() - self._beginLongPressTime) / 1000
    if self._longPress and not self._sendProtocolTag then
      local longPressDeltaTime = (ServerGameTimer.GetServerTimeForecast() - self._beginLongPressTime) / 1000
      local exp = math.floor(self._exp + longPressDeltaTime * self._growthRate)
      local needSoul = math.ceil(longPressDeltaTime * self._growthRate)
      if needSoul <= self._mana then
        if maxExp > exp then
          self._progress:SetFillAmount(exp / maxExp)
        elseif maxExp <= exp then
          self._progress:SetFillAmount(1)
          needSoul = maxExp - self._exp
        end
        if needSoul < 2 then
          needSoul = 2
        end
        self._curExp:SetText(tostring(exp))
      else
        self._progress:SetFillAmount((self._exp + self._mana) / maxExp)
        self._curExp:SetText(tostring(self._exp + self._mana))
        needSoul = self._mana
      end
      self._sendProtocolTag = true
      local CAddSoul = LuaNetManager.CreateProtocol("protocol.login.caddsoul")
      if CAddSoul then
        CAddSoul.roleId = self._key
        CAddSoul.soul = needSoul
        CAddSoul:Send()
      end
    end
  end
end

function LevelUpCell:OnUpdate(notification)
  if #self._task1 ~= 0 then
    for i, v in pairs(self._task1) do
      if v:update(notification.userInfo.deltaTime) then
        self._task1 = {}
        self._leftHealthNum:SetText(self._propertyTable[1])
        self._leftPhyDefNum:SetText(self._propertyTable[2])
        self._leftMagDefNum:SetText(self._propertyTable[3])
        self._leftAtkNum:SetText(self._propertyTable[4])
        self._rightHealthNum:SetText(self._propertyTable[5])
        self._rightPhyDefNum:SetText(self._propertyTable[6])
        self._rightMagDefNum:SetText(self._propertyTable[7])
        self._rightAtkNum:SetText(self._propertyTable[8])
        break
      elseif i == 1 then
        self._leftHealthNum:SetText(math.ceil(v.subject.value))
      elseif i == 2 then
        self._leftPhyDefNum:SetText(math.ceil(v.subject.value))
      elseif i == 3 then
        self._leftMagDefNum:SetText(math.ceil(v.subject.value))
      elseif i == 4 then
        self._leftAtkNum:SetText(math.ceil(v.subject.value))
      elseif i == 5 then
        self._rightHealthNum:SetText(math.ceil(v.subject.value))
      elseif i == 6 then
        self._rightPhyDefNum:SetText(math.ceil(v.subject.value))
      elseif i == 7 then
        self._rightMagDefNum:SetText(math.ceil(v.subject.value))
      elseif i == 8 then
        self._rightAtkNum:SetText(math.ceil(v.subject.value))
      end
    end
  end
  if self._progressTask then
    local roleLevelRecord = CRoleLevelCfgTable:GetRecorder(self._lv)
    local maxExp
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
    if self._progressTask:update(notification.userInfo.deltaTime) then
      self._progress:SetFillAmount(self._progressTask.subject.exp / maxExp)
      self._curExp:SetText(tostring(math.ceil(self._progressTask.subject.exp)))
      self._maxExp:SetText(tostring(maxExp))
      local mana = self._mana - self._soul
      self._restSoulForce:SetNumber(mana)
      self._progressTask = nil
      self._sendProtocolTag = true
      local CAddSoul = LuaNetManager.CreateProtocol("protocol.login.caddsoul")
      if CAddSoul then
        CAddSoul.roleId = self._key
        CAddSoul.soul = self._soul
        CAddSoul:Send()
      end
    else
      local mana = self._mana - (math.ceil(self._progressTask.subject.exp) - self._exp)
      self._restSoulForce:SetNumber(mana)
      self._progress:SetFillAmount(self._progressTask.subject.exp / maxExp)
      self._curExp:SetText(tostring(math.ceil(self._progressTask.subject.exp)))
      self._maxExp:SetText(tostring(maxExp))
    end
  end
  if self._startTag and self._longPress and not self._sendProtocolTag then
    local roleLevelRecord = CRoleLevelCfgTable:GetRecorder(self._lv)
    local maxExp
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
    local longPressDeltaTime = (ServerGameTimer.GetServerTimeForecast() - self._beginLongPressTime) / 1000
    local exp = math.floor(self._exp + longPressDeltaTime * self._growthRate)
    local needSoul = math.ceil(longPressDeltaTime * self._growthRate)
    if needSoul <= self._mana then
      if maxExp > exp then
        self._progress:SetFillAmount(exp / maxExp)
      elseif maxExp <= exp then
        self._progress:SetFillAmount(1)
        self._sendProtocolTag = true
        local soul = maxExp - self._exp
        if soul < 2 then
          soul = 2
        end
        local CAddSoul = LuaNetManager.CreateProtocol("protocol.login.caddsoul")
        if CAddSoul then
          CAddSoul.roleId = self._key
          CAddSoul.soul = soul
          CAddSoul:Send()
        end
      end
      self._curExp:SetText(tostring(exp))
      local mana = self._mana - (exp - self._exp)
      self._restSoulForce:SetNumber(mana)
    else
      self._progress:SetFillAmount((self._exp + self._mana) / maxExp)
      self._curExp:SetText(tostring(self._exp + self._mana))
      self._restSoulForce:SetNumber(0)
    end
  end
end

return LevelUpCell
