local Role = require("logic.manager.experimental.types.role")
local Friend = require("logic.manager.experimental.types.friend")
local CItemAttrTable = BeanManager.GetTableByName("item.citemattr")
local CItemPinJiTable = BeanManager.GetTableByName("item.citempinji")
local CSkillTypeTable = BeanManager.GetTableByName("skill.cskilltype")
local CSkillTable = BeanManager.GetTableByName("skill.cskill")
local CSkillScreeningConditions = BeanManager.GetTableByName("skill.cskillscreeningconditions")
local GridFrame = require("framework.ui.frame.grid.gridframe")
local ChooseSupportRoleDialog = class("ChooseSupportRoleDialog", Dialog)
ChooseSupportRoleDialog.AssetBundleName = "ui/layouts.teamedit"
ChooseSupportRoleDialog.AssetName = "TeamEditChooseAssist"
local TopToBottom = 3
local TYPE = {
  R = 1,
  SR = 2,
  SSR = 3,
  UR = 4
}
local ELEMENT_TYPE = {
  HYDRAGYRUM = 1,
  SALT = 2,
  FIRE = 3,
  ETHER = 4
}
local FILTER = {
  [TYPE.SSR] = 501831,
  [TYPE.SR] = 501832,
  [TYPE.R] = 501833,
  [TYPE.UR] = 501834
}
local FILTER_ELEMENT = {
  [ELEMENT_TYPE.HYDRAGYRUM] = 502771,
  [ELEMENT_TYPE.SALT] = 502772,
  [ELEMENT_TYPE.FIRE] = 502773,
  [ELEMENT_TYPE.ETHER] = 502774
}

function ChooseSupportRoleDialog:Ctor(...)
  ChooseSupportRoleDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
  self._friendsAndStrangers = {}
  self._screeningConditions = {}
  self._listByConditions = {}
  self._requestSupportRoleTime = nil
  self._supportVocationTable = nil
end

function ChooseSupportRoleDialog:OnCreate()
  self._backEmpty = self:GetChild("BackEmpty")
  self._backEmptyTxt = self:GetChild("BackEmpty/Txt")
  self._back = self:GetChild("Back")
  self._framePanel = self:GetChild("Back/Frame")
  self._scrollBar = self:GetChild("Back/Scrollbar")
  self._scrollBar:SetScrollDirection(TopToBottom)
  self._filterBtn = self:GetChild("Btn1")
  self._refreshListBtn = self:GetChild("Btn2")
  self._confirmBtn = self:GetChild("ConfirmBtn")
  self._backBtn = self:GetChild("BackBtn")
  self._menuBtn = self:GetChild("MenuBtn")
  self._menuBtn:SetActive(GlobalGameFSM and GlobalGameFSM:GetCurrentState() == "MainCity")
  self._jobLimit = self:GetChild("JobLimit")
  self._jobLimitTxt = self:GetChild("JobLimit/Txt2")
  self._frame = GridFrame.Create(self._framePanel, self, true, 2, true)
  self._filterBtn:Subscribe_PointerClickEvent(self.OnFilterBtnClick, self)
  self._refreshListBtn:Subscribe_PointerClickEvent(self.OnRefreshListBtnClick, self)
  self._confirmBtn:Subscribe_PointerClickEvent(self.OnConfirmBtnClicked, self)
  self._backBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._menuBtn:Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
  self._filterPanel = self:GetChild("BaseCharacterListFliterNew")
  self._filterDlg = require("logic.dialog.common.filterdialog").Create(self._filterPanel)
  self._recommendColdTime = 3
  LuaNotificationCenter.PostNotification(Common.n_TriggerGuide, self, nil)
  UIBackManager.SetUIBackShow(true)
  UIBackManager.SetUIModalBackColor(6)
end

function ChooseSupportRoleDialog:OnDestroy()
  UIBackManager.SetUIBackShow(false)
  self._frame:Destroy()
  if self._filterDlg then
    self._filterDlg:Destroy()
    self._filterDlg = nil
  end
end

function ChooseSupportRoleDialog:OnSRefreshSupportRoleList(protocol)
  self:GetSupportVocationTable()
  self._selectedRole = nil
  self._friendsAndStrangers = {}
  local currentSelectSupportUser = NekoData.BehaviorManager.BM_Team:GetSupportRole().user
  for k, v in pairs(protocol.rolesFromFriends) do
    local temp = {}
    temp.friend = NekoData.BehaviorManager.BM_Friends:GetFriend(k)
    temp.role = Role.Create(v.id)
    temp.role:SetLevel(v.lv)
    temp.role:SetBreakLv(v.breakLv)
    temp.role:SetSupportSkill(v.contractSkill[1])
    temp.role:SetFashionId(v.skin)
    table.insert(self._friendsAndStrangers, temp)
    if currentSelectSupportUser and currentSelectSupportUser:GetID() == k then
      self._selectedRole = temp
    end
  end
  table.sort(self._friendsAndStrangers, function(a, b)
    return a.friend:GetLastLoginTime() > b.friend:GetLastLoginTime()
  end)
  local list = {}
  for k, v in pairs(protocol.rolesFromStrangers) do
    local temp = {}
    temp.friend = Friend.Create()
    temp.friend:SetDataFromProtol(v.userInfo)
    temp.role = Role.Create(v.roleInfo.id)
    temp.role:SetLevel(v.roleInfo.lv)
    temp.role:SetBreakLv(v.roleInfo.breakLv)
    temp.role:SetFashionId(v.roleInfo.skin)
    temp.role:SetSupportSkill(v.roleInfo.contractSkill[1])
    table.insert(list, temp)
    if currentSelectSupportUser and currentSelectSupportUser:GetID() == v.userInfo.baseUserData.userId then
      self._selectedRole = temp
    end
  end
  table.sort(list, function(a, b)
    return a.friend:GetLastLoginTime() > b.friend:GetLastLoginTime()
  end)
  table.insertto(self._friendsAndStrangers, list)
  self:ScreeningAndSorting()
