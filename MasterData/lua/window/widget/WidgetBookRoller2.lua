local WU, DB, REF = require("Common/WindowUtil")(this)
local m_dragDelta
local m_textures = {
  "Texture/ChapterBackground/journey_wiki_bg_0",
  "Texture/ChapterBackground/journey_wiki_bg_0B"
}
local m_topTexture, m_bottomTexture

function Start()
  WU.BindPressEvent(REF.DragArea, OnPress, "empty")
  WU.BindDragEvent(REF.DragArea, OnDraging)
  m_topTexture = m_textures[2]
  m_bottomTexture = m_textures[1]
end

function OnDraging(go, delta)
  m_dragDelta = m_dragDelta + delta
end

function OnPress(go, press)
  if press then
    m_dragDelta = CS.UnityEngine.Vector2.zero
  else
    local luaWindow = REF["$transform"]:GetComponentInParent(typeof(CS.UILuaWindow))
    if _ENV["$"](luaWindow)["$$NavigateRelative"] == nil then
      error("WidgetBookRoller", "NavigateRelative function not found")
      return
    end
    if m_dragDelta.x < -100 then
      _ENV["$"](luaWindow)["$$NavigateRelative"](1)
    elseif m_dragDelta.x > 100 then
      _ENV["$"](luaWindow)["$$NavigateRelative"](-1)
    end
  end
end

function Page(fromIndex, toIndex, callback)
  fromIndex = fromIndex or -1
  if fromIndex ~= toIndex then
    REF.PageIndicator[toIndex]["$UIToggle"].value = true
    local bookRef = fif(toIndex < fromIndex, _ENV["$"](REF.EffectBookB), _ENV["$"](REF.EffectBookA))
    local delay = 0.2
    if toIndex < fromIndex then
      delay = 0.4
    end
    this:DelayInvokeInSeconds(delay, function()
      if callback ~= nil then
        callback()
      end
    end)
    bookRef.pPlane1.MeshRenderer.material:SetTexture("_MainTex", WU.AcquireAsset(fif(toIndex < fromIndex, m_topTexture, m_bottomTexture), this))
    bookRef.pPlaneMove.MeshRenderer.material:SetTexture("_MainTex", WU.AcquireAsset(fif(toIndex < fromIndex, m_bottomTexture, m_topTexture), this))
    bookRef["$EffectGenerator"]:Play()
    WU.ToggleRendering(REF.EffectBookA, toIndex > fromIndex)
    WU.ToggleRendering(REF.EffectBookB, toIndex < fromIndex)
    m_bottomTexture, m_topTexture = m_topTexture, m_bottomTexture
  end
end

function ReservePageIndicators(count, onClick)
  local dotPrefab = REF.PageIndicator[0]["$gameObject"]
  if dotPrefab then
    if #REF.PageIndicator == 1 then
      WU.BindButtonEvent(REF.PageIndicator[0].root, function()
        onClick(0)
      end)
    end
    while count > #REF.PageIndicator do
      local dot = CS.UnityEngine.GameObject.Instantiate(dotPrefab, REF.PageIndicator.transform)
      WU.BindButtonEvent(_ENV["$"](dot).root, function()
        onClick(dot.transform:GetSiblingIndex())
      end)
    end
    for i = 0, #REF.PageIndicator - 1 do
      REF.PageIndicator[i]["$gameObject"]:SetActive(count > i)
    end
  end
  REF.PageIndicator.UIGrid:Reposition()
end
