-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/behaviormanager/bm_message.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CSceneInfoStatic = (BeanManager.GetTableByName)("scene.csceneinfostatic")
local CTopMessageTable = (BeanManager.GetTableByName)("message.ctopmessage")
local ChannelType = require("protocols.bean.protocol.chat.channeltype")
local CFunctionUnlockCfg = (BeanManager.GetTableByName)("guide.cfunctionunlockconfig")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local CurrencyExchangeTable = (BeanManager.GetTableByName)("recharge.ccurrencyexchange")
local CSkillShow_Role = (BeanManager.GetTableByName)("skill.cskillshow_role")
local CSkillShow_Soul = (BeanManager.GetTableByName)("skill.cskillshow_soul")
local CTipsConfigTable = (BeanManager.GetTableByName)("message.ctipsconfig")
local CCurrencySymbol = (BeanManager.GetTableByName)("topup.ccurrencysymbol")
local SSendMsgNotifyDef = (LuaNetManager.GetProtocolDef)("protocol.notify.ssendmsgnotify")
local BM_Message = class("BM_Message")
BM_Message.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self._message = (NekoData.Data).message
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnTopMessageDestroy, Common.n_DialogWillDestroy, nil)
end

BM_Message.AddSecondConfirmDialog = function(self, id, parameter, yesfunc, yesargs, nofunc, noargs)
  -- function num : 0_1 , upvalues : _ENV
  local dialog = (DialogManager.CreateSingletonDialog)("confirmbox.secondconfirmdialog")
  dialog:PushDialogSetting(id, parameter, yesfunc, yesargs, nofunc, noargs)
end

BM_Message.AddDelayedSecondConfirmDialog = function(self, id, parameter, yesfunc, yesargs, nofunc, noargs)
  -- function num : 0_2 , upvalues : _ENV
  local dialog = (DialogManager.CreateSingletonDialog)("confirmbox.delayedsecondconfirmdialog")
  dialog:PushDialogSetting(id, parameter, yesfunc, yesargs, nofunc, noargs)
end

BM_Message.SendMessageById = function(self, msgId, params)
  -- function num : 0_3 , upvalues : _ENV, SSendMsgNotifyDef, ChannelType
  local msgRecord = ((BeanManager.GetTableByName)("message.cmessagetip")):GetRecorder(msgId)
  local str = (TextManager.GetText)(msgRecord.msgTextID)
  if params then
    local num = 1
    for _,i in pairs(params) do
      str = (string.gsub)(str, "%$parameter1%$", params[num], 1)
      num = num + 1
    end
  end
  do
    if tonumber(msgRecord.msgType) == 1 then
      if msgId ~= SSendMsgNotifyDef.GM_MESSAGE_ID then
        self:AddMessageTip(str)
      else
        self:AddGMMessageTip(str)
      end
    else
      if tonumber(msgRecord.msgType) == 2 then
        ((NekoData.DataManager).DM_Chat):OnSReceiveSystemMsg(str)
        local userinfo = {}
        userinfo.channelType = ChannelType.CHANNEL_SYSTEM
        ;
        (LuaNotificationCenter.PostNotification)(Common.n_ChatInfoReceive, nil, userinfo)
      else
        do
          if tonumber(msgRecord.msgType) == 3 then
            self:AddConfirmTip(str)
          end
        end
      end
    end
  end
end

BM_Message.AddMessageTip = function(self, msg)
  -- function num : 0_4 , upvalues : _ENV
  local dialog = (DialogManager.CreateSingletonDialog)("messagetip.msgtipframedialog")
  dialog:AddMessageTip(msg)
end

BM_Message.AddGMMessageTip = function(self, msg)
  -- function num : 0_5 , upvalues : _ENV
  local dialog = (DialogManager.CreateSingletonDialog)("messagetip.gmmsgtipframedialog")
  dialog:AddMessageTip(msg)
end

BM_Message.AddConfirmTip = function(self, str)
  -- function num : 0_6 , upvalues : _ENV
  local dialog = (DialogManager.CreateSingletonDialog)("messagetip.msgtipconfirmdialog")
  dialog:AddConfirmTip(str)
end

