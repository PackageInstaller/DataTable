local CSceneInfoStatic = BeanManager.GetTableByName("scene.csceneinfostatic")
local CTopMessageTable = BeanManager.GetTableByName("message.ctopmessage")
local ChannelType = require("protocols.bean.protocol.chat.channeltype")
local CFunctionUnlockCfg = BeanManager.GetTableByName("guide.cfunctionunlockconfig")
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local CurrencyExchangeTable = BeanManager.GetTableByName("recharge.ccurrencyexchange")
local CSkillShow_Role = BeanManager.GetTableByName("skill.cskillshow_role")
local CSkillShow_Soul = BeanManager.GetTableByName("skill.cskillshow_soul")
local CTipsConfigTable = BeanManager.GetTableByName("message.ctipsconfig")
local CCurrencySymbol = BeanManager.GetTableByName("topup.ccurrencysymbol")
local SSendMsgNotifyDef = LuaNetManager.GetProtocolDef("protocol.notify.ssendmsgnotify")
local BM_Message = class("BM_Message")

function BM_Message:Ctor()
  self._message = NekoData.Data.message
  LuaNotificationCenter.AddObserver(self, self.OnTopMessageDestroy, Common.n_DialogWillDestroy, nil)
end

function BM_Message:AddSecondConfirmDialog(id, parameter, yesfunc, yesargs, nofunc, noargs)
  local dialog = DialogManager.CreateSingletonDialog("confirmbox.secondconfirmdialog")
  dialog:PushDialogSetting(id, parameter, yesfunc, yesargs, nofunc, noargs)
end

function BM_Message:AddDelayedSecondConfirmDialog(id, parameter, yesfunc, yesargs, nofunc, noargs)
  local dialog = DialogManager.CreateSingletonDialog("confirmbox.delayedsecondconfirmdialog")
  dialog:PushDialogSetting(id, parameter, yesfunc, yesargs, nofunc, noargs)
end

function BM_Message:SendMessageById(msgId, params)
  local msgRecord = BeanManager.GetTableByName("message.cmessagetip"):GetRecorder(msgId)
  if not msgRecord then
    return
  end
  local str = TextManager.GetText(msgRecord.msgTextID)
  if params then
    local num = 1
    for _, i in pairs(params) do
      str = string.gsub(str, "%$parameter1%$", params[num], 1)
      num = num + 1
    end
  end
  if tonumber(msgRecord.msgType) == 1 then
    if msgId ~= SSendMsgNotifyDef.GM_MESSAGE_ID then
      self:AddMessageTip(str)
    else
      self:AddGMMessageTip(str)
    end
  elseif tonumber(msgRecord.msgType) == 2 then
    NekoData.DataManager.DM_Chat:OnSReceiveSystemMsg(str)
    local userinfo = {}
    userinfo.channelType = ChannelType.CHANNEL_SYSTEM
    LuaNotificationCenter.PostNotification(Common.n_ChatInfoReceive, nil, userinfo)
  elseif tonumber(msgRecord.msgType) == 3 then
    self:AddConfirmTip(str)
  elseif tonumber(msgRecord.msgType) == 4 then
    self:AddConfirmTip(str)
  end
end

function BM_Message:AddMessageTip(msg)
  local dialog = DialogManager.CreateSingletonDialog("messagetip.msgtipframedialog")
  dialog:AddMessageTip(msg)
end

function BM_Message:AddGMMessageTip(msg)
  local dialog = DialogManager.CreateSingletonDialog("messagetip.gmmsgtipframedialog")
  dialog:AddMessageTip(msg)
end

function BM_Message:AddConfirmTip(str)
  local dialog = DialogManager.CreateSingletonDialog("messagetip.msgtipconfirmdialog")
  dialog:AddConfirmTip(str)
end

function BM_Message:OnTopMessageDestroy(notification)
  if (notification.userInfo._dialogName == "topnoticebar.topnoticebardialog" or notification.userInfo._dialogName == "topnoticebar.topnoticeloadbardialog" or notification.userInfo._dialogName == "loadingdialog") and #self._message.topNoticeBar > 0 then
    local data = self._message.topNoticeBar[1]
    table.remove(self._message.topNoticeBar, 1)
    self:SendTopMessage(data.id, data.params, data.showClear)
  end
  if notification.userInfo._dialogName == "messagetip.functionunlockdialog" then
    table.remove(self._message.functionUnlock, 1)
    self:ShowFunctionUnlockDialog()
  end
end

