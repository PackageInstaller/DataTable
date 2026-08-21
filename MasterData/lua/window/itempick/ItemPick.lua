local WU, DB, REF = require("Common/WindowUtil")(this)
local AU = require("Common/ActorUtil")
local PB = require("Common/PbHelper")
local LU = require("Common/ListUtil")
local m_oriSelect, m_fromWindow, m_type, m_isFixed
local m_selectNum = 0
local m_selectedItems, m_items
local m_selectedWidgets = {}
local m_finishClick

function SetupWindow()
  WU.BindButtonEvent(REF.BtnFinishFixed, OnFinishClick)
  WU.BindButtonEvent(REF.BtnFinishScroll, OnFinishClick)
  for i = 1, #REF.WrapContentActor do
    WU.TraverseChildren(REF.WrapContentActor[i - 1]["$"], function(go)
      WU.BindButtonEvent(go, OnActorWidgetClick)
    end)
  end
  LU.Bind(REF.WrapContentActor, {
    dataSource = function(dataIndex)
      return m_items and m_items[dataIndex]
    end,
    updateSlot = OnUpdateSlot
  })
  LU.Bind(REF.WrapContentPre, {
    updateRow = OnUpdatePreRow
  })
end

function InitWindow()
  REF.NodeContainerActor.gameObject:SetActive(false)
  REF.NodePreviewFixed.gameObject:SetActive(false)
  REF.NodePreviewScroll.gameObject:SetActive(false)
end

function OnFinishClick()
  if m_finishClick then
    m_finishClick()
    return
  end
  if m_fromWindow == "GachaResult" or m_fromWindow == "CollectionsActor" then
    if m_selectedItems and #m_selectedItems == m_selectNum then
      this:SetData("Share/SelectedActors", m_selectedItems)
      WU.RecycleWindow(this)
    else
      WU.ShowHintText(WU.GetString("Window_ShareMustSelectEnoughActor", m_selectNum))
    end
  elseif m_fromWindow == "MySpaceActor" then
    local selectIds
    for i = 1, #m_selectedItems do
      selectIds = selectIds or {}
      table.insert(selectIds, m_selectedItems[i].roleId)
    end
    local favorRolesTable = {favorRoles = selectIds}
    local wireFormatfavor = ProtobufT("ApiRelationPlayerPageInfo", favorRolesTable)
    this:GameRequest("fci/playerpageinfo/"):Patch(wireFormatfavor, function(result)
      this:SetData("Space/SelectedPlayer", result)
      WU.RecycleWindow(this)
    end)
  end
end

