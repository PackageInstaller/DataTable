local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local ACU = require("Common/ActivityUtil")
local m_t = 0.47
local m_item, m_radian, m_beginDrop, m_toPos, m_remainCount, m_durintTime, m_vy, m_vx, m_passTime

function SetItem(item)
  m_item = item
  m_beginDrop = false
  REF.EffectStar.transform.localPosition = CS.UnityEngine.Vector3.zero
  local cuisineInfo = PB.get("ItemInfo", m_item.id)
  REF.TextureCuisine.UITexture.mainTexturePath = "Texture/Welfare/new_year/Food_" .. m_item.id
  REF.LabelCount.UILabel.text = m_item.count
  WU.SetActive(REF.Content, true)
  WU.SetActive(REF.SpriteBubble, true)
  WU.SetActive(REF.LabelCount, true)
  m_radian = math.random(1, 20) * 1.0 / 10
end

function Update(delta)
  DoFloatEffect(delta)
  DoDrop(delta)
end

function DoAppearEffect(refreshContent)
  REF.EffectAppear.EffectGenerator:Reset()
  REF.EffectAppear.EffectGenerator:Play()
  if refreshContent then
    WU.SetActive(REF.root, true)
    REF.EffectStar.transform.localPosition = CS.UnityEngine.Vector3.zero
    REF.LabelCount.UILabel.text = m_remainCount
    m_remainCount = nil
  end
end

function DoPutIntoPot(pos, remainCount)
  m_remainCount = remainCount
  REF.EffectEat.EffectGenerator:Reset()
  REF.EffectEat.EffectGenerator:Play()
  this:DelayInvokeInSeconds(0.2, function()
    WU.SetActive(REF.SpriteBubble, false)
    WU.SetActive(REF.LabelCount, false)
    WU.SetActive(REF.Content, false)
    REF.EffectStar.EffectGenerator:Reset()
    REF.EffectStar.EffectGenerator:Play()
    m_toPos = pos
    local y = m_toPos.y
    local x = m_toPos.x
    m_vx = x / m_t
    m_vy = y / m_t
    m_passTime = 0
    m_beginDrop = true
  end)
end

function DoFloatEffect(delta)
  if m_radian and REF.root.gameObject.activeSelf then
    local radian = m_radian + delta * 2
    local dy = math.cos(radian) * 0.5
    local oldPos = REF["$transform"].localPosition
    REF["$transform"].localPosition = oldPos + CS.UnityEngine.Vector3(0, dy, 0)
    m_radian = radian
  end
end

function DoDrop(delta)
  if m_beginDrop then
    m_passTime = m_passTime + delta
    local x = m_vx * m_passTime
    local y = m_vy * m_passTime
    local realX, realY
    if y <= m_toPos.y then
      m_beginDrop = false
      REF.EffectStar.transform.localPosition = m_toPos
      WU.SetActive(REF.root, false)
      this:BroadcastGameEvent("HotPot/CuisineDropIntoPot")
      if m_remainCount then
        DoAppearEffect(true)
      end
    else
      REF.EffectStar.transform.localPosition = CS.UnityEngine.Vector3(x, y, 0)
    end
  end
end

function ToggleContentView(show)
  WU.ToggleRendering(REF.Content, show)
end
