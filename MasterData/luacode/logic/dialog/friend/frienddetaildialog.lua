-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/friend/frienddetaildialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local UIManager = ((CS.PixelNeko).UI).UIManager
local HeadTable = (BeanManager.GetTableByName)("headphoto.cheadphotoconfig")
local ImageTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CstringCfg = (BeanManager.GetTableByName)("message.cstringres")
local FriendDetailDialog = class("FriendDetailDialog", Dialog)
FriendDetailDialog.AssetBundleName = "ui/layouts.friends"
FriendDetailDialog.AssetName = "FriendDetail"
FriendDetailDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : FriendDetailDialog
  ((FriendDetailDialog.super).Ctor)(self, ...)
  self._groupName = "Tip"
end

FriendDetailDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self._back = self:GetChild("Back")
  self._icon = self:GetChild("PlayerInfo/HeadPhoto/Photo")
  self._level = self:GetChild("PlayerInfo/LvBack/Level")
  self._name = self:GetChild("PlayerInfo/NameBack/Name")
  self._btnInfo = self:GetChild("DetailBtn")
  self._btnRemove = self:GetChild("DeleteBtn")
  self._btnRemoveText = self:GetChild("DeleteBtn/Txt")
  self._btnBlack = self:GetChild("BlackListBtn")
  ;
  (self._btnInfo):Subscribe_PointerClickEvent(self.OnInfoClicked, self)
  ;
  (self._btnRemove):Subscribe_PointerClickEvent(self.OnRemoveClicked, self)
  ;
  (self._btnBlack):Subscribe_PointerClickEvent(self.OnBlackClicked, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnGlobalPointerDown, Common.n_GlobalPointerWillDown, nil)
end

FriendDetailDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
end

FriendDetailDialog.Init = function(self, data, bFromFriend)
  -- function num : 0_3 , upvalues : HeadTable, ImageTable, _ENV, CstringCfg
  if bFromFriend then
    local imageinfo = data:GetHeadImagePath()
    if imageinfo then
      (self._icon):SetSprite(imageinfo.assetBundle, imageinfo.assetName)
    end
    ;
    (self._level):SetText(data:GetLevel())
    ;
    (self._name):SetText(data:GetName())
    self._userId = data:GetID()
  else
    do
      local temp = HeadTable:GetRecorder(data.headid)
      do
        do
          if temp then
            local gamerInfo = ImageTable:GetRecorder(temp.photoid)
            ;
            (self._icon):SetSprite(gamerInfo.assetBundle, gamerInfo.assetName)
          end
          ;
          (self._name):SetText(data.username)
          ;
          (self._level):SetText(data.level)
          self._userId = data.userid
          if ((NekoData.BehaviorManager).BM_Friends):IsFriend(self._userId) then
            (self._btnRemoveText):SetText((TextManager.GetText)((CstringCfg:GetRecorder(1088)).msgTextID))
          else
            ;
            (self._btnRemoveText):SetText((TextManager.GetText)((CstringCfg:GetRecorder(1089)).msgTextID))
          end
        end
      end
    end
  end
end

FriendDetailDialog.OnRemoveClicked = function(self)
  -- function num : 0_4 , upvalues : _ENV
  if ((NekoData.BehaviorManager).BM_Friends):IsFriend(self._userId) then
    ((NekoData.BehaviorManager).BM_Message):AddSecondConfirmDialog(16, nil, function()
    -- function num : 0_4_0 , upvalues : _ENV, self
    ((NekoData.BehaviorManager).BM_Friends):RequestRemoveFriend(self._userId)
  end
, {}, nil, {})
  else
    ;
    ((NekoData.BehaviorManager).BM_Friends):RequesAddFriend(self._userId)
  end
  self:Destroy()
end

FriendDetailDialog.OnBlackClicked = function(self)
  -- function num : 0_5 , upvalues : _ENV
  ((NekoData.BehaviorManager).BM_Message):AddSecondConfirmDialog(17, nil, function()
    -- function num : 0_5_0 , upvalues : _ENV, self
    ((NekoData.BehaviorManager).BM_Friends):RequesBlackFriend(self._userId)
  end
, {}, nil, {})
  self:Destroy()
end

FriendDetailDialog.OnInfoClicked = function(self)
  -- function num : 0_6 , upvalues : _ENV
  local protocol = (LuaNetManager.CreateProtocol)("protocol.chat.clookotherinfo")
  protocol.userId = self._userId
  protocol:Send()
  self:Destroy()
end

FriendDetailDialog.OnGlobalPointerDown = function(self, args)
  -- function num : 0_7 , upvalues : UIManager
  if not (UIManager.RectangleContainsScreenPoint)((self:GetRootWindow())._uiObject, (((args.userInfo).eventData).position).x, (((args.userInfo).eventData).position).y) then
    self:OnBackBtnClicked()
  end
end

FriendDetailDialog.OnBackBtnClicked = function(self)
  -- function num : 0_8
  self:Destroy()
end

FriendDetailDialog.UpdatePosition = function(self, anchored)
  -- function num : 0_9
end

return FriendDetailDialog