function SetEditInfo(items, selectNum, selectedItems, fromWindow)
  m_items = items
  m_selectNum = selectNum
  m_oriSelect = selectedItems
  m_selectedItems = {}
  m_fromWindow = fromWindow
  for i = 1, #m_oriSelect do
    table.insert(m_selectedItems, m_oriSelect[i])
  end
  if m_fromWindow == "GachaResult" or m_fromWindow == "CollectionsActor" or m_fromWindow == "MySpaceActor" then
    m_type = "actor"
  end
  if m_type == "actor" then
    REF.NodeContainerActor.gameObject:SetActive(true)
    local row = math.ceil(#m_items / #REF.WrapContentActor[0]["$"])
    LU.Set(REF.WrapContentActor, row)
    REF.BottomBarSpace.gameObject:SetActive(true)
    REF.BottomBarSpace.transform.localPosition = CS.UnityEngine.Vector3(0, (1 - row) * REF.WrapContentActor.UIWrapContent.itemSize, 0)
    m_isFixed = m_selectNum <= 6
    if not m_isFixed then
      LU.Set(REF.WrapContentPre, 0)
      REF.NodePreviewScroll.gameObject:SetActive(true)
    else
      REF.NodePreviewFixed.gameObject:SetActive(true)
    end
    SetSelectInfo(selectedItems)
  end
end

function OnUpdateSlot(ref, actor)
  ref.ActorSprite.UISprite.spriteName = "actor_head_" .. (actor.config and actor.config.animRes or actor.animRes)
  ref.BGSprite1.UISprite.spriteName = "role_bg_" .. tostring(actor.quality or 0)
  ref.SpriteMask.gameObject:SetActive(actor.unlock ~= nil and actor.unlock ~= true)
  ref.SpriteSub.gameObject:SetActive(false)
  if actor.config and actor.config.kind and actor.config.kind == 2 then
    ref.SpriteSub.UISprite.spriteName = "rolelist_sub_s_" .. tostring(actor.quality or 0)
    ref.SpriteSub.gameObject:SetActive(true)
  end
  ref["@data"] = actor
  ref["@locked"] = actor.unlock ~= nil and actor.unlock ~= true
  local idx
  if actor.uid then
    idx = table.find(m_selectedItems, function(k, v)
      return v.uid == actor.uid
    end)
  elseif actor.id then
    idx = table.find(m_selectedItems, function(k, v)
      return v.id == actor.id
    end)
  elseif actor.roleId then
    idx = table.find(m_selectedItems, function(k, v)
      return v.roleId == actor.roleId
    end)
  end
  if idx ~= nil then
    ref.SelectedSprite.gameObject:SetActive(true)
    ref.SelectedSprite.UISprite.spriteName = "number_icon_" .. idx
    m_selectedWidgets[idx] = ref
  else
    ref.SelectedSprite.gameObject:SetActive(false)
  end
end

function OnActorWidgetClick(go)
  local ref = _ENV["$"](go)
  local locked = ref["@locked"]
  if locked and m_fromWindow == "MySpaceActor" then
    WU.ShowHintText(WU.GetString("Window_ActorNotGet"))
    return
  end
  local actor = ref["@data"]
  local idx
  if actor.uid then
    idx = table.find(m_selectedItems, function(k, v)
      return v.uid == actor.uid
    end)
  elseif actor.id then
    idx = table.find(m_selectedItems, function(k, v)
      return v.id == actor.id
    end)
  elseif actor.roleId then
    idx = table.find(m_selectedItems, function(k, v)
      return v.roleId == actor.roleId
    end)
  end
  if idx ~= nil then
    table.remove(m_selectedItems, idx)
  elseif #m_selectedItems < m_selectNum then
    table.insert(m_selectedItems, actor)
  end
  SetSelectInfo(m_selectedItems)
  local row = math.ceil(#m_items / #REF.WrapContentActor[0]["$"])
  LU.Set(REF.WrapContentActor, row, false)
end

function SetSelectInfo(actors)
  local ref
  if m_isFixed then
    for i = 1, #REF.PreviewSeqFixed do
      local ref = REF.PreviewSeqFixed[i - 1]
      if i <= m_selectNum then
        ref.root.gameObject:SetActive(true)
        if actors and actors[i] ~= nil then
          UpdateWidgetElem(ref, actors[i])
        else
          ref.UnpickedNode.gameObject:SetActive(true)
          ref.Selection.gameObject:SetActive(false)
        end
      else
        ref.root.gameObject:SetActive(false)
      end
    end
    REF.NodePreviewFixed.gameObject:SetActive(true)
  else
    LU.Set(REF.WrapContentPre, #actors)
    REF.LabelSelectNum.UILabel.text = #actors
    REF.LabelTotalNum.UILabel.text = m_selectNum
    local itemWidth = REF.WrapContentPre.UIWrapContent.itemSize
    local moveDistance = (#actors - 1) * itemWidth
    REF.ScrollViewPre.UIScrollView:MoveRelative(CS.UnityEngine.Vector3(-moveDistance, 0, 0))
    REF.ScrollViewPre.UIScrollView:RestrictWithinBounds(true)
  end
end

function OnUpdatePreRow(rowRef, wrapIndex, realIndex)
  if m_selectedItems and realIndex ~= nil and realIndex < #m_selectedItems then
    UpdateWidgetElem(rowRef, m_selectedItems[realIndex + 1])
  end
end

function UpdateWidgetElem(ref, actor)
  if m_isFixed then
    ref.UnpickedNode.gameObject:SetActive(false)
  end
  ref.Selection.gameObject:SetActive(true)
  ref.ActorSprite.UISprite.spriteName = "actor_head_" .. (actor.config and actor.config.animRes or actor.animRes)
  ref.BGSprite1.UISprite.spriteName = "role_bg_" .. tostring(actor.quality or 0)
  ref.SpriteSub.gameObject:SetActive(false)
  if actor.config and actor.config.kind and actor.config.kind == PB.enum.ActorType.Sub then
    ref.SpriteSub.UISprite.spriteName = "rolelist_sub_s_" .. tostring(actor.quality or 0)
    ref.SpriteSub.gameObject:SetActive(true)
  end
end
