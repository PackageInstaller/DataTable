local CPlayerLevel = BeanManager.GetTableByName("role.cplayerlevel")
local CFunctionUnlockCfg = BeanManager.GetTableByName("guide.cfunctionunlockconfig")
local GMOrderDialog = class("GMOrderDialog", Dialog)
GMOrderDialog.AssetBundleName = "ui/layouts.gm"
GMOrderDialog.AssetName = "GMOrder"
local MulTextNewLine = 2

function GMOrderDialog:Ctor(...)
  GMOrderDialog.super.Ctor(self, ...)
  self._groupName = "Chat"
end

function GMOrderDialog:OnCreate()
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
  self._inputField:SetGenerateOutOfBounds(true)
  self._inputField:SetLineType(MulTextNewLine)
  self:GetRootWindow():Subscribe_StateExitEvent(self.OnChatDialogHideStateExit, self)
  self._addDiamond999:Subscribe_PointerClickEvent(self.OnAddDiamond999Click, self)
  self._addMana999999:Subscribe_PointerClickEvent(self.OnAddMana999999Click, self)
  self._addAllEquip:Subscribe_PointerClickEvent(self.OnAddAllEquipClick, self)
  self._addAllRole:Subscribe_PointerClickEvent(self.OnAddAllRoleClick, self)
  self._addAllRoleToLevelMax:Subscribe_PointerClickEvent(self.OnAddAllRoleToLevelMaxClick, self)
  self._testBattle:Subscribe_PointerClickEvent(self.OnTestBattleClick, self)
  self._testDungeon:Subscribe_PointerClickEvent(self.OnTestDungeonClick, self)
  self._unlockAllFunction:Subscribe_PointerClickEvent(self.OnUnlockAllFunctionClick, self)
  self._unlockAllResource:Subscribe_PointerClickEvent(self.OnUnlockAllResourceClick, self)
  self._unlockAllDungeon:Subscribe_PointerClickEvent(self.OnUnlockAllDungeonClick, self)
  self._goBackToBaseMain:Subscribe_PointerClickEvent(self.OnGoBackToBaseMainClick, self)
  self._openAllBox:Subscribe_PointerClickEvent(self.OnOpenAllBoxClick, self)
  self._problemFeedback:Subscribe_PointerClickEvent(self.OnProblemFeedbackClick, self)
  self._improveMovingSpeed:Subscribe_PointerClickEvent(self.OnImproveMovingSpeedClick, self)
  self._arrowBtn:Subscribe_PointerClickEvent(self.OnArrowBtnClick, self)
  self._sendBtn:Subscribe_PointerClickEvent(self.OnSendBtnClick, self)
end

function GMOrderDialog:OnDestroy()
end

function GMOrderDialog:Toggle()
  if self._openChat then
    self._openChat = false
    self:GetRootWindow():PlayAnimation("ChatDialogHide")
  else
    self:GetRootWindow():PlayAnimation("ChatDialogShow")
    self._openChat = true
  end
end

function GMOrderDialog:OnChatDialogHideStateExit(arg1, arg2)
  if not self._openChat and arg2 == "chatdialoghide" then
    self:Destroy()
  end
end

function GMOrderDialog:OnAddDiamond999Click()
  NekoData.BehaviorManager.BM_Chat:SendMsg("//adddiamond 1 999 0")
end

function GMOrderDialog:OnAddMana999999Click()
  NekoData.BehaviorManager.BM_Chat:SendMsg("//additem 35002 999999")
end

function GMOrderDialog:OnAddAllEquipClick()
  for i = 1, 51 do
    local idMin = 45001 + (i - 1) * 99
    local idMax = 45001 + i * 98
    NekoData.BehaviorManager.BM_Chat:SendMsg("//additem " .. tostring(idMin) .. "-" .. tostring(idMax) .. " 1")
  end
  NekoData.BehaviorManager.BM_Chat:SendMsg("//additem 50000 1")
end

function GMOrderDialog:OnAddAllRoleClick()
  NekoData.BehaviorManager.BM_Chat:SendMsg("//addroleall")
  local roleList = NekoData.BehaviorManager.BM_AllRoles:GetRoleList()
  for _, role in ipairs(roleList) do
    if role:GetId() ~= 1 then
      NekoData.BehaviorManager.BM_Chat:SendMsg("//additem " .. tostring(role:GetItemId()) .. " 1")
    end
  end
end

function GMOrderDialog:OnAddAllRoleToLevelMaxClick()
  local roleList = NekoData.BehaviorManager.BM_AllRoles:GetRoleList()
  for _, role in ipairs(roleList) do
    NekoData.BehaviorManager.BM_Chat:SendMsg("//addlevel " .. tostring(role:GetId()) .. " 290")
  end
