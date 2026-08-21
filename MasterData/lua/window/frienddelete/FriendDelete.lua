local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local LU = require("Common/ListUtil")
local SU = require("Common/SortUtil")
local CU = require("Common/ChatUtil")
local DBH = require("Manager/DataBindingHandler")
local m_allFriend, m_selectedFriend, m_afkTime

function SetupWindow()
  LU.Bind(REF.WrapContent, {
    updateRow = OnFriendItem
  })
  WU.BindButtonEvent(REF.ButtonFastSelect, OnFastSelectClick)
  WU.BindButtonEvent(REF.ButtonBatchDelete, OnBatchDeleteClick)
  WU.TraverseChildren(REF.WrapContent, function(go)
    local ref = _ENV["$"](go)
    WU.BindButtonEvent(ref.ButtonSelect, function()
      local info = m_selectedFriend[ref["@info"].playerId]
      m_selectedFriend[ref["@info"].playerId] = fif(info == nil, ref["@info"].name, nil)
      WU.ToggleRendering(ref.SpriteSelected, m_selectedFriend[ref["@info"].playerId] ~= nil)
    end)
  end)
  local info = PB.index("Misc", 1)
  m_afkTime = PB.index("Misc", 1).friendFastDeleteTime * 24 * 3600
end

function InitWindow()
  m_selectedFriend = _ENV["!"]({})
  this:Bind("SortFinished", OnSortFinished)
end

function OnSortFinished(data)
  if data == nil or data.sortMate ~= REF["$SortMate"] then
    return
  end
  m_allFriend = {}
  for _, f in pairs(data.list) do
    if f.playerId ~= nil and f.playerId ~= "" then
      f.online = fif(f.lastLogoutTime == 0, 1, 0)
      table.insert(m_allFriend, f)
    end
  end
  REF.SpriteFriendEmpty.gameObject:SetActive(#m_allFriend <= 0)
  LU.Set(REF.WrapContent, #m_allFriend)
end

function OnFriendItem(rowRef, wrapIndex, realIndex)
  if m_allFriend ~= nil and realIndex < #m_allFriend then
    local player = m_allFriend[realIndex + 1]
    rowRef["@info"] = player
    rowRef["$$SetData"](player, 1)
    WU.ToggleRendering(rowRef.SpriteSelected, m_selectedFriend[player.playerId] ~= nil)
    rowRef["$$SetClickCallback"](function()
      WU.ShowPlayerSpace(player.playerId, nil, "ToggleTeam")
    end)
  end
end

function OnFastSelectClick()
  local now = CS.GameTime.serverUtc
  for _, friend in pairs(m_allFriend) do
    if friend.lastLogoutTime ~= 0 and now > friend.lastLogoutTime + m_afkTime then
      m_selectedFriend[friend.playerId] = friend.name
    end
  end
  LU.Set(REF.WrapContent, #m_allFriend, false)
end

function OnBatchDeleteClick()
  WU.ShowMessageYesNo(WU.GetString("WindowFriend_ConfirmBatchDelete"), function(message)
    if message == "YES" then
      this:GameRequest("fci/friendlist/"):Patch({
        targetList = m_selectedFriend:keys()
      }, function(result)
        for _, id in pairs(result.delResult) do
          CU.AddLatestTalkTarget(id, m_selectedFriend[id])
          m_selectedFriend[id] = nil
        end
        DBH.RelationFriendlistRemoveBatch(result.delResult)
        local sortMate = REF["$SortMate"]
        this:BroadcastGameEvent("ApplySortAlternative", sortMate.tabIndex, sortMate.reverse)
      end)
    end
  end)
end
