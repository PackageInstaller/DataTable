local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local LU = require("Common/ListUtil")
local EU = require("Common/EquipUtil")
local NU = require("Common/NotepadUtil")
local m_novels

function SetupWindow()
  REF.Share.gameObject:SetActive(false)
  m_novels = NU.CreateNovelsData()
  LU.Bind(REF.WrapContentNovelList, {
    dataSource = function(dataIndex)
      return m_novels and m_novels[dataIndex]
    end,
    updateSlot = UpdateNovelSlot,
    slotsName = "Slots",
    delta = 0.01
  })
end

function InitWindow()
  WU.ToggleRendering(REF.NodeNovelList, false)
  this:Bind("fci/CollectionsNovel", function(result)
    if result then
      for _, novel in pairs(result.novels) do
        local novelData = this:GetData("Collections/Novels/" .. novel.novelId)
        if novelData ~= nil then
          if novel.curCover == 0 then
            novel.curCover = novelData.curCover
          end
          table.merge(novelData, novel)
          novelData.unlock = true
        end
        this:SetData("Collections/Novels/" .. novel.novelId, novelData)
      end
      WU.ToggleRendering(REF.NodeNovelList, true)
      LU.Set(REF.WrapContentNovelList, math.ceil(#m_novels / #REF.Slots))
    end
  end)
  if WU.IsShareSwitchOn() then
    this:RegisterGameEvent("UI/WindowUninited", OnWindowUninited)
  end
end

function SetShareInfo(window)
  this:SetData("ShareConfig", {
    shareName = "CollectionsNovel",
    fromWindow = WU.TopWindow() and WU.TopWindow().name
  })
  REF.Share.gameObject:SetActive(true)
  ToggleSlotBg(false)
end

function OnWindowUninited(window)
  if window.name == "Share" then
    REF.Share.gameObject:SetActive(false)
    ToggleSlotBg(true)
  end
end

function ToggleSlotBg(visible)
  for i = 0, #REF.WrapContentNovelList - 1 do
    local ref = REF.WrapContentNovelList[i]
    ref.root.UISprite.enabled = visible
    ref.Html.gameObject:SetActive(visible)
    WU.TraverseChildren(ref.Slots, function(go)
      _ENV["$"](go)["$$ToggleStateUI"](visible)
    end)
  end
end

function UpdateNovelSlot(slotRef, novel)
  slotRef["$$SetData"](novel)
end

function Focus(on)
  WU.RecordWindowFocus(1001362, on)
end
