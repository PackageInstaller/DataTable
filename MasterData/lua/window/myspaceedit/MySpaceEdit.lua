local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local CU = require("Common/ChatUtil")
local U = require("Common/Util")
local LU = require("Common/ListUtil")
local NU = require("Common/NotepadUtil")
local m_playerInfo, m_mode, m_favRoles, m_favBooks, m_showPreview, m_roles, m_novels

function SetupWindow()
  m_novels = NU.CreateNovelsData()
  WU.BindButtonEvent(REF.BtnFinish, function()
    if m_mode == "FavActor" then
      WU.RecordButtonClick(100137302)
      local patchTable = {
        favorRoles = m_favRoles or {}
      }
      local wireFormatTable = ProtobufT("ApiRelationPlayerPageInfo", patchTable)
      this:GameRequest("fci/playerpageinfo/"):Patch(wireFormatTable, function(result)
        this:SetData("Space/SelectedPlayer", result)
        WU.RecycleWindow(this)
      end)
    elseif m_mode == "FavBook" then
      WU.RecordButtonClick(100137202)
      local patchTable = {
        favorBooks = m_favBooks or {}
      }
      local wireFormatTable = ProtobufT("ApiRelationPlayerPageInfo", patchTable)
      this:GameRequest("fci/playerpageinfo/"):Patch(wireFormatTable, function(result)
        this:SetData("Space/SelectedPlayer", result)
        WU.RecycleWindow(this)
      end)
    end
  end)
  
  local function OnWidgetClick(go)
    local ref = _ENV["$"](go)
    if ref["@data"].isOpen == nil or ref["@data"].isOpen then
      if ref["@unlocked"] then
        OnElemSelected(ref["@data"])
      else
        WU.ShowHintText(WU.GetString("Window_ActorNotGet"))
      end
    end
  end
  
  for i = 1, #REF.WrapContentActor do
    WU.TraverseChildren(REF.WrapContentActor[i - 1]["$"], function(go)
      _ENV["$"](go)["$$SetClickCallback"](function(go)
        WU.RecordButtonClick(100137301)
        OnWidgetClick(go)
      end)
    end)
  end
  for i = 1, #REF.WrapContentBook do
    WU.TraverseChildren(REF.WrapContentBook[i - 1]["$"], function(go)
      WU.BindButtonEvent(go, function(go)
        WU.RecordButtonClick(100137201)
        OnWidgetClick(go)
      end)
    end)
  end
end

function InitWindow()
  WU.TraverseChildren(REF.PreviewSeq, function(go, i)
    _ENV["$"](go).NumberLabel.UILabel.text = i + 1
  end)
  WU.ToggleRendering(REF.NodeContainerActor, false)
  WU.ToggleRendering(REF.NodeContainerBook, false)
  WU.TraverseChildren(REF.PreviewSeq, function(go)
    _ENV["$"](go).UnpickedNode.gameObject:SetActive(true)
    _ENV["$"](go).Selection.gameObject:SetActive(false)
  end)
  SetMode(this:GetData("MySpaceEdit/Mode"))
end

function UninitWindow()
  if m_showPreview then
    m_showPreview = false
    REF.NodePreview["$Hide"]()
  end
end

function OnElemSelected(data)
  local idx, func, toFind, dataSet
  if m_mode == "FavActor" then
    toFind = data.role
    dataSet = m_favRoles
    func = RefreshSelectionActor
  elseif m_mode == "FavBook" then
    toFind = data.novelId
    dataSet = m_favBooks
    func = RefreshSelectionBook
  end
  idx = table.find(dataSet, function(k, v)
    return v == toFind
  end)
  if idx ~= nil then
    table.remove(dataSet, idx)
  else
    local idx = #dataSet
    if 5 <= idx then
      return
    else
      dataSet[idx + 1] = toFind
    end
  end
  func(dataSet)
end

