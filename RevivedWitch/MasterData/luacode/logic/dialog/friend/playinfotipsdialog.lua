-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/friend/playinfotipsdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local UIManager = ((CS.PixelNeko).UI).UIManager
local UIRootOffsetMax = (UIManager.GetUiRootOffsetMax)()
local PlayInfoTipsDialog = class("PlayInfoTipsDialog", Dialog)
PlayInfoTipsDialog.AssetBundleName = "ui/layouts.friends"
PlayInfoTipsDialog.AssetName = "PlayerInfo"
PlayInfoTipsDialog.ShowType = {Friend = 1, Black = 2, Other = 3}
PlayInfoTipsDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : PlayInfoTipsDialog
  ((PlayInfoTipsDialog.super).Ctor)(self, ...)
  self._groupName = "Tip"
end

PlayInfoTipsDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV
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
  ;
  (self._btnInfo):Subscribe_PointerClickEvent(self.OnInfoClicked, self)
  ;
  (self._btnAdd):Subscribe_PointerClickEvent(self.OnAddClicked, self)
  ;
  (self._btnBlack):Subscribe_PointerClickEvent(self.OnBlackClicked, self)
  ;
  (self._btnReport):Subscribe_PointerClickEvent(self.OnReportClicked, self)
  ;
  (self._btnDelete):Subscribe_PointerClickEvent(self.OnRemoveClicked, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnGlobalPointerDown, Common.n_GlobalPointerWillDown, nil)
end

PlayInfoTipsDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
end

PlayInfoTipsDialog.Init = function(self, data, isFriend)
  -- function num : 0_3 , upvalues : _ENV
  self._data = data
  local imageinfo = (self._data):GetHeadImagePath()
  self._selectID = data:GetID()
  if imageinfo then
    (self._photo):SetSprite(imageinfo.assetBundle, imageinfo.assetName)
  else
    LogErrorFormat("PlayInfoTipsDialog", "userInfo.avatarId %s is wrong", data._id)
  end
  imageinfo = data:GetFrameImagePath()
  if imageinfo then
    (self._photoFrame):SetSprite(imageinfo.assetBundle, imageinfo.assetName)
  else
    LogErrorFormat("PlayInfoTipsDialog", "userInfo.frameId %s is wrong", data._id)
  end
  ;
  (self._lv):SetText(data:GetLevel())
  ;
  (self._name):SetText(data:GetName())
  if isFriend then
    (self._btnDelete):SetActive(true)
    ;
    (self._btnAdd):SetActive(false)
  else
    ;
    (self._btnDelete):SetActive(false)
    ;
    (self._btnAdd):SetActive(true)
  end
end

PlayInfoTipsDialog.OnAddClicked = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local lock = not ((NekoData.BehaviorManager).BM_Game):IsUnlockFunction((DataCommon.Functions).Equip_Unlock)
  if lock then
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100302)
    return 
  end
  if ((NekoData.BehaviorManager).BM_Game):GetUserId() == self._selectID then
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100043)
    return 
  end
  local friend = ((NekoData.BehaviorManager).BM_Friends):GetFriend(self._selectID)
  if friend and friend:IsBlack() then
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100046)
    return 
  end
  if friend and friend:IsFriend() then
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100045)
    return 
  end
  ;
  ((NekoData.BehaviorManager).BM_Friends):RequesAddFriend(self._selectID)
end

PlayInfoTipsDialog.OnBlackClicked = function(self)
  -- function num : 0_5 , upvalues : _ENV
  local lock = not ((NekoData.BehaviorManager).BM_Game):IsUnlockFunction((DataCommon.Functions).Equip_Unlock)
  if lock then
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100302)
    return 
  end
  local friend = ((NekoData.BehaviorManager).BM_Friends):GetFriend(self._selectID)
  if friend and friend:IsBlack() then
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100046)
    return 
  end
  ;
  ((NekoData.BehaviorManager).BM_Message):AddSecondConfirmDialog(17, nil, function()
    -- function num : 0_5_0 , upvalues : _ENV, self
    ((NekoData.BehaviorManager).BM_Friends):RequesBlackFriend(self._selectID)
  end
, {}, nil, {})
  self:Destroy()
end

PlayInfoTipsDialog.OnInfoClicked = function(self)
  -- function num : 0_6 , upvalues : _ENV
  local protocol = (LuaNetManager.CreateProtocol)("protocol.chat.clookotherinfo")
  protocol.userId = self._selectID
  protocol:Send()
  self:Destroy()
end

PlayInfoTipsDialog.OnGlobalPointerDown = function(self, args)
  -- function num : 0_7 , upvalues : UIManager
  if not (UIManager.RectangleContainsScreenPoint)((self._back)._uiObject, (((args.userInfo).eventData).position).x, (((args.userInfo).eventData).position).y) then
    self:OnBackBtnClicked()
  end
end

PlayInfoTipsDialog.OnBackBtnClicked = function(self)
  -- function num : 0_8
  self:Destroy()
end

PlayInfoTipsDialog.OnReportClicked = function(self)
  -- function num : 0_9 , upvalues : _ENV
  local data = {reportid = self._selectID, nickname = (self._data):GetName(), type = 2}
  ;
  ((DialogManager.CreateSingletonDialog)("report.reportplayerdialog")):SetData(data)
  self:Destroy()
end

PlayInfoTipsDialog.OnRemoveClicked = function(self)
  -- function num : 0_10 , upvalues : _ENV
  ((NekoData.BehaviorManager).BM_Message):AddSecondConfirmDialog(16, nil, function()
    -- function num : 0_10_0 , upvalues : _ENV, self
    ((NekoData.BehaviorManager).BM_Friends):RequestRemoveFriend(self._selectID)
  end
, {}, nil, {})
  self:Destroy()
end

return PlayInfoTipsDialog

