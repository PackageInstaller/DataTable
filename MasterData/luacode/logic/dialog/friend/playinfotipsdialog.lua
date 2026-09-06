local CStringRes = BeanManager.GetTableByName("message.cstringres")
local UIManager = CS.PixelNeko.UI.UIManager
local UIRootOffsetMax = UIManager.GetUiRootOffsetMax()
local PlayInfoTipsDialog = class("PlayInfoTipsDialog", Dialog)
PlayInfoTipsDialog.AssetBundleName = "ui/layouts.friends"
PlayInfoTipsDialog.AssetName = "PlayerInfo"
PlayInfoTipsDialog.ShowType = {
  Friend = 1,
  Black = 2,
  Other = 3
}

function PlayInfoTipsDialog:Ctor(...)
  PlayInfoTipsDialog.super.Ctor(self, ...)
  self._groupName = "Tip"
end

function PlayInfoTipsDialog:OnCreate()
  self._back = self:GetChild("Back")
  self._photo = self:GetChild("Back/Player/HeadPhoto/Photo")
  self._photoFrame = self:GetChild("Back/Player/HeadPhoto/Frame")
  self._lv = self:GetChild("Back/Player/LvBack/Level")
  self._name = self:GetChild("Back/Player/NameBack/Name")
  self._btnInfo = self:GetChild("Back/Btn1")
  self._btnAdd = self:GetChild("Back/Btn2")
  self._btnBlack = self:GetChild("Back/Btn3")
  self._btnReport = self:GetChild("Back/Btn4")
  self._btnDelete = self:GetChild("Back/Btn6")
  self._btnGive = self:GetChild("Back/Btn7")
  self._btnGiveTxt = self:GetChild("Back/Btn7/_Text")
  self._btnBlock = self:GetChild("Back/Btn8")
  self._btnBlockTxt = self:GetChild("Back/Btn8/_Text")
  self._btnInfo:SetActive(false)
  self._btnAdd:SetActive(false)
  self._btnBlack:SetActive(false)
  self._btnReport:SetActive(false)
  self._btnDelete:SetActive(false)
  self._btnGive:SetActive(false)
  self._btnBlock:SetActive(false)
  self._btnInfo:Subscribe_PointerClickEvent(self.OnInfoClicked, self)
  self._btnAdd:Subscribe_PointerClickEvent(self.OnAddClicked, self)
  self._btnBlack:Subscribe_PointerClickEvent(self.OnBlackClicked, self)
  self._btnBlock:Subscribe_PointerClickEvent(self.OnBlockClicked, self)
  self._btnReport:Subscribe_PointerClickEvent(self.OnReportClicked, self)
  self._btnDelete:Subscribe_PointerClickEvent(self.OnRemoveClicked, self)
  self._btnGive:Subscribe_PointerClickEvent(self.OnGiveClicked, self)
  LuaNotificationCenter.AddObserver(self, self.OnGlobalPointerDown, Common.n_GlobalPointerWillDown, nil)
  self._pos1_x, self._pos1_offset_x, self._pos1_y, self._pos1_offset_y = self._btnInfo:GetPosition()
  self._pos2_x, self._pos2_offset_x, self._pos2_y, self._pos2_offset_y = self._btnAdd:GetPosition()
  self._pos3_x, self._pos3_offset_x, self._pos3_y, self._pos3_offset_y = self._btnBlack:GetPosition()
  self._delta = self._pos1_offset_y - self._pos3_offset_y
  self.showTab = {}
  self._data = nil
  self._isfriend = false
end

function PlayInfoTipsDialog:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
end

function PlayInfoTipsDialog:Init(data, isFriend)
  self._data = data
  self._isfriend = isFriend
  self:InitShowTab()
  local imageinfo = self._data:GetHeadImagePath()
  self._selectID = data:GetID()
  if imageinfo then
    self._photo:SetSprite(imageinfo.assetBundle, imageinfo.assetName)
  else
    LogErrorFormat("PlayInfoTipsDialog", "userInfo.avatarId %s is wrong", data._id)
  end
  imageinfo = data:GetFrameImagePath()
  if imageinfo then
    self._photoFrame:SetSprite(imageinfo.assetBundle, imageinfo.assetName)
  else
    LogErrorFormat("PlayInfoTipsDialog", "userInfo.frameId %s is wrong", data._id)
  end
  self._lv:SetText(data:GetLevel())
  self._name:SetText(data:GetName())
  local is_block = NekoData.BehaviorManager.BM_Friends:IsBlockWorldMsgList(self._selectID)
  if is_block then
    self._btnBlockTxt:SetText(TextManager.GetText(CStringRes:GetRecorder(2273).msgTextID))
  else
    self._btnBlockTxt:SetText(TextManager.GetText(CStringRes:GetRecorder(2274).msgTextID))
  end
