local WU, DB, REF = require("Common/WindowUtil")(this)
local U = require("Common/Util")
local PB = require("Common/PbHelper")
local Height = REF.ImgConsoleNode.UIWidget.height
local TopWindow = WU.TopWindow()
local m_translateContainer, m_focusScrollView, m_focusInput
local m_state = 0
local m_showCallback, m_hideCallback, m_moveDistance, m_imgEvent, m_textEvent
local ImgPerPage = 18
local TextPerPage = 10
local m_dataImg = _ENV["!"]({})
local m_dataText = _ENV["!"]({})

function Start()
  WU.BindButtonEvent(REF.ConsoleMask, Hide)
  SetupEmojiConsole()
  REF.ImgPages.UICenterOnChild.onCenter = OnCenterImg
  REF.FaceTextPages.UICenterOnChild.onCenter = OnCenterText
end

function OnEnable()
  this:BindRemote(DB:GameRequest("fci/emoji/"), ImgUnlockCheck)
end

function OnDisable()
  this:Unbind("fci/emoji/", ImgUnlockCheck)
end

function RefreshContent()
  ImgUnlockCheck(this:GetData("fci/emoji/"))
  TextCheck()
end

function BindButtonEvent(img, text)
  m_imgEvent = img
  m_textEvent = text
end

function SetCallback(show, hide)
  m_showCallback = show
  m_hideCallback = hide
end

function AdjustObjects(scrollViewRef, inputRef)
  m_focusScrollView = scrollViewRef
  m_focusInput = inputRef
end

function Hide()
  if m_state == 0 then
    return
  end
  WU.ToggleRendering(REF["$"], false)
  m_state = 0
  m_focusScrollView.ScrollView.UIScrollView:DisableSpring()
  local height = m_focusScrollView["$UIWidget"].height
  m_focusScrollView["$UIWidget"].height = height + Height
  if m_translateContainer then
    U.Translate(m_focusScrollView.Container.transform, 0, Height, 0)
    m_translateContainer = false
  end
  U.Translate(REF.ImgConsoleNode.transform, 0, -Height, 0)
  U.Translate(m_focusInput["$Transform"], 0, -Height, 0)
  m_focusScrollView.ScrollView.UIScrollView.mIsForward = true
  m_focusScrollView.ScrollView.UIScrollView:MoveRelative(CS.UnityEngine.Vector3(0, -m_moveDistance, 0))
  WU.ToggleRendering(REF.ConsoleMask, false)
  local boundsA = this:CalculateRelativeWidgetBounds(m_focusScrollView.Container.transform, TopWindow.transform)
  if boundsA.size.y < m_focusScrollView["$UIWidget"].height then
    m_focusScrollView.ScrollView.UIScrollView.contentPivot = CS.UIWidget.Pivot.Top
    m_focusScrollView.ScrollView.UIScrollView:ResetPosition()
  end
  if type(m_hideCallback) == "function" then
    m_hideCallback()
  end
end

function Show()
  if m_state == 1 then
    return
  end
  WU.ToggleRendering(REF["$"], true)
  m_state = 1
  m_moveDistance = 0
  m_focusScrollView.ScrollView.UIScrollView:DisableSpring()
  local height = m_focusScrollView["$UIWidget"].height
  m_focusScrollView["$UIWidget"].height = height - Height
  if not m_focusScrollView.Container.ReuseTable.isFullAndNeedReuse then
    U.Translate(m_focusScrollView.Container.transform, 0, -Height, 0)
    m_translateContainer = true
  end
  U.Translate(REF.ImgConsoleNode.transform, 0, Height, 0)
  U.Translate(m_focusInput["$Transform"], 0, Height, 0)
  local boundsA = this:CalculateRelativeWidgetBounds(m_focusScrollView.Container.transform, TopWindow.transform)
  local boundsB = this:CalculateRelativeWidgetBounds(m_focusInput["$transform"], TopWindow.transform)
  if boundsA:Intersects(boundsB) then
    local boundsDistance = math.abs((boundsA.min - boundsB.max).y)
    m_moveDistance = fif(boundsDistance > Height, Height, boundsDistance)
    m_focusScrollView.ScrollView.UIScrollView.mIsForward = false
    m_focusScrollView.ScrollView.UIScrollView:MoveRelative(CS.UnityEngine.Vector3(0, m_moveDistance, 0))
    
    function m_focusScrollView.ScrollView.UIScrollView.onDragStarted()
      m_moveDistance = 0
    end
  end
  WU.ToggleRendering(REF.ConsoleMask, true)
  if type(m_showCallback) == "function" then
    m_showCallback()
  end
end

