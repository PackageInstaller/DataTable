-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/bag/rolereset/roleresetmaindialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local GridFrame = require("framework.ui.frame.grid.gridframe")
local TableFrame = require("framework.ui.frame.table.tableframe")
local Item = require("logic.manager.experimental.types.item")
local ItemTypeEnum = (LuaNetManager.GetBeanDef)("protocol.item.beans.item")
local Skill = require("logic.manager.experimental.types.skill")
local Role = require("logic.manager.experimental.types.role")
local CDollRemodeling = (BeanManager.GetTableByName)("role.cdollremodeling")
local CStringres = (BeanManager.GetTableByName)("message.cstringres")
local RoleResetMainDialog = class("RoleResetMainDialog", Dialog)
RoleResetMainDialog.AssetBundleName = "ui/layouts.bag"
RoleResetMainDialog.AssetName = "RoleRestartMain"
local ColumnsNum = 8
local MinRowNum = 4
local ShowCharUpgrade = function(self, level)
  -- function num : 0_0
  ((self._charUpgrade).panel):SetActive(level ~= 0)
  for i = 1, 5 do
    (((self._charUpgrade).levelImage)[i]):SetActive(level == i)
  end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

local tempFun = function(a, b)
  -- function num : 0_1
  if b:GetPinJiID() < a:GetPinJiID() then
    return true
  else
    if a:GetPinJiID() == b:GetPinJiID() and a:GetID() < b:GetID() then
      return true
    end
  end
  return false
end

local RefreshSkillPanel = function(self)
  -- function num : 0_2 , upvalues : Role, Skill, _ENV
  local role = (Role.Create)(self._curSelectRoleId)
  self._roleConfigRecord = role:GetRoleConfig()
  self._showSkillList = {}
  for i = 1, 3 do
    if i == 1 then
      local skillItemId = (self._roleConfigRecord).contractskillid
      local skill = (Skill.Create)(skillItemId)
      ;
      (table.insert)(self._showSkillList, {skillId = skill:GetSkillId(), skillItemId = skillItemId, unlock = true})
    else
      do
        if i == 2 then
          local skillItemId = (self._roleConfigRecord).contractskillid2
          local skill = (Skill.Create)(skillItemId)
          local unlock = false
          if (self._role):GetRoleId() == 16 then
            unlock = ((self._role):GetShowSkillDataByIndex(2)).unlock
          end
          ;
          (table.insert)(self._showSkillList, {skillId = skill:GetSkillId(), skillItemId = skillItemId, unlock = unlock})
        else
          do
            do
              if i == 3 then
                (table.insert)(self._showSkillList, {skillId = (self._roleConfigRecord).contractskillid3, unlock = false, isPassive = true})
              end
              -- DECOMPILER ERROR at PC71: LeaveBlock: unexpected jumping out DO_STMT

              -- DECOMPILER ERROR at PC71: LeaveBlock: unexpected jumping out IF_ELSE_STMT

              -- DECOMPILER ERROR at PC71: LeaveBlock: unexpected jumping out IF_STMT

              -- DECOMPILER ERROR at PC71: LeaveBlock: unexpected jumping out DO_STMT

              -- DECOMPILER ERROR at PC71: LeaveBlock: unexpected jumping out IF_ELSE_STMT

              -- DECOMPILER ERROR at PC71: LeaveBlock: unexpected jumping out IF_STMT

            end
          end
        end
      end
    end
  end
  local skill1 = (self._showSkillList)[1]
  if not skill1.skillItemId then
    do
      local skill = (Skill.Create)(skill1.skillId, not skill1 or true)
      ;
      (self._skill1Panel):SetActive(true)
      ;
      (self._skill1):Init(skill, skill1.unlock)
      ;
      (self._skill1Panel):SetActive(false)
      local skill2 = (self._showSkillList)[2]
      if not skill2.skillItemId then
        do
          local skill = (Skill.Create)(skill2.skillId, not skill2 or true)
          ;
          (self._skill2Panel):SetActive(true)
          ;
          (self._skill2):Init(skill, skill2.unlock)
          ;
          (self._skill2Panel):SetActive(false)
          local skill3 = (self._showSkillList)[3]
          if not skill3.skillItemId then
            do
              local skill = (Skill.Create)(skill3.skillId, not skill3 or true)
              ;
              (self._skill3Panel):SetActive(true)
              ;
              (self._skill3):Init(skill, skill3.unlock)
              ;
              (self._skill3Panel):SetActive(false)
            end
          end
        end
      end
    end
  end