end

function ChooseSupportRoleDialog:CheckConditionNum()
  local count = 0
  for k, v in pairs(self._screeningConditions) do
    count = count + table.nums(v)
  end
  return count
end

function ChooseSupportRoleDialog:ScreeningAndSorting()
  self._listByConditions = {}
  local tempList = {}
  if self:CheckConditionNum() > 0 then
    local indexMap = {}
    local map1, map2, map3 = {}, {}, {}
    local check1, check2, check3 = false, false, false
    for k, v in pairs(self._screeningConditions) do
      for _, value in ipairs(v) do
        for i, people in ipairs(self._friendsAndStrangers) do
          if k == 1 then
            check1 = true
            if value.nameid == FILTER[people.role:GetRarityId()] then
              table.insert(map1, i)
            end
          end
          if k == 2 then
            check2 = true
            local skillId = people.role:GetSupportSkillId()
            if CSkillTable:GetRecorder(skillId).attr == value.skillattr then
              table.insert(map2, i)
            end
          end
          if k == 3 then
            check3 = true
            if value.nameid == FILTER_ELEMENT[people.role:GetElement()] then
              table.insert(map3, i)
            end
          end
        end
      end
    end
    if check1 and check2 and check3 then
      for _, v1 in ipairs(map1) do
        if table.indexof(map2, v1) and table.indexof(map3, v1) then
          indexMap[v1] = v1
        end
      end
    elseif check1 and check2 then
      for _, v1 in ipairs(map1) do
        if table.indexof(map2, v1) then
          indexMap[v1] = v1
        end
      end
    elseif check1 and check3 then
      for _, v1 in ipairs(map1) do
        if table.indexof(map3, v1) then
          indexMap[v1] = v1
        end
      end
    elseif check2 and check3 then
      for _, v1 in ipairs(map2) do
        if table.indexof(map3, v1) then
          indexMap[v1] = v1
        end
      end
    elseif check1 then
      indexMap = map1
    elseif check2 then
      indexMap = map2
    elseif check3 then
      indexMap = map3
    end
    for _, v in pairs(indexMap) do
      table.insert(tempList, self._friendsAndStrangers[v])
    end
  else
    tempList = self._friendsAndStrangers
  end
  for _, value in pairs(tempList) do
    if NekoData.BehaviorManager.BM_Vocation:GetVocationIsSupport(value.role, self._supportVocationTable) then
      table.insert(self._listByConditions, value)
    end
  end
  if #self._listByConditions == 0 then
    self._backEmpty:SetActive(true)
    local str = TextManager.GetText(BeanManager.GetTableByName("message.cstringres"):GetRecorder(1077).msgTextID)
    self._backEmptyTxt:SetText(str)
    self._back:SetActive(false)
    self._tag = true
  else
    self._backEmpty:SetActive(false)
    self._back:SetActive(true)
    self._tag = false
  end
  self._frame:ReloadAllCell()
  self._frame:MoveToTop()
  if self._selectedRole then
    self._frame:FireEvent("SetSelectRoleState", self._selectedRole.friend:GetID())
  end
end

function ChooseSupportRoleDialog:OnFilterBtnClick()
  if not self._filterDlg then
    LogError("[Dialog]: ", "Common filter dlg create error")
    return
  end
  self._filterDlg:SetData(self, 1, "SupportRole", self._screeningConditions)
end

function ChooseSupportRoleDialog:SetScreeningConditions(screeningConditions)
  self._screeningConditions = screeningConditions
  self:ScreeningAndSorting()
end

function ChooseSupportRoleDialog:OnRefreshListBtnClick()
  if not self._requestSupportRoleTime or ServerGameTimer.GetServerTimeForecast() - self._requestSupportRoleTime > self._recommendColdTime * 1000 then
    local crefreshSupportRoleList = LuaNetManager.CreateProtocol("protocol.chat.crefreshsupportrolelist")
    crefreshSupportRoleList:Send()
    self._requestSupportRoleTime = ServerGameTimer.GetServerTimeForecast()
  else
    NekoData.BehaviorManager.BM_Message:SendMessageById(100109, {
      self._recommendColdTime
    })
  end