BM_Message.OnTopMessageDestroy = function(self, notification)
  -- function num : 0_7 , upvalues : _ENV
  do
    if ((notification.userInfo)._dialogName == "topnoticebar.topnoticebardialog" or (notification.userInfo)._dialogName == "topnoticebar.topnoticeloadbardialog" or (notification.userInfo)._dialogName == "loadingdialog") and #(self._message).topNoticeBar > 0 then
      local data = ((self._message).topNoticeBar)[1]
      ;
      (table.remove)((self._message).topNoticeBar, 1)
      self:SendTopMessage(data.id, data.params, data.showClear)
    end
    if (notification.userInfo)._dialogName == "messagetip.functionunlockdialog" then
      (table.remove)((self._message).functionUnlock, 1)
      self:ShowFunctionUnlockDialog()
    end
  end
end

BM_Message.SendTopMessage = function(self, id, params, showClear)
  -- function num : 0_8 , upvalues : _ENV, CTopMessageTable, CSceneInfoStatic
  local dialog = (DialogManager.GetDialog)("topnoticebar.topnoticebardialog")
  if not dialog then
    dialog = (DialogManager.GetDialog)("topnoticebar.topnoticeloadbardialog")
  end
  if dialog or (DialogManager.GetDialog)("loadingdialog") then
    local data = {}
    data.id = id
    data.params = params
    data.showClear = showClear
    ;
    (table.insert)((self._message).topNoticeBar, data)
  else
    do
      local msgRecord = CTopMessageTable:GetRecorder(id)
      local str = ""
      if msgRecord.msgType == 1 then
        str = (TextManager.GetText)(msgRecord.msgNumTextID)
        if params then
          str = (string.gsub)(str, "%$parameter(%d)%$", function(i)
    -- function num : 0_8_0 , upvalues : id, params, _ENV, CSceneInfoStatic
    if id ~= 200003 and id ~= 200001 then
      return params[tonumber(i)]
    else
      local sceneId = nil
      local allIds = CSceneInfoStatic:GetAllIds()
      for j = 1, #allIds do
        local recorder = CSceneInfoStatic:GetRecorder(allIds[j])
        if ((id == 200001 and (string.sub)(tostring(recorder.id), 1, 3) == "100") or id ~= 200003 or (string.sub)(tostring(recorder.id), 1, 2) == "12") and recorder.floor == tonumber(params[tonumber(i)]) then
          return (TextManager.GetText)(recorder.nameTextID)
        end
      end
    end
  end
)
        end
        dialog = (DialogManager.CreateSingletonDialog)("topnoticebar.topnoticebardialog")
        local msgTitle = (TextManager.GetText)(msgRecord.msgTitleTextID)
        local msgMain = (TextManager.GetText)(msgRecord.msgMainTextID)
        dialog:SetData(msgTitle, msgMain .. str, showClear)
      else
        do
          if msgRecord.msgType == 2 then
            dialog = (DialogManager.CreateSingletonDialog)("topnoticebar.topnoticeloadbardialog")
            local msgTitle = (TextManager.GetText)(msgRecord.msgTitleTextID)
            local msgNum = (TextManager.GetText)(msgRecord.msgNumTextID)
            local msgMain = (TextManager.GetText)(msgRecord.msgMainTextID)
            dialog:SetData(msgTitle, msgMain, msgNum, params, showClear)
          end
        end
      end
    end
  end
end

BM_Message.PopFunctionUnlockDialog = function(self, functionId)
  -- function num : 0_9 , upvalues : _ENV, CFunctionUnlockCfg
  local dialog = (DialogManager.GetDialog)("messagetip.functionunlockdialog")
  if not self._showFunctionUnlockDialog or dialog then
    local record = CFunctionUnlockCfg:GetRecorder(functionId)
    if record and record.tips ~= 0 then
      (table.insert)((self._message).functionUnlock, functionId)
    end
  else
    do
      ;
      ((DialogManager.CreateSingletonDialog)("messagetip.functionunlockdialog")):SetData(CFunctionUnlockCfg:GetRecorder(functionId))
    end
  end
end

BM_Message.ShowFunctionUnlockDialog = function(self)
  -- function num : 0_10
  self._showFunctionUnlockDialog = true
  local length = #(self._message).functionUnlock
  if length > 0 then
    self:PopFunctionUnlockDialog(((self._message).functionUnlock)[1])
  else
    self._showFunctionUnlockDialog = false
  end
