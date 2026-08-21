local WU, DB, REF = require("Common/WindowUtil")(this)

function Start()
  WU.BindButtonEvent(REF.TagLeft, OpenSortFullScreen)
  WU.BindButtonEvent(REF.TagCenter, OpenSortFullScreen)
  WU.BindButtonEvent(REF.TagRight, OpenSortFullScreen)
  WU.BindButtonEvent(REF.ResetAdvanced, ResetAdvanced)
end

function ResetAdvanced()
  local sortMate = this:GetData("SortMate/Current")
  local sortLocalContext = WU.GetGameDataCache("SortLocalContext") or {}
  local advancedFilters = {
    contextName = sortMate.contextName,
    kind = 0,
    tags1 = 0,
    tags2 = 0,
    displayOption = "name"
  }
  sortLocalContext[sortMate.contextName] = advancedFilters
  this:BroadcastGameEvent("ApplySortAlternative", sortMate.tabIndex, sortMate.reverse, advancedFilters)
end

function OpenSortFullScreen()
  local top = WU.TopWindow()
  if top and top.name == "SortFullScreen" then
    return
  end
  WU.AcquireWindowAsync("SortFullScreen", function(ui)
  end)
end

function FilterContext(context, showReset)
  REF.ResetAdvanced.gameObject:SetActive(context ~= nil)
  REF.Grid.gameObject:SetActive(context ~= nil)
  if context == nil then
    return
  end
  REF.ResetAdvanced.gameObject:SetActive(showReset and (context.kind ~= 0 or context.tags1 ~= 0 or context.tags2 ~= 0))
  REF.TagLeft.gameObject:SetActive(context.kind ~= 0)
  REF.TagCenter.gameObject:SetActive(context.tags1 ~= 0)
  REF.TagRight.gameObject:SetActive(context.tags2 ~= 0)
  local tagLocTable = {}
  table.insert(tagLocTable, WU.GetString("tag" .. context.kind .. "_kind"))
  table.insert(tagLocTable, WU.GetString("tag" .. context.tags1))
  table.insert(tagLocTable, WU.GetString("tag" .. context.tags2))
  for i = 0, #REF.Grid - 1 do
    REF.Grid[i].Label.UILabel.text = tagLocTable[i + 1]
  end
  REF.Grid.UIGrid:Reposition()
end
