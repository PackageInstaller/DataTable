local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local HU = require("Common/HtmlUtil")
local DBH = require("Manager/DataBindingHandler")
local m_renameCost, m_renameInfo, m_hasRenameCard

function OnRenameClick()
  local itemInfo = DB:GetData("fci/item/" .. 80010)
  if itemInfo and itemInfo.count > 0 then
    m_renameCost = {
      id = 80010,
      type = 11,
      count = itemInfo.count
    }
    m_hasRenameCard = true
    m_renameInfo = this:GetData("fci/name/")
    RenameImpl()
  else
    m_hasRenameCard = false
    this:GameRequest("fci/resbuyprice/" .. PB.enum.RefreshPriceType.ChgName):Get(function(resp)
      m_renameCost = resp.cost
      m_renameInfo = this:GetData("fci/name/")
      RenameImpl()
    end)
  end
end

function RenameImpl()
  local costHtml
  local Misc = PB.index("Misc", 1)
  if not m_renameInfo.notFirstRename then
    costHtml = HU.ApplyFontColor(WU.GetString("Window_FirstNameChangeFree"), "#3B578B")
  elseif m_hasRenameCard then
    costHtml = "<img src='ResIcon_s." .. PB.enum.ResourceType.__keys[m_renameCost.type] .. "_80010'/>&nbsp;" .. HU.ApplyFontColor(m_renameCost.count, "#3B578B")
  else
    costHtml = "<img src='ResIcon_s." .. PB.enum.ResourceType.__keys[m_renameCost.type] .. "_0'/>&nbsp;" .. HU.ApplyFontColor(m_renameCost.count, "#3B578B")
    if not WU.IsEnoughMoney(m_renameCost.count, m_renameCost.type) then
      costHtml = HU.ApplyFontColor(costHtml, "#fd5454")
    end
  end
  WU.ShowEditBox({
    title = WU.GetString("WindowRename_ChangeNickname"),
    subTitle = WU.GetString("Window_GuildEditNameSub"),
    tips = WU.GetString("Window_CharacterLimit", Misc.maxNameLen),
    costEx = costHtml,
    characterLimit = Misc.maxNameLen
  }, OnConfirmRename)
end

function OnConfirmRename(name)
  local baseInfo = this:GetData("fci/baseinfo")
  if string.match(name, "[/?#\\\"]") then
    WU.ShowHintText(WU.GetString("Window_RenameIllegal"))
    return false
  elseif name == baseInfo.name then
    WU.ShowHintText(WU.GetString("Window_RenameEquals"))
    return false
  elseif not m_renameInfo.notFirstRename or m_hasRenameCard then
    this:GameRequest("fci/name"):Patch({name = name}, OnPatchNameResponse)
  elseif WU.IsEnoughMoney(m_renameCost.count, m_renameCost.type) then
    WU.TryToPayResource(m_renameCost, function()
      this:GameRequest("fci/name"):Patch({name = name}, OnPatchNameResponse)
    end)
  else
    WU.ShowHintText(WU.GetString("Window_RenameCostNotEnough"))
    return false
  end
  return true
end

function OnPatchNameResponse(response)
  DBH.ResChange(response.resChange)
  local baseInfo = this:GetData("fci/baseinfo")
  baseInfo.name = response.name
  this:SetData("fci/baseinfo", baseInfo)
  if not m_renameInfo.notFirstRename then
    m_renameInfo.notFirstRename = true
    this:SetData("fci/name/", m_renameInfo)
  end
  local space = this:GetData("Space/SelectedPlayer")
  if space then
    space.name = response.name
    this:SetData("Space/SelectedPlayer", space)
  end
end
