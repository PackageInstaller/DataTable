local WU, DB, REF = require("Common/WindowUtil")(this)
local U = require("Common/Util")
local PB = require("Common/PbHelper")
local m_selectIDType
local m_agree = false

function SetupWindow()
  WU.BindButtonEvent(REF.SelectType, function()
    REF.DropList.gameObject:SetActive(true)
  end)
  WU.BindButtonEvent(REF.DropListButtonMask, function()
    REF.DropList.gameObject:SetActive(false)
  end)
  WU.BindButtonEvent(REF.BtnNo, function()
    WU.RecycleWindow(this)
  end)
  WU.BindButtonEvent(REF.BtnYes, function()
    local name = U.trim(REF.InputName.UIInput.value)
    local identityNum = U.trim(REF.InputID.UIInput.value)
    local identityType = m_selectIDType
    if not m_agree then
      WU.ShowMessageOK(WU.GetString("Window_RealNameTipNeedAgree"))
    elseif name == "" then
      WU.ShowMessageOK(WU.GetString("Window_RealNameTipNeedName"))
    elseif identityNum == "" then
      WU.ShowMessageOK(WU.GetString("Window_RealNameTipNeedID"))
    end
  end)
  WU.TraverseChildren(REF.DropListGrid, function(go, index)
    WU.BindButtonEvent(go, function(go)
      REF.LabelType.UILabel.text = _ENV["$"](go).DropListLabelItemSelected.UIHtmlLabel.text
      m_selectIDType = index
      REF.DropList.gameObject:SetActive(false)
      WU.TraverseChildren(REF.DropListGrid, function(go, index)
        _ENV["$"](go).DropListNodeSelected.gameObject:SetActive(false)
      end)
      _ENV["$"](go).DropListNodeSelected.gameObject:SetActive(true)
    end)
  end)
  CS.EventDelegate.Add(REF.ToggleAgree.UIToggle.onChange, function()
    REF.ToggleSelect.gameObject:SetActive(CS.UIToggle.current.value)
    m_agree = CS.UIToggle.current.value ~= false
  end)
end

function InitWindow()
  REF.InputName.UIInput.defaultText = WU.GetString("Window_RealNamePlaceholderName")
  REF.InputID.UIInput.defaultText = WU.GetString("Window_RealNamePlaceholderID")
end
