local GridFrame = require("framework.ui.frame.grid.gridframe")
local TableFrame = require("framework.ui.frame.table.tableframe")
local Item = require("logic.manager.experimental.types.item")
local ItemTypeEnum = LuaNetManager.GetBeanDef("protocol.item.beans.item")
local Skill = require("logic.manager.experimental.types.skill")
local Role = require("logic.manager.experimental.types.role")
local CDollRemodeling = BeanManager.GetTableByName("role.cdollremodeling")
local CStringres = BeanManager.GetTableByName("message.cstringres")
local RoleResetMainDialog = class("RoleResetMainDialog", Dialog)
RoleResetMainDialog.AssetBundleName = "ui/layouts.bag"
RoleResetMainDialog.AssetName = "RoleRestartMain"
local ColumnsNum = 8
local MinRowNum = 4

local function ShowCharUpgrade(self, level)
  self._charUpgrade.panel:SetActive(level ~= 0)
  for i = 1, 5 do
    self._charUpgrade.levelImage[i]:SetActive(level == i)
  end
end

local function tempFun(a, b)
  if a:GetPinJiID() > b:GetPinJiID() then
    return true
  elseif a:GetPinJiID() == b:GetPinJiID() and a:GetID() < b:GetID() then
    return true
  end
  return false
end

local function RefreshSkillPanel(self)
  local role = Role.Create(self._curSelectRoleId)
  self._roleConfigRecord = role:GetRoleConfig()
  self._showSkillList = {}
  for i = 1, 3 do
    if i == 1 then
      local skillItemId = self._roleConfigRecord.contractskillid
      local skill = Skill.Create(skillItemId)
      table.insert(self._showSkillList, {
        skillId = skill:GetSkillId(),
        skillItemId = skillItemId,
        unlock = true
      })
    elseif i == 2 then
      local skillItemId = self._roleConfigRecord.contractskillid2
      local skill = Skill.Create(skillItemId)
      local unlock = false
      if self._role:GetRoleId() == 16 then
        unlock = self._role:GetShowSkillDataByIndex(2).unlock
      end
      table.insert(self._showSkillList, {
        skillId = skill:GetSkillId(),
        skillItemId = skillItemId,
        unlock = unlock
      })
    elseif i == 3 then
      table.insert(self._showSkillList, {
        skillId = self._roleConfigRecord.contractskillid3,
        unlock = false,
        isPassive = true
      })
    end
  end
  local skill1 = self._showSkillList[1]
  if skill1 then
    local skill = Skill.Create(skill1.skillId, skill1.skillItemId or true)
    self._skill1Panel:SetActive(true)
    self._skill1:Init(skill, skill1.unlock)
  else
    self._skill1Panel:SetActive(false)
  end
  local skill2 = self._showSkillList[2]
  if skill2 then
    local skill = Skill.Create(skill2.skillId, skill2.skillItemId or true)
    self._skill2Panel:SetActive(true)
    self._skill2:Init(skill, skill2.unlock)
  else
    self._skill2Panel:SetActive(false)
  end
  local skill3 = self._showSkillList[3]
  if skill3 then
    local skill = Skill.Create(skill3.skillId, skill3.skillItemId or true)
    self._skill3Panel:SetActive(true)
    self._skill3:Init(skill, skill3.unlock)
  else
    self._skill3Panel:SetActive(false)
  end
end

function RoleResetMainDialog:Ctor(...)
  RoleResetMainDialog.super.Ctor(self, ...)
  self._curSelectRoleId = 0
  self._itemList = {}
end

