-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/debug/gmorderdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CPlayerLevel = (BeanManager.GetTableByName)("role.cplayerlevel")
local CFunctionUnlockCfg = (BeanManager.GetTableByName)("guide.cfunctionunlockconfig")
local GMOrderDialog = class("GMOrderDialog", Dialog)
GMOrderDialog.AssetBundleName = "ui/layouts.gm"
GMOrderDialog.AssetName = "GMOrder"
local MulTextNewLine = 2
GMOrderDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : GMOrderDialog
  ((GMOrderDialog.super).Ctor)(self, ...)
  self._groupName = "Chat"
end

GMOrderDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : MulTextNewLine
  self._addDiamond999 = self:GetChild("Back/Item/Item1")
  self._addMana999999 = self:GetChild("Back/Item/Item2")
  self._addAllEquip = self:GetChild("Back/Item/Item3")
  self._addAllRole = self:GetChild("Back/Char/Char1")
  self._addAllRoleToLevelMax = self:GetChild("Back/Char/Char2")
  self._testBattle = self:GetChild("Back/Test/Test1")
  self._testDungeon = self:GetChild("Back/Test/Test2")
  self._unlockAllFunction = self:GetChild("Back/Quick/Quick1")
  self._unlockAllResource = self:GetChild("Back/Quick/Quick2")
  self._unlockAllDungeon = self:GetChild("Back/Quick/Quick3")
  self._goBackToBaseMain = self:GetChild("Back/Dungeon/Dungeon1")
  self._openAllBox = self:GetChild("Back/Dungeon/Dungeon2")
  self._problemFeedback = self:GetChild("Back/Dungeon/Dungeon3")
  self._improveMovingSpeed = self:GetChild("Back/Dungeon/Dungeon4")
  self._arrowBtn = self:GetChild("Back/ArrowBtn")
  self._sendBtn = self:GetChild("Back/Down/SendBtn")
  self._inputField = self:GetChild("Back/Down/InputField")
  ;
  (self._inputField):SetGenerateOutOfBounds(true)
  ;
  (self._inputField):SetLineType(MulTextNewLine)
  ;
  (self:GetRootWindow()):Subscribe_StateExitEvent(self.OnChatDialogHideStateExit, self)
  ;
  (self._addDiamond999):Subscribe_PointerClickEvent(self.OnAddDiamond999Click, self)
  ;
  (self._addMana999999):Subscribe_PointerClickEvent(self.OnAddMana999999Click, self)
  ;
  (self._addAllEquip):Subscribe_PointerClickEvent(self.OnAddAllEquipClick, self)
  ;
  (self._addAllRole):Subscribe_PointerClickEvent(self.OnAddAllRoleClick, self)
  ;
  (self._addAllRoleToLevelMax):Subscribe_PointerClickEvent(self.OnAddAllRoleToLevelMaxClick, self)
  ;
  (self._testBattle):Subscribe_PointerClickEvent(self.OnTestBattleClick, self)
  ;
  (self._testDungeon):Subscribe_PointerClickEvent(self.OnTestDungeonClick, self)
  ;
  (self._unlockAllFunction):Subscribe_PointerClickEvent(self.OnUnlockAllFunctionClick, self)
  ;
  (self._unlockAllResource):Subscribe_PointerClickEvent(self.OnUnlockAllResourceClick, self)
  ;
  (self._unlockAllDungeon):Subscribe_PointerClickEvent(self.OnUnlockAllDungeonClick, self)
  ;
  (self._goBackToBaseMain):Subscribe_PointerClickEvent(self.OnGoBackToBaseMainClick, self)
  ;
  (self._openAllBox):Subscribe_PointerClickEvent(self.OnOpenAllBoxClick, self)
  ;
  (self._problemFeedback):Subscribe_PointerClickEvent(self.OnProblemFeedbackClick, self)
  ;
  (self._improveMovingSpeed):Subscribe_PointerClickEvent(self.OnImproveMovingSpeedClick, self)
  ;
  (self._arrowBtn):Subscribe_PointerClickEvent(self.OnArrowBtnClick, self)
  ;
  (self._sendBtn):Subscribe_PointerClickEvent(self.OnSendBtnClick, self)
