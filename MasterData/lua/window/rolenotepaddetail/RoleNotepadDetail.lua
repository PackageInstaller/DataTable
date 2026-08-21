local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local NU = require("Common/NotepadUtil")
local RU = require("Common/RedMarkUtil")
local SDU = require("Common/SoundUtil")
local LU = require("Common/ListUtil")
local DU = require("Common/DungeonUtil")
local AU = require("Common/ActorUtil")
local NVU = require("Common/NotepadVoiceUtil")
local RoleId2CartoonConfig
local PageType = {
  PT_Notepad = 1,
  PT_Voice = 2,
  PT_Video = 3,
  PT_Speech = 4
}
local FromViewtype = {From_RoleNotepad = 1, From_ActorMain = 2}
local m_roleId, m_data, m_events, m_preTab
local m_allVoiceList = {}
local m_allMovieClips = {}
local m_allSpeaches = {}
local m_nowAudioSource, m_nowItemVoice
local m_voiceSprites = {}
local m_bDoTween = false
local m_nowTheActorAudioSource
local m_nowPageTag = PageType.PT_Notepad
local m_novelId, m_dragDelta, m_allSortedNotepads
local m_specialRoleIdOfSaiErBeiLiYa = 19
local m_actorSwitchEffect
local m_repeatedContext = {}
local m_firstInit = true
local m_heightNoNovel = 846
local m_heightNovel = 738

function SetupWindow()
  CreateRoleId2CartoonConfig()
  WU.BindButtonEvent(REF.ButtonSpeechShelter, function()
    WU.ShowHintText(WU.GetString("Notepad_ClassicAnaLock"))
  end)
  CS.EventDelegate.Add(REF.WidgetTabSlotHandNote.UIToggle.onChange, function()
    if CS.UIToggle.current.value then
      _ENV["$"](REF.WidgetTabSlotHandNote).SpriteButton.UISprite.spriteName = "account_book/account_button_on"
      OnPageHandNote()
      m_bDoTween = false
      m_nowItemVoice = nil
      WU.ToggleRendering(REF.NodeNoVideo, false)
      m_nowPageTag = PageType.PT_Notepad
    else
      _ENV["$"](REF.WidgetTabSlotHandNote).SpriteButton.UISprite.spriteName = "account_book/account_button_off"
    end
  end)
  CS.EventDelegate.Add(REF.WidgetTabSlotVoice.UIToggle.onChange, function()
    if CS.UIToggle.current.value then
      WU.RecordButtonClick(100134103)
      _ENV["$"](REF.WidgetTabSlotVoice).SpriteButton.UISprite.spriteName = "account_book/account_button_on"
      OnPageVoice()
      WU.ToggleRendering(REF.NodeNoVideo, false)
      m_nowPageTag = PageType.PT_Voice
    else
      _ENV["$"](REF.WidgetTabSlotVoice).SpriteButton.UISprite.spriteName = "account_book/account_button_off"
    end
  end)
  CS.EventDelegate.Add(REF.WidgetTabSlotVideo.UIToggle.onChange, function()
    if CS.UIToggle.current.value then
      _ENV["$"](REF.WidgetTabSlotVideo).SpriteButton.UISprite.spriteName = "account_book/account_button_on"
      m_bDoTween = false
      m_nowItemVoice = nil
      WU.ToggleRendering(REF.NodeNoVideo, false)
      OnPageVideo()
      m_nowPageTag = PageType.PT_Video
    else
      _ENV["$"](REF.WidgetTabSlotVideo).SpriteButton.UISprite.spriteName = "account_book/account_button_off"
    end
  end)
  CS.EventDelegate.Add(REF.WidgetTabSlotSpeach.UIToggle.onChange, function()
    if CS.UIToggle.current.value then
      WU.RecordButtonClick(100134104)
      _ENV["$"](REF.WidgetTabSlotSpeach).SpriteButton.UISprite.spriteName = "account_book/account_button_on"
      m_bDoTween = false
      m_nowItemVoice = nil
      OnPageSpeach()
      WU.ToggleRendering(REF.NodeNoVideo, false)
      m_nowPageTag = PageType.PT_Speech
    else
      _ENV["$"](REF.WidgetTabSlotSpeach).SpriteButton.UISprite.spriteName = "account_book/account_button_off"
    end
  end)
  WU.BindButtonEvent(REF.BoardSetting, function()
    WU.RecordButtonClick(100134101)
    WU.AcquireWindowAsync("RoleNotepadDetailBoard", function(w)
      _ENV["$"](w)["$$SetActor"](m_data)
      _ENV["$"](w)["$$InitData"]()
    end)
  end)
  WU.BindButtonEvent(REF.Gift, function()
    WU.RecordButtonClick(100134102)
    REF.WidgetRoleIntimateUp["$Show"](m_data.roleId)
    ShowHear(false)
  end)
  REF.WidgetActorRoller["$SetClickCallback"](function()
    if m_data ~= nil then
      if m_nowTheActorAudioSource ~= nil and m_nowTheActorAudioSource.isPlaying then
        return
      end
      m_nowTheActorAudioSource = SDU.PlayActorNotePad(m_data.roleId)
    end
  end)
  WU.BindButtonEvent(REF.ButtonReadNovel, function()
    if m_novelId then
      local url = PB.get("Novel", m_novelId).url
      if url ~= "" then
        WU.OpenUrlExternal(url)
      end
    end
  end)
  REF.WidgetActorRoller["$SetMode"]("roleNotepad")