end

RoleResetMainDialog.Ctor = function(self, ...)
  -- function num : 0_3 , upvalues : RoleResetMainDialog
  ((RoleResetMainDialog.super).Ctor)(self, ...)
  self._curSelectRoleId = 0
  self._itemList = {}
end

RoleResetMainDialog.OnCreate = function(self)
  -- function num : 0_4 , upvalues : TableFrame, _ENV, GridFrame
  self._backBtn = self:GetChild("BackBtn")
  self._menuBtn = self:GetChild("MenuBtn")
  self._title = self:GetChild("Title")
  self._topFrame = self:GetChild("TopGroup")
  self._currencyFrame = (TableFrame.Create)(self._topFrame, self, false, false, true)
  self._back = self:GetChild("Back")
  self._empty = self:GetChild("Back/TeamEditChangeNewCell/Empty")
  self._cell = self:GetChild("Back/TeamEditChangeNewCell/Cell")
  self._photo = self:GetChild("Back/TeamEditChangeNewCell/Cell/Photo")
  self._grey = self:GetChild("Back/TeamEditChangeNewCell/Cell/Grey")
  self._rankFrame = self:GetChild("Back/TeamEditChangeNewCell/Cell/Frame")
  self._rankBack = self:GetChild("Back/TeamEditChangeNewCell/Cell/RankBack")
  self._downRankBack = self:GetChild("Back/TeamEditChangeNewCell/Cell/DownRankBack")
  self._rank = self:GetChild("Back/TeamEditChangeNewCell/Cell/Rank")
  self._job = self:GetChild("Back/TeamEditChangeNewCell/Cell/Job")
  self._level = self:GetChild("Back/TeamEditChangeNewCell/Cell/Level/Num")
  self._maxLevel = self:GetChild("Back/TeamEditChangeNewCell/Cell/Level/MaxNum")
  self._breakLevelBackBlack = self:GetChild("Back/TeamEditChangeNewCell/Cell/BreakLevelBackBlack")
  self._breakLevelBack = self:GetChild("Back/TeamEditChangeNewCell/Cell/BreakLevelBack")
  self._breakLevel = self:GetChild("Back/TeamEditChangeNewCell/Cell/BreakLevelNum")
  self._txt = self:GetChild("Back/TeamEditChangeNewCell/Cell/Txt")
  self._cur = self:GetChild("Back/TeamEditChangeNewCell/Cell/Current")
  self._select = self:GetChild("Back/TeamEditChangeNewCell/Cell/Select")
  self._elementImg = self:GetChild("Back/TeamEditChangeNewCell/Cell/Element")
  self._charUpgrade = {panel = self:GetChild("Back/TeamEditChangeNewCell/Cell/CharUpgrade"), 
levelImage = {}
}
  for i = 1, 5 do
    -- DECOMPILER ERROR at PC119: Confused about usage of register: R5 in 'UnsetPending'

    ((self._charUpgrade).levelImage)[i] = self:GetChild("Back/TeamEditChangeNewCell/Cell/CharUpgrade/Img" .. i)
  end
  self._restartBtn = self:GetChild("Back/RestartBtn")
  self._resetBtn_Text = self:GetChild("Back/RestartBtn/_Text")
  ;
  (self._resetBtn_Text):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1732))
  self._consumptionTxt = self:GetChild("Back/UPCost")
  self._consumptionItemImg = self:GetChild("Back/UPCost/Line")
  self._consumptionNumTxt = self:GetChild("Back/UPCost/Num")
  ;
  (self._consumptionTxt):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1731))
  self._tipsBtn = self:GetChild("Tips")
  self._tipsName = self:GetChild("TipsText/TipsName")
  self._emptyTipsText = self:GetChild("TipsText")
  ;
  (self._tipsName):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1765))
  ;
  (self._emptyTipsText):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1766))
  self._detailsBack = self:GetChild("Frame")
  self._roleName = self:GetChild("Back/RoleName")
  ;
  (self._roleName):SetActive(false)
  self._titelTxt = self:GetChild("Frame/RoleRestartCell/Titel")
  ;
  (self._titelTxt):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1728))
  self._levelBack = {}
  -- DECOMPILER ERROR at PC230: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._levelBack)[1] = {breaklevelBack = self:GetChild("Frame/RoleRestartCell/BreakLevel/LevelBack1/BreakLevelBack"), breaklevelBackBlack = self:GetChild("Frame/RoleRestartCell/BreakLevel/LevelBack1/BreakLevelBackBlack"), breaklevelNum = self:GetChild("Frame/RoleRestartCell/BreakLevel/LevelBack1/BreakLevelNum")}
  -- DECOMPILER ERROR at PC245: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._levelBack)[2] = {breaklevelBack = self:GetChild("Frame/RoleRestartCell/BreakLevel/LevelBack2/BreakLevelBack"), breaklevelBackBlack = self:GetChild("Frame/RoleRestartCell/BreakLevel/LevelBack2/BreakLevelBackBlack"), breaklevelNum = self:GetChild("Frame/RoleRestartCell/BreakLevel/LevelBack2/BreakLevelNum")}
  ;
  (((self._levelBack)[2]).breaklevelBackBlack):SetActive(true)
  ;
  (((self._levelBack)[2]).breaklevelBack):SetActive(false)
  ;
  (((self._levelBack)[2]).breaklevelNum):SetActive(false)
  self._breakLevelText = self:GetChild("Frame/RoleRestartCell/BreakLevel")
  self._roleLevelTxt = self:GetChild("Frame/RoleRestartCell/RoleLevel")
  self._skillLevelTxt = self:GetChild("Frame/RoleRestartCell/SkillLevel")
  ;
  (self._breakLevelText):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1767))
  ;
  (self._roleLevelTxt):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1768))
  ;
  (self._skillLevelTxt):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1769))
  self._currentLevelTxt = self:GetChild("Frame/RoleRestartCell/RoleLevel/Lv/NowLeve")
  self._skill1Panel = self:GetChild("Frame/RoleRestartCell/SkillLevel/SkillBack1")
  self._skill1 = (DialogManager.CreateDialog)("skill.skillcell", (self._skill1Panel)._uiObject)
  self._skill2Panel = self:GetChild("Frame/RoleRestartCell/SkillLevel/SkillBack2")
  self._skill2 = (DialogManager.CreateDialog)("skill.skillcell", (self._skill2Panel)._uiObject)
  self._skill3Panel = self:GetChild("Frame/RoleRestartCell/SkillLevel/SkillBack3")
  self._skill3 = (DialogManager.CreateDialog)("skill.skillcell", (self._skill3Panel)._uiObject)
  ;
  ((self._skill1)._rootWindow):Subscribe_PointerClickEvent(self.OnSkill1Clicked, self)
  ;
  ((self._skill2)._rootWindow):Subscribe_PointerClickEvent(self.OnSkill2Clicked, self)
  ;
  ((self._skill3)._rootWindow):Subscribe_PointerClickEvent(self.OnSkill3Clicked, self)
  ;
  (self._tipsBtn):Subscribe_PointerClickEvent(self.OpenTips, self)
  self._tipsTxt = self:GetChild("Frame/RoleRestartCell/Tips")
  ;
  (self._tipsTxt):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1729))
  self._itemText = self:GetChild("Frame/RoleRestartCell/Item")
  ;
  (self._itemText):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1730))
  self._itemPanel = self:GetChild("Frame/RoleRestartCell/Item/Frame")
  self._itemFrame = (GridFrame.Create)(self._itemPanel, self, true, 5, true)
  self._width = (self._itemPanel):GetRectSize()
  ;
  (self:GetChild("Frame/RoleRestartCell/CharUpgrade")):SetText(((NekoData.BehaviorManager).BM_Message):GetString(2086))
  self._curRuneLevel = self:GetChild("Frame/RoleRestartCell/CharUpgrade/Lv/NowLeve")
  self._scrollBar = self:GetChild("Frame/RoleRestartCell/Item/Scrollbar")
  self._roleClick = self:GetChild("Back/RoleClick")
  self._effectPoint = self:GetChild("Back/Effect")
  self._backPay = self:GetChild("Back/TeamEditChangeNewCell/BackPay")
  self:InitCurrencyData()
  ;
  (self._restartBtn):Subscribe_PointerClickEvent(self.OnSendRestart, self)
  ;
  (self._roleClick):Subscribe_PointerClickEvent(self.OpenSelectDialog, self)
  ;
  (self._backBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self._menuBtn):Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRefreshCurrency, Common.n_RefreshCurrency, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnSRoleReset, Common.n_OnSRoleReset, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.Refresh, Common.n_RoleInfoChange, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.Refresh, Common.n_RefreshFashion, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.Refresh, Common.n_RefreshWitchSkills, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.Refresh, Common.n_ImproveSkill, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.Refresh, Common.n_UniqueEquipLevelUp, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnTipGuide, Common.n_GuideStatusChanged, nil)
