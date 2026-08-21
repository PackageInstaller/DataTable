local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local U = require("Common/Util")
local m_itemArray = {}
local m_selectIndex = -1
local m_callback

function Start()
  if REF["$transform"].childCount > 0 then
    Select(0)
  end
  for i = 0, REF["$transform"].childCount - 1 do
    local widget = REF["$transform"]:GetChild(i)
    m_itemArray[widget.gameObject] = i
  end
  for i = 0, REF["$transform"].childCount - 1 do
    local widget = REF["$transform"]:GetChild(i)
    WU.BindButtonEvent(widget, function(go)
      Select(m_itemArray[go])
    end)
  end
end

function Select(index)
  if m_selectIndex == index then
    return
  end
  m_selectIndex = index
  for i = 0, REF["$transform"].childCount - 1 do
    local widget = REF["$transform"]:GetChild(i)
    local spriteSelected = widget:Find("SpriteSelected")
    if m_selectIndex == i then
      spriteSelected.gameObject:SetActive(true)
    else
      spriteSelected.gameObject:SetActive(false)
    end
  end
  if m_callback then
    m_callback(m_selectIndex)
  end
end

function SetCallback(func)
  m_callback = func
end

function Tranverse(func)
  for i = 0, REF["$transform"].childCount - 1 do
    local widget = REF["$transform"]:GetChild(i)
    func(i, widget)
  end
end
