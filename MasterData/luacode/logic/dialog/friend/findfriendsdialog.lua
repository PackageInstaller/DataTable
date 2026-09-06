local FindFriendsDialog = class("FindFriendsDialog", Dialog)
local TableFrame = require("framework.ui.frame.table.tableframe")
local Friend = require("logic.manager.experimental.types.friend")
local CstringCfg = BeanManager.GetTableByName("message.cstringres")
local OtherUserInfo = LuaNetManager.GetBeanDef("protocol.chat.otheruserinfo")
local RedData = require("logic.manager.experimental.types.reddata")
local CFriendConfig = BeanManager.GetTableByName("friend.cfriendconfig")
FindFriendsDialog.AssetBundleName = "ui/layouts.friends"
FindFriendsDialog.AssetName = "FriendsAdd"

function FindFriendsDialog:Ctor(...)
  FindFriendsDialog.super.Ctor(self, ...)
  self._bRecommendState = true
  self._requestFrindsTime = 0
  self._cdTimer = nil
end

function FindFriendsDialog:OnCreate()
  self._groupBtnInfo = {}
  self._groupBtnInfo[1] = self:GetChild("ApplicationBtn")
  self._groupBtnInfo[2] = self:GetChild("RecommendBtn")
  for i = 1, 2 do
    self._groupBtnInfo[i]:Subscribe_PointerClickEvent(function()
      self:OnGroupClick(i)
    end)
  end
  self._searchBack = self:GetChild("Search")
  self._inputField = self:GetChild("Search/FriendsInputField")
  self._inputField:SetGenerateOutOfBounds(true)
  self._btnSearch = self:GetChild("Search/SearchBtn")
  self._findBack = self:GetChild("Back/Left")
  self._txtTitle = self:GetChild("Back/Left/Title")
  self._leftPanel = self:GetChild("Back/Left/SearchResultFrame")
  self._leftListHelper = TableFrame.Create(self._leftPanel, self, true, true, false)
  self._btnRefresh = self:GetChild("Back/Left/RefreshBtn")
  self._applicationBack = self:GetChild("Back/Right")
  self._rightPanel = self:GetChild("Back/Right/ApplicationFrame")
  self._rightListHelper = TableFrame.Create(self._rightPanel, self, true, true, false)
  self._applicationScrollBar = self:GetChild("Scrollbar1")
  self._applicationScrollBar:SetScrollDirection(3)
  self._scrollBar = self:GetChild("Scrollbar")
  self._scrollBar:SetScrollDirection(3)
  self._applyRedDot = self:GetChild("ApplicationBtn/RedDot")
  self._applyRedDot:SetActive(false)
  self._btnSearch:Subscribe_PointerClickEvent(self.OnSearchClicked, self)
  self._btnRefresh:Subscribe_PointerClickEvent(self.RequestRecommendFriend, self)
  LuaNotificationCenter.AddObserver(self, self.RefreshRecommendFriends, Common.n_ReceiveRecommendFriends, nil)
  LuaNotificationCenter.AddObserver(self, self.RemoveRecommendFriend, Common.n_RemoveRecommendFriend, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshApplicantList, Common.n_FriendIdentityChange, nil)
  self._recommendColdTime = tonumber(CFriendConfig:GetRecorder(1).RefreshLimit)
  self:RequestRecommendFriend()
  self._requestFrindsTime = ServerGameTimer.GetServerTimeForecast()
  self:SetApplicantData()
  if #self._applicantCellInfo > 0 then
    self:OnGroupClick(1)
  else
    self:OnGroupClick(2)
  end
end

function FindFriendsDialog:OnDestroy()
  self._leftListHelper:Destroy()
  self._rightListHelper:Destroy()
  if not self._cdTimer then
    GameTimer.RemoveTask(self._cdTimer)
    self._cdTimer = nil
  end
  LuaNotificationCenter.RemoveObserver(self)
end

function FindFriendsDialog:Refresh()
  if #self._applicantCellInfo > 0 then
    self:OnGroupClick(1)
  else
    self._recommentCellInfo = {}
    local recommendfriends = NekoData.BehaviorManager.BM_Friends:GetRecommendFriends()
    for id, friend in pairs(recommendfriends) do
      table.insert(self._recommentCellInfo, friend)
    end
    if #self._recommentCellInfo == 0 then
      self:RequestRecommendFriend()
      self._requestFrindsTime = 0
    end
    self._leftListHelper:ReloadAllCell()
    self._bRecommendState = true
    self._txtTitle:SetText(TextManager.GetText(CstringCfg:GetRecorder(1033).msgTextID))
    self:OnGroupClick(2)
  end
end

function FindFriendsDialog:RequestRecommendFriend()
  local now = ServerGameTimer.GetServerTimeForecast() - self._requestFrindsTime
  if not self._cdTimer or now >= self._requestFrindsTime * 1000 then
    NekoData.BehaviorManager.BM_Friends:RequestRecommendFriend()
    if not self._cdTimer then
      GameTimer.RemoveTask(self._cdTimer)
      self._cdTimer = nil
    end
    self._cdTimer = GameTimer.AddTask(self._recommendColdTime, -1, function(self)
      self._cdTimer = nil
    end, self)
    self._requestFrindsTime = ServerGameTimer.GetServerTimeForecast()
  else
    NekoData.BehaviorManager.BM_Message:SendMessageById(100109, {
      self._recommendColdTime
    })
  end
end