end

RoleResetMainDialog.OnDestroy = function(self)
  -- function num : 0_5 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
  if self._currencyFrame then
    (self._currencyFrame):Destroy()
  end
  if self._itemFrame then
    (self._itemFrame):Destroy()
  end
  if self._handler then
    ((NekoData.BehaviorManager).BM_Game):DestroyGuideClickEffectDialog(self._handler)
    self._handler = nil
  end
  if (DialogManager.GetDialog)("bag.itemtipsdialog") then
    (DialogManager.DestroySingletonDialog)("bag.itemtipsdialog")
  end
  self:ReleaseEffect()
end

RoleResetMainDialog.InitCurrencyData = function(self)
  -- function num : 0_6 , upvalues : _ENV, Item
  self._currencyList = {}
  ;
  (table.insert)(self._currencyList, {CurrencyID = DataCommon.RoleResetCoin, CurrencyShowID = ((Item.Create)(DataCommon.RoleResetCoin)):GetIconId()})
  ;
  (self._currencyFrame):ReloadAllCell()
end

RoleResetMainDialog.RefreshCell = function(self)
  -- function num : 0_7
  self:Refresh()
end

RoleResetMainDialog.Refresh = function(self)
  -- function num : 0_8 , upvalues : Item, _ENV, CDollRemodeling, RefreshSkillPanel, ShowCharUpgrade
  (self._emptyTipsText):SetActive(self._curSelectRoleId == 0)
  ;
  (self._detailsBack):SetActive(self._curSelectRoleId ~= 0)
  ;
  (self._consumptionTxt):SetActive(self._curSelectRoleId ~= 0)
  ;
  (self._backPay):SetActive(self._curSelectRoleId ~= 0)
  ;
  (self._restartBtn):SetActive(self._curSelectRoleId ~= 0)
  ;
  (self._roleName):SetActive(self._curSelectRoleId ~= 0)
  if self._curSelectRoleId == 0 then
    (self._empty):SetActive(true)
    ;
    (self._cell):SetActive(false)
  else
    (self._empty):SetActive(false)
    ;
    (self._cell):SetActive(true)
    local item = (Item.Create)(DataCommon.RoleResetCoin)
    ;
    (self._consumptionItemImg):SetSprite(item:GetIconAB())
    self._role = ((NekoData.BehaviorManager).BM_AllRoles):GetRole(self._curSelectRoleId)
    ;
    (self._roleName):SetText((self._role):GetRoleName())
    self._record = CDollRemodeling:GetRecorder((self._role):GetBreakLv())
    ;
    (self._consumptionNumTxt):SetText((self._record).itemnum)
    local image = (self._role):GetSmallRarityBackRecord()
    image = (self._role):GetShapeLittleHeadImageRecord()
    ;
    (self._photo):SetSprite(image.assetBundle, image.assetName)
    ;
    (self._grey):SetActive(false)
    image = (self._role):GetSmallRarityFrameRecord()
    ;
    (self._rankFrame):SetSprite(image.assetBundle, image.assetName)
    if (self._role):GetIsLeader() then
      (self._rankBack):SetActive(false)
      ;
      (self._rank):SetActive(false)
    else
      (self._rankBack):SetActive(true)
      ;
      (self._rank):SetActive(true)
      image = (self._role):GetRarityImageRecord()
      ;
      (self._rank):SetSprite(image.assetBundle, image.assetName)
    end
    image = (self._role):GetRarityBottomBackRecord()
    ;
    (self._downRankBack):SetSprite(image.assetBundle, image.assetName)
    image = (self._role):GetVocationImageRecord()
    ;
    (self._job):SetSprite(image.assetBundle, image.assetName)
    ;
    (self._level):SetText((self._role):GetShowLv())
    ;
    (self._currentLevelTxt):SetText((self._role):GetShowLv())
    ;
    (self._maxLevel):SetText((self._role):GetShowMaxBreakLv())
    image = (self._role):GetElementImageRecord()
    ;
    (self._elementImg):SetSprite(image.assetBundle, image.assetName)
    local breakLv = (self._role):GetBreakLv()
    ;
    (self._breakLevelBackBlack):SetActive(breakLv == 0)
    ;
    (self._breakLevelBack):SetActive(breakLv > 0)
    ;
    (self._breakLevel):SetActive(breakLv > 0)
    ;
    (((self._levelBack)[1]).breaklevelBackBlack):SetActive(breakLv == 0)
    ;
    (((self._levelBack)[1]).breaklevelBack):SetActive(breakLv > 0)
    ;
    (((self._levelBack)[1]).breaklevelNum):SetActive(breakLv > 0)
    do
      do
        if breakLv > 0 then
          local imageRecord = (self._role):GetCurBreakFrame1ImageRecord()
          ;
          (self._breakLevelBack):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
          ;
          (self._breakLevel):SetText(breakLv)
          ;
          (((self._levelBack)[1]).breaklevelBack):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
          ;
          (((self._levelBack)[1]).breaklevelNum):SetText(breakLv)
        end
        RefreshSkillPanel(self)
        ShowCharUpgrade(self, (self._role):GetRuneLevel())
        ;
        (self._curRuneLevel):SetText((self._role):GetRuneLevel())
        -- DECOMPILER ERROR: 17 unprocessed JMP targets
      end
    end
  end
