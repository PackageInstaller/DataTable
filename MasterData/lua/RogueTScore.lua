-- 积分
function Awake()
    UIUtil:AddTop2("RogueTReward", gameObject, function()
        view:Close()
    end, nil, {})
    layout = ComUtil.GetCom(hsv, "UISV")
    layout:Init("UIs/RogueT/RogueTRewardItem", LayoutCallBack, true)

    eventMgr = ViewEvent.New()
    -- 红点刷新
    eventMgr:AddListener(EventType.RedPoint_Refresh, RefreshPanel)
end
function OnDestroy()
    eventMgr:ClearListener()
end

function LayoutCallBack(index)
    local _data = curDatas[index]
    local item = layout:GetItemLua(index)
    item.SetIndex(index)
    item.SetClickCB(ItemClickCB)
    item.Refresh(_data, lv1, s1, 2)
end
function ItemClickCB()
    FightProto:RogueTGainReward(2)
end
function Update()
    if (endTime ~= nil) then
        timer = Time.time + 1
        SetTime()
    end
end

function OnOpen()
    RefreshPanel()
end

function RefreshPanel()
    -- 当前已领取等级，当前积分，最大积分
    lv1, s1, ms1 = RogueTMgr:GetScore()
    curDatas = Cfgs.CfgRogueTPeriodReward:GetAll()
    layout:IEShowList(#curDatas)
    -- time 
    endTime = RogueTMgr:GetRogueTTime()
    timer = Time.time
    --
    CSAPI.SetText(txtCur, s1 .. "")
    CSAPI.SetText(txtMax, "/" .. ms1)
    --
    -- line
    local curLv = 0
    if (s1 > 0) then
        for k, v in ipairs(curDatas) do
            if (v.points <= s1) then
                curLv = k
            else
                break
            end
        end
    end
    local width = (curLv - 1) * 226.5
    CSAPI.SetRectSize(line, width, 16)
end

function SetTime()
    local needTime = endTime - TimeUtil:GetTime()
    if (needTime <= 0) then
        endTime = nil
        -- UIUtil:ToHome()
        -- LogError("周期结束，回到主界面（无多语言）")
    else
        local tab = TimeUtil:GetTimeTab(needTime)
        LanguageMgr:SetText(txtTime, 54047, tab[1], tab[2], tab[3])
    end
end

---返回虚拟键公共接口  函数名一样，调用该页面的关闭接口
function OnClickVirtualkeysClose()
    view:Close()
end
