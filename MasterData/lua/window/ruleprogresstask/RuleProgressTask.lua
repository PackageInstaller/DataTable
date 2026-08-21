local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local U = require("Common/Util")
local SU = require("Common/SortUtil")
local LU = require("Common/ListUtil")
local EU = require("Common/EquipUtil")
local ACU = require("Common/ActivityUtil")
local S = require("Common/Singleton")
local m_activityManager = S:Get("ActivityManager")
local ShowRolePresent = 9
local m_activityManager = S:Get("ActivityManager")
local m_sealActivityInfo, m_postcardActivityInfo, m_tenChekinActivityInfo, m_rolePresents

function SetupWindow()
  CreateTab()
end

function InitWindow()
  SetTab()
  local activeTabName = this:GetData("ProgressTaskHelpTab")
  REF[activeTabName].UIToggle.value = true
  REF.ScrollViewTab.UIScrollView:ResetPosition()
  local index = -1
  for i = 0, REF.TabGrid.transform.childCount - 1 do
    local obj = REF.TabGrid[i].root.gameObject
    if obj.gameObject.activeSelf then
      index = index + 1
      if obj.gameObject.name == activeTabName then
        break
      end
    end
  end
  if 4 < index then
    local itemHeight = REF.TabGrid.UIGrid.cellHeight
    local m_moveDistance = index * itemHeight
    REF.ScrollViewTab.UIScrollView:MoveRelative(CS.UnityEngine.Vector3(0, m_moveDistance, 0))
    REF.ScrollViewTab.UIScrollView:RestrictWithinBounds(true)
  end
end

function CreateTab()
  local allTab = PB.all("ProgressTaskConfig")
  local go = REF.TabGrid[0].root.gameObject
  for i, config in pairs(allTab) do
    local tabName = config.helpTabName
    if tabName == "" then
      tabName = config.name
    end
    local tabRef = reRef(REF.TabGrid)
    local tab = tabRef[tabName]
    local ref
    if tab == nil then
      local g = CS.NGUITools.AddChild(REF.TabGrid.gameObject, go)
      g.name = tabName
      ref = _ENV["$"](g)
      local tabLocale = config.tabLocale
      if tabLocale == "" then
        tabLocale = "ProgressTaskTabName_" .. config.name
      end
      ref.LabelButton.UIHtmlLabel.text = WU.GetString(tabLocale)
      ref.SpriteIcon.UISprite.atlasPath = config.tabIconAtlasPath
      ref.SpriteIcon.UISprite.spriteName = config.tabIconSpriteName
      ref.SpriteIcon.UISprite:SnapWithoutScale()
    else
      ref = _ENV["$"](tab)
      tab.transform:SetSiblingIndex(i - 1)
    end
    CS.EventDelegate.Add(ref.root.UIToggle.onChange, function()
      if CS.UIToggle.current.value then
        WU.SetActive(REF.ScrollViewText, true)
        REF.LabelHelp.UIHtmlLabel.text = WU.GetString("Help_" .. tabName)
        REF.ScrollViewHelp.UIScrollView:ResetPosition()
      end
    end)
  end
  WU.HandleGameObjectAttached(REF.root.gameObject)
  REF.TabGrid.UIGrid:Reposition()
end

function SetTab()
  local window = WU.FindWindow("ProgressTask")
  local actorCultivationVisible = false
  local customActorCultivationVisible = false
  WU.TraverseChildren(_ENV["$"](window).TabGrid, function(go)
    local tabName = string.sub(go.name, #"TabSlot" + 1)
    local tab = REF[tabName]
    if tab == nil then
      if go.name:find("CustomActorCultivation") ~= nil and go.activeSelf then
        customActorCultivationVisible = true
      elseif go.name:find("ActorCultivation") ~= nil and go.activeSelf then
        actorCultivationVisible = true
      end
    else
      tab.gameObject:SetActive(go.activeSelf)
    end
  end)
  if REF.ActorCultivation ~= nil then
    REF.ActorCultivation.gameObject:SetActive(actorCultivationVisible)
  end
  if REF.CustomActorCultivation ~= nil then
    REF.CustomActorCultivation.gameObject:SetActive(customActorCultivationVisible)
  end
  REF.TabGrid.UIGrid:Reposition()
end
