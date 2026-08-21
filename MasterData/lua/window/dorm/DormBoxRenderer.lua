local WU, DB, REF = require("Common/WindowUtil")(this)
local BoxTerm = CS.IsometricGame.BoxTerm
local m_renderers, m_spriteRenderers, m_meshRenderers, m_defaultSpriteSuitName

function GetRenderers()
  if m_renderers == nil then
    m_renderers = REF.root.gameObject:GetComponentsInChildren(typeof(CS.UnityEngine.Renderer), true)
  end
  return m_renderers
end

function GetSpriteRenderers()
  if m_spriteRenderers == nil then
    m_spriteRenderers = REF.root.gameObject:GetComponentsInChildren(typeof(CS.UnityEngine.SpriteRenderer), true)
  end
  return m_spriteRenderers
end

function GetMeshRenderers()
  if m_meshRenderers == nil then
    m_meshRenderers = REF.root.gameObject:GetComponentsInChildren(typeof(CS.UnityEngine.MeshRenderer), true)
  end
  return m_meshRenderers
end

local function RendererFlipEnable(renderer)
  return string.sub(renderer.gameObject.name, 1, 1) ~= "_"
end

function SetFlip(value)
  local r, p
  local spriteRenderers = GetSpriteRenderers()
  local meshRenderers = GetMeshRenderers()
  if spriteRenderers.Length > 0 then
    if value then
      local box = REF.root.transform.parent:GetComponent(typeof(CS.IsometricGame.IsometricBox))
      p = CS.IsometricGame.IsometricTools.IsoToCart(box.unitSize, {
        x = box.bound.x,
        y = box.bound.y
      })
    else
      p = CS.UnityEngine.Vector3.zero
    end
  end
  for i = 0, spriteRenderers.Length - 1 do
    r = spriteRenderers[i]
    if RendererFlipEnable(r) then
      r.flipX = value
      r.transform.localPosition = p
    end
  end
  for i = 0, meshRenderers.Length - 1 do
    r = meshRenderers[i]
    if RendererFlipEnable(r) then
      r.transform.parent.localScale = {
        x = fif(value, -1, 1),
        y = 1,
        z = 1
      }
    end
  end
end

function SetSortingOrder(values)
  local renderers = GetRenderers()
  if type(values) == "table" then
    for i = 0, renderers.Length - 1 do
      if values[i] then
        renderers[i].sortingOrder = values[i]
      end
    end
  else
    local value = values
    for i = 0, renderers.Length - 1 do
      renderers[i].sortingOrder = value and value + i
    end
  end
end

function SetSpriteSuit(spriteSuitName)
  spriteSuitName = spriteSuitName or ""
  local spriteRenderers = GetSpriteRenderers()
  local sprr = spriteRenderers[0]
  if m_defaultSpriteSuitName == nil then
    if spriteSuitName == "" then
      return
    end
    m_defaultSpriteSuitName = sprr.sprite.name
  end
  if spriteSuitName == "" then
    spriteSuitName = m_defaultSpriteSuitName
  end
  sprr.sprite = WU.AcquireAssetSprite("Texture/DormSprite/" .. spriteSuitName)
end