function RoleResetMainDialog:OnCreate()
  self._backBtn = self:GetChild("BackBtn")
  self._menuBtn = self:GetChild("MenuBtn")
  self._title = self:GetChild("Title")
  self._topFrame = self:GetChild("TopGroup")
  self._currencyFrame = TableFrame.Create(self._topFrame, self, false, false, true)
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
  self._charUpgrade = {
    panel = self:GetChild("Back/TeamEditChangeNewCell/Cell/CharUpgrade"),
    levelImage = {}
  }
  for i = 1, 5 do
    self._charUpgrade.levelImage[i] = self:GetChild("Back/TeamEditChangeNewCell/Cell/CharUpgrade/Img" .. i)
  end
  self._restartBtn = self:GetChild("Back/RestartBtn")
  self._resetBtn_Text = self:GetChild("Back/RestartBtn/_Text")
  self._resetBtn_Text:SetText(NekoData.BehaviorManager.BM_Message:GetString(1732))
  self._consumptionTxt = self:GetChild("Back/UPCost")
  self._consumptionItemImg = self:GetChild("Back/UPCost/Line")
  self._consumptionNumTxt = self:GetChild("Back/UPCost/Num")
  self._consumptionTxt:SetText(NekoData.BehaviorManager.BM_Message:GetString(1731))
  self._tipsBtn = self:GetChild("Tips")
  self._tipsName = self:GetChild("TipsText/TipsName")
  self._emptyTipsText = self:GetChild("TipsText")
  self._tipsName:SetText(NekoData.BehaviorManager.BM_Message:GetString(1765))
  self._emptyTipsText:SetText(NekoData.BehaviorManager.BM_Message:GetString(1766))
  self._detailsBack = self:GetChild("Frame")
  self._roleName = self:GetChild("Back/RoleName")
  self._roleName:SetActive(false)
  self._titelTxt = self:GetChild("Frame/RoleRestartCell/Titel")
  self._titelTxt:SetText(NekoData.BehaviorManager.BM_Message:GetString(1728))
  self._levelBack = {}
  self._levelBack[1] = {
    breaklevelBack = self:GetChild("Frame/RoleRestartCell/BreakLevel/LevelBack1/BreakLevelBack"),
    breaklevelBackBlack = self:GetChild("Frame/RoleRestartCell/BreakLevel/LevelBack1/BreakLevelBackBlack"),
    breaklevelNum = self:GetChild("Frame/RoleRestartCell/BreakLevel/LevelBack1/BreakLevelNum")
  }
  self._levelBack[2] = {
    breaklevelBack = self:GetChild("Frame/RoleRestartCell/BreakLevel/LevelBack2/BreakLevelBack"),
    breaklevelBackBlack = self:GetChild("Frame/RoleRestartCell/BreakLevel/LevelBack2/BreakLevelBackBlack"),
    breaklevelNum = self:GetChild("Frame/RoleRestartCell/BreakLevel/LevelBack2/BreakLevelNum")
  }
  self._levelBack[2].breaklevelBackBlack:SetActive(true)
  self._levelBack[2].breaklevelBack:SetActive(false)
  self._levelBack[2].breaklevelNum:SetActive(false)
  self._breakLevelText = self:GetChild("Frame/RoleRestartCell/BreakLevel")
  self._roleLevelTxt = self:GetChild("Frame/RoleRestartCell/RoleLevel")
  self._skillLevelTxt = self:GetChild("Frame/RoleRestartCell/SkillLevel")
  self._breakLevelText:SetText(NekoData.BehaviorManager.BM_Message:GetString(1767))
  self._roleLevelTxt:SetText(NekoData.BehaviorManager.BM_Message:GetString(1768))
  self._skillLevelTxt:SetText(NekoData.BehaviorManager.BM_Message:GetString(1769))
  self._currentLevelTxt = self:GetChild("Frame/RoleRestartCell/RoleLevel/Lv/NowLeve")
  self._skill1Panel = self:GetChild("Frame/RoleRestartCell/SkillLevel/SkillBack1")
  self._skill1 = DialogManager.CreateDialog("skill.skillcell", self._skill1Panel._uiObject)
  self._skill2Panel = self:GetChild("Frame/RoleRestartCell/SkillLevel/SkillBack2")
  self._skill2 = DialogManager.CreateDialog("skill.skillcell", self._skill2Panel._uiObject)
  self._skill3Panel = self:GetChild("Frame/RoleRestartCell/SkillLevel/SkillBack3")
  self._skill3 = DialogManager.CreateDialog("skill.skillcell", self._skill3Panel._uiObject)
  self._skill1._rootWindow:Subscribe_PointerClickEvent(self.OnSkill1Clicked, self)
  self._skill2._rootWindow:Subscribe_PointerClickEvent(self.OnSkill2Clicked, self)
  self._skill3._rootWindow:Subscribe_PointerClickEvent(self.OnSkill3Clicked, self)
  self._tipsBtn:Subscribe_PointerClickEvent(self.OpenTips, self)
  self._tipsTxt = self:GetChild("Frame/RoleRestartCell/Tips")
  self._tipsTxt:SetText(NekoData.BehaviorManager.BM_Message:GetString(1729))
  self._itemText = self:GetChild("Frame/RoleRestartCell/Item")
  self._itemText:SetText(NekoData.BehaviorManager.BM_Message:GetString(1730))
  self._itemPanel = self:GetChild("Frame/RoleRestartCell/Item/Frame")
  self._itemFrame = GridFrame.Create(self._itemPanel, self, true, 5, true)
  self._width, self._height = self._itemPanel:GetRectSize()
  self:GetChild("Frame/RoleRestartCell/CharUpgrade"):SetText(NekoData.BehaviorManager.BM_Message:GetString(2086))
  self._curRuneLevel = self:GetChild("Frame/RoleRestartCell/CharUpgrade/Lv/NowLeve")
  self._scrollBar = self:GetChild("Frame/RoleRestartCell/Item/Scrollbar")
  self._roleClick = self:GetChild("Back/RoleClick")
  self._effectPoint = self:GetChild("Back/Effect")
  self._backPay = self:GetChild("Back/TeamEditChangeNewCell/BackPay")
  self:InitCurrencyData()
  self._restartBtn:Subscribe_PointerClickEvent(self.OnSendRestart, self)
  self._roleClick:Subscribe_PointerClickEvent(self.OpenSelectDialog, self)
  self._backBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._menuBtn:Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
  LuaNotificationCenter.AddObserver(self, self.OnRefreshCurrency, Common.n_RefreshCurrency, nil)
  LuaNotificationCenter.AddObserver(self, self.OnSRoleReset, Common.n_OnSRoleReset, nil)
  LuaNotificationCenter.AddObserver(self, self.Refresh, Common.n_RoleInfoChange, nil)
  LuaNotificationCenter.AddObserver(self, self.Refresh, Common.n_RefreshFashion, nil)
  LuaNotificationCenter.AddObserver(self, self.Refresh, Common.n_RefreshWitchSkills, nil)
  LuaNotificationCenter.AddObserver(self, self.Refresh, Common.n_ImproveSkill, nil)
  LuaNotificationCenter.AddObserver(self, self.Refresh, Common.n_UniqueEquipLevelUp, nil)
  LuaNotificationCenter.AddObserver(self, self.OnTipGuide, Common.n_GuideStatusChanged, nil)
