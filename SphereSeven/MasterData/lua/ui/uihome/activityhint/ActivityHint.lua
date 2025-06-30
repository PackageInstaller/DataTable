local ActivityHint = {}
local this = ActivityHint

local function SummonHint(self)
    -- local freeCall = this.Summon:GetChild(1000)
    -- local num = 0;
    -- if this.player.IsAllowFreeCallCard == 1 then
    --     num = num + 1;
    -- end
    -- freeCall:SetCount(num)
end

local function StarLightRebateHint(self)
    -- local starLightRebateComponent = Game.Scene.Player:GetComponent("StarLightRebateComponent")
    -- local hint = this.Activity:GetChild("StarLightRebate")
    -- hint:SetCount(0)
    -- if starLightRebateComponent:ActiveIsOpen() then
    --     local index = 0
    --     local activityType = this.clientData:GetActivityType()
    --     if not table.any(activityType, function(v) return v == "StarLightRebate" end) then
    --         index = index + 1
    --     end
    --     local count = math.min(table.count(starLightRebateComponent.Records), table.count(Z_StarLightRebate))
    --     local starLightTotal = 0 -- Game.Scene.Player:GetComponent("RecordComponent").PaidStarStoneNum
    --     for i = 1, count do
    --         --达成条件未领取的
    --         if starLightRebateComponent.Records[i] == 0 and Z_StarLightRebate[i].RewardStandard <= starLightTotal then
    --             index = index + 1
    --         end
    --     end
    --     if index > 0 then
    --         hint:AddCount(index)
    --     end
    -- end
end

local function ActivityFightSouleHint(self)
    -- local hint = this.Activity:GetChild("ActivityFightSoule")
    -- local rewardHint = this.Activity:GetChild("ActivityFightSoule2"):GetChild("Reward")
    -- rewardHint:SetCount(0)
    -- hint:SetCount(0)
    -- if this.diffTime > 0 then 
    --     local activityType = this.clientData:GetActivityType()
    --     if not table.any(activityType, function(v) return v == "ActivityFightSoule" end) then
    --         hint:AddCount(1)
    --     end
    --     local tasks = Game.Scene.Player:GetComponent("TaskComponent").Tasks
    --     local index = table.count(table.choose(tasks,function(_,v) return v.MissionType == 6 and v.State == 1 end))
    --     if index > 0 then
    --         rewardHint:AddCount(index)
    --     end
    -- end
end

local function ActivitLoginHint(self)
    local activityName = { [1001] = "ActivityLogin", }
    local activityTypes = this.clientData:GetActivityType()
    -- for k, v in pairs(activityName) do
    --     if this.activityDemonComponent:LoginIsOpen(k) then
    --         local hint = this.Activity:GetChild(v)
    --         local rewardHint = this.Activity:GetChild(v .. "2"):GetChild("Reward")
    --         hint:SetCount(0)
    --         rewardHint:SetCount(0)
    --         if not table.any(activityTypes, function(av) return av == v end) then
    --             hint:AddCount(1)
    --         end
    --         local index = this.activityDemonComponent.ActivityLogins[k].LoginNum - table.count(this.activityDemonComponent.ActivityLogins[k].Records)
    --         if index > 0 then
    --             rewardHint:AddCount(index)
    --         end
    --     end
    -- end
end

function this.OnLangCreate(self)
    LangUtil.BindText(self.drawCard_btn.transform:Find("Hint/Text"))
    -- LangUtil.BindText(self.ActiveBtn.transform:Find("Hint/Text"))

end

function this.OnCreate(self)
    this.player = Game.Scene.Player
    this.clientData = ClientData:GetInstance()
    -- 活动红点 跟 主页左边的活动绑定
    -- this.Activity = Game.Scene:GetComponent("HintComponent").Activity
    -- this.Activity:AddObject(self.ActiveBtn.transform:Find("Hint").gameObject,"Home")

    this.Summon = Game.Scene:GetComponent("HintComponent").Recruit
    this.Summon:AddObject(self.drawCard_btn.transform:Find("Hint").gameObject, "Home")
    -- coroutine.start(function()
    --     coroutine.waitforseconds(3)
    --     TaskData.OnCheckT()
    -- end)
end

function this.InitActivityHint(self)
    this.activityDemonComponent = Game.Scene.Player:GetComponent("GameEventComponent")
    this.diffTime = UIUtil.GetDiffTime(5)
    -- StarLightRebateHint(self)
    -- ActivityFightSouleHint(self)
    -- ActivitLoginHint(self)
    -- SummonHint(self)
end

function this.OnPaidStarStoneChg(self)
    StarLightRebateHint(self)
end

function this.OnTaskDataChg(self)
    this.diffTime = UIUtil.GetDiffTime(5)
    ActivityFightSouleHint(self)
end

function this.OnSummonDataChg(self)
    SummonHint(self)
end

function this.OnActivityLoginChg(self)
    ActivitLoginHint(self)
end

function this.OnDestroy()

end

return this