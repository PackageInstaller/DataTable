local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local EU = require("Common/EquipUtil")
local U = require("Common/Util")
local OnlyContent = {
  [0] = 280,
  [1] = 520
}
local m_mail, m_mailIndex

function SetupWindow()
  WU.BindButtonEvent(REF.ButtonGotIt, OnCloseClick)
  WU.BindButtonEvent(REF.ButtonFullContentReceive, OnGotItClick)
  WU.BindButtonEvent(REF.ButtonFullContentClose, OnCloseClick)
  REF.ButtonClose["$SetCallback"](OnCloseClick)
  REF.Black["$SetCallback"](OnCloseClick)
end

function InitWindow()
  this:RegisterGameEvent("OnLinkClick", OnLinkClick)
  m_mail = nil
  local mailId = this:GetData("Mail/SelectedId")
  this:Bind("fci/mail/" .. mailId, OnMailContent)
end

function OnGotItClick()
  WU.RecordButtonClick(143003)
  if m_mail ~= nil then
    if m_mail.attachmentsGot == false then
      this:BroadcastGameEvent("Mail/AttachmentsGot", m_mail.id)
    end
    WU.RecycleWindow("MailFullContent")
  end
end

function OnCloseClick()
  if m_mail ~= nil then
    if m_mail.read == false then
      this:BroadcastGameEvent("Mail/Read", m_mail.id)
    end
    WU.RecycleWindow("MailFullContent")
  end
end

function OnMailContent(mail)
  if mail ~= nil then
    m_mail = mail
    local sender = mail.senderName
    local time = mail.createTime
    local content = mail.content
    local title = mail.title
    local attachments = m_mail.attachments or {}
    local isAttachimentGot = m_mail.attachmentsGot
    REF.MailContent.UIWidget.height = OnlyContent[fif(#attachments == 0, 1, 0)]
    REF.LabelSender.UILabel.text = WU.GetString("Window_MailSender", sender)
    REF.LabelTime.UIHtmlLabel.text = WU.RenderTime(time)
    REF.LabelMailContent.UIHtmlLabel.text = content
    REF.LabelTitle.UILabel.text = title
    REF.ButtonFullContentReceive.gameObject:SetActive(false)
    REF.ButtonFullContentClose.gameObject:SetActive(false)
    REF.SpriteReceived.gameObject:SetActive(false)
    WU.TraverseChildren(REF.SlotContainer, function(go)
      go:SetActive(false)
    end)
    REF.AttachmentsBg.gameObject:SetActive(0 < #attachments)
    if 0 < #attachments then
      REF.ButtonGotIt.gameObject:SetActive(isAttachimentGot)
      REF.ButtonFullContentReceive.gameObject:SetActive(not isAttachimentGot)
      REF.SpriteReceived.gameObject:SetActive(isAttachimentGot)
      for i = 1, #attachments do
        local ref = REF.SlotContainer[i - 1]
        ref["$gameObject"]:SetActive(true)
        local showRes = WU.AttachmentToResourceType(attachments[i])
        if showRes.type == PB.enum.ResourceType.ResUniqueWeapon then
          ref["$$SetData"](showRes.type, showRes.id, nil, "S")
          ref["$$ShowCustom"]({
            hideLevel = true,
            showEquip = false,
            showStar = false,
            phase = 1
          })
        else
          ref["$$SetData"](showRes.type, showRes.id, showRes.count)
        end
      end
    end
    REF.SlotContainer.UIPlayTween:Play(true)
  end
end

function OnLinkClick(url)
  CS.Msdk.WGPlatform.Instance:WGOpenUrl(url)
end