end

GMOrderDialog.OnDestroy = function(self)
  -- function num : 0_2
end

GMOrderDialog.Toggle = function(self)
  -- function num : 0_3
  if self._openChat then
    self._openChat = false
    ;
    (self:GetRootWindow()):PlayAnimation("ChatDialogHide")
  else
    ;
    (self:GetRootWindow()):PlayAnimation("ChatDialogShow")
    self._openChat = true
  end
end

GMOrderDialog.OnChatDialogHideStateExit = function(self, arg1, arg2)
  -- function num : 0_4
  if not self._openChat and arg2 == "chatdialoghide" then
    self:Destroy()
  end
end

GMOrderDialog.OnAddDiamond999Click = function(self)
  -- function num : 0_5 , upvalues : _ENV
  ((NekoData.BehaviorManager).BM_Chat):SendMsg("//adddiamond 1 999 0")
end

GMOrderDialog.OnAddMana999999Click = function(self)
  -- function num : 0_6 , upvalues : _ENV
  ((NekoData.BehaviorManager).BM_Chat):SendMsg("//additem 35002 999999")
end

GMOrderDialog.OnAddAllEquipClick = function(self)
  -- function num : 0_7 , upvalues : _ENV
  for i = 1, 51 do
    local idMin = 45001 + (i - 1) * 99
    local idMax = 45001 + i * 98
    ;
    ((NekoData.BehaviorManager).BM_Chat):SendMsg("//additem " .. tostring(idMin) .. "-" .. tostring(idMax) .. " 1")
  end
  ;
  ((NekoData.BehaviorManager).BM_Chat):SendMsg("//additem 50000 1")
end

GMOrderDialog.OnAddAllRoleClick = function(self)
  -- function num : 0_8 , upvalues : _ENV
  ((NekoData.BehaviorManager).BM_Chat):SendMsg("//addroleall")
  local roleList = ((NekoData.BehaviorManager).BM_AllRoles):GetRoleList()
  for _,role in ipairs(roleList) do
    if role:GetId() ~= 1 then
      ((NekoData.BehaviorManager).BM_Chat):SendMsg("//additem " .. tostring(role:GetItemId()) .. " 1")
    end
  end
end

GMOrderDialog.OnAddAllRoleToLevelMaxClick = function(self)
  -- function num : 0_9 , upvalues : _ENV
  local roleList = ((NekoData.BehaviorManager).BM_AllRoles):GetRoleList()
  for _,role in ipairs(roleList) do
    ((NekoData.BehaviorManager).BM_Chat):SendMsg("//addlevel " .. tostring(role:GetId()) .. " 290")
  end
end

GMOrderDialog.OnTestBattleClick = function(self)
  -- function num : 0_10 , upvalues : _ENV
  self:SetActive(false)
  ;
  (DialogManager.CreateSingletonDialog)("mainline.battletextsecondconfirmdialog")
end

GMOrderDialog.OnTestDungeonClick = function(self)
  -- function num : 0_11 , upvalues : _ENV
  (DialogManager.CreateSingletonDialog)("debug.dungeontestsecondconfirmdialog")
end