end

function PlayInfoTipsDialog:InitShowTab()
  table.insert(self.showTab, self._btnInfo)
  if self._isfriend then
    table.insert(self.showTab, self._btnDelete)
  else
    table.insert(self.showTab, self._btnAdd)
  end
  table.insert(self.showTab, self._btnReport)
  if self._isfriend then
    table.insert(self.showTab, self._btnBlack)
  end
  table.insert(self.showTab, self._btnBlock)
  if NekoData.BehaviorManager.BM_Activity:GetFlowerActInfo() then
    self._btnGiveTxt:SetText(NekoData.BehaviorManager.BM_Message:GetString(2260))
    table.insert(self.showTab, self._btnGive)
  end
  local count = 0
  for index, v in ipairs(self.showTab) do
    v:SetActive(true)
    local delta = self._delta * math.floor(count / 2)
    if count % 2 == 0 then
      v:SetPosition(self._pos1_x, self._pos1_offset_x, self._pos1_y, self._pos1_offset_y - delta)
    else
      v:SetPosition(self._pos2_x, self._pos2_offset_x, self._pos2_y, self._pos2_offset_y - delta)
    end
    count = count + 1
  end
end

function PlayInfoTipsDialog:OnAddClicked()
  local lock = not NekoData.BehaviorManager.BM_Game:IsUnlockFunction(DataCommon.Functions.Equip_Unlock)
  if lock then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100302)
    return
  end
  if NekoData.BehaviorManager.BM_Game:GetUserId() == self._selectID then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100043)
    return
  end
  local friend = NekoData.BehaviorManager.BM_Friends:GetFriend(self._selectID)
  if friend and friend:IsBlack() then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100046)
    return
  end
  if friend and friend:IsFriend() then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100045)
    return
  end
  NekoData.BehaviorManager.BM_Friends:RequesAddFriend(self._selectID)
end

function PlayInfoTipsDialog:OnBlackClicked()
  local lock = not NekoData.BehaviorManager.BM_Game:IsUnlockFunction(DataCommon.Functions.Equip_Unlock)
  if lock then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100302)
    return
  end
  local friend = NekoData.BehaviorManager.BM_Friends:GetFriend(self._selectID)
  if friend and friend:IsBlack() then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100046)
    return
  end
  NekoData.BehaviorManager.BM_Message:AddSecondConfirmDialog(17, nil, function()
    NekoData.BehaviorManager.BM_Friends:RequesBlackFriend(self._selectID)
  end, {}, nil, {})
  self:Destroy()
end

function PlayInfoTipsDialog:OnBlockClicked()
  local lock = not NekoData.BehaviorManager.BM_Game:IsUnlockFunction(DataCommon.Functions.Chat)
  if lock then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100523)
    return
  end
  local name = self._data:GetName()
  local is_block = NekoData.BehaviorManager.BM_Friends:IsBlockWorldMsgList(self._selectID)
  if is_block then
    local protocol = LuaNetManager.CreateProtocol("protocol.chat.cblockworldmsg")
    protocol.userId = self._selectID
    protocol:Send()
  else
    NekoData.BehaviorManager.BM_Message:AddSecondConfirmDialog(153, {name}, function()
      local protocol = LuaNetManager.CreateProtocol("protocol.chat.cblockworldmsg")
      protocol.userId = self._selectID
      protocol:Send()
    end, {}, nil, {})
  end
  self:Destroy()
end

function PlayInfoTipsDialog:OnInfoClicked()
  local protocol = LuaNetManager.CreateProtocol("protocol.chat.clookotherinfo")
  protocol.userId = self._selectID
  protocol:Send()
  self:Destroy()
