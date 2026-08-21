local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local S = require("Common/Singleton")
local U = require("Common/Util")
local LU = require("Common/ListUtil")
local DBH = require("Manager/DataBindingHandler")
local IU = require("Common/ItemUtil")
local MU = require("Common/MailUtil")
local m_configDataManager = S:Get("ConfigDataManager")
local m_mails = {}
local m_mailWarningCount, m_autoDelete, m_resetPosition

function SetupWindow()
  WU.BindButtonEvent(REF.ButtonAutoDelete, function()
    WU.RecordButtonClick(fif(m_autoDelete, 143004, 143005))
    this:GameRequest("fci/mail-auto-delete/"):Post({
      autoDelete = not m_autoDelete
    }, function(result)
      this:SetData("fci/mail-auto-delete/", result)
    end)
  end)
  WU.BindButtonEvent(REF.ButtonReceiveAll, OnReceiveAllClick)
  LU.Bind(REF.MailContent, {
    updateRow = UpdateRow
  })
end

function InitWindow()
  m_resetPosition = true
  m_mailWarningCount = PB.all("Misc")[1].mailWarningCount
  m_autoDelete = nil
  WU.ToggleRendering(REF.MailContent, false)
  REF.ButtonAutoDelete.gameObject:SetActive(false)
  this:Bind("fci/mail/", OnMailListChange)
  this:BindRemote(DB:GameRequest("fci/mail-auto-delete/"), function(result)
    if result ~= nil then
      AutoDeleteChanged(result.autoDelete)
      REF.ButtonAutoDelete.gameObject:SetActive(true)
      if result.delMails and not table.empty(result.delMails) then
        MU.RemoveFromDelayMails(result.delMails)
        DBH.MailRemoveBatch(result.delMails)
      end
    end
  end)
  this:RegisterGameEvent("Mail/AttachmentsGot", OnAttachmentsGot)
  this:RegisterGameEvent("Mail/Read", OnMailRead)
  this:RegisterGameEvent("Mail/Delete", OnMailDelete)
  if m_mails and #m_mails > m_mailWarningCount then
    WU.ShowHintText(WU.GetString("Mail_WarningCount"))
  end
  local nav = WU.FindWindow("Navigation")
  if nav then
    _ENV["$"](nav)["$$Save"]()
    _ENV["$"](nav)["$$SetBackCallback"](function()
      OnBackValidate()
    end)
    _ENV["$"](nav)["$$SetHomeCallback"](function()
      OnBackValidate(true)
    end)
  end
end

function UninitWindow()
  local nav = WU.FindWindow("Navigation")
  if nav then
    _ENV["$"](nav)["$$Load"]()
  end
end

function OnBackValidate(isHome)
  if isHome then
    Home()
  else
    this:BroadcastGameEvent("OnNavigation", "Back")
  end
end

function Home()
  local winName = "City"
  WU.RecycleWindow("MazeInterEvent")
  if WU.IsStandaloneGame() then
    winName = "StoryMode"
  end
  S:Get("TutorialManager").SetNavigation(winName)
  this:BroadcastGameEvent("OnNavigation", winName)
end

function UpdateWindow(delta)
  local timeElapse = this:GetData("Mail/TimeElapse") or {}
  local delMails = _ENV["!"]({})
  for i = #timeElapse, 1, -1 do
    local data = timeElapse[i]
    data.time = data.time - delta
    if 1 >= data.time then
      table.remove(timeElapse, i)
      table.insert(delMails, data.id)
    end
  end
  OnMailClose(delMails)
end

function OnMailClose(delMails)
  if table.empty(delMails) then
    return
  end
  MU.RemoveFromDelayMails(delMails)
  DBH.MailRemoveBatch(delMails)
  local top = WU.TopWindow()
  if top and top.name == "Mail" then
    WU.ShowHintText(WU.GetString("Mail_DeleteRefresh"))
  end
end