end

RoleResetMainDialog.InsertEmptyCellData = function(self)
  -- function num : 0_9 , upvalues : MinRowNum, ColumnsNum, _ENV
  local curNum = #self._itemList
  local onePageNum = MinRowNum * ColumnsNum
  if curNum <= onePageNum then
    for i = curNum + 1, onePageNum do
      local celldata = {}
      celldata.item = nil
      ;
      (table.insert)(self._itemList, celldata)
    end
    return 
  end
  local curRow = (math.ceil)(curNum / ColumnsNum)
  for i = curNum + 1, curRow * ColumnsNum do
    local celldata = {}
    celldata.item = nil
    ;
    (table.insert)(self._itemList, celldata)
  end
end

RoleResetMainDialog.NumberOfCell = function(self, frame)
  -- function num : 0_10
  if frame == self._itemFrame then
    return #self._itemList
  else
    return #self._currencyList
  end
end

RoleResetMainDialog.CellAtIndex = function(self, frame)
  -- function num : 0_11
  if frame == self._itemFrame then
    return "bag.rolereset.roleresetitemcell"
  else
    return "bag.bagcurrencycell"
  end
end

RoleResetMainDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_12
  if frame == self._itemFrame then
    return (self._itemList)[index]
  else
    return (self._currencyList)[index]
  end