GMOrderDialog.OnUnlockAllFunctionClick = function(self)
  -- function num : 0_12 , upvalues : CPlayerLevel, _ENV, CFunctionUnlockCfg
  local playerMaxLevel = (CPlayerLevel:GetRecorder(#CPlayerLevel:GetAllIds())).id
  ;
  ((NekoData.BehaviorManager).BM_Chat):SendMsg("//addplayerlevel " .. tostring(playerMaxLevel))
  ;
  ((NekoData.BehaviorManager).BM_Chat):SendMsg("//passbefore 1")
  for _,id in ipairs(CFunctionUnlockCfg:GetAllIds()) do
    ((NekoData.BehaviorManager).BM_Chat):SendMsg("//unlockfunction " .. tostring(id))
  end
  ;
  ((NekoData.BehaviorManager).BM_Chat):SendMsg("//skipguide")
  ;
  ((NekoData.BehaviorManager).BM_Chat):SendMsg("//clearboss")
end

GMOrderDialog.OnUnlockAllResourceClick = function(self)
  -- function num : 0_13 , upvalues : _ENV
  ((NekoData.BehaviorManager).BM_Chat):SendMsg("//unlockresource")
  ;
  ((NekoData.BehaviorManager).BM_Chat):SendMsg("//unlocktower 3")
end

GMOrderDialog.OnUnlockAllDungeonClick = function(self)
  -- function num : 0_14 , upvalues : _ENV
  ((NekoData.BehaviorManager).BM_Chat):SendMsg("//unlockdungeon")
end

GMOrderDialog.OnGoBackToBaseMainClick = function(self)
  -- function num : 0_15 , upvalues : _ENV
  self:Destroy()
  ;
  ((NekoData.BehaviorManager).BM_Chat):SendMsg("//go 30001")
end

GMOrderDialog.OnOpenAllBoxClick = function(self)
  -- function num : 0_16 , upvalues : _ENV
  ((NekoData.BehaviorManager).BM_Chat):SendMsg("//openallbox")
end

GMOrderDialog.OnProblemFeedbackClick = function(self)
  -- function num : 0_17 , upvalues : _ENV
  (DialogManager.CreateSingletonDialog)("confirmbox.sendlogconfirmdialog")
end

GMOrderDialog.OnImproveMovingSpeedClick = function(self)
  -- function num : 0_18 , upvalues : _ENV
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R1 in 'UnsetPending'

  ((CS.UnityEngine).Time).timeScale = 3.5
end

GMOrderDialog.OnSendBtnClick = function(self, args)
  -- function num : 0_19 , upvalues : _ENV
  local msg = (self._inputField):GetText()
  if self:IsLocalGMmsg(msg) then
    (self._inputField):SetText("")
    return 
  end
  ;
  ((NekoData.BehaviorManager).BM_Chat):SendMsg(msg, 1)
  ;
  (self._inputField):SetText("")
end

GMOrderDialog.IsLocalGMmsg = function(self, msg)
  -- function num : 0_20 , upvalues : _ENV
  local str = (string.sub)(msg, 1, 2)
  if not (string.sub)(msg, 3) then
    local lastStr = str ~= "//" or ""
  end
  if lastStr == "testchat" then
    ((NekoData.BehaviorManager).BM_FriendsChat):RandomChatFriend(200)
    return true
  end
  if lastStr == "spring" then
    ((NekoData.BehaviorManager).BM_Activity):EnterActivityById(999)
    return true
  end
  if lastStr ~= "" then
    local posS, posE = (string.find)(lastStr, "chat")
    local posBS, posBE = (string.find)(lastStr, " ")
    if posS and posE and posBS and posBE then
      local strtemp = (string.sub)(lastStr, posBE + 1)
      local pos1, pos2 = (string.find)(strtemp, " ")
      if pos1 and pos2 then
        local strUserId = (string.sub)(strtemp, 1, pos1)
        local strNum = (string.sub)(strtemp, pos2)
        ;
        ((NekoData.BehaviorManager).BM_FriendsChat):TestChatWithFriend(tonumber(strUserId), tonumber(strNum))
        return true
      end
    end
    do
      posS = (string.find)(lastStr, "clientnpcchat")
      posBS = (string.find)(lastStr, " ")
      if posS and posE and posBS and posBE then
        local ID = (string.sub)(lastStr, posBE + 1, #lastStr)
        local dialog = (DialogManager.CreateSingletonDialog)("npcchat.newnpcchatdialog")
        if dialog then
          dialog:SetDialogLibraryId(tonumber(ID), false, (dialog.DialogType).SwimSuit)
        end
        return true
      end
      do
        return false
      end
    end
  end
end

GMOrderDialog.OnArrowBtnClick = function(self, args)
  -- function num : 0_21
  self._openChat = false
  ;
  (self:GetRootWindow()):PlayAnimation("ChatDialogHide")
end

GMOrderDialog.OnBackBtnClicked = function(self)
  -- function num : 0_22
  self:OnArrowBtnClick()
end

return GMOrderDialog

