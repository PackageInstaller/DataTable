local data = nil
local layout = nil
local currDatas = nil
local arrowUtil = nil
local currStageData = nil
local time,timer = 0,0
local pSlider = nil
local rSlider = nil
local isFinish = false
local isMissionFinish = false
local rewardItems = nil
local limitNum = 0
local refreshTime = 0
local totalQuota = 0
local showRewards = nil
local stage = 0

function Awake()
    layout = ComUtil.GetCom(vsv, "UIInfinite")
    layout:Init("UIs/OperationActivity2/MissionLimitedItem", LayoutCallBack, true)
    eventMgr = ViewEvent.New();
    eventMgr:AddListener(EventType.Mission_List, OnMissionList);
    eventMgr:AddListener(EventType.Mission_Limit_Update,OnTopRefresh)

    pSlider = ComUtil.GetCom(sliderProgress,"Slider")
    rSlider = ComUtil.GetCom(sliderReward,"Slider")

    arrowUtil = ArrowUtil.New()
    arrowUtil:Init(sv, rewardParent, arrowL, arrowR)

    CSAPI.SetGOActive(goodsFinish,false)
    CSAPI.SetGOActive(getObj,false)
end

function OnMissionList(_data)
    if gameObject.activeSelf == false then
        return
    end
    if not _data then
        RefreshPanel()
        RefreshTopPanel()
        return
    end

    local rewards = _data[2]
    RefreshPanel()
    RefreshTopPanel()
    if (#rewards > 0) then
        UIUtil:OpenReward({rewards})
    end
end

function LayoutCallBack(index)
    local lua = layout:GetItemLua(index)
    if (lua) then
        local _data = currDatas[index]
        lua.SetIndex(index)
        lua.Refresh(_data)
    end
end

function OnDestroy()
    eventMgr:ClearListener()
end

function Update()
    arrowUtil:Update()

    if time > 0 and timer < Time.time then
        timer = Time.time + 1
        time = data:GetEndTime() - TimeUtil:GetTime()
        LanguageMgr:SetText(txtTime,13021,TimeUtil:GetTimeStr3(time))
    end
end

function Refresh(_data, _elseData)
    data = _data
    if data then
        totalQuota = tonumber(data:GetInfoContent("totalQuota") or 1)
        RefreshPanel()
        OperateActiveProto:GetLimitRewardInfo(data:GetID(),OnTopRefresh)
    end
end

function RefreshPanel()
    SetTime()
    SetDatas()
    SetItems()
end

function SetTime()
    time = data:GetEndTime() - TimeUtil:GetTime()
end

function SetDatas()
    currDatas = MissionMgr:GetActivityDatas(eTaskType.LimitReward)
end

function SetItems()
    layout:IEShowList(#currDatas)
end

function OnTopRefresh(proto)
    if proto then
        if proto.stage then
            stage = proto.stage
        end
        RefreshTopPanel()
        if currStageData then
            local cfgStage = currStageData and currStageData:GetCfg()
            if cfgStage then
                LanguageMgr:SetText(txtProgress,45025,proto.curQuota,totalQuota)
                pSlider.value = proto.curQuota / totalQuota
                LanguageMgr:SetText(txtSurplus,45026,totalQuota - proto.curQuota < 0 and 0 or totalQuota - proto.curQuota)
                CSAPI.SetText(txtDesc1,cfgStage.sRewardDes or "")
                isFinish = proto.curQuota - totalQuota >= 0
                CSAPI.SetGOActive(goodsFinish,isFinish)
                CSAPI.SetGOAlpha(iconParent,isFinish and 0.5 or 1)
            end

        end
        if proto.isPopup then
            ShowGetPanel(proto)
        end
    end
end

function RefreshTopPanel()
    if stage > 0 then
        local datas = MissionMgr:GetActivityDatas(eTaskType.LimitRewardStage,nil,stage)
        currStageData = datas and datas[1]
        if currStageData then
            isMissionFinish = currStageData:IsFinish()
            SetGoodPanel()
            SetRewards()
        end
    end
end

-- 物品信息
function SetGoodPanel()
    if currStageData and currStageData:GetCfg() then
        local iconName = currStageData:GetCfg().sIcon
        if iconName ~= "" then
            ResUtil.IconGoods:Load(icon, iconName .. "")
        end
        local cfg = Cfgs.ItemInfo:GetByID(tonumber(iconName))
        CSAPI.SetText(txtName, cfg and cfg.name or "")
    end
end

-- 奖励信息
function SetRewards()
    local rewards = {}
    limitNum = 0
    if currStageData then
        rewards = GetJLimitRewardIds(data:GetInfoContent("itemId"))
        limitNum = #rewards
        local _rewards = currStageData:GetJAwardId()
        if _rewards and #_rewards > 0 then
            for i, v in ipairs(_rewards) do
                table.insert(rewards, v)
            end
        end
        rSlider.value = (currStageData:GetCnt() / currStageData:GetMaxCnt()) or 0
        CSAPI.SetText(txtNum, currStageData:GetCnt() .. "/" .. currStageData:GetMaxCnt())
        showRewards = rewards
    end
    -- item
    local gridDatas = GridUtil.GetGridObjectDatas(rewards) 
    
    --scale
    local scale = #gridDatas > 3 and 0.54 or 0.7
    CSAPI.SetScale(rewardParent, scale, scale, 1)

    rewardItems = rewardItems or {}
    ItemUtil.AddItems("OperationActivity2/MissionLimitedReward", rewardItems, gridDatas, rewardParent,
        GridClickFunc.OpenInfoSmiple, 1,{scale = scale,isFinish = isMissionFinish},OnItemLoadSuccess)

    CSAPI.SetGOActive(finishObj, currStageData:IsFinish())
    CSAPI.SetGOActive(nolObj,not currStageData:IsFinish())
end

--限量任务展示用
function GetJLimitRewardIds(ids)
	local rewards = {}
	if(ids) then
		for i, v in ipairs(ids) do
			table.insert(rewards, {id = v[1], num = v[2], type = v[3]})
		end
	end
	return rewards
end

function OnItemLoadSuccess()
    arrowUtil:RefreshLen()
    if limitNum > 0 then
        for i = 1, limitNum do
            rewardItems[i].ShowLimit(isFinish)
        end
    end
end

function OnClickRefresh()
    if TimeUtil:GetTime() <= refreshTime then
        LanguageMgr:ShowTips(40006)
        return
    end
    refreshTime = TimeUtil:GetTime() + 20
    OperateActiveProto:GetLimitRewardInfo(data:GetID())
end

--显示窗口
function ShowGetPanel(proto)
    CSAPI.SetGOActive(getObj, true)
    if proto.time then
        local loseTimeTab = {}
        if currStageData then
            local rewards = GetJLimitRewardIds()
            local cfgItemInfo = Cfgs.ItemInfo:GetByID(rewards and rewards[1] and rewards[1].id) 
            if cfgItemInfo and cfgItemInfo.sExpiry then
                local time = TimeUtil:GetTimeStampBySplit(cfgItemInfo.sExpiry)
                loseTimeTab = TimeUtil:GetTimeHMS(time)
            end
        end
        local timeTab = TimeUtil:GetTimeHMS(proto.time)
        local str = ""
        if proto.quota then --已领取
            str = LanguageMgr:GetTips(60001,timeTab.year,timeTab.month,timeTab.day,timeTab.hour,timeTab.min,timeTab.sec,proto.quota,loseTimeTab.year,loseTimeTab.month,loseTimeTab.day)
        else
            str = LanguageMgr:GetTips(60002,timeTab.year,timeTab.month,timeTab.day,timeTab.hour,timeTab.min,timeTab.sec)
        end
        CSAPI.SetText(txtDesc2,str)
    end
end

function OnClickGet()
    OperateActiveProto:LimitRewardCloseWindow(OnRewardShow)
    CSAPI.SetGOActive(getObj, false)
end

function OnRewardShow()
    if showRewards and #showRewards >0 then
        UIUtil:OpenReward({showRewards})
        showRewards = nil
    end
end