end

RoleResetMainDialog.OnBackBtnClicked = function(self)
  -- function num : 0_13
  self:Destroy()
end

RoleResetMainDialog.OnMenuBtnClicked = function(self)
  -- function num : 0_14 , upvalues : _ENV
  (DialogManager.CreateSingletonDialog)("fastmenu.fastmenudialog")
end

RoleResetMainDialog.OnRefreshCurrency = function(self, notification)
  -- function num : 0_15
  (self._currencyFrame):ReloadAllCell()
end

RoleResetMainDialog.OpenSelectDialog = function(self)
  -- function num : 0_16 , upvalues : _ENV
  if self._effectHandler and self._effectHandler ~= 0 then
    (self._effectPoint):ReleaseEffect(self._effectHandler)
    self._effectHandler = 0
  end
  local dialog = (DialogManager.CreateSingletonDialog)("bag.rolereset.changeselectroledialog")
  dialog:Init({roleKey = self._curSelectRoleId})
end

RoleResetMainDialog.ItemAccountShow = function(self, data)
  -- function num : 0_17 , upvalues : _ENV
  ((NekoData.DataManager).DM_ItemAccountShow):AddShowDialogData(data)
end

RoleResetMainDialog.OnSRoleReset = function(self, notification)
  -- function num : 0_18 , upvalues : _ENV, Item, tempFun
  local data = notification.userInfo
  if data == nil then
    self._curSelectRoleId = 0
  else
    if data.isPreview == 1 then
      local data = {items = data.itemList}
      do
        if data.items and #data.items > 0 then
          self._task = (ServerGameTimer.AddTask)(1, -1, function()
    -- function num : 0_18_0 , upvalues : self, _ENV, data
    self:ItemAccountShow({tag = (DataCommon.ShowDialogType).ItemAccount, data = data})
  end
, nil)
        end
        self:PlayEffect()
        self._curSelectRoleId = 0
      end
    else
      do
        while 1 do
          if data.isPreview == 0 then
            if (self._itemList)[#self._itemList] then
              (table.remove)(self._itemList, #self._itemList)
              -- DECOMPILER ERROR at PC46: LeaveBlock: unexpected jumping out IF_THEN_STMT

              -- DECOMPILER ERROR at PC46: LeaveBlock: unexpected jumping out IF_STMT

              -- DECOMPILER ERROR at PC46: LeaveBlock: unexpected jumping out IF_THEN_STMT

              -- DECOMPILER ERROR at PC46: LeaveBlock: unexpected jumping out IF_STMT

            end
          end
        end
        do
          local tempItemList = {}
          for _,itemInfo in pairs(data.itemList) do
            local item = (Item.Create)(itemInfo.id)
            item:InitWithItemInfo(itemInfo)
            ;
            (table.insert)(tempItemList, item)
          end
          ;
          (table.sort)(tempItemList, function(a, b)
    -- function num : 0_18_1 , upvalues : tempFun
    return tempFun(a, b)
  end
)
          for i,v in ipairs(tempItemList) do
            (table.insert)(self._itemList, v)
          end
          self._curSelectRoleId = data.roleId
          ;
          (self._itemFrame):ReloadAllCell()
          self:Refresh()
        end
      end
    end
  end
end

RoleResetMainDialog.OnSendRestart = function(self)
  -- function num : 0_19 , upvalues : _ENV
  if (self._role):GetRoleId() == (((NekoData.BehaviorManager).BM_Friends):GetSupportRole()):GetRoleId() then
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100466)
    return 
  end
  if self._record then
    if (self._record).itemnum <= ((NekoData.BehaviorManager).BM_Currency):GetCurrencyNum((self._record).itemID) then
      ((NekoData.BehaviorManager).BM_Message):AddSecondConfirmDialog(133, {(self._role):GetRoleName()}, function()
    -- function num : 0_19_0 , upvalues : _ENV, self
    local csend = (LuaNetManager.CreateProtocol)("protocol.login.rolereset.crolereset")
    csend.roleId = (self._role):GetRoleId()
    csend.isPreview = 1
    csend:Send()
  end
, {}, nil, {})
    else
      ;
      ((NekoData.BehaviorManager).BM_Message):SendMessageById(100457)
    end
  else
    LogErrorFormat("RoleResetMainDialog", "No Exist %s", (self._role):GetBreakLv())
  end
end

RoleResetMainDialog.OnSkill1Clicked = function(self)
  -- function num : 0_20 , upvalues : _ENV, Skill
  if not ((self._showSkillList)[1]).unlock then
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100315)
  else
    local skillItemId = (self._roleConfigRecord).contractskillid
    local skill = (Skill.Create)(skillItemId)
    ;
    ((DialogManager.CreateSingletonDialog)("skill.skilltipsdialog")):SetSkillAndRoleId(skill:GetSkillId(), skillItemId, (self._role):GetRoleId())
  end
