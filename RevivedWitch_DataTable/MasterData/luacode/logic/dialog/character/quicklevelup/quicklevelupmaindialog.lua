-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/character/quicklevelup/quicklevelupmaindialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local AttrTypeEnum = (LuaNetManager.GetBeanDef)("protocol.login.attrtype")
local CAttrNameTable = (BeanManager.GetTableByName)("role.cattreffectidname")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CRoleLevelCfgTable = (BeanManager.GetTableByName)("role.crolelevelcfg")
local CPlayerLevel = (BeanManager.GetTableByName)("role.cplayerlevel")
local Item = require("logic.manager.experimental.types.item")
local TableFrame = require("framework.ui.frame.table.tableframe")
local Num = 3
local QuickLevelUpMainDialog = class("QuickLevelUpMainDialog", Dialog)
QuickLevelUpMainDialog.AssetBundleName = "ui/layouts.basecharacterinfo"
QuickLevelUpMainDialog.AssetName = "CharFastLevelUp"
QuickLevelUpMainDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : QuickLevelUpMainDialog, _ENV, CPlayerLevel
  ((QuickLevelUpMainDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
  self._role = nil
  self._curLv = nil
  self._nextLv = nil
  self._availableMinLv = nil
  self._availableMaxLv = nil
  self._costManaAndBreakMaterialsList = {}
  local userLevel = (((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()).userlevel
  if userLevel < DataCommon.MaxPlayerLevel then
    self._maxLevel = (CPlayerLevel:GetRecorder(userLevel)).roleMaxLv
  else
    local allIds = CPlayerLevel:GetAllIds()
    self._maxLevel = (CPlayerLevel:GetRecorder(allIds[#allIds])).roleMaxLv
  end
  do
    self._mana = ((NekoData.BehaviorManager).BM_Currency):GetCurrencyNum(DataCommon.ManaID)
  end
end

QuickLevelUpMainDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame, _ENV, CImagePathTable
  self._cur_lv = self:GetChild("LevelBack1/LevelNum")
  self._cur_breakLevelBackBlack = self:GetChild("LevelBack1/BreakLevelBackBlack")
  self._cur_breakLvBack = self:GetChild("LevelBack1/BreakLevelBack")
  self._cur_breakLv = self:GetChild("LevelBack1/BreakLevelNum")
  self._cur_prop_health_value = self:GetChild("Property/Health/Num")
  self._cur_prop_phyAtk_value = self:GetChild("Property/PhyAtk/Num")
  self._cur_prop_phyDef_value = self:GetChild("Property/PhyDef/Num")
  self._cur_prop_magDef_value = self:GetChild("Property/MagDef/Num")
  self._next_lv = self:GetChild("LevelBack2/LevelNum")
  self._next_breakLevelBackBlack = self:GetChild("LevelBack2/BreakLevelBackBlack")
  self._next_breakLvBack = self:GetChild("LevelBack2/BreakLevelBack")
  self._next_breakLv = self:GetChild("LevelBack2/BreakLevelNum")
  self._next_prop_health_value = self:GetChild("Property/Health/Num2")
  self._next_prop_phyAtk_value = self:GetChild("Property/PhyAtk/Num2")
  self._next_prop_phyDef_value = self:GetChild("Property/PhyDef/Num2")
  self._next_prop_magDef_value = self:GetChild("Property/MagDef/Num2")
  self._prop_health_icon = self:GetChild("Property/Health/Image")
  self._prop_health_name = self:GetChild("Property/Health/Name")
  self._prop_phyAtk_icon = self:GetChild("Property/PhyAtk/Image")
  self._prop_phyAtk_name = self:GetChild("Property/PhyAtk/Name")
  self._prop_phyDef_icon = self:GetChild("Property/PhyDef/Image")
  self._prop_phyDef_name = self:GetChild("Property/PhyDef/Name")
  self._prop_magDef_icon = self:GetChild("Property/MagDef/Image")
  self._prop_magDef_name = self:GetChild("Property/MagDef/Name")
  self._cost_breakMaterial_panel = self:GetChild("Frame")
  self._cost_breakMaterial_frame = (TableFrame.Create)(self._cost_breakMaterial_panel, self, false, false)
  self._cost_breakMaterial_frame_width = (self._cost_breakMaterial_panel):GetRectSize()
  self._cost_breakMaterial_frame_anchoredx = (self._cost_breakMaterial_panel):GetAnchoredPosition()
  self._op_reduceBtn = self:GetChild("Num/Reduce")
  self._op_addBtn = self:GetChild("Num/Add")
  self._op_minBtn = self:GetChild("Num/MinBtn")
  self._op_maxBtn = self:GetChild("Num/MaxBtn")
  self._op_scrollbar = self:GetChild("Num/HandleScrollbar")
  self._quickLvUpBtn = self:GetChild("UpBtn")
  self._closeBtn = self:GetChild("Tips/CloseBtn")
  ;
  (self._op_reduceBtn):Subscribe_PointerClickEvent(function()
    -- function num : 0_1_0 , upvalues : self
    self:OnNumBtnClicked(-1)
  end
)
  ;
  (self._op_addBtn):Subscribe_PointerClickEvent(function()
    -- function num : 0_1_1 , upvalues : self
    self:OnNumBtnClicked(1)
  end
)
  ;
  (self._op_minBtn):Subscribe_PointerClickEvent(function()
    -- function num : 0_1_2 , upvalues : self
    self:OnMinOrMaxBtnClicked(-1)
  end
)
  ;
  (self._op_maxBtn):Subscribe_PointerClickEvent(function()
    -- function num : 0_1_3 , upvalues : self
    self:OnMinOrMaxBtnClicked(1)
  end
)
  ;
  (self._op_scrollbar):Subscribe_ValueChangedEvent(self.OnScrollbarValueChange, self)
  ;
  (self._quickLvUpBtn):Subscribe_PointerClickEvent(self.OnQuickLvUpBtnClicked, self)
  ;
  (self._closeBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRoleInfoChange, Common.n_RoleInfoChange, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRefresh, Common.n_RefreshCurrency, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRefresh, Common.n_ItemAdd, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRefresh, Common.n_ItemRemove, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRefresh, Common.n_ItemNumModify, nil)
  ;
  (self:GetChild("Tips/Text")):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1770))
  ;
  (self:GetChild("text")):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1731))
  if not CImagePathTable:GetRecorder(14211) then
    local imageRecord = DataCommon.DefaultImageAsset
  end
  ;
  (self._cur_breakLvBack):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  ;
  (self._next_breakLvBack):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
end

QuickLevelUpMainDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (self._cost_breakMaterial_frame):Destroy()
  ;
  (DialogManager.DestroySingletonDialog)("character.quicklevelup.quicklevelupconfirmdialog")
end

QuickLevelUpMainDialog.OnRefresh = function(self)
  -- function num : 0_3 , upvalues : _ENV
  self._curExp = (self._role):GetExp()
  self._breakLv = (self._role):GetBreakLv()
  self._curLv = (self._role):GetLevel()
  self:RefreshCurInfo()
  local availableMinLv = self._availableMinLv
  local availableMaxLv = self._availableMaxLv
  self:CaculateLvUpLimit()
  if self._nextLv == availableMinLv or self._nextLv < self._availableMinLv then
    self._nextLv = self._availableMinLv
  else
    if availableMaxLv <= self._nextLv or self._availableMaxLv < self._nextLv then
      self._nextLv = self._availableMaxLv
    end
  end
  local nextBreakLv, nextShowLv = (self._role):GetBreakLvAndShowLvByRoleLv(self._nextLv)
  local maxBreakLv, maxShowLv = (self._role):GetBreakLvAndShowLvByRoleLv(self._availableMaxLv)
  LogInfoFormat("QuickLevelUpMainDialog", "--- curLv = %s, nextLv = %s, availableMinLv = %s, availableMaxLv = %s, nextBreakLv = %s, nextShowLv = %s, maxBreakLv = %s, maxShowLv = %s ---", self._curLv, self._nextLv, self._availableMinLv, self._availableMaxLv, nextBreakLv, nextShowLv, maxBreakLv, maxShowLv)
  self:RefreshNextInfo()
  local dialog = (DialogManager.GetDialog)("character.quicklevelup.quicklevelupconfirmdialog")
  if dialog then
    self:OnQuickLvUpBtnClicked()
  end
end

QuickLevelUpMainDialog.OnRoleInfoChange = function(self, notification)
  -- function num : 0_4
  if notification and notification.userInfo then
    local roleId = (notification.userInfo).key
    local name = (notification.userInfo).name
    if roleId == (self._role):GetRoleId() and (name == "sroleupdatelv" or name == "sroleupdatebreaklv") then
      self:OnRefresh()
    end
  end
end

QuickLevelUpMainDialog.RefreshCurInfo = function(self)
  -- function num : 0_5 , upvalues : CAttrNameTable, AttrTypeEnum, CImagePathTable, _ENV
  (self._cur_lv):SetText((self._role):GetShowLv())
  local breakLv = (self._role):GetBreakLv()
  ;
  (self._cur_breakLevelBackBlack):SetActive(breakLv == 0)
  ;
  (self._cur_breakLvBack):SetActive(breakLv > 0)
  ;
  (self._cur_breakLv):SetActive(breakLv > 0)
  if breakLv > 0 then
    (self._cur_breakLv):SetText(breakLv)
  end
  local properties = (self._role):GetCurLvBasePro()
  local record = CAttrNameTable:GetRecorder(AttrTypeEnum.MAX_HP)
  if not CImagePathTable:GetRecorder(record.classIcon) then
    local imageRecord = DataCommon.DefaultImageAsset
  end
  ;
  (self._prop_health_icon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  ;
  (self._prop_health_name):SetText((TextManager.GetText)(record.classnameTextID))
  ;
  (self._cur_prop_health_value):SetText(tostring(properties[AttrTypeEnum.MAX_HP]))
  if (self._role):GetDamageType() == 1 then
    record = CAttrNameTable:GetRecorder(AttrTypeEnum.ATTACK)
  else
    record = CAttrNameTable:GetRecorder(AttrTypeEnum.MAGIC_ATTACK)
  end
  if not CImagePathTable:GetRecorder(record.classIcon) then
    imageRecord = DataCommon.DefaultImageAsset
  end
  ;
  (self._prop_phyAtk_icon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  ;
  (self._prop_phyAtk_name):SetText((TextManager.GetText)(record.classnameTextID))
  ;
  (self._cur_prop_phyAtk_value):SetText(tostring(properties[AttrTypeEnum.ATTACK]))
  record = CAttrNameTable:GetRecorder(AttrTypeEnum.DEFEND)
  if not CImagePathTable:GetRecorder(record.classIcon) then
    imageRecord = DataCommon.DefaultImageAsset
  end
  ;
  (self._prop_phyDef_icon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  ;
  (self._prop_phyDef_name):SetText((TextManager.GetText)(record.classnameTextID))
  ;
  (self._cur_prop_phyDef_value):SetText(tostring(properties[AttrTypeEnum.DEFEND]))
  record = CAttrNameTable:GetRecorder(AttrTypeEnum.MAGIC_DEFEND)
  if not CImagePathTable:GetRecorder(record.classIcon) then
    imageRecord = DataCommon.DefaultImageAsset
  end
  ;
  (self._prop_magDef_icon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  ;
  (self._prop_magDef_name):SetText((TextManager.GetText)(record.classnameTextID))
  ;
  (self._cur_prop_magDef_value):SetText(tostring(properties[AttrTypeEnum.MAGIC_DEFEND]))
  -- DECOMPILER ERROR: 10 unprocessed JMP targets
end

QuickLevelUpMainDialog.RefreshNextInfo = function(self)
  -- function num : 0_6 , upvalues : AttrTypeEnum, _ENV, Num
  local breakLv, showLv = (self._role):GetBreakLvAndShowLvByRoleLv(self._nextLv)
  ;
  (self._next_lv):SetText(showLv)
  ;
  (self._next_breakLevelBackBlack):SetActive(breakLv == 0)
  ;
  (self._next_breakLvBack):SetActive(breakLv > 0)
  ;
  (self._next_breakLv):SetActive(breakLv > 0)
  if breakLv > 0 then
    (self._next_breakLv):SetText(breakLv)
  end
  local roleConfigRecord = (self._role):GetRoleConfig()
  local multiple = 0
  for i = 1, breakLv do
    multiple = multiple + (roleConfigRecord.breakMultiple)[i]
  end
  local addPercent = (self._baseProAddPercent)[AttrTypeEnum.MAX_HP] or 0
  local value = (roleConfigRecord.hp + (self._evolutionAddProperties)[AttrTypeEnum.MAX_HP] + roleConfigRecord.addhp * self._nextLv + roleConfigRecord.breakaddhp * (multiple)) * (1000 + addPercent) / 1000
  ;
  (self._next_prop_health_value):SetText((math.floor)(value))
  addPercent = (self._baseProAddPercent)[AttrTypeEnum.ATTACK] or 0
  local value = (roleConfigRecord.attack + (self._evolutionAddProperties)[AttrTypeEnum.ATTACK] + roleConfigRecord.addattack * self._nextLv + roleConfigRecord.breakaddattack * (multiple)) * (1000 + (addPercent)) / 1000
  ;
  (self._next_prop_phyAtk_value):SetText((math.floor)(value))
  addPercent = (self._baseProAddPercent)[AttrTypeEnum.DEFEND] or 0
  local value = (roleConfigRecord.def + (self._evolutionAddProperties)[AttrTypeEnum.DEFEND] + roleConfigRecord.adddef * self._nextLv + roleConfigRecord.breakadddef * (multiple)) * (1000 + (addPercent)) / 1000
  ;
  (self._next_prop_phyDef_value):SetText((math.floor)(value))
  addPercent = (self._baseProAddPercent)[AttrTypeEnum.MAGIC_DEFEND] or 0
  local value = (roleConfigRecord.magicDef + (self._evolutionAddProperties)[AttrTypeEnum.MAGIC_DEFEND] + roleConfigRecord.addmagicDef * self._nextLv + roleConfigRecord.breakaddmagicDef * (multiple)) * (1000 + (addPercent)) / 1000
  ;
  (self._next_prop_magDef_value):SetText((math.floor)(value))
  local costData = (self._costManaAndBreakMaterialsList)[self._nextLv - self._availableMinLv + 1]
  local cellPanelWidth = self._cost_breakMaterial_frame_width / Num * #costData.breakMaterials
  ;
  (self._cost_breakMaterial_panel):SetSize(0, cellPanelWidth, 0, self._cost_breakMaterial_frame_height)
  ;
  (self._cost_breakMaterial_panel):SetAnchoredPosition(self._cost_breakMaterial_frame_anchoredx, self._cost_breakMaterial_frame_anchoredy)
  ;
  (self._cost_breakMaterial_frame):ReloadAllCell()
  self:RefreshScrollBar()
  -- DECOMPILER ERROR: 8 unprocessed JMP targets
end

QuickLevelUpMainDialog.RefreshScrollBar = function(self)
  -- function num : 0_7 , upvalues : _ENV
  local value1 = self._nextLv - self._availableMinLv + 1
  local value2 = self._availableMaxLv - self._availableMinLv + 1
  if value1 == value2 then
    (self._op_scrollbar):SetScrollValue(1)
  else
    if value2 ~= 0 then
      (self._op_scrollbar):SetScrollValue(value1 / value2)
    else
      LogErrorFormat("QuickLevelUpMainDialog", "nextLv = %s, availableMinLv = %s, availableMaxLv = %s, value1 = %s, value2 = %s", self._nextLv, self._availableMinLv, self._availableMaxLv, value1, value2)
    end
  end
end

QuickLevelUpMainDialog.SetRoleId = function(self, roleId)
  -- function num : 0_8 , upvalues : _ENV, CAttrNameTable, AttrTypeEnum
  self._role = ((NekoData.BehaviorManager).BM_AllRoles):GetRole(roleId)
  self._rarityId = (self._role):GetRarityId()
  self._curExp = (self._role):GetExp()
  self._breakLv = (self._role):GetBreakLv()
  self._allBreakRecords = (self._role):GetBreakRecords()
  self._baseProAddPercent = (self._role):GetBaseProAddPercent()
  local str = ""
  for k,v in pairs(self._baseProAddPercent) do
    local record = CAttrNameTable:GetRecorder(k)
    str = str .. "{attrName: " .. (TextManager.GetText)(record.classnameTextID) .. ", attrKey: " .. k .. ", addPercent: " .. v .. "},"
  end
  LogInfoFormat("QuickLevelUpMainDialog", "%s", str)
  local evolution = (self._role):GetEvolution()
  local evolutionLevelRecords = (self._role):GetEvolutionLevelRecords()
  self._evolutionAddProperties = {[AttrTypeEnum.MAX_HP] = 0, [AttrTypeEnum.ATTACK] = 0, [AttrTypeEnum.DEFEND] = 0, [AttrTypeEnum.MAGIC_DEFEND] = 0}
  for i = 1, evolution do
    local evolutionRecord = evolutionLevelRecords[i]
    -- DECOMPILER ERROR at PC91: Confused about usage of register: R10 in 'UnsetPending'

    if (self._evolutionAddProperties)[evolutionRecord.addProperty - 1] then
      (self._evolutionAddProperties)[evolutionRecord.addProperty - 1] = (self._evolutionAddProperties)[evolutionRecord.addProperty - 1] + evolutionRecord.addPropertyValue
    end
  end
  self._curLv = (self._role):GetLevel()
  self:RefreshCurInfo()
  self:CaculateLvUpLimit()
  self._nextLv = self._availableMinLv
  local nextBreakLv, nextShowLv = (self._role):GetBreakLvAndShowLvByRoleLv(self._nextLv)
  local maxBreakLv, maxShowLv = (self._role):GetBreakLvAndShowLvByRoleLv(self._availableMaxLv)
  LogInfoFormat("QuickLevelUpMainDialog", "--- curLv = %s, nextLv = %s, availableMinLv = %s, availableMaxLv = %s, nextBreakLv = %s, nextShowLv = %s, maxBreakLv = %s, maxShowLv = %s ---", self._curLv, self._nextLv, self._availableMinLv, self._availableMaxLv, nextBreakLv, nextShowLv, maxBreakLv, maxShowLv)
  self:RefreshNextInfo()
end

QuickLevelUpMainDialog.GetCostManaByLv = function(self, lv)
  -- function num : 0_9 , upvalues : CRoleLevelCfgTable
  local roleLevelRecord = CRoleLevelCfgTable:GetRecorder(lv)
  if self._rarityId == 1 then
    return roleLevelRecord.Rexp
  end
  if self._rarityId == 2 then
    return roleLevelRecord.SRexp
  end
  if self._rarityId == 3 then
    return roleLevelRecord.SSRexp
  end
  if self._rarityId == 4 then
    return roleLevelRecord.URexp
  end
  if self._rarityId == 5 then
    return roleLevelRecord.EXexp
  end
end

QuickLevelUpMainDialog.CaculateLvUpLimit = function(self)
  -- function num : 0_10 , upvalues : _ENV, CRoleLevelCfgTable, Item
  while (self._costManaAndBreakMaterialsList)[#self._costManaAndBreakMaterialsList] do
    (table.remove)(self._costManaAndBreakMaterialsList, #self._costManaAndBreakMaterialsList)
  end
  self._availableMinLv = self._curLv
  self._availableMaxLv = self._curLv
  local maxExp = self:GetCostManaByLv(self._curLv)
  local needMana = maxExp - self._curExp
  local levelStart = self._curLv + 1
  local levelEnd = 0
  local breakRecord = (self._allBreakRecords)[self._breakLv]
  local nextBreakMinLevel = breakRecord.levelmax + 1
  if self._breakLv < (self._role):GetMaxBreakLv() and nextBreakMinLevel < self._maxLevel then
    levelEnd = nextBreakMinLevel
  else
    local maxLevelIgnorePlayerLv = (self._role):GetMaxLevelIgnorePlayerLv()
    if self._maxLevel < maxLevelIgnorePlayerLv then
      levelEnd = self._maxLevel
    else
      levelEnd = maxLevelIgnorePlayerLv
    end
  end
  do
    for i = levelStart, levelEnd do
      local record = (CRoleLevelCfgTable:GetRecorder(i))
      local data = nil
      local temp = (self._costManaAndBreakMaterialsList)[#self._costManaAndBreakMaterialsList]
      if not temp then
        data = {mana = 0, 
breakMaterials = {}
}
      else
        data = clone(temp)
      end
      if record.clientBreakLevel == self._breakLv then
        local mana = nil
        if i == levelStart then
          mana = needMana
        else
          mana = data.mana + self:GetCostManaByLv(i - 1)
        end
        if mana <= self._mana then
          data.mana = mana
        else
          if i == levelStart then
            self._availableMaxLv = i - 1
            do break end
            do
              local manaInfo = (data.breakMaterials)[1]
              if data.mana > 0 then
                if not manaInfo or (manaInfo.item):GetID() ~= DataCommon.ManaID then
                  (table.insert)(data.breakMaterials, 1, {item = (Item.Create)(DataCommon.ManaID), num = data.mana})
                else
                  manaInfo.num = data.mana
                end
              end
              local breakRecord = (self._allBreakRecords)[record.clientBreakLevel - 1]
              local mana = data.mana + breakRecord.goldcost
              if mana <= self._mana then
                data.mana = mana
              else
                self._availableMaxLv = i - 1
                break
              end
              local tag = false
              local list = {}
              for i,v in ipairs(breakRecord.itemId) do
                if v ~= 0 then
                  local num = (breakRecord.itemNum)[i]
                  if num <= ((NekoData.BehaviorManager).BM_BagInfo):GetItemCountById(v) then
                    local item = (Item.Create)(v)
                    ;
                    (table.insert)(list, {item = item, num = num})
                  else
                    do
                      do
                        tag = true
                        do break end
                        -- DECOMPILER ERROR at PC176: LeaveBlock: unexpected jumping out DO_STMT

                        -- DECOMPILER ERROR at PC176: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                        -- DECOMPILER ERROR at PC176: LeaveBlock: unexpected jumping out IF_STMT

                        -- DECOMPILER ERROR at PC176: LeaveBlock: unexpected jumping out IF_THEN_STMT

                        -- DECOMPILER ERROR at PC176: LeaveBlock: unexpected jumping out IF_STMT

                      end
                    end
                  end
                end
              end
              if not tag then
                for _,value in ipairs(list) do
                  (table.insert)(data.breakMaterials, value)
                end
              else
                do
                  self._availableMaxLv = i - 1
                  do break end
                  do
                    do
                      local manaInfo = (data.breakMaterials)[1]
                      if data.mana > 0 then
                        if not manaInfo or (manaInfo.item):GetID() ~= DataCommon.ManaID then
                          (table.insert)(data.breakMaterials, 1, {item = (Item.Create)(DataCommon.ManaID), num = data.mana})
                        else
                          manaInfo.num = data.mana
                        end
                      end
                      ;
                      (table.insert)(self._costManaAndBreakMaterialsList, data)
                      if i == levelStart then
                        self._availableMinLv = levelStart
                      end
                      if i == levelEnd then
                        self._availableMaxLv = levelEnd
                      end
                      -- DECOMPILER ERROR at PC236: LeaveBlock: unexpected jumping out DO_STMT

                      -- DECOMPILER ERROR at PC236: LeaveBlock: unexpected jumping out DO_STMT

                      -- DECOMPILER ERROR at PC236: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                      -- DECOMPILER ERROR at PC236: LeaveBlock: unexpected jumping out IF_STMT

                      -- DECOMPILER ERROR at PC236: LeaveBlock: unexpected jumping out DO_STMT

                      -- DECOMPILER ERROR at PC236: LeaveBlock: unexpected jumping out IF_THEN_STMT

                      -- DECOMPILER ERROR at PC236: LeaveBlock: unexpected jumping out IF_STMT

                      -- DECOMPILER ERROR at PC236: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                      -- DECOMPILER ERROR at PC236: LeaveBlock: unexpected jumping out IF_STMT

                      -- DECOMPILER ERROR at PC236: LeaveBlock: unexpected jumping out IF_THEN_STMT

                      -- DECOMPILER ERROR at PC236: LeaveBlock: unexpected jumping out IF_STMT

                    end
                  end
                end
              end
            end
          end
        end
      end
    end
    if self._availableMaxLv <= self._curLv then
      LogInfo("条件不足，不能升至下一等级！")
    end
  end
end

QuickLevelUpMainDialog.OnNumBtnClicked = function(self, step)
  -- function num : 0_11
  local value = self._nextLv + step
  if value >= self._availableMinLv or self._availableMaxLv < value then
    self._nextLv = value
    self:RefreshNextInfo()
  end
end

QuickLevelUpMainDialog.OnMinOrMaxBtnClicked = function(self, tag)
  -- function num : 0_12
  local value = nil
  if tag == -1 then
    value = self._availableMinLv
  else
    value = self._availableMaxLv
  end
  if value ~= self._nextLv then
    self._nextLv = value
    self:RefreshNextInfo()
  end
end

QuickLevelUpMainDialog.OnScrollbarValueChange = function(self, value, window)
  -- function num : 0_13 , upvalues : _ENV
  local len = self._availableMaxLv - self._availableMinLv + 1
  local value1 = (math.floor)(value * len + 0.5) + self._curLv
  if value1 < self._availableMinLv then
    value1 = self._availableMinLv
  end
  if value1 ~= self._nextLv then
    self._nextLv = value1
    self:RefreshNextInfo()
  else
    if value1 == self._availableMinLv then
      self:RefreshScrollBar()
    end
  end
end

QuickLevelUpMainDialog.OnQuickLvUpBtnClicked = function(self)
  -- function num : 0_14 , upvalues : _ENV
  local costData = (self._costManaAndBreakMaterialsList)[self._nextLv - self._availableMinLv + 1]
  ;
  ((DialogManager.CreateSingletonDialog)("character.quicklevelup.quicklevelupconfirmdialog")):SetData(self._role, self._curLv, self._nextLv, costData)
end

QuickLevelUpMainDialog.NumberOfCell = function(self)
  -- function num : 0_15
  local costData = (self._costManaAndBreakMaterialsList)[self._nextLv - self._availableMinLv + 1]
  if costData then
    return #costData.breakMaterials
  else
    return 0
  end
end

QuickLevelUpMainDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_16
  return "character.quicklevelup.costbreakmaterialitemcell"
end

QuickLevelUpMainDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_17
  local costData = (self._costManaAndBreakMaterialsList)[self._nextLv - self._availableMinLv + 1]
  if costData then
    return (costData.breakMaterials)[index]
  end
end

QuickLevelUpMainDialog.OnBackBtnClicked = function(self)
  -- function num : 0_18
  self:Destroy()
end

return QuickLevelUpMainDialog

