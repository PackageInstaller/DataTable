local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local S = require("Common/Singleton")
local U = require("Common/Util")
local m_configDataManager = S:Get("ConfigDataManager")
local ACU = require("Common/ActivityUtil")
local ATU = require("Common/AutumnUtil")
local AutumnHardId = {40001, 40002}
local m_activity
local m_playSoundAble = true
local m_activities = {}

function Awake()
  WU.BindButtonEvent(REF.ButtonAutumnWelfare, OnButtonAutumnWelfare)
  BindEvent()
end

function OnEnable()
  CS.SoundManager.Instance:PlaySound("Sound/system/s_System_ChapterChange")
  m_playSoundAble = false
end

function SetTab(index)
  this:SetData("EventDungeon/TabIndexUpdateAble", false)
  REF["tab" .. index].UIToggle.value = true
  m_playSoundAble = true
  ToggleEvent(index)
  SetShelter()
end

function BindEvent()
  WU.TraverseChildren(REF.TabGrid, function(go)
    local gasket = _ENV["$"](go).root
    CS.EventDelegate.Add(gasket.UIToggle.onChange, function()
      m_activities = this:GetData("EventActivity/Activities")
      local color = fif(CS.UIToggle.current.value, 1079611391, 4294967295)
      local index = string.sub(gasket.name, -1)
      REF["LabelName" .. index].UIHtmlLabel.color = CS.NGUIMath.HexToColor(color)
      REF["LabelName" .. index].UIHtmlLabel.text = WU.GetString("EventActivity_Tab" .. m_activities[U.ToInt(index)].activityId)
      REF["LabelOpenTime" .. index].UIHtmlLabel.color = CS.NGUIMath.HexToColor(color)
      if CS.UIToggle.current.value then
        ToggleEvent(index)
        REF["Visual" .. index].UIPlayTween:ResetToBeginning()
        REF["Visual" .. index].UIPlayTween:Play(true)
        REF.EffectBg.EffectGenerator:Play()
        if m_playSoundAble then
          CS.SoundManager.Instance:PlaySound("Sound/system/s_System_ChapterChange")
        end
      end
    end)
  end)
end

function OnButtonAutumnWelfare()
  this:SetData("WelfareTab", "Autumn")
  WU.AcquireWindowAsync("Welfare")
end

function SetRewardPreview()
  local flag = false
  for k, v in pairs(AutumnHardId) do
    if m_activity.activityId == v then
      flag = true
      break
    end
  end
  if flag then
    SetRewardData()
  end
  REF.NodeReward.gameObject:SetActive(flag)
end

function SetRewardData()
  local reward = PB.all("EventReward"):where(function(k, v)
    return v.activityId == m_activity.activityId
  end):toarray():sort(function(a, b)
    return a.star < b.star
  end)
  local index = 1
  WU.TraverseChildren(REF.RewardGrid, function(go)
    local gasket = _ENV["$"](go).root
    gasket["$SetData"](reward[index].reward[1].type, reward[index].reward[1].id)
    if reward[index].reward[1].type == PB.enum.ResourceType.ResMedal then
      local data = {name = false}
      gasket["$ShowCustom"](data)
    end
    REF["LabelStar" .. index].UIHtmlLabel.text = reward[index].star
    index = index + 1
  end)
end

function SetShelter()
  WU.TraverseChildren(REF.TabGrid, function(go)
    local gasket = _ENV["$"](go).root
    local index = string.sub(gasket.name, -1)
    local ac = m_activities[U.ToInt(index)]
    local isOpen, month, day = ATU.AutumnActivityOpen(ac.activityId)
    if not isOpen then
      REF["LabelOpenTime" .. index].UIHtmlLabel.text = WU.GetString("EventActivity_Stage_OpenTime", month, day)
    else
      REF["LabelOpenTime" .. index].UIHtmlLabel.text = WU.GetString("EventActivity_Opening")
    end
    REF["SpriteLock" .. index].gameObject:SetActive(not isOpen)
  end)
end

function ToggleEvent(index)
  m_activity = m_activities[U.ToInt(index)]
  m_activity.index = index
  this:SetData("EventActivity/CurrentActivity", m_activity)
end
