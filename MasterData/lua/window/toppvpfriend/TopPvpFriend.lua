local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local CU = require("Common/ChatUtil")
local U = require("Common/Util")
local HU = require("Common/HtmlUtil")
local DU = require("Common/DungeonUtil")
local LU = require("Common/ListUtil")
local m_friendList

function SetupWindow()
  LU.Bind(REF.WrapContent, {
    updateRow = UpdateWidget
  })
end

function UpdateWidget(refRow, wrapIndex, realIndex)
  if m_friendList then
    local info = m_friendList[realIndex + 1]
    if info then
      refRow.TopPvpFriendSlot["$SetData"](info)
    end
  end
end

function InitWindow()
  REF.NoData.gameObject:SetActive(false)
  REF.HasData.gameObject:SetActive(false)
  this:Bind("fci/friendlist/", FriendWrapContent)
end

function FriendWrapContent(res)
  if res == nil or #res == 0 then
    REF.NoData.gameObject:SetActive(true)
    REF.HasData.gameObject:SetActive(false)
    return
  end
  m_friendList = {}
  for k, v in pairs(res) do
    if v.playerId ~= nil and v.playerId ~= "" and v.lastLogoutTime == 0 then
      m_friendList[#m_friendList + 1] = v
      this:SetData("PvpFriend" .. v.playerId, v)
    end
  end
  if #m_friendList == 0 then
    REF.NoData.gameObject:SetActive(true)
    REF.HasData.gameObject:SetActive(false)
  else
    REF.NoData.gameObject:SetActive(false)
    REF.HasData.gameObject:SetActive(true)
  end
  LU.Set(REF.WrapContent, #m_friendList, true)
end