end

BM_Message.GetFunctionUnlockNum = function(self)
  -- function num : 0_11
  return #(self._message).functionUnlock
end

BM_Message.GetString = function(self, id, params)
  -- function num : 0_12 , upvalues : CStringRes, _ENV
  local recorder = CStringRes:GetRecorder(id)
  if recorder then
    local str = (TextManager.GetText)(recorder.msgTextID)
    if params then
      for i,v in ipairs(params) do
        str = (string.gsub)(str, "%$parameter" .. i .. "%$", v)
      end
    end
    do
      do
        do return str end
        LogErrorFormat("BM_Message", "Can not find stringRes record By id: %s", id)
      end
    end
  end
end

BM_Message.AddConfirmDialog = function(self, str, confirmFunc)
  -- function num : 0_13 , upvalues : _ENV
  local dialog = (DialogManager.CreateSingletonDialog)("confirmbox.confirmdialog")
  dialog:AddConfirmDialog(str, confirmFunc)
end

BM_Message.OpenCurrencyExchangeDialog = function(self, id)
  -- function num : 0_14 , upvalues : CurrencyExchangeTable, _ENV
  if not CurrencyExchangeTable:GetRecorder(id) then
    LogErrorFormat("BM_Message", "CurrencyExchange not exit! id : %s", id)
    return 
  end
  local dialog = (DialogManager.CreateSingletonDialog)("confirmbox.currencyexchangedialog")
  dialog:PushDialogSetting(id)
end

BM_Message.OpenCurrencyExchangeBuyDialog = function(self, id, lackNum)
  -- function num : 0_15 , upvalues : CurrencyExchangeTable, _ENV
  if not CurrencyExchangeTable:GetRecorder(id) then
    LogErrorFormat("BM_Message", "CurrencyExchange not exit! id : %s", id)
    return 
  end
  local dialog = (DialogManager.CreateSingletonDialog)("confirmbox.currencyexchangebuydialog")
  dialog:PushDialogSetting(id, lackNum)
end

BM_Message.GetRoleSkillDescribe = function(self, skillId)
  -- function num : 0_16 , upvalues : CSkillShow_Role, _ENV
  local record = CSkillShow_Role:GetRecorder(skillId)
  if record then
    local str = (TextManager.GetText)(record.exDiscribeTextID)
    if #record.attr > 0 then
      for i,v in ipairs(record.attr) do
        str = (string.gsub)(str, "%$parameter" .. i .. "%$", v)
      end
    end
    do
      do
        do return str end
        LogError("skillId Error.")
      end
    end
  end
end

BM_Message.GetUniqueEquipSkillDescribe = function(self, skillId)
  -- function num : 0_17 , upvalues : CSkillShow_Soul, _ENV
  local skillShowRecord = CSkillShow_Soul:GetRecorder(skillId)
  if skillShowRecord then
    local str = (TextManager.GetText)(skillShowRecord.exDiscribeTextID)
    if #skillShowRecord.attr > 0 then
      for i,v in ipairs(skillShowRecord.attr) do
        str = (string.gsub)(str, "%$parameter" .. i .. "%$", v)
      end
    end
    do
      do
        do return str end
        LogErrorFormat("BM_Message", "no id %s in cskillshow_soul", skillId)
      end
    end
  end
end

BM_Message.OpenInstructionsTipDialog = function(self, id)
  -- function num : 0_18 , upvalues : CTipsConfigTable, _ENV
  local record = CTipsConfigTable:GetRecorder(id)
  if not record then
    LogErrorFormat("BM_Message", "Can not find record By id: %s in ctipsconfig", id)
    return 
  end
  ;
  ((DialogManager.CreateSingletonDialog)("messagetip.instructionstipdialog")):SetData(record)
end

BM_Message.GetMoneySymbol = function(self, moneyType)
  -- function num : 0_19 , upvalues : CCurrencySymbol, _ENV
  local record = CCurrencySymbol:GetRecorder(moneyType)
  if record then
    return record.symbol
  else
    LogErrorFormat("BM_Message", "Can not find record by id: %s in ccurrencysymbol", moneyType)
  end
end

return BM_Message

