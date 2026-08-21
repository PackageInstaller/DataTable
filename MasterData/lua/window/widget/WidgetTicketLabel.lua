local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local m_ticket

function Start()
  WU.BindButtonEvent(REF.ClickArea, OnShowTicketMessage)
end

function UpdateTickets(ticket)
  if ticket ~= nil then
    m_ticket = ticket
    REF.TicketLabel.ResourcePrinter:SetResource(ticket.type, ticket.id, 1)
  end
end

function UpdateTickets_ClickOff(ticket)
  m_ticket = nil
  if ticket ~= nil then
    REF.TicketLabel.ResourcePrinter:SetResource(ticket.type, ticket.id, 1)
  end
end

function OnShowTicketMessage()
  if m_ticket ~= nil then
    if m_ticket.type == PB.enum.ResourceType.ResItem then
      WU.ShowItemDetail(m_ticket.id)
    else
      WU.ShowHintText(WU.GetString("ResourceTypeName_" .. m_ticket.type))
    end
  end
end