end

function GMOrderDialog:OnTestBattleClick()
  self:SetActive(false)
  DialogManager.CreateSingletonDialog("mainline.battletextsecondconfirmdialog")
end

function GMOrderDialog:OnTestDungeonClick()
  DialogManager.CreateSingletonDialog("debug.dungeontestsecondconfirmdialog")
end

function GMOrderDialog:OnUnlockAllFunctionClick()
  local playerMaxLevel = CPlayerLevel:GetRecorder(#CPlayerLevel:GetAllIds()).id
  NekoData.BehaviorManager.BM_Chat:SendMsg("//addplayerlevel " .. tostring(playerMaxLevel))
  NekoData.BehaviorManager.BM_Chat:SendMsg("//passbefore 1")
  for _, id in ipairs(CFunctionUnlockCfg:GetAllIds()) do
    NekoData.BehaviorManager.BM_Chat:SendMsg("//unlockfunction " .. tostring(id))
  end
  NekoData.BehaviorManager.BM_Chat:SendMsg("//skipguide")
  NekoData.BehaviorManager.BM_Chat:SendMsg("//clearboss")
end

function GMOrderDialog:OnUnlockAllResourceClick()
  NekoData.BehaviorManager.BM_Chat:SendMsg("//unlockresource")
  NekoData.BehaviorManager.BM_Chat:SendMsg("//unlocktower 3")
end

function GMOrderDialog:OnUnlockAllDungeonClick()
  NekoData.BehaviorManager.BM_Chat:SendMsg("//unlockdungeon")
end

function GMOrderDialog:OnGoBackToBaseMainClick()
  self:Destroy()
  NekoData.BehaviorManager.BM_Chat:SendMsg("//go 30001")
end

function GMOrderDialog:OnOpenAllBoxClick()
  NekoData.BehaviorManager.BM_Chat:SendMsg("//openallbox")
end

function GMOrderDialog:OnProblemFeedbackClick()
  DialogManager.CreateSingletonDialog("confirmbox.sendlogconfirmdialog")
end

function GMOrderDialog:OnImproveMovingSpeedClick()
  CS.UnityEngine.Time.timeScale = 3.5
end

function GMOrderDialog:OnSendBtnClick(args)
  local msg = self._inputField:GetText()
  if self:IsLocalGMmsg(msg) then
    self._inputField:SetText("")
    return
  end
  NekoData.BehaviorManager.BM_Chat:SendMsg(msg, nil, 1)
  self._inputField:SetText("")
end

function GMOrderDialog:IsLocalGMmsg(msg)
  local str = string.sub(msg, 1, 2)
  if str == "//" then
    LogInfoFormat("GMOrderDialog", "handle local gm msg = %s", msg)
    local lastStr = string.sub(msg, 3) or ""
    if lastStr == "testchat" then
      NekoData.BehaviorManager.BM_FriendsChat:RandomChatFriend(200)
      return true
    end
    if lastStr == "spring" then
      NekoData.BehaviorManager.BM_Activity:EnterActivityById(999)
      return true
    end
    if lastStr ~= "" then
      local list = string.split(lastStr, " ")
      if list and list[1] == "goto" then
        NekoData.BehaviorManager.BM_GotoDialog:HandleGoto(list[2], tonumber(list[3]))
        return true
      end
      local posS, posE = string.find(lastStr, "chat")
      local posBS, posBE = string.find(lastStr, " ")
      if posS and posE and posBS and posBE then
        local strtemp = string.sub(lastStr, posBE + 1)
        local pos1, pos2 = string.find(strtemp, " ")
        if pos1 and pos2 then
          local strUserId = string.sub(strtemp, 1, pos1)
          local strNum = string.sub(strtemp, pos2)
          NekoData.BehaviorManager.BM_FriendsChat:TestChatWithFriend(tonumber(strUserId), tonumber(strNum))
          return true
        end
      end
      posS, posE = string.find(lastStr, "clientnpcchat")
      posBS, posBE = string.find(lastStr, " ")
      if posS and posE and posBS and posBE then
        local ID = string.sub(lastStr, posBE + 1, #lastStr)
        local dialog = DialogManager.CreateSingletonDialog("npcchat.newnpcchatdialog")
        if dialog then
          dialog:SetDialogLibraryId(tonumber(ID), false, dialog.DialogType.SwimSuit)
        end
        return true
      end
    end
  end
  return false
end

function GMOrderDialog:OnArrowBtnClick(args)
  self._openChat = false
  self:GetRootWindow():PlayAnimation("ChatDialogHide")
end

function GMOrderDialog:OnBackBtnClicked()
  self:OnArrowBtnClick()
end

return GMOrderDialog