function BM_Message:SendTopMessage(id, params, showClear)
  local dialog = DialogManager.GetDialog("topnoticebar.topnoticebardialog")
  dialog = dialog or DialogManager.GetDialog("topnoticebar.topnoticeloadbardialog")
  if dialog or DialogManager.GetDialog("loadingdialog") then
    local data = {}
    data.id = id
    data.params = params
    data.showClear = showClear
    table.insert(self._message.topNoticeBar, data)
  else
    local msgRecord = CTopMessageTable:GetRecorder(id)
    local str = ""
    if msgRecord.msgType == 1 then
      str = TextManager.GetText(msgRecord.msgNumTextID)
      if params then
        str = string.gsub(str, "%$parameter(%d)%$", function(i)
          if id ~= 200003 and id ~= 200001 then
            return params[tonumber(i)]
          else
            local sceneId
            local allIds = CSceneInfoStatic:GetAllIds()
            for j = 1, #allIds do
              local recorder = CSceneInfoStatic:GetRecorder(allIds[j])
              if (id == 200001 and string.sub(tostring(recorder.id), 1, 3) == "100" or id == 200003 and string.sub(tostring(recorder.id), 1, 2) == "12") and recorder.floor == tonumber(params[tonumber(i)]) then
                return TextManager.GetText(recorder.nameTextID)
              end
            end
          end
        end)
      end
      dialog = DialogManager.CreateSingletonDialog("topnoticebar.topnoticebardialog")
      local msgTitle = TextManager.GetText(msgRecord.msgTitleTextID)
      local msgMain = TextManager.GetText(msgRecord.msgMainTextID)
      dialog:SetData(msgTitle, msgMain .. str, showClear)
    elseif msgRecord.msgType == 2 then
      dialog = DialogManager.CreateSingletonDialog("topnoticebar.topnoticeloadbardialog")
      local msgTitle = TextManager.GetText(msgRecord.msgTitleTextID)
      local msgNum = TextManager.GetText(msgRecord.msgNumTextID)
      local msgMain = TextManager.GetText(msgRecord.msgMainTextID)
      dialog:SetData(msgTitle, msgMain, msgNum, params, showClear)
    end
  end
end

function BM_Message:PopFunctionUnlockDialog(functionId)
  local dialog = DialogManager.GetDialog("messagetip.functionunlockdialog")
  if not self._showFunctionUnlockDialog or dialog then
    local record = CFunctionUnlockCfg:GetRecorder(functionId)
    if record and record.tips ~= 0 then
      table.insert(self._message.functionUnlock, functionId)
    end
  else
    DialogManager.CreateSingletonDialog("messagetip.functionunlockdialog"):SetData(CFunctionUnlockCfg:GetRecorder(functionId))
  end
end

function BM_Message:ShowFunctionUnlockDialog()
  self._showFunctionUnlockDialog = true
  local length = #self._message.functionUnlock
  if 0 < length then
    self:PopFunctionUnlockDialog(self._message.functionUnlock[1])
  else
    self._showFunctionUnlockDialog = false
  end
end

function BM_Message:GetFunctionUnlockNum()
  return #self._message.functionUnlock
end

function BM_Message:GetString(id, params)
  local recorder = CStringRes:GetRecorder(id)
  if recorder then
    local str = TextManager.GetText(recorder.msgTextID)
    if params then
      for i, v in ipairs(params) do
        str = string.gsub(str, "%$parameter" .. i .. "%$", v)
      end
    end
    return str
  else
    LogErrorFormat("BM_Message", "Can not find stringRes record By id: %s", id)
  end
end

function BM_Message:AddConfirmDialog(str, confirmFunc)
  local dialog = DialogManager.CreateSingletonDialog("confirmbox.confirmdialog")
  dialog:AddConfirmDialog(str, confirmFunc)
end

function BM_Message:OpenCurrencyExchangeDialog(id)
  if not CurrencyExchangeTable:GetRecorder(id) then
    LogErrorFormat("BM_Message", "CurrencyExchange not exit! id : %s", id)
    return
  end
  local dialog = DialogManager.CreateSingletonDialog("confirmbox.currencyexchangedialog")
  dialog:PushDialogSetting(id)
end

function BM_Message:OpenCurrencyExchangeBuyDialog(id, lackNum)
  if not CurrencyExchangeTable:GetRecorder(id) then
    LogErrorFormat("BM_Message", "CurrencyExchange not exit! id : %s", id)
    return
  end
  local dialog = DialogManager.CreateSingletonDialog("confirmbox.currencyexchangebuydialog")
  dialog:PushDialogSetting(id, lackNum)
end

function BM_Message:GetRoleSkillDescribe(skillId)
  local record = CSkillShow_Role:GetRecorder(skillId)
  if record then
    local str = TextManager.GetText(record.exDiscribeTextID)
    if #record.attr > 0 then
      for i, v in ipairs(record.attr) do
        str = string.gsub(str, "%$parameter" .. i .. "%$", v)
      end
    end
    return str
  else
    LogError("skillId Error.")
  end
end

function BM_Message:GetUniqueEquipSkillDescribe(skillId)
  local skillShowRecord = CSkillShow_Soul:GetRecorder(skillId)
  if skillShowRecord then
    local str = TextManager.GetText(skillShowRecord.exDiscribeTextID)
    if #skillShowRecord.attr > 0 then
      for i, v in ipairs(skillShowRecord.attr) do
        str = string.gsub(str, "%$parameter" .. i .. "%$", v)
      end
    end
    return str
  else
    LogErrorFormat("BM_Message", "no id %s in cskillshow_soul", skillId)
  end
end

function BM_Message:OpenInstructionsTipDialog(id)
  local record = CTipsConfigTable:GetRecorder(id)
  if not record then
    LogErrorFormat("BM_Message", "Can not find record By id: %s in ctipsconfig", id)
    return
  end
  DialogManager.CreateSingletonDialog("messagetip.instructionstipdialog"):SetData(record)
end

function BM_Message:GetMoneySymbol(moneyType)
  local record = CCurrencySymbol:GetRecorder(moneyType)
  if record then
    return record.symbol
  else
    LogErrorFormat("BM_Message", "Can not find record by id: %s in ccurrencysymbol", moneyType)
  end
end

return BM_Message
