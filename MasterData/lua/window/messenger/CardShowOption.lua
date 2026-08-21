local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local U = require("Common/Util")
local SU = require("Common/SortUtil")
local TU = require("Common/TaskUtil")
local m_tabGroups = {}
local m_firstIn = true
local m_hideAttr = false
local m_hideEquip = false

function Awake()
  m_tabGroups = {}
  WU.TraverseChildren(REF.TabGridOption, function(go, index)
    local gasket = _ENV["$"](go)
    local key = string.sub(gasket.root.name, string.len("TabShow") + 1)
    table.insert(m_tabGroups, gasket)
    WU.BindButtonEvent(gasket.root, function()
      HightLightTab(key, true)
    end)
  end)
  WU.BindButtonEvent(REF.ButtonShow, function()
    REF.ShowNode.gameObject:SetActive(not REF.ShowNode.gameObject.activeSelf)
    REF.ButtonHide.gameObject:SetActive(REF.ShowNode.gameObject.activeSelf)
  end)
  WU.BindButtonEvent(REF.ButtonHide, function()
    REF.ShowNode.gameObject:SetActive(false)
    REF.ButtonHide.gameObject:SetActive(false)
  end)
end

function Start()
  REF.ButtonHide.gameObject:SetActive(false)
  REF.ShowNode.gameObject:SetActive(false)
end

function OnEnable()
  this:Bind("Arm/ArmUnlock", SetVisual)
  this:Bind("DisplayOptionChange", OnDisplayOptionChange)
end

function OnDisable()
  this:Unbind("DisplayOptionChange", OnDisplayOptionChange)
end

function OnDisplayOptionChange(data)
  local key = "name"
  local displayOption = WU.GetGameDataCache("LocalDisplayOption")
  if displayOption then
    key = displayOption
  end
  HightLightTab(key, m_firstIn)
end

function HightLightTab(key, callBind)
  m_firstIn = false
  local gasket = REF["TabShow" .. key]
  for k, v in pairs(m_tabGroups) do
    v.SpriteActve.gameObject:SetActive(false)
  end
  _ENV["$"](gasket).SpriteActve.gameObject:SetActive(true)
  if not callBind then
    return
  end
  WU.SetDislayOption(key)
  this:SetData("DisplayOptionOrigin", key)
  this:SetData("SortFinished", this:GetData("SortFinished"))
end

function SetVisual(visual)
  local showArm = visual
  REF.TabShowarm.gameObject:SetActive(showArm)
  REF.TabShowequip.gameObject:SetActive(not m_hideEquip)
  REF.ToggleAttrs.gameObject:SetActive(not m_hideAttr)
  REF.TabGridOption.UIGrid:Reposition()
  local height = 460
  height = fif(showArm, 460, 366)
  height = height + fif(m_hideEquip, -100, 0)
  height = height + fif(m_hideAttr, -100, 0)
  REF.Bg.UISprite.height = height
end

function HideAttr(flag)
  m_hideAttr = flag
  SetVisual(DB:GetData("Arm/ArmUnlock"))
end

function HideEquip(flag)
  m_hideEquip = flag
  SetVisual(DB:GetData("Arm/ArmUnlock"))
end
