local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local DU = require("Common/DormUtil")
local m_data

function Awake()
  WU.BindButtonEvent(REF.ButtonAddFriend, OnClickAddFriend)
  WU.BindButtonEvent(REF.ButtonVisit, OnClickVisit)
end

function SetData(data, isFriend)
  m_data = data
  REF.WidgetPlayerName["$SetData"]({playerInfo = data})
  REF.WidgetIconPlayerHeadPhoto["$SetPlayerInfo"](data)
  REF.LabelLevel.UILabel.text = "Lv." .. data.level
  REF.LabelAppreciate.UILabel.text = data.dormInfo.likeNum
  REF.LabelComfort.UILabel.text = data.dormInfo.comfort
  WU.SetActive(REF.ButtonAddFriend, not isFriend)
end

function OnClickAddFriend()
  this:GameRequest("fci/applyfriend/"):Post({
    targetId = m_data.playerId
  }, function(resp)
    WU.ShowHintText(WU.GetString("Window_SendFriendApply"))
  end)
end

function OnClickVisit()
  this:GameRequest("fci/dorm/" .. m_data.playerId):Get(function(resp)
    this:SetData("Dorm/Host", resp)
    WU.RecycleWindow("DormVisit")
    this:SetData("Dorm/InVisitMode", true)
  end)
end