function ImgUnlockCheck(emojiAll)
  if emojiAll == nil then
    return
  end
  local locked = _ENV["!"]({})
  local unlocked = _ENV["!"]({})
  local unlockedIds = {}
  for i = 1, #emojiAll do
    unlockedIds[emojiAll[i].id] = true
  end
  for i = 1, #m_dataImg do
    local imgData = m_dataImg[i]
    if unlockedIds[imgData.id] then
      imgData.locked = false
      table.insert(unlocked, imgData)
    else
      imgData.locked = true
      table.insert(locked, imgData)
    end
  end
  unlocked:append(locked)
  for i = 0, #REF.ImgPages - 1 do
    local startIndex = i * ImgPerPage + 1
    SetPageImg(REF.ImgPages[i]["$gameObject"], unlocked:slice(startIndex, ImgPerPage))
  end
end

function TextCheck()
  for i = 0, #REF.FaceTextPages - 1 do
    local startIndex = i * TextPerPage + 1
    SetPageText(REF.FaceTextPages[i]["$gameObject"], m_dataText:slice(startIndex, TextPerPage))
  end
end

function SetupEmojiConsole()
  m_dataImg = _ENV["!"]({})
  m_dataText = _ENV["!"]({})
  local resChatImage = PB.all("ChatImage")
  for i = 1, #resChatImage do
    if resChatImage[i].type == 1 then
      table.insert(m_dataImg, resChatImage[i])
    else
      table.insert(m_dataText, resChatImage[i])
    end
  end
  ReservePagesAndIndicators(#m_dataImg, #m_dataText)
end

function OnCenterImg(page)
  WU.TraverseChildren(REF.PageIndicatorImg, function(go, i)
    if page.transform:GetSiblingIndex() == i then
      go:GetComponent(typeof(CS.UISprite)).spriteName = "dot_light"
    else
      go:GetComponent(typeof(CS.UISprite)).spriteName = "dot_dark"
    end
  end)
end

function OnCenterText(page)
  WU.TraverseChildren(REF.PageIndicatorText, function(go, i)
    if page.transform:GetSiblingIndex() == i then
      go:GetComponent(typeof(CS.UISprite)).spriteName = "dot_light"
    else
      go:GetComponent(typeof(CS.UISprite)).spriteName = "dot_dark"
    end
  end)
end

function SetPageImg(go, imgData)
  for i = 0, go.transform.childCount - 1 do
    local data = imgData[i + 1]
    local img = go.transform:GetChild(i).gameObject
    img:SetActive(data ~= nil)
    if data ~= nil then
      do
        local ref = _ENV["$"](img)
        WU.ClearButtonEvent(img)
        if data.locked then
          WU.BindButtonEvent(img, function()
            WU.ShowHintText(WU.GetString("Window_ChatEmojiLocked", WU.GetString("RoleName_" .. data.imageRoleId)))
          end)
        else
          WU.BindButtonEvent(img, m_imgEvent)
        end
        ref["$UISprite"].graify = data.locked
        ref["$UISprite"].atlasPath = data.atlas
        ref["$UISprite"].spriteName = data.sprite
        ref["@text"] = data.atlas .. "." .. data.sprite
      end
    end
  end
end

function SetPageText(go, textData)
  for i = 0, go.transform.childCount - 1 do
    local data = textData[i + 1]
    local text = go.transform:GetChild(i).gameObject
    text:SetActive(data ~= nil)
    if data ~= nil then
      local ref = _ENV["$"](text)
      WU.ClearButtonEvent(text)
      WU.BindButtonEvent(text, m_textEvent)
      ref["$UILabel"].text = data.text
      ref["@text"] = data.text
    end
  end
end

function ReservePagesAndIndicators(imgCount, textCount)
  local imgPageCnt = math.ceil(imgCount / ImgPerPage)
  local instantiateCnt = imgPageCnt - #REF.ImgPages
  for i = 1, instantiateCnt do
    CS.NGUITools.AddChild(REF.ImgPages.gameObject, REF.ImgPage.gameObject)
    CS.NGUITools.AddChild(REF.PageIndicatorImg.gameObject, REF.SpriteDot.gameObject)
  end
  REF.ImgPages.UIGrid:Reposition()
  REF.PageIndicatorImg.UIGrid:Reposition()
  REF.ImgPages.UICenterOnChild:CenterOn(REF.ImgPages.transform:GetChild(0))
  local textPageCnt = math.ceil(textCount / TextPerPage)
  instantiateCnt = textPageCnt - #REF.FaceTextPages
  for i = 1, instantiateCnt do
    CS.NGUITools.AddChild(REF.FaceTextPages.gameObject, REF.FaceTextPage.gameObject)
    CS.NGUITools.AddChild(REF.PageIndicatorText.gameObject, REF.SpriteDot.gameObject)
  end
  REF.FaceTextPages.UIGrid:Reposition()
  REF.PageIndicatorText.UIGrid:Reposition()
  REF.FaceTextPages.UICenterOnChild:CenterOn(REF.FaceTextPages.transform:GetChild(0))
end