function HandleShareData(allActors, haveActors, window)
  for i = 1, #haveActors do
    local role = PB.get("ActorConfig", haveActors[i].id).role
    if allActors[role] then
      allActors[role].unlock = true
    end
  end
  local selectNum = 5
  local selectedActors = {}
  local favorRoles = _ENV["!"](this:GetData("Space/SelectedPlayer").favorRoles)
  for i = 1, #favorRoles do
    table.insert(selectedActors, allActors[favorRoles[i]])
  end
  allActors = allActors:toarray()
end

function SetMode(mode)
  m_mode = mode
  if mode == "FavActor" then
    local allActors = NU.CreateRolesData()
    NU.GetCollectionsActor(function()
      HandleShareData(allActors, this:GetData("CollectionsActor/ActorsCollected"))
      m_roles = allActors
      this:Bind("Space/SelectedPlayer", DisplayFavActors)
    end)
  elseif mode == "FavBook" then
    if this:GetData("fci/CollectionsNovel") then
      SetNovel(this:GetData("fci/CollectionsNovel").novels)
    else
      this:GameRequest("fci/CollectionsNovel"):Get(function(result)
        this:SetData("fci/CollectionsNovel", result)
        SetNovel(result.novels)
      end)
    end
  end
end

function SetNovel(novels)
  for _, novel in pairs(novels) do
    local novelData = this:GetData("Collections/Novels/" .. novel.novelId)
    if novel.curCover == 0 and novelData then
      novel.curCover = novelData.curCover
      table.merge(novelData, novel)
      novelData.unlock = true
    end
  end
  this:Bind("Space/SelectedPlayer", DisplayFavBooks)
end