end

function RoleResetMainDialog:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
  if self._currencyFrame then
    self._currencyFrame:Destroy()
  end
  if self._itemFrame then
    self._itemFrame:Destroy()
  end
  if self._handler then
    NekoData.BehaviorManager.BM_Game:DestroyGuideClickEffectDialog(self._handler)
    self._handler = nil
  end
  if DialogManager.GetDialog("bag.itemtipsdialog") then
    DialogManager.DestroySingletonDialog("bag.itemtipsdialog")
  end
  self:ReleaseEffect()
end

function RoleResetMainDialog:InitCurrencyData()
  self._currencyList = {}
  table.insert(self._currencyList, {
    CurrencyID = DataCommon.RoleResetCoin,
    CurrencyShowID = Item.Create(DataCommon.RoleResetCoin):GetIconId()
  })
  self._currencyFrame:ReloadAllCell()
end

function RoleResetMainDialog:RefreshCell()
  self:Refresh()
end

function RoleResetMainDialog:Refresh()
  self._emptyTipsText:SetActive(self._curSelectRoleId == 0)
  self._detailsBack:SetActive(self._curSelectRoleId ~= 0)
  self._consumptionTxt:SetActive(self._curSelectRoleId ~= 0)
  self._backPay:SetActive(self._curSelectRoleId ~= 0)
  self._restartBtn:SetActive(self._curSelectRoleId ~= 0)
  self._roleName:SetActive(self._curSelectRoleId ~= 0)
  if self._curSelectRoleId == 0 then
    self._empty:SetActive(true)
    self._cell:SetActive(false)
  else
    self._empty:SetActive(false)
    self._cell:SetActive(true)
    local item = Item.Create(DataCommon.RoleResetCoin)
    self._consumptionItemImg:SetSprite(item:GetIconAB())
    self._role = NekoData.BehaviorManager.BM_AllRoles:GetRole(self._curSelectRoleId)
    self._roleName:SetText(self._role:GetRoleName())
    self._record = CDollRemodeling:GetRecorder(self._role:GetBreakLv())
    self._consumptionNumTxt:SetText(self._record.itemnum)
    local image = self._role:GetSmallRarityBackRecord()
    image = self._role:GetShapeLittleHeadImageRecord()
    self._photo:SetSprite(image.assetBundle, image.assetName)
    self._grey:SetActive(false)
    image = self._role:GetSmallRarityFrameRecord()
    self._rankFrame:SetSprite(image.assetBundle, image.assetName)
    if self._role:GetIsLeader() then
      self._rankBack:SetActive(false)
      self._rank:SetActive(false)
    else
      self._rankBack:SetActive(true)
      self._rank:SetActive(true)
      image = self._role:GetRarityImageRecord()
      self._rank:SetSprite(image.assetBundle, image.assetName)
    end
    image = self._role:GetRarityBottomBackRecord()
    self._downRankBack:SetSprite(image.assetBundle, image.assetName)
    image = self._role:GetVocationImageRecord()
    self._job:SetSprite(image.assetBundle, image.assetName)
    self._level:SetText(self._role:GetShowLv())
    self._currentLevelTxt:SetText(self._role:GetShowLv())
    self._maxLevel:SetText(self._role:GetShowMaxBreakLv())
    image = self._role:GetElementImageRecord()
    self._elementImg:SetSprite(image.assetBundle, image.assetName)
    local breakLv = self._role:GetBreakLv()
    self._breakLevelBackBlack:SetActive(breakLv == 0)
    self._breakLevelBack:SetActive(0 < breakLv)
    self._breakLevel:SetActive(0 < breakLv)
    self._levelBack[1].breaklevelBackBlack:SetActive(breakLv == 0)
    self._levelBack[1].breaklevelBack:SetActive(0 < breakLv)
    self._levelBack[1].breaklevelNum:SetActive(0 < breakLv)
    if 0 < breakLv then
      local imageRecord = self._role:GetCurBreakFrame1ImageRecord()
      self._breakLevelBack:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      self._breakLevel:SetText(breakLv)
      self._levelBack[1].breaklevelBack:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      self._levelBack[1].breaklevelNum:SetText(breakLv)
    end
    RefreshSkillPanel(self)
    ShowCharUpgrade(self, self._role:GetRuneLevel())
    self._curRuneLevel:SetText(self._role:GetRuneLevel())
  end