end

function InitWindow()
  m_firstInit = true
  this:SetData("RoleNotepadUpdateAble", true)
  WU.ToggleRendering(REF.NodeNoVideo, false)
  WU.ToggleRendering(REF.Content, false)
  REF.WidgetRoleIntimateUp["$SetOnHideCallback"](OnHideGiftListView)
  m_allSortedNotepads = this:GetData("Notepad/AllSortedNotepads")
  this:Bind("Notepad/SelectedRoleId", OnSelectedRoleId)
  if WU.IsShareSwitchOn() then
    this:RegisterGameEvent("UI/WindowUninited", OnShareWindowUninited)
  end
  local lastToggle = this:GetData("RoleNotePadDetail/ToggleIndex") or 1
  REF.WidgetTabSlotHandNote.UIToggle.value = lastToggle == 1
  REF.WidgetTabSlotVoice.UIToggle.value = lastToggle == 2
  REF.WidgetTabSlotVideo.UIToggle.value = lastToggle == 3
  REF.WidgetTabSlotSpeach.UIToggle.value = lastToggle == 4
  this:SetData("RoleNotePadDetail/ToggleIndex", nil)
end

function OnSelectedRoleId(roleId)
  if m_roleId ~= nil then
    this:Unbind("fci/RoleNotePad/" .. m_roleId, OnRoleNotepadDetail)
  end
  m_roleId = roleId
  m_bDoTween = false
  if m_firstInit then
    table.insert(m_repeatedContext, m_roleId)
    m_firstInit = false
  end
  REF.WidgetActorRoller["$OnRoleNotepadActorSelected"](m_roleId)
  if m_roleId ~= nil then
    this:BindRemote(DB:GameRequest("fci/RoleNotePad/" .. m_roleId), OnRoleNotepadDetail)
  end
end

function OnHideGiftListView()
  WU.ToggleRendering(REF.IconSpriteHeart, true)
end

function ShowHear(show)
  WU.ToggleRendering(REF.IconSpriteHeart, show)
end

function SaveContext(context)
  table.insert(m_repeatedContext, m_roleId)
end