function FindFriendsDialog:RefreshRecommendFriends(notification)
  self._recommentCellInfo = {}
  for index, info in pairs(notification.userInfo.users) do
    local friend = Friend.Create()
    friend:SetDataFromProtol(info)
    table.insert(self._recommentCellInfo, friend)
  end
  self._leftListHelper:ReloadAllCell()
  if notification.userInfo.tag and notification.userInfo.tag == "Recommend" then
    self._bRecommendState = true
    self._inputField:SetText("")
    self._txtTitle:SetText(TextManager.GetText(CstringCfg:GetRecorder(1033).msgTextID))
  else
    self._bRecommendState = false
    self._txtTitle:SetText(TextManager.GetText(CstringCfg:GetRecorder(1034).msgTextID))
  end
end

function FindFriendsDialog:RemoveRecommendFriend(notification)
  for i = #self._recommentCellInfo, 1, -1 do
    if self._recommentCellInfo[i]:GetID() == notification.userInfo then
      table.remove(self._recommentCellInfo, i)
      break
    end
  end
  self._leftListHelper:ReloadAllCell()
end

function FindFriendsDialog:SetApplicantData()
  self._applicantCellInfo = {}
  local allfriends = NekoData.BehaviorManager.BM_Friends:GetAllFriend()
  LogInfo("FindFriendsDialog", "refresh application list")
  for id, friend in pairs(allfriends) do
    if friend:IsApplicant() then
      LogInfoFormat("FindFriendsDialog", "friend userid %s", friend:GetID())
      table.insert(self._applicantCellInfo, friend)
    end
  end
  self._rightListHelper:ReloadAllCell()
  local redData = NekoData.BehaviorManager.BM_Friends:GetRedData()
  self._applyRedDot:SetActive(redData:IsIndexTrue(2))
end

function FindFriendsDialog:RefreshApplicantList(notification)
  if not notification then
    return
  end
  if not notification.userInfo then
    return
  end
  LogInfoFormat("FindFriendsDialog", "new %s old %s", notification.userInfo.newIdentity, notification.userInfo.oldIdentity)
  local bNeedRefresh = false
  if notification.userInfo.newIdentity and notification.userInfo.newIdentity == OtherUserInfo.APPLICANT then
    bNeedRefresh = true
  elseif notification.userInfo.oldIdentity and notification.userInfo.oldIdentity == OtherUserInfo.APPLICANT then
    bNeedRefresh = true
  end
  if bNeedRefresh then
    LogInfo("FindFriendsDialog", "begin refresh application friend list")
    self:SetApplicantData()
  end
  if notification.userInfo.newIdentity and notification.userInfo.newIdentity == OtherUserInfo.BLACK_LIST then
    if #self._recommentCellInfo > 0 then
      for i = #self._recommentCellInfo, 1, -1 do
        if self._recommentCellInfo[i]:GetID() == notification.userInfo.userid then
          table.remove(self._recommentCellInfo, i)
          NekoData.DataManager.DM_Friends:RemoveRecommendFriend(notification.userInfo.userid)
          self._leftListHelper:ReloadAllCell()
          break
        end
      end
    else
      LogInfoFormat("FindFriendsDialog", "RecommentCellInfo Length is %s", #self._recommentCellInfo)
    end
  end
end

function FindFriendsDialog:NumberOfCell(panel)
  if panel == self._leftListHelper then
    return #self._recommentCellInfo
  end
  if panel == self._rightListHelper then
    return #self._applicantCellInfo
  end
end

function FindFriendsDialog:CellAtIndex(panel, index)
  if panel == self._leftListHelper then
    return "friend.friendrecommendcell"
  end
  if panel == self._rightListHelper then
    return "friend.friendapplicantcell"
  end
end

function FindFriendsDialog:DataAtIndex(panel, index)
  if panel == self._leftListHelper then
    return self._recommentCellInfo[index]
  end
  if panel == self._rightListHelper then
    return self._applicantCellInfo[index]
  end
end

function FindFriendsDialog:OnSearchClicked()
  local keyword = self._inputField:GetText()
  if keyword == "" then
    return
  end
  NekoData.BehaviorManager.BM_Friends:RequestSearchFriend(keyword)
end

function FindFriendsDialog:OnGroupClick(index)
  for i = 1, 2 do
    self._groupBtnInfo[i]:SetSelected(index == i)
  end
  self._curPage = index
  self._searchBack:SetActive(index == 2)
  self._findBack:SetActive(index == 2)
  self._applicationBack:SetActive(index == 1)
  if index == 1 then
    local width, height = self._rightPanel:GetRectSize()
    local total = self._rightListHelper:GetTotalLength()
    if height < total then
      self._applicationScrollBar:SetActive(true)
    else
      self._applicationScrollBar:SetActive(false)
    end
    self._scrollBar:SetActive(false)
  elseif index == 2 then
    local width, height = self._leftPanel:GetRectSize()
    local total = self._leftListHelper:GetTotalLength()
    if height < total then
      self._scrollBar:SetActive(true)
    else
      self._scrollBar:SetActive(false)
    end
    self._applicationScrollBar:SetActive(false)
  end
end

function FindFriendsDialog:OnCurPosChange(frame, proportion)
  if self._curPage == 2 and frame == self._leftListHelper then
    local width, height = self._leftPanel:GetRectSize()
    local total = self._leftListHelper:GetTotalLength()
    if height < total then
      self._scrollBar:SetActive(true)
      self._scrollBar:SetScrollSize(height / total)
      self._scrollBar:SetScrollValue(proportion)
    else
      self._scrollBar:SetActive(false)
    end
  elseif self._curPage == 1 and frame == self._rightListHelper then
    local width, height = self._rightPanel:GetRectSize()
    local total = self._rightListHelper:GetTotalLength()
    if height < total then
      self._applicationScrollBar:SetActive(true)
      self._applicationScrollBar:SetScrollSize(height / total)
      self._applicationScrollBar:SetScrollValue(proportion)
    else
      self._applicationScrollBar:SetActive(false)
    end
  end
end

return FindFriendsDialog
