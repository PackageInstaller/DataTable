-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/mainline/branchline/branchlineunlockworldconfirm.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CSideStoryChapter = (BeanManager.GetTableByName)("dungeonselect.csidestorychapter")
local ImageTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CSecondConfirm = (BeanManager.GetTableByName)("message.csecondconfirm")
local Item = require("logic.manager.experimental.types.item")
local BranchLineUnlockWorldConfirm = class("BranchLineUnlockWorldConfirm", Dialog)
BranchLineUnlockWorldConfirm.AssetBundleName = "ui/layouts.sidestory"
BranchLineUnlockWorldConfirm.AssetName = "SideStorySecondConfirm1"
BranchLineUnlockWorldConfirm.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : BranchLineUnlockWorldConfirm
  ((BranchLineUnlockWorldConfirm.super).Ctor)(self, ...)
  self._groupName = "Tip"
end

BranchLineUnlockWorldConfirm.OnCreate = function(self)
  -- function num : 0_1
  self._describ = self:GetChild("Text1")
  self._cancelBtn = self:GetChild("CancelButton")
  self._confirmBtn = self:GetChild("ConfirmButton")
  ;
  (self._cancelBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self._confirmBtn):Subscribe_PointerClickEvent(self.OnConfirm, self)
end

BranchLineUnlockWorldConfirm.OnDestroy = function(self)
  -- function num : 0_2
end

BranchLineUnlockWorldConfirm.Init = function(self, id)
  -- function num : 0_3 , upvalues : CSideStoryChapter, Item, _ENV, CSecondConfirm
  self._id = id
  local recorder = CSideStoryChapter:GetRecorder(id)
  self._itemId = recorder.unlockitem
  local item = (Item.Create)(self._itemId)
  local itemName = item:GetName()
  local str = (TextManager.GetText)((CSecondConfirm:GetRecorder(77)).messageTextID)
  str = (string.gsub)(str, "%$parameter1%$", itemName)
  str = (string.gsub)(str, "%$parameter2%$", (TextManager.GetText)(recorder.chapternumnametxt))
  str = (string.gsub)(str, "%$parameter3%$", (TextManager.GetText)(recorder.sidestorytitletxt))
  ;
  (self._describ):SetText(str)
end

BranchLineUnlockWorldConfirm.OnBackBtnClicked = function(self)
  -- function num : 0_4
  self:Destroy()
end

BranchLineUnlockWorldConfirm.OnConfirm = function(self)
  -- function num : 0_5 , upvalues : _ENV
  local count = ((NekoData.BehaviorManager).BM_BagInfo):GetItemCountById(self._itemId)
  if count > 0 then
    local csend = (LuaNetManager.CreateProtocol)("protocol.activity.cunlocknewsidequest")
    csend.unlockDungeonID = self._id
    csend:Send()
    self:Destroy()
  else
    do
      local dialog = (DialogManager.CreateSingletonDialog)("mainline.branchline.branchlineunlockitemnotenoughtip")
      if dialog then
        dialog:Init(self._itemId)
      end
      self:Destroy()
    end
  end
end

return BranchLineUnlockWorldConfirm