function LoadContext(context)
  if 0 < #m_repeatedContext then
    this:SetData("RoleNotepadUpdateAble", true)
    this:SetData("Notepad/SelectedRoleId", m_repeatedContext[#m_repeatedContext - 1])
    table.remove(m_repeatedContext, #m_repeatedContext)
  end
end

function OnRoleNotepadDetail(result)
  if result ~= nil then
    m_data = result
    UpdateFavourText()
    local shouldUpdate = this:GetData("RoleNotepadUpdateAble")
    if shouldUpdate then
      InitNotepadSummary()
      SetTab()
      GetSpeech()
      this:SetData("RoleNotepadUpdateAble", false)
    end
  end
end

function SetTab()
  if m_nowPageTag == PageType.PT_Notepad then
    OnPageHandNote()
  elseif m_nowPageTag == PageType.PT_Voice then
    OnPageVoice()
  elseif m_nowPageTag == PageType.PT_Video then
    OnPageVideo()
  elseif m_nowPageTag == PageType.PT_Speech then
    OnPageSpeach()
  end
end

function UninitWindow()
  if m_nowAudioSource ~= nil then
    m_nowAudioSource:Stop()
    m_nowAudioSource = nil
  end
  if m_nowTheActorAudioSource ~= nil then
    m_nowTheActorAudioSource:Stop()
  end
  m_nowItemVoice = nil
  REF.WidgetRoleIntimateUp["$Hide"](true)
end

function SetShareInfo(window)
  RebuildUI(true)
  this:SetData("ShareConfig", {
    shareName = "RoleNotepadDetail",
    fromWindow = WU.TopWindow() and WU.TopWindow().name
  })
end

function OnShareWindowUninited(window)
  if window.name == "Share" then
    RebuildUI(false)
  end
end

function RebuildUI(visible)
  if visible then
    for i = 1, #REF.TabGrid do
      local tabRef = REF.TabGrid[i - 1]
      if tabRef.Visual[0]["$UIToggle"].value == true then
        m_preTab = tabRef.Visual[0].root
      end
    end
    REF.WidgetTabSlotHandNote["$SetSelected"]()
    REF.TabGrid.gameObject:SetActive(not visible)
  else
    REF.TabGrid.gameObject:SetActive(not visible)
    m_preTab["$SetSelected"]()
  end
  REF.BoardSetting.gameObject:SetActive(not visible)
  REF.Gift.gameObject:SetActive(not visible)
end

function InitNotepadSummary()
  if m_data == nil then
    return
  end
  if m_roleId == 135 and m_nowPageTag == PageType.PT_Speech then
    m_nowPageTag = PageType.PT_Notepad
    REF.WidgetTabSlotHandNote.UIToggle.value = true
  end
  SetTab()
  m_novelId = AU.GetRoleNovel(m_roleId)
  REF.IntimateLevelLabel.UILabel.text = m_data.favourLevel
  WU.ToggleRendering(REF.LabelNoSpeeches, false)
end

function UpdateFavourText()
  local favourLevel = PB.get("FavourLevel", m_data.favourLevel + 1)
  if favourLevel then
    REF.IntimatePointsLabel.UILabel.text = m_data.favour .. "/" .. favourLevel.favour
  else
    REF.IntimatePointsLabel.UILabel.text = WU.GetString("Window_FavourMax")
  end
end

function OnPageHandNote()
  if m_data == nil then
    return
  end
  SetDefaultView()
  m_events = m_data.notepadEvents
  InitItemViewOfHandNote()
  WU.ToggleRendering(REF.Content, true)
end

function InitItemViewOfHandNote()
  WU.RemoveAllChild(REF.ScrollViewContentHandNote)
  if m_events ~= nil then
    for i = 1, #m_events do
      local event = m_events[i]
      local widgetRef = _ENV["$"](WU.InstantiateWindowPrefab(REF.ScrollViewContentHandNote, "RoleNotepadDetail/WidgetNotepadRecord" .. event.type, "WidgetRecord"))
      WU.HandleGameObjectAttached(widgetRef.root.gameObject)
      widgetRef.TimeLabel.UILabel.text = WU.RenderTime2(event.time, true)
      if event.type == PB.enum.NotePadEventType.NotePadEventType_ClassicAna then
        local jsonObj = JsonD(event.text)
        local theSpeach = PB.get("RoleClassicAna", jsonObj.id)
        local novel = WU.GetString("NovelName_" .. theSpeach.bookName)
        local text1 = WU.GetString("AnaSource", novel, theSpeach.chapterNumber, theSpeach.pageNumber)
        widgetRef.LabelSrc.UILabel.text = text1
        local heightOfLabelSrc = widgetRef.LabelSrc.UILabel.height
        widgetRef.ContentLabel.UILabel.text = NU.GetNotepadText(event, m_data, widgetRef)
        local heightOfContentLabel = widgetRef.ContentLabel.UILabel.height
        local offsetY = 70
        local vec = CS.NGUIText.CalculatePrintedSize(widgetRef.ContentLabel.UILabel.text)
        widgetRef["$UIWidget"].height = heightOfContentLabel + heightOfLabelSrc + offsetY
        local offsetLineY = -10
        local maxLine = 11
        local lineHeight = vec.y
        local prefix = "Line"
        local lines = math.floor(heightOfContentLabel / lineHeight + 0.5)
        for j = 1, maxLine do
          local itemLine = prefix .. j
          if j <= lines then
            local py = (j + 1) * -lineHeight
            if widgetRef[itemLine] ~= nil then
              widgetRef[itemLine].transform.localPosition = CS.UnityEngine.Vector3(0, offsetLineY + py, 0)
              WU.ToggleRendering(widgetRef[itemLine], true)
            end
          else
            WU.ToggleRendering(widgetRef[itemLine], false)
          end
        end
      else
        widgetRef.ContentLabel.UIHtmlLabel.text = NU.GetNotepadText(event, m_data, widgetRef)
      end
      WU.HandleGameObjectAttached(widgetRef["$gameObject"])
    end
  end
  REF.ScrollViewContentHandNote.UITable:Reposition()
  local boundsA = this:CalculateRelativeWidgetBounds(REF.ScrollViewContentHandNote.transform, REF["$transform"])
  if boundsA.size.y < REF.ScrollViewHandNote.UIWidget.height then
    REF.ScrollViewHandNoteScroll.UIScrollView.contentPivot = CS.UIWidget.Pivot.Top
  else
    REF.ScrollViewHandNoteScroll.UIScrollView.contentPivot = CS.UIWidget.Pivot.Bottom
  end
  REF.ScrollViewHandNoteScroll.UIScrollView:ResetPosition()
end

function OnPageVoice()
  SetDefaultView()
  m_allVoiceList = {}
  local list1 = NVU.GetEachVoiceListByLocked(true, m_data)
  local list2 = NVU.GetEachVoiceListByLocked(false, m_data)
  for _, v in pairs(list1) do
    table.insert(m_allVoiceList, v)
  end
  for _, v in pairs(list2) do
    table.insert(m_allVoiceList, v)
  end
  InitItemViewOfVoice()
end

function InitItemViewOfVoice()
  m_voiceSprites = {}
  WU.RemoveAllChild(REF.WrapContentVoice)
  local y = 0
  for i = 1, #m_allVoiceList do
    local data = m_allVoiceList[i]
    local widgetRef = _ENV["$"](WU.InstantiateWindowPrefab(REF.WrapContentVoice, "RoleNotepadDetail/ItemNoteVoice", "ItemNoteVoice"))
    WU.BindButtonEvent(widgetRef.IconSpeaker, function()
      WU.RecordButtonClick(100134121)
      if data.unlocked then
        if m_nowAudioSource then
          m_nowAudioSource:Stop()
          if m_nowTheActorAudioSource ~= nil then
            m_nowTheActorAudioSource:Stop()
          end
        end
        m_nowItemVoice = widgetRef
        table.insert(m_voiceSprites, _ENV["$"](m_nowItemVoice.IconSpeaker).IconSpeakerInner.UISprite)
        if m_nowItemVoice ~= nil then
          _ENV["$"](m_nowItemVoice.IconSpeaker).IconSpeakerInner.UISprite.color = CS.NGUIMath.HexToColor(4294967295)
        end
        m_nowAudioSource = CS.SoundManager.Instance:PlaySound(data.audioFullPath)
        InitBlinkParams(m_nowAudioSource.clip.length)
      end
    end)
    local text = "\239\188\159\239\188\159\239\188\159\239\188\159\239\188\159\239\188\159"
    if data.voiceType == PB.enum.RoleNotepadVoiceType.RVT_BOARD then
      local row = PB.get("BoardVoice2Text", data.audioText)
      if row ~= nil then
        text = ""
        for i = 1, #row.data do
          local tmp = WU.GetString(row.data[i].localizationText)
          text = text .. tmp
        end
      else
        error("RoleNotePadDetail", "\232\175\165emote\230\178\161\230\156\137\229\175\185\229\186\148\231\154\132\232\175\173\233\159\179\230\150\135\229\173\151\239\188\140\232\175\183\233\133\141\231\189\174 BoardVoice2Text ")
      end
    else
      text = WU.GetString(data.audioText)
    end
    if data.unlocked then
      widgetRef.IconSpeaker.UISprite.color = CS.NGUIMath.HexToColor(3568812031)
      widgetRef.LabelSrc.UILabel.text = WU.GetString("audio_src_" .. data.audioSrc)
    else
      widgetRef.IconSpeaker.UISprite.color = CS.NGUIMath.HexToColor(2593823487)
      text = "\239\188\159\239\188\159\239\188\159\239\188\159\239\188\159\239\188\159"
      widgetRef.LabelSrc.UILabel.text = WU.GetString("Notepad_favour_level_required", data.favourLevel)
    end
    widgetRef.LabelDesc.UILabel.text = text
    local height = widgetRef.LabelDesc.UILabel.height
    local totalHeight = height + widgetRef.LabelSrc.UILabel.height + 70
    local offset = (totalHeight - 150) / 2
    widgetRef["$transform"].localPosition = CS.UnityEngine.Vector3(0, y - offset, 0)
    y = y - totalHeight
  end
  REF.ScrollViewVoiceScroll.UIScrollView:ResetPosition()
end

function UpdateWindow(delta)
  BlinkSpeaker(delta)
end

local m_fTweenerInterval = 0
local m_fElapsed = 0
local m_iFadeInterval = 0.5
local m_fAlpha = 1
local m_bUpGoes = false

function BlinkSpeaker(deltaTime)
  if m_bDoTween then
    local sprite
    m_fElapsed = m_fElapsed + deltaTime
    if m_nowItemVoice then
      sprite = _ENV["$"](m_nowItemVoice.IconSpeaker).IconSpeakerInner.UISprite
    end
    if m_fElapsed <= m_fTweenerInterval then
      local fAttenStep = deltaTime
      if m_bUpGoes then
        m_fAlpha = m_fAlpha + fAttenStep
        if 1 < m_fAlpha then
          m_bUpGoes = false
          m_fAlpha = 1
        end
      else
        m_fAlpha = m_fAlpha - fAttenStep
        if m_fAlpha <= 0.5 then
          m_fAlpha = 0.5
          m_bUpGoes = true
        end
      end
      if sprite then
        sprite.color = CS.UnityEngine.Color(1, 1, 1, m_fAlpha)
      end
    else
      m_bDoTween = false
      if sprite then
        sprite.color = CS.UnityEngine.Color(1, 1, 1, 1)
      end
    end
  end
end

function InitBlinkParams(audioClipLenght)
  local iTotalFadeCount = math.ceil(audioClipLenght / m_iFadeInterval)
  if iTotalFadeCount % 2 ~= 0 then
    iTotalFadeCount = iTotalFadeCount + 1
  end
  for i = 1, #m_voiceSprites do
    m_voiceSprites[i].color = CS.UnityEngine.Color(1, 1, 1, 1)
  end
  m_fElapsed = 0
  m_bDoTween = true
  m_fAlpha = 1
  m_bUpGoes = false
  m_fTweenerInterval = iTotalFadeCount * m_iFadeInterval
end

function OnInitItemMovieAtIndex(goRef, wrapIndex, realIndex)
  if realIndex ~= nil and realIndex < #m_allMovieClips then
    local data1 = m_allMovieClips[realIndex * 2 + 1]
    local data2 = m_allMovieClips[realIndex * 2 + 2]
    local kDataCouple = {}
    table.insert(kDataCouple, data1)
    table.insert(kDataCouple, data2)
    goRef["$$SetData"](kDataCouple)
  end
end

function SetDefaultView()
  WU.ToggleRendering(REF.NodeNovel, false)
end

function OnPageVideo()
  SetDefaultView()
  m_allMovieClips = RoleId2CartoonConfig[m_data.roleId] or {}
  table.sort(m_allMovieClips, function(a, b)
    if a.chapterId ~= b.chapterId then
      return a.chapterId < b.chapterId
    else
      return a.dungeonId < b.dungeonId
    end
  end)
  LU.Bind(REF.WrapContentVideo, {
    updateRow = OnInitItemMovieAtIndex
  })
  local count = math.ceil(#m_allMovieClips / 2)
  if count <= 0 then
    WU.ToggleRendering(REF.NodeNoVideo, true)
  else
    WU.ToggleRendering(REF.NodeNoVideo, false)
  end
  LU.Set(REF.WrapContentVideo, count)
end

function GetSpeech()
  local all = PB.all("RoleClassicAna")
  m_allSpeaches = _ENV["!"]({})
  for k, v in pairs(all) do
    if v.role == m_roleId then
      local tab = table.copy({}, v)
      tab.favourLevel = v.FavourLevel
      if v.FavourLevel <= m_data.favourLevel then
        tab.unlocked = true
      else
        tab.unlocked = false
      end
      table.insert(m_allSpeaches, tab)
    end
  end
  REF.WidgetTabSlotSpeach.BoxCollider2D.enabled = 0 < #m_allSpeaches
  REF.ButtonSpeechShelter.gameObject:SetActive(#m_allSpeaches <= 0)
end

function OnPageSpeach()
  GetSpeech()
  local unlockedAll = {}
  local lockedAll = {}
  for _, v in pairs(m_allSpeaches) do
    if v.unlocked then
      table.insert(unlockedAll, v)
    else
      table.insert(lockedAll, v)
    end
  end
  for i = 1, #lockedAll do
    table.insert(unlockedAll, lockedAll[i])
  end
  m_allSpeaches = unlockedAll
  InitItemViewOfSpeech()
end

function InitItemViewOfSpeech()
  WU.RemoveAllChild(REF.ScrollViewContentSpeach)
  local y = 0
  if #m_allSpeaches == 0 then
    REF.ScrollViewContentSpeach.gameObject:SetActive(false)
    REF.LabelNoSpeeches.UILabel.text = WU.GetString("Notepad_ClassicAnaLock")
    return
  else
    WU.ToggleRendering(REF.LabelNoSpeeches, false)
    REF.ScrollViewContentSpeach.gameObject:SetActive(true)
  end
  for i = 1, #m_allSpeaches do
    local data = m_allSpeaches[i]
    local widgetRef = _ENV["$"](WU.InstantiateWindowPrefab(REF.ScrollViewContentSpeach, "RoleNotepadDetail/ItemNotePadSpeach", "ItemNotePadSpeach"))
    local text = WU.GetString("AnaContent_" .. data.id)
    if not data.unlocked then
      text = "\239\188\159\239\188\159\239\188\159\239\188\159\239\188\159\239\188\159"
    end
    widgetRef.LabelDesc.UILabel.text = text
    local novel = WU.GetString("NovelName_" .. data.bookName)
    local text1 = WU.GetString("AnaSource", novel, data.chapterNumber, data.pageNumber)
    if m_data.roleId == m_specialRoleIdOfSaiErBeiLiYa then
      text1 = WU.GetString("Notepad_SpecialActorSpeechOfSaiErBeiLiYa")
    end
    if not data.unlocked then
      text1 = WU.GetString("Notepad_favour_level_required", data.favourLevel)
    end
    widgetRef.LabelSrc.UILabel.text = text1
    local height = widgetRef.LabelDesc.UILabel.height
    local totalHeight = height + widgetRef.LabelSrc.UILabel.height
    widgetRef["$transform"].localPosition = CS.UnityEngine.Vector3(0, y, 0)
    y = y - totalHeight - 70
    local vec = CS.NGUIText.CalculatePrintedSize(widgetRef.LabelDesc.UILabel.text)
    local offsetY = 4
    local maxLine = 11
    local lineHeight = vec.y
    local prefix = "Line"
    local lines = math.floor(height / lineHeight + 0.5)
    for j = 1, maxLine do
      local itemLine = prefix .. j
      if j <= lines then
        local py = (j + 1) * -lineHeight
        widgetRef[itemLine].transform.localPosition = CS.UnityEngine.Vector3(0, offsetY + py, 0)
        widgetRef[itemLine].gameObject:SetActive(true)
      else
        widgetRef[itemLine].gameObject:SetActive(false)
      end
    end
  end
  local boundsA = this:CalculateRelativeWidgetBounds(REF.ScrollViewContentSpeach.transform, REF["$transform"])
  if boundsA.size.y < REF.ScrollViewSpeach.UIWidget.height then
    REF.ScrollViewHandNoteScroll.UIScrollView.contentPivot = CS.UIWidget.Pivot.Top
  else
    REF.ScrollViewHandNoteScroll.UIScrollView.contentPivot = CS.UIWidget.Pivot.Bottom
  end
  REF.ScrollViewHandNoteScroll.UIScrollView:ResetPosition()
  WU.ToggleRendering(REF.ButtonReadNovel, false)
  local url = ""
  if m_novelId then
    url = PB.get("Novel", m_novelId).url
    REF.LabelNovelTitle.UILabel.text = WU.GetString("NovelName_" .. m_novelId)
    WU.ToggleRendering(REF.ButtonReadNovel, url ~= "" and this:GetData("accountCache").socialPlatform == PB.enum.MSDKLoginPlatform.MSDK_QQ and not WU.IsPreCommit())
  end
  REF.NodeNovel.gameObject:SetActive(url ~= "")
  local height = fif(url ~= "", m_heightNovel, m_heightNoNovel)
  REF.ScrollViewSpeach.UIWidget.height = height
  WU.ToggleRendering(REF.NodeNovel, m_novelId ~= nil)
  REF.ScrollViewSpeachScroll.UIScrollView:ResetPosition()
end

function CreateRoleId2CartoonConfig()
  RoleId2CartoonConfig = _ENV["!"]({})
  local cartoonConfigs = PB.all("CartoonConfig")
  for _, v in pairs(cartoonConfigs) do
    for i = 1, #v.roleID do
      RoleId2CartoonConfig[v.roleID[i]] = RoleId2CartoonConfig[v.roleID[i]] or {}
      table.insert(RoleId2CartoonConfig[v.roleID[i]], v)
    end
  end
end

function Focus(on)
  WU.RecordWindowFocus(1001341, on)
end