end

function RoleResetMainDialog:InsertEmptyCellData()
  local curNum = #self._itemList
  local onePageNum = MinRowNum * ColumnsNum
  if curNum <= onePageNum then
    for i = curNum + 1, onePageNum do
      local celldata = {}
      celldata.item = nil
      table.insert(self._itemList, celldata)
    end
    return
  end
  local curRow = math.ceil(curNum / ColumnsNum)
  for i = curNum + 1, curRow * ColumnsNum do
    local celldata = {}
    celldata.item = nil
    table.insert(self._itemList, celldata)
  end
end

function RoleResetMainDialog:NumberOfCell(frame)
  if frame == self._itemFrame then
    return #self._itemList
  else
    return #self._currencyList
  end
end

function RoleResetMainDialog:CellAtIndex(frame)
  if frame == self._itemFrame then
    return "bag.rolereset.roleresetitemcell"
  else
    return "bag.bagcurrencycell"
  end
end

function RoleResetMainDialog:DataAtIndex(frame, index)
  if frame == self._itemFrame then
    return self._itemList[index]
  else
    return self._currencyList[index]
  end
end

function RoleResetMainDialog:OnBackBtnClicked()
  self:Destroy()
end

function RoleResetMainDialog:OnMenuBtnClicked()
  DialogManager.CreateSingletonDialog("fastmenu.fastmenudialog")
end

function RoleResetMainDialog:OnRefreshCurrency(notification)
  self._currencyFrame:ReloadAllCell()
end

function RoleResetMainDialog:OpenSelectDialog()
  if self._effectHandler and self._effectHandler ~= 0 then
    self._effectPoint:ReleaseEffect(self._effectHandler)
    self._effectHandler = 0
  end
  local dialog = DialogManager.CreateSingletonDialog("bag.rolereset.changeselectroledialog")
  dialog:Init({
    roleKey = self._curSelectRoleId
  })
end

function RoleResetMainDialog:ItemAccountShow(data)
  NekoData.DataManager.DM_ItemAccountShow:AddShowDialogData(data)
end

