local PB = require("Common/PbHelper")
local WU, DB, REF = require("Common/WindowUtil")(this)
local HU = require("Common/HtmlUtil")
local LU = require("Common/ListUtil")
local U = require("Common/Util")
local CooldownInterval = 10
local ListType = {
  [PB.enum.TeamDungeonInviteFrom.Friend] = this:GetData("fci/friendlist/"),
  [PB.enum.TeamDungeonInviteFrom.Guild] = this:GetData("fci/guild/members/")
}
local m_type, m_data, m_roomInfo

function SetupWindow()
  LU.Bind(REF.WrapContent, {
    updateRow = UpdateRow,
    delta = 0.067
  })
  WU.BindButtonEvent(REF.InviteAll, function()
    if m_data then
      if not table.find(m_roomInfo.memberList, function(k, v)
        return U.trim(v) == ""
      end) then
        WU.ShowHintText(WU.GetString("DungeonTeam_GroupIsFull"))
        return
      end
      local playerIds = {}
      local cooldown = this:GetData("DungeonTeamInvite/Cooldown")
      local map = {}
      for i = 1, #m_data do
        local inGroup = table.find(m_roomInfo.memberList, function(k, v)
          return v == m_data[i].playerId
        end)
        if (cooldown[m_data[i].playerId] == nil or cooldown[m_data[i].playerId] < 0) and inGroup == nil then
          table.insert(playerIds, m_data[i].playerId)
          cooldown[m_data[i].playerId] = CooldownInterval
          map[m_data[i].playerId] = true
        end
      end
      for i = 0, #REF.WrapContent - 1 do
        if map[REF.WrapContent[i]["@playerId"] or ""] then
          REF.WrapContent[i]["$$CooldownTag"](false)
        end
      end
      if not table.empty(playerIds) then
        this:BroadcastGameEvent("DungeonTeamInvite", playerIds, m_type)
        WU.ShowHintText(WU.GetString("DungeonTeam_InviteAllSuccess"))
      else
        WU.ShowHintText(WU.GetString("DungeonTeam_NoInviteTargets"))
      end
    end
  end)
end

function InitWindow()
  m_data = nil
  m_roomInfo = this:GetData("DungeonTeam/RoomInfo")
end

function UpdateRow(rowRef, wrapIndex, rowIndex)
  WU.ToggleRendering(rowRef["$"], rowIndex ~= nil)
  if rowIndex ~= nil and m_data ~= nil and rowIndex < #m_data then
    local data = m_data[rowIndex + 1]
    rowRef["$$SetData"](data, m_type)
  end
end

function InitData(type, level)
  m_type = type
  m_data = Filter(ListType[type], level)
  local isEmpty = table.empty(m_data)
  REF.Content.gameObject:SetActive(not isEmpty)
  REF.EmptyList.gameObject:SetActive(isEmpty)
  local pivot = fif(#m_data < #REF.WrapContent - 1, CS.UIWidget.Pivot.Center, CS.UIWidget.Pivot.TopLeft)
  REF.ScrollViewList.UIScrollView.contentPivot = pivot
  LU.Set(REF.WrapContent, #m_data)
end

function Filter(data, level)
  local result = _ENV["!"]({})
  if data ~= nil then
    local myPlayerId = this:GetData("playerId")
    for i = 1, #data do
      if level <= data[i].level and data[i].lastLogoutTime == 0 and data[i].playerId ~= myPlayerId then
        table.insert(result, data[i])
      end
    end
  end
  return result
end
