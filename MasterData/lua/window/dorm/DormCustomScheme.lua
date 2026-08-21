local WU, DB, REF = require("Common/WindowUtil")(this)
local AI = require("Common/DormAI")
local PB = require("Common/PbHelper")
local DU = require("Common/DormUtil")
local m_schemeUid, m_dormRoot, m_floor

function SetupWindow()
  WU.BindButtonEvent(REF.ButtonSave, OnClickSave)
  WU.BindButtonEvent(REF.ButtonDelete, OnClickDelete)
  WU.BindButtonEvent(REF.ButtonApply, OnClickApply)
end

function InitWindow()
  REF.InputName.UIInput.defaultText = WU.GetString("Dorm_CustomSchemeInputDefaultText")
  REF.InputName.UIInput.value = ""
end

function SetData(uid, dormRoot, floor)
  m_schemeUid = uid
  m_dormRoot = dormRoot
  m_floor = floor
  WU.SetActive(REF.ButtonDelete, uid ~= 0)
  WU.SetActive(REF.ButtonApply, uid ~= 0)
  REF.LabelHint.UILabel.text = WU.GetString("Dorm_CustomSchemeHint", GetName())
end

function OnClickSave()
  local name = GetName()
  if name == nil then
    return
  end
  local dormArrangement = _ENV["!"](this:GetData("fci/dorm/{playerId}").dormInfo.dormArrangement):duplicate(true)
  local idx = table.find(dormArrangement, function(k, v)
    return v.floor == m_floor
  end)
  if idx then
    dormArrangement[idx] = DU.GetLuaArrangement(m_dormRoot, m_floor)
  else
    error("GamePlay", "[Dorm] arrangement is nil")
    return
  end
  local reqBody = {
    arrangementUid = m_schemeUid,
    name = name,
    arrangement = dormArrangement
  }
  this:GameRequest("fci/dorm-custom-arrangement/"):Post(reqBody, function(resp)
    SyncData(function()
      WU.ShowHintText("Dorm_CustomSchemeSaveSucceed")
      WU.RecycleWindow(this)
    end)
  end)
end

function OnClickDelete()
  this:GameRequest("fci/dorm-custom-arrangement/" .. m_schemeUid):Delete(function(resp)
    SyncData(function()
      WU.ShowHintText("Dorm_CustomSchemeDeleteSucceed")
      WU.RecycleWindow(this)
    end)
  end)
end

function OnClickApply()
  this:GameRequest("fci/dorm-custom-arrangement/"):Patch({arrangementUid = m_schemeUid}, function(resp)
    local data = this:GetData("fci/dorm/{playerId}")
    data.dormInfo.dormArrangement = resp.arrangement
    this:SetData("fci/dorm/{playerId}", data)
    this:BroadcastGameEvent("DormNeedReload")
    WU.ShowHintText("Dorm_CustomSchemeApplySucceed")
    WU.RecycleWindow(this)
  end)
end

function SyncData(callback)
  local data = this:GetData("fci/dorm-custom-arrangement/")
  this:GameRequest("fci/dorm-custom-arrangement/"):Get(function(resp)
    this:SetData("fci/dorm-custom-arrangement/", resp)
    if callback then
      callback(resp)
    end
  end)
end

function GetName()
  local inputName = REF.InputName.UIInput.value
  local maxLen = PB.index("Misc", 1).dormCustomSchemeNameMax
  if string.match(inputName, "[/?#\\\"]") then
    WU.ShowHintText(WU.GetString("Window_RenameIllegal"))
    return nil
  elseif maxLen < utf8.len(inputName) then
    WU.ShowHintText(WU.GetString("Window_EditBoxTooLong", maxLen))
    return nil
  elseif inputName ~= "" then
    return inputName
  end
  local data = this:GetData("fci/dorm-custom-arrangement/")
  local _, info = table.find(data.customInfo, function(k, v)
    return v.arrangementUid == m_schemeUid
  end)
  if info then
    return info.name
  else
    return WU.GetString("Dorm_CustomScheme") .. #data.customInfo + 1
  end
end