end

RoleResetMainDialog.OnSkill2Clicked = function(self)
  -- function num : 0_21 , upvalues : _ENV, Skill
  if not ((self._showSkillList)[2]).unlock then
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100315)
  else
    local skillItemId = (self._roleConfigRecord).contractskillid2
    local skill = (Skill.Create)(skillItemId)
    ;
    ((DialogManager.CreateSingletonDialog)("skill.skilltipsdialog")):SetSkillAndRoleId(skill:GetSkillId(), skillItemId, (self._role):GetRoleId())
  end
end

RoleResetMainDialog.OnSkill3Clicked = function(self)
  -- function num : 0_22 , upvalues : _ENV
  ((NekoData.BehaviorManager).BM_Message):SendMessageById(100315)
end

RoleResetMainDialog.OnSkillUnlock = function(self)
  -- function num : 0_23 , upvalues : RefreshSkillPanel
  RefreshSkillPanel(self)
end

RoleResetMainDialog.OpenTips = function(self)
  -- function num : 0_24 , upvalues : _ENV, CStringres
  if self._handler then
    ((NekoData.BehaviorManager).BM_Game):DestroyGuideClickEffectDialog(self._handler)
  end
  ;
  ((DialogManager.CreateSingletonDialog)("bag.rolereset.tipsdialog")):SetData((CStringres:GetRecorder(1727)).msgTextID)