end

function ChooseSupportRoleDialog:OnConfirmBtnClicked()
  if NekoData.BehaviorManager.BM_Guide:IsCurrentGuide(20) then
    local GuideType = LuaNetManager.GetBeanDef("protocol.user.guidtypes")
    NekoData.BehaviorManager.BM_Game:SetGuideTag(GuideType.SUPPORT_LIST, 1)
  end
  if self._selectedRole then
    NekoData.BehaviorManager.BM_Team:SaveChooseSupportRole(self._selectedRole.friend:GetID())
    local cchooseSupportRole = LuaNetManager.CreateProtocol("protocol.chat.cchoosesupportrole")
    cchooseSupportRole.userId = self._selectedRole.friend:GetID()
    cchooseSupportRole:Send()
  else
    NekoData.BehaviorManager.BM_Team:SaveChooseSupportRole()
    local cchooseSupportRole = LuaNetManager.CreateProtocol("protocol.chat.cchoosesupportrole")
    cchooseSupportRole.userId = 0
    cchooseSupportRole:Send()
  end
  local teamEditPreWarDialog = DialogManager.GetDialog("teamedit.teameditprewardialog")
  if not teamEditPreWarDialog then
    teamEditPreWarDialog = DialogManager.CreateSingletonDialog("teamedit.teameditprewardialog")
    local copyInfo = NekoData.BehaviorManager.BM_Team:GetTeamEditCopyInfo()
    if copyInfo then
      teamEditPreWarDialog:SetCopyInfo(copyInfo.copyInfo, copyInfo.id, copyInfo.additionalData)
    else
      LogError("ChooseSupportRoleDialog", "no copyinfo from NekoData.BehaviorManager.BM_Team:GetTeamEditCopyInfo()")
    end
  else
    self:Destroy()
  end
  teamEditPreWarDialog:RefreshSupportRoleInfo()
end

function ChooseSupportRoleDialog:SetSelectRole(data)
  self._selectedRole = data
  if self._selectedRole then
    self._tag = true
    self._frame:FireEvent("SetSelectRoleState", self._selectedRole.friend:GetID())
  else
    self._frame:FireEvent("SetSelectRoleState", nil)
  end
end

function ChooseSupportRoleDialog:NumberOfCell(frame)
  return #self._listByConditions
end

function ChooseSupportRoleDialog:CellAtIndex(frame)
  return "assistbattle.choosesupportrolecell"
end

function ChooseSupportRoleDialog:DataAtIndex(frame, index)
  return self._listByConditions[index]
end

function ChooseSupportRoleDialog:OnCurPosChange(frame, proportion)
  local width, height = self._framePanel:GetRectSize()
  local total = self._frame:GetTotalLength()
  if height < total then
    self._scrollBar:SetActive(true)
    self._scrollBar:SetScrollSize(height / total)
    self._scrollBar:SetScrollValue(proportion)
  else
    self._scrollBar:SetActive(false)
  end
end

function ChooseSupportRoleDialog:AddNewModal(dialog)
  if dialog._dialogName == "teamedit.teameditprewardialog" then
    self:GetRootWindow():SetActive(false)
  end
end

function ChooseSupportRoleDialog:OnBackBtnClicked()
  NekoData.BehaviorManager.BM_Team:SaveChooseSupportRole()
  local cchooseSupportRole = LuaNetManager.CreateProtocol("protocol.chat.cchoosesupportrole")
  cchooseSupportRole.userId = 0
  cchooseSupportRole:Send()
  self:Destroy()
end

function ChooseSupportRoleDialog:OnMenuBtnClicked()
  DialogManager.CreateSingletonDialog("fastmenu.fastmenudialog")
end

function ChooseSupportRoleDialog:GetSupportVocationTable()
  local showJobLimit = false
  local mainLineFloorDialog = DialogManager.GetDialog("mainline.mainline.newmainlinefloordialog")
  if mainLineFloorDialog == nil then
    local dungeonNextFloorDialog = DialogManager.GetDialog("dungeon.dungeonnextfloordialog")
    if dungeonNextFloorDialog == nil then
      local bossRushPanelDialog = DialogManager.GetDialog("mainline.bossrush.bossrushpaneldialog")
      if bossRushPanelDialog == nil then
        local resourceFloorDialog = DialogManager.GetDialog("mainline.resource.resourcefloordialog")
        if resourceFloorDialog ~= nil then
          self._supportVocationTable = NekoData.BehaviorManager.BM_Vocation:GetOneSupportVocationTable(resourceFloorDialog._floorDetail.id)
          if self._supportVocationTable ~= nil then
            showJobLimit = true
            self._jobLimitTxt:SetText(NekoData.BehaviorManager.BM_Vocation:GetOneSupportVocationDescription(self._supportVocationTable))
          end
        end
      end
    end
  end
  self._jobLimit:SetActive(showJobLimit)
end

return ChooseSupportRoleDialog