function DisplayFavActors(playerInfo)
  if playerInfo == nil then
    return
  end
  m_playerInfo = playerInfo
  for i = 1, #REF.PreviewSeq do
    REF.PreviewSeq[i - 1].PicSprite.gameObject:SetActive(false)
    REF.PreviewSeq[i - 1].ActorNode.gameObject:SetActive(true)
  end
  RefreshSelectionActor(playerInfo.favorRoles)
  local roleCount = 0
  for k, v in pairs(m_roles) do
    roleCount = roleCount + 1
  end
  local row = math.ceil(roleCount / #REF.WrapContentActor[0]["$"])
  REF.WrapContentActor.UIWrapContent:UpdateContent(row, true)
end

function RefreshSelectionActor(favRoles)
  m_favRoles = {}
  _ENV["!"](favRoles):copy(m_favRoles)
  local unlockedRoles = _ENV["!"]({})
  local lockedRoles = _ENV["!"]({})
  for k, v in pairs(m_roles) do
    if v.unlock then
      table.insert(unlockedRoles, {
        role = k,
        unlock = true,
        animRes = v.animRes
      })
    else
      table.insert(lockedRoles, {
        role = k,
        unlock = false,
        animRes = v.animRes
      })
    end
  end
  local data = _ENV["!"]({})
  data:append(unlockedRoles)
  data:append(lockedRoles)
  WU.ToggleRendering(REF.NodeContainerActor, true)
  local row = math.ceil(#data / #REF.WrapContentActor[0]["$"])
  LU.Bind(REF.WrapContentActor, {
    dataSource = data,
    updateSlot = OnUpdateSlot
  })
  LU.Set(REF.WrapContentActor, row, false)
  _ENV["$"](REF.ScrollViewActor).BottomBarSpace.transform.localPosition = CS.UnityEngine.Vector3(0, (1 - row) * REF.WrapContentActor.UIWrapContent.itemSize, 0)
  for i = 1, 5 do
    local role = favRoles[i]
    local ref = REF.PreviewSeq[i - 1]
    if role ~= nil then
      ref.UnpickedNode.gameObject:SetActive(false)
      ref.Selection.gameObject:SetActive(true)
      local _, value = table.find(data, function(_, v)
        return v.role == role
      end)
      if value ~= nil then
        ref.ActorSprite.UISprite.spriteName = "actor_head_" .. value.animRes
      end
    else
      ref.UnpickedNode.gameObject:SetActive(true)
      ref.Selection.gameObject:SetActive(false)
    end
  end
  if 0 < #m_favRoles and not m_showPreview then
    m_showPreview = true
    REF.NodePreview["$Show"]()
  elseif #m_favRoles == 0 and m_showPreview then
    m_showPreview = false
    REF.NodePreview["$Hide"]()
  end
end

function OnUpdateSlot(ref, data)
  local toFind, dataSet
  ref["@data"] = data
  if m_mode == "FavActor" then
    toFind = data.role
    ref["$$SetActorByRoleId"](data.role)
    dataSet = m_favRoles
    ref["@unlocked"] = data.unlock
    ref["$$SetMask"](not data.unlock)
  elseif m_mode == "FavBook" then
    ref.PicSprite.UISprite.spriteName = "book_" .. data.novelId
    ref.NotOpen.gameObject:SetActive(not data.isOpen)
    toFind = data.novelId
    dataSet = m_favBooks
    ref["@unlocked"] = data.unlock and data.curRewardNum > 0
    ref.SpriteMask.gameObject:SetActive(not data.unlock or data.curRewardNum == 0)
  end
  local idx = table.find(dataSet, function(k, v)
    return v == toFind
  end)
  if m_mode == "FavActor" then
    ref["$$SetSelected"](idx ~= nil)
    if idx ~= nil then
      ref.SelectedSprite.UISprite.spriteName = "number_icon_" .. idx
    end
  elseif m_mode == "FavBook" then
    ref.SelectedSprite.gameObject:SetActive(idx ~= nil)
  end
end

function DisplayFavBooks(playerInfo)
  if playerInfo == nil then
    return
  end
  m_playerInfo = playerInfo
  for i = 1, #REF.PreviewSeq do
    REF.PreviewSeq[i - 1].PicSprite.gameObject:SetActive(true)
    REF.PreviewSeq[i - 1].ActorNode.gameObject:SetActive(false)
  end
  RefreshSelectionBook(playerInfo.favorBooks)
  local row = math.ceil(#m_novels / #REF.WrapContentBook[0]["$"])
  REF.WrapContentBook.UIWrapContent:UpdateContent(row, true)
end

function RefreshSelectionBook(favBooks)
  m_favBooks = {}
  _ENV["!"](favBooks):copy(m_favBooks)
  WU.ToggleRendering(REF.NodeContainerBook, true)
  local row = math.ceil(#m_novels / #REF.WrapContentBook[0]["$"])
  LU.Bind(REF.WrapContentBook, {
    dataSource = m_novels,
    updateSlot = OnUpdateSlot
  })
  LU.Set(REF.WrapContentBook, row, false)
  _ENV["$"](REF.ScrollViewBook).BottomBarSpace.transform.localPosition = CS.UnityEngine.Vector3(0, (1 - row) * REF.WrapContentBook.UIWrapContent.itemSize, 0)
  for i = 1, 5 do
    local book = favBooks[i]
    local ref = REF.PreviewSeq[i - 1]
    if book ~= nil then
      ref.UnpickedNode.gameObject:SetActive(false)
      ref.Selection.gameObject:SetActive(true)
      ref.PicSprite.UISprite.spriteName = "book_" .. book
    else
      ref.UnpickedNode.gameObject:SetActive(true)
      ref.Selection.gameObject:SetActive(false)
    end
  end
  if 0 < #m_favBooks and not m_showPreview then
    m_showPreview = true
    REF.NodePreview["$Show"]()
  elseif #m_favBooks == 0 and m_showPreview then
    m_showPreview = false
    REF.NodePreview["$Hide"]()
  end
end

function Focus(on)
  WU.RecordWindowFocus(1001372, on)
end