end

RoleResetMainDialog.OnTipGuide = function(self, notification)
  -- function num : 0_25 , upvalues : _ENV
  if self._handler then
    ((NekoData.BehaviorManager).BM_Game):DestroyGuideClickEffectDialog(self._handler)
    self._handler = nil
  end
  local guideId = (notification.userInfo).guideID
  if guideId == 65 and (notification.userInfo).guideStatus == "Finish" then
    self._handler = ((NekoData.BehaviorManager).BM_Game):CreateGuideClickEffectDialog(self._tipsBtn, 1058)
  end
end

RoleResetMainDialog.PlayEffect = function(self)
  -- function num : 0_26 , upvalues : _ENV
  if self._effectHandler and self._effectHandler ~= 0 then
    (self._effectPoint):ReleaseEffect(self._effectHandler)
    self._effectHandler = 0
  end
  self._effectHandler = (self._effectPoint):AddEffectSync((EffectUtil.GetAssetBundleNameAndAssetName)(1160))
end

RoleResetMainDialog.ReleaseEffect = function(self)
  -- function num : 0_27
  if self._effectHandler and self._effectHandler ~= 0 then
    (self._effectPoint):ReleaseEffect(self._effectHandler)
    self._effectHandler = 0
  end
end

RoleResetMainDialog.OnCurPosChange = function(self, frame, proportion)
  -- function num : 0_28
  if frame == self._itemFrame then
    local total = (self._itemFrame):GetTotalLength()
    if self._height < total then
      (self._scrollBar):SetActive(true)
      ;
      (self._scrollBar):SetScrollSize(self._height / total)
      ;
      (self._scrollBar):SetScrollValue(proportion)
    else
      ;
      (self._scrollBar):SetActive(false)
    end
  end
end

return RoleResetMainDialog

