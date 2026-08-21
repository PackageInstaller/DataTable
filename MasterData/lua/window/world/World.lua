local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local S = require("Common/Singleton")
local U = require("Common/Util")
local LU = require("Common/ListUtil")
local m_allWorlds = {}

function SetupWindow()
  LU.Bind(REF.AllWorldContentShort, {
    dataSource = GetData,
    updateSlot = UpdateSlot
  })
  LU.Bind(REF.AllWorldContentLong, {
    dataSource = GetData,
    updateSlot = UpdateSlot
  })
  WU.BindButtonEvent(REF.SpriteBoard, OnBoardClick)
end

function InitWindow()
  REF.RecentView.gameObject:SetActive(false)
  REF.AllWorldScrollViewLong.gameObject:SetActive(false)
end

function GetData(dataIndex)
  return m_allWorlds and m_allWorlds[dataIndex]
end

function UpdateSlot(widgetRef, data)
  if data ~= nil then
    widgetRef["$$UpdateSlot"](data)
  end
end

function SetDirInfo(dirInfo)
  if dirInfo ~= nil then
    m_allWorlds = dirInfo.dirWorld
    table.sort(m_allWorlds, SortWorld)
    local recentWorlds = {}
    for i = 1, 3 do
      if m_allWorlds[i] == nil or m_allWorlds[i].playerInfo == nil or m_allWorlds[i].playerInfo.lastLogoutTime == 0 then
        break
      end
      table.insert(recentWorlds, m_allWorlds[i])
    end
    local reccentCount = #recentWorlds
    local hasRecentWorld = reccentCount ~= 0
    if hasRecentWorld then
      for i = 1, 3 do
        local slot = REF.RecentWorldContent[i - 1]
        slot["$gameObject"]:SetActive(i <= reccentCount)
        if i <= reccentCount then
          slot["$$UpdateSlot"](recentWorlds[i])
        end
      end
      LU.Set(REF.AllWorldContentShort, math.ceil(#m_allWorlds / #REF.AllWorldContentShort[0].root))
      REF.Drag.UIDragScrollView.scrollView = REF.AllWorldScrollViewShort.UIScrollView
    else
      LU.Set(REF.AllWorldContentLong, math.ceil(#m_allWorlds / #REF.AllWorldContentLong[0].root))
      REF.Drag.UIDragScrollView.scrollView = REF.AllWorldScrollViewLong.UIScrollView
    end
    REF.RecentView.gameObject:SetActive(hasRecentWorld)
    REF.AllWorldScrollViewLong.gameObject:SetActive(not hasRecentWorld)
    REF.RecentWorldScrollView.UIScrollView:ResetPosition()
    REF.AllWorldScrollViewShort.UIScrollView:ResetPosition()
    REF.AllWorldScrollViewLong.UIScrollView:ResetPosition()
  end
end

function SortWorld(a, b)
  if a.playerInfo == nil then
    return false
  elseif b.playerInfo == nil then
    return true
  else
    return a.playerInfo.lastLogoutTime > b.playerInfo.lastLogoutTime
  end
end

function OnBoardClick()
  local worldInfo = m_allWorlds.worldInfo
  this:SetData("CurrentWorld", worldInfo)
  WU.RecycleWindow(this)
end