end

function PlayInfoTipsDialog:OnGiveClicked()
  local flowerActInfo = NekoData.BehaviorManager.BM_Activity:GetFlowerActInfo()
  if not flowerActInfo then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100033)
  else
    local flowerID = flowerActInfo.flowerId
    local flowerNum = NekoData.BehaviorManager.BM_BagInfo:GetItemCountById(flowerID)
    if flowerNum == 0 then
      NekoData.BehaviorManager.BM_Message:SendMessageById(100522)
    else
      DialogManager.CreateSingletonDialog("activity.flower.giveflowerdialog"):SetData(self._selectID, self._data:GetName(), flowerNum)
    end
  end
  self:Destroy()
end

function PlayInfoTipsDialog:OnGlobalPointerDown(args)
  if not UIManager.RectangleContainsScreenPoint(self._back._uiObject, args.userInfo.eventData.position.x, args.userInfo.eventData.position.y) then
    self:OnBackBtnClicked()
  end
end

function PlayInfoTipsDialog:OnBackBtnClicked()
  self:Destroy()
end

function PlayInfoTipsDialog:OnReportClicked()
  local data = {
    reportid = self._selectID,
    nickname = self._data:GetName(),
    type = 2
  }
  DialogManager.CreateSingletonDialog("report.reportplayerdialog"):SetData(data)
  self:Destroy()
end

function PlayInfoTipsDialog:OnRemoveClicked()
  NekoData.BehaviorManager.BM_Message:AddSecondConfirmDialog(16, nil, function()
    NekoData.BehaviorManager.BM_Friends:RequestRemoveFriend(self._selectID)
  end, {}, nil, {})
  self:Destroy()
end

function PlayInfoTipsDialog:UpdatePosition(anchored)
  local uiRootOffsetMax = UIManager.GetUiRootOffsetMax()
  local tipsWidth, tipsHeight = self._back:GetRectSize()
  local width, height = anchored:GetRectSize()
  local screenPosition = anchored:GetLocalPointInUiRootPanel()
  local xPos = screenPosition.x + width / 2 + tipsWidth / 2
  local yPos = screenPosition.y + height / 2 - tipsHeight / 2
  LogInfoFormat("PlayInfoTipsDialog", "UpdatePosition 000 anchored   screenPositionx: %s screenPositiony:%s", screenPosition.x, screenPosition.y)
  LogInfoFormat("PlayInfoTipsDialog", "UpdatePosition 000 anchored   tipsWidth: %s tipsHeight:%s", tipsWidth, tipsHeight)
  LogInfoFormat("PlayInfoTipsDialog", "UpdatePosition 000 tip  width: %s height:%s", width, height)
  local minScreenPosition = {
    xPos = -uiRootOffsetMax.x,
    yPos = -uiRootOffsetMax.y
  }
  local maxScreenPosition = {
    xPos = uiRootOffsetMax.x,
    yPos = uiRootOffsetMax.y
  }
  LogInfoFormat("PlayInfoTipsDialog", "UpdatePosition 111 minScreenPositionx: %s minScreenPositiony:%s", minScreenPosition.xPos, minScreenPosition.yPos)
  LogInfoFormat("PlayInfoTipsDialog", "UpdatePosition 111 maxScreenPositionx: %s maxScreenPositiony:%s", maxScreenPosition.xPos, maxScreenPosition.yPos)
  local newPos = {x = xPos, y = yPos}
  LogInfoFormat("PlayInfoTipsDialog", "UpdatePosition 111 posx: %s posy:%s", newPos.x, newPos.y)
  if newPos.x + tipsWidth / 2 > maxScreenPosition.xPos then
    newPos.x = screenPosition.x - width / 2 - tipsWidth / 2
  end
  if newPos.y - tipsHeight / 2 < minScreenPosition.yPos then
    newPos.y = screenPosition.y + tipsHeight / 2 - height / 2
  end
  self:GetRootWindow():SetAnchoredPosition(newPos.x, newPos.y)
  LogInfoFormat("PlayInfoTipsDialog", "UpdatePosition 222 posx: %s posy:%s", newPos.x, newPos.y)
end

return PlayInfoTipsDialog