function OnMailListChange(result)
  if result ~= nil then
    REF.NodeEmpty.gameObject:SetActive(#result == 0)
    WU.ToggleRendering(REF.MailContent, #result ~= 0)
    table.sort(result, function(a, b)
      return a.id > b.id
    end)
    m_mails = SortMails(result)
    LU.Set(REF.MailContent, #m_mails, m_resetPosition)
    if m_resetPosition then
      REF.MailContent.UIPlayTween:Play(true)
      m_resetPosition = false
    else
      REF.MailScrollView.UIScrollView:Scroll(-0.01)
    end
    if #m_mails <= m_mailWarningCount then
      REF.LabelMailsCount.UIHtmlLabel.text = "<font color=#FFFFFF>" .. #m_mails .. "/99</font>"
    elseif #m_mails < 99 then
      REF.LabelMailsCount.UIHtmlLabel.text = "<font color=#FFFF37>" .. #m_mails .. "/99</font>"
    else
      REF.LabelMailsCount.UIHtmlLabel.text = "<font color=#FF0000>" .. #m_mails .. "/99</font>"
    end
  else
    REF.NodeEmpty.gameObject:SetActive(true)
    REF.LabelMailsCount.UIHtmlLabel.text = "<font color=#FFFFFF>" .. #m_mails .. "/99</font>"
  end
end

function SortMails(mails)
  local unreadUngot = _ENV["!"]({})
  local readUngot = _ENV["!"]({})
  local readForNothing = _ENV["!"]({})
  local readAndGot = _ENV["!"]({})
  for i = 1, #mails do
    local mail = mails[i]
    if mail.attachmentsGot == false and mail.read == false then
      table.insert(unreadUngot, mail)
    elseif not table.empty(mail.attachments) and mail.attachmentsGot == false and mail.read == true then
      table.insert(readUngot, mail)
    elseif mail.read and table.empty(mail.attachments) then
      table.insert(readForNothing, mail)
    else
      table.insert(readAndGot, mail)
    end
  end
  local result = _ENV["!"]({})
  result:append(unreadUngot)
  result:append(readUngot)
  result:append(readForNothing)
  result:append(readAndGot)
  return result
end

function UpdateRow(rowRef, wrapIndex, realIndex)
  if 0 < #m_mails and realIndex ~= nil and realIndex < #m_mails then
    local mailId = m_mails[realIndex + 1].id
    rowRef["$$BindMail"](mailId)
  end
end

function OnReceiveAllClick()
  WU.RecordButtonClick(143006)
  if not MU.MailCanReceive(true) then
    return
  end
  this:GameRequest("fci/mail/"):Patch({attachmentsGot = true}, function(result)
    HandlerMailPatchResponse(result)
  end)
end

function HandlerMailPatchResponse(result, noAttachments)
  local resChange = result.resChange
  local delMails = result.delMails or {}
  local gotMails = result.attachmentsGot or {}
  DBH.ResChange(resChange)
  if 0 < #resChange then
    WU.ShowRewards(resChange)
  elseif not noAttachments then
    WU.ShowHintText(WU.GetString("Window_MailNoAttachments"))
  end
  for i = 1, #gotMails do
    local mail = this:GetData("fci/mail/" .. gotMails[i])
    if mail ~= nil then
      mail.attachmentsGot = true
      mail.read = true
      this:SetData("fci/mail/" .. mail.id, mail)
    end
  end
  if not table.empty(delMails) then
    MU.RemoveFromDelayMails(delMails)
    DBH.MailRemoveBatch(delMails)
  end
  if not table.empty(delMails) or not table.empty(gotMails) then
    this:SetData("fci/mail/", this:GetData("fci/mail/"))
  end
end

function OnMailDelete(mailId)
  this:GameRequest("fci/mail/" .. mailId):Delete(function(response)
    DBH.MailRemove(mailId)
  end)
end

function OnAttachmentsGot(mailId)
  if not MU.MailCanReceive(true) then
    return
  end
  this:GameRequest("fci/mail/" .. mailId):Patch({attachmentsGot = true}, function(result)
    HandlerMailPatchResponse(result)
  end)
end

function OnMailRead(mailId)
  this:GameRequest("fci/mail/" .. mailId):Patch({read = true}, function(result)
    if m_autoDelete then
      HandlerMailPatchResponse(result, true)
    else
      local k, mail = table.find(m_mails, function(k, v)
        return v.id == mailId
      end)
      if mail ~= nil then
        m_mails[k].read = true
      end
      local mailDetail = this:GetData("fci/mail/" .. mailId)
      if mailDetail ~= nil then
        mailDetail.read = true
        this:SetData("fci/mail/" .. mailId, mailDetail)
      end
      this:SetData("fci/mail/", this:GetData("fci/mail/"))
    end
  end)
end

function AutoDeleteChanged(autoDelete)
  m_autoDelete = autoDelete
  REF.ButtonAutoDeleteFalse.gameObject:SetActive(not autoDelete)
  REF.ButtonAutoDeleteTrue.gameObject:SetActive(autoDelete)
end

function Focus(on)
  WU.RecordWindowFocus(100143, on)
end