function RoleResetMainDialog:OnSRoleReset(notification)
  local data = notification.userInfo
  if data == nil then
    self._curSelectRoleId = 0
  elseif data.isPreview == 1 then
    local data = {
      items = data.itemList
    }
    if data.items and 0 < #data.items then
      self._task = ServerGameTimer.AddTask(1, -1, function()
        self:ItemAccountShow({
          tag = DataCommon.ShowDialogType.ItemAccount,
          data = data
        })
      end, nil)
    end
    self:PlayEffect()
    self._curSelectRoleId = 0
  elseif data.isPreview == 0 then
    while self._itemList[#self._itemList] do
      table.remove(self._itemList, #self._itemList)
    end
    local tempItemList = {}
    for _, itemInfo in pairs(data.itemList) do
      local item = Item.Create(itemInfo.id)
      item:InitWithItemInfo(itemInfo)
      table.insert(tempItemList, item)
    end
    table.sort(tempItemList, function(a, b)
      return tempFun(a, b)
    end)
    for i, v in ipairs(tempItemList) do
      table.insert(self._itemList, v)
    end
    self._curSelectRoleId = data.roleId
    self._itemFrame:ReloadAllCell()
  end
  self:Refresh()
end

function RoleResetMainDialog:OnSendRestart()
  if self._role:GetRoleId() == NekoData.BehaviorManager.BM_Friends:GetSupportRole():GetRoleId() then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100466)
    return
  end
  if self._record then
    if NekoData.BehaviorManager.BM_Currency:GetCurrencyNum(self._record.itemID) >= self._record.itemnum then
      NekoData.BehaviorManager.BM_Message:AddSecondConfirmDialog(133, {
        self._role:GetRoleName()
      }, function()
        local csend = LuaNetManager.CreateProtocol("protocol.login.rolereset.crolereset")
        csend.roleId = self._role:GetRoleId()
        csend.isPreview = 1
        csend:Send()
      end, {}, nil, {})
    else
      NekoData.BehaviorManager.BM_Message:SendMessageById(100457)
    end
  else
    LogErrorFormat("RoleResetMainDialog", "No Exist %s", self._role:GetBreakLv())
  end
end

function RoleResetMainDialog:OnSkill1Clicked()
  if not self._showSkillList[1].unlock then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100315)
  else
    local skillItemId = self._roleConfigRecord.contractskillid
    local skill = Skill.Create(skillItemId)
    DialogManager.CreateSingletonDialog("skill.skilltipsdialog"):SetSkillAndRoleId(skill:GetSkillId(), skillItemId, self._role:GetRoleId())
  end
end

function RoleResetMainDialog:OnSkill2Clicked()
  if not self._showSkillList[2].unlock then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100315)
  else
    local skillItemId = self._roleConfigRecord.contractskillid2
    local skill = Skill.Create(skillItemId)
    DialogManager.CreateSingletonDialog("skill.skilltipsdialog"):SetSkillAndRoleId(skill:GetSkillId(), skillItemId, self._role:GetRoleId())
  end
end

function RoleResetMainDialog:OnSkill3Clicked()
  NekoData.BehaviorManager.BM_Message:SendMessageById(100315)
end

function RoleResetMainDialog:OnSkillUnlock()
  RefreshSkillPanel(self)
end

function RoleResetMainDialog:OpenTips()
  if self._handler then
    NekoData.BehaviorManager.BM_Game:DestroyGuideClickEffectDialog(self._handler)
  end
  DialogManager.CreateSingletonDialog("bag.rolereset.tipsdialog"):SetData(CStringres:GetRecorder(1727).msgTextID)
end

function RoleResetMainDialog:OnTipGuide(notification)
  if self._handler then
    NekoData.BehaviorManager.BM_Game:DestroyGuideClickEffectDialog(self._handler)
    self._handler = nil
  end
  local guideId = notification.userInfo.guideID
  if guideId == 65 and notification.userInfo.guideStatus == "Finish" then
    self._handler = NekoData.BehaviorManager.BM_Game:CreateGuideClickEffectDialog(self._tipsBtn, 1058)
  end
end

function RoleResetMainDialog:PlayEffect()
  if self._effectHandler and self._effectHandler ~= 0 then
    self._effectPoint:ReleaseEffect(self._effectHandler)
    self._effectHandler = 0
  end
  self._effectHandler = self._effectPoint:AddEffectSync(EffectUtil.GetAssetBundleNameAndAssetName(1160))
end

function RoleResetMainDialog:ReleaseEffect()
  if self._effectHandler and self._effectHandler ~= 0 then
    self._effectPoint:ReleaseEffect(self._effectHandler)
    self._effectHandler = 0
  end
end

function RoleResetMainDialog:OnCurPosChange(frame, proportion)
  if frame == self._itemFrame then
    local total = self._itemFrame:GetTotalLength()
    if total > self._height then
      self._scrollBar:SetActive(true)
      self._scrollBar:SetScrollSize(self._height / total)
      self._scrollBar:SetScrollValue(proportion)
    else
      self._scrollBar:SetActive(false)
    end
  end
end

return RoleResetMainDialog
