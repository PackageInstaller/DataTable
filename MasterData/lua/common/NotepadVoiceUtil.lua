local WU, DB = require("Common/WindowUtil")()
local PB = require("Common/PbHelper")
local NVU = {}

function NVU.SetAudioFullPath(voiceType, audioActorName, audio)
  local audioFullPath
  if voiceType == 1 then
    audioFullPath = string.format("Voice/%s/%s", audioActorName, audio)
  elseif voiceType == 2 then
    audioFullPath = string.format("Voice/%s/board_Emote/%s", audioActorName, audio)
  elseif voiceType == 3 then
    audioFullPath = string.format("Voice/%s/Event/%s", audioActorName, audio)
  elseif voiceType == 4 then
    audioFullPath = string.format("Voice/%s/character_select/%s", audioActorName, audio)
  end
  return audioFullPath
end

function NVU.GetVoiceListOfWhenRoleSelected(notepadData)
  local allTab = _ENV["!"]({})
  local allVoice = PB.all("RoleNoteVoiceConfig")
  for _, v in pairs(allVoice) do
    if v.roleId == notepadData.roleId and v.audioSrc == PB.enum.RoleNotepadVoiceType.RVT_SELECTED then
      local unlocked = v.favourLevel <= notepadData.favourLevel
      local tab = {}
      tab.unlocked = unlocked
      tab.audio = v.audioName
      tab.audioText = v.text
      tab.audioName = ""
      tab.audioActorName = v.roleName
      tab.favourLevel = v.favourLevel
      local audioFullPath = NVU.SetAudioFullPath(v.voiceType, v.roleName, v.audioName)
      tab.audioFullPath = audioFullPath
      tab.voiceType = v.voiceType
      tab.audioSrc = PB.enum.RoleNotepadVoiceType.RVT_SELECTED
      table.insert(allTab, tab)
    end
  end
  return allTab
end

function NVU.GetVoiceListOfEvent(notepadData)
  local allTab = _ENV["!"]({})
  local allVoice = PB.all("RoleNoteVoiceConfig")
  for _, v in pairs(allVoice) do
    if v.roleId == notepadData.roleId and v.audioSrc == PB.enum.RoleNotepadVoiceType.RVT_EVENT then
      local unlocked = v.favourLevel <= notepadData.favourLevel
      local tab = {}
      tab.unlocked = unlocked
      tab.audio = v.audioName
      tab.audioText = v.text
      tab.audioName = ""
      tab.audioActorName = v.roleName
      tab.favourLevel = v.favourLevel
      local audioFullPath = NVU.SetAudioFullPath(v.voiceType, v.roleName, v.audioName)
      tab.audioFullPath = audioFullPath
      tab.voiceType = v.voiceType
      tab.audioSrc = PB.enum.RoleNotepadVoiceType.RVT_EVENT
      table.insert(allTab, tab)
    end
  end
  return allTab
end

function NVU.GetVoiceListOfSystem(notepadData)
  local allTab = _ENV["!"]({})
  local allVoice = PB.all("RoleNoteVoiceConfig")
  for _, v in pairs(allVoice) do
    if v.roleId == notepadData.roleId and v.audioSrc == PB.enum.RoleNotepadVoiceType.RVT_SYSTEM then
      local unlocked = v.favourLevel <= notepadData.favourLevel
      local tab = {}
      tab.unlocked = unlocked
      tab.audio = v.audioName
      tab.audioText = v.text
      tab.audioName = ""
      tab.audioActorName = v.roleName
      tab.favourLevel = v.favourLevel
      local audioFullPath = NVU.SetAudioFullPath(v.voiceType, v.roleName, v.audioName)
      tab.audioFullPath = audioFullPath
      tab.voiceType = v.voiceType
      tab.audioSrc = PB.enum.RoleNotepadVoiceType.RVT_SYSTEM
      table.insert(allTab, tab)
    end
  end
  return allTab
end

function NVU.GetVoiceListOfSkill(notepadData)
  local allTab = _ENV["!"]({})
  local allVoice = PB.all("RoleNoteVoiceConfig")
  for _, v in pairs(allVoice) do
    if v.roleId == notepadData.roleId and v.audioSrc == PB.enum.RoleNotepadVoiceType.RVT_COMBAT then
      local unlocked = v.favourLevel <= notepadData.favourLevel
      local tab = {}
      tab.unlocked = unlocked
      tab.audio = v.audioName
      tab.audioText = v.text
      tab.audioName = ""
      tab.audioActorName = v.roleName
      tab.favourLevel = v.favourLevel
      local audioFullPath = NVU.SetAudioFullPath(v.voiceType, v.roleName, v.audioName)
      tab.audioFullPath = audioFullPath
      tab.voiceType = v.voiceType
      tab.audioSrc = PB.enum.RoleNotepadVoiceType.RVT_COMBAT
      table.insert(allTab, tab)
    end
  end
  return allTab
end

function NVU.GetVoiceListOfShowBoard(notepadData)
  local allTab = _ENV["!"]({})
  local allVoice = PB.all("RoleNoteVoiceConfig")
  for _, v in pairs(allVoice) do
    if v.roleId == notepadData.roleId and v.audioSrc == PB.enum.RoleNotepadVoiceType.RVT_BOARD then
      local unlocked = v.favourLevel <= notepadData.favourLevel
      local tab = {}
      tab.unlocked = unlocked
      tab.audio = v.audioName
      tab.audioText = v.text
      tab.audioName = ""
      tab.audioActorName = v.roleName
      tab.favourLevel = v.favourLevel
      local audioFullPath = NVU.SetAudioFullPath(v.voiceType, v.roleName, v.audioName)
      tab.audioFullPath = audioFullPath
      tab.voiceType = v.voiceType
      tab.audioSrc = PB.enum.RoleNotepadVoiceType.RVT_BOARD
      table.insert(allTab, tab)
    end
  end
  return allTab
end

function NVU.GetEachVoiceListByLocked(unlocked, notepadData)
  local all = _ENV["!"]({})
  local dataList1 = NVU.GetVoiceListOfEvent(notepadData)
  local dataList2 = NVU.GetVoiceListOfSystem(notepadData)
  local dataList3 = NVU.GetVoiceListOfSkill(notepadData)
  local dataList4 = NVU.GetVoiceListOfShowBoard(notepadData)
  local dataList5 = NVU.GetVoiceListOfWhenRoleSelected(notepadData)
  for _, v in pairs(dataList1) do
    if v.unlocked == unlocked then
      table.insert(all, v)
    end
  end
  for _, v in pairs(dataList2) do
    if v.unlocked == unlocked then
      table.insert(all, v)
    end
  end
  for _, v in pairs(dataList3) do
    if v.unlocked == unlocked then
      table.insert(all, v)
    end
  end
  for _, v in pairs(dataList4) do
    if v.unlocked == unlocked then
      table.insert(all, v)
    end
  end
  for _, v in pairs(dataList5) do
    if v.unlocked == unlocked then
      table.insert(all, v)
    end
  end
  table.sort(all, function(a, b)
    return a.favourLevel < b.favourLevel
  end)
  return all
end

return NVU
