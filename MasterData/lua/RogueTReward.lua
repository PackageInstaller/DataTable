local showIndex = nil
local curLv = 1

local barTime = nil
local barValue = 0
local barLen = 0.5

function Awake()
    UIUtil:AddTop2("RogueTScore", gameObject, function()
        view:Close()
    end, nil, {})
    layout = ComUtil.GetCom(hsv, "UISV")
    layout:Init("UIs/RogueT/RogueTRewardItem", LayoutCallBack, true)

    fill_imgLv = ComUtil.GetCom(imgLv, "Image")

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
    item.Refresh(_data, lv1, s1, 1)
end
function ItemClickCB(alpha, index)
    if (alpha == 1) then
        FightProto:RogueTGainReward(1)
    else
        showIndex = index
        SetCur()
    end
end
function Update()
    if (endTime ~= nil) then
        timer = Time.time + 1
        SetTime()
    end

    -- 经验
    if (barTime) then
        Anim_fillLv()
    end
end

function OnOpen()
    RefreshPanel()
end

function RefreshPanel()
    -- 当前已领取等级，当前积分，最大积分
    lv1, s1, ms1 = RogueTMgr:GetReward()
    curDatas = Cfgs.CfgRogueTScoreReward:GetAll()
    layout:IEShowList(#curDatas)
    --
    curLv = 0
    if (s1 > 0) then
        for k, v in ipairs(curDatas) do
            if (v.points <= s1) then
                curLv = k
            else
                break
            end
        end
    end
    -- time 
    endTime = RogueTMgr:GetRogueTTime()
    timer = Time.time
    --
    local curCfg = curLv > 0 and curDatas[curLv] or nil
    local nextLv = (curLv + 1) > #curDatas and #curDatas or (curLv + 1)
    local nextCfg = curDatas[nextLv]
    CSAPI.SetText(txtLv, curLv .. "")
    if (nextLv == #curDatas) then
        CSAPI.SetText(txtCur, curCfg.points .. "")
        CSAPI.SetText(txtMax, "/" .. curCfg.points)
        fill_imgLv.fillAmount = 1
    else
        local curPoints = curCfg and curCfg.points or 0
        CSAPI.SetText(txtCur, (s1 - curPoints) .. "")
        CSAPI.SetText(txtMax, "/" .. (nextCfg.points - curPoints))
        fill_imgLv.fillAmount = (s1 - curPoints) / (nextCfg.points - curPoints)
    end
    SetCur()

    --
    barValue = fill_imgLv.fillAmount
    barTime = 0
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

function SetCur()
    local _showIndex = showIndex or (lv1 + 1)
    local curIndex = _showIndex > #curDatas and #curDatas or _showIndex
    local id = curDatas[curIndex].reward[1][1]
    local itemData = BagMgr:GetFakeData(id, BagMgr:GetCount(id))
    CSAPI.SetText(txtName, itemData:GetName())
    CSAPI.SetText(txtDesc, itemData:GetDesc())
    -- iconbg
    ResUtil.IconGoods:Load(frame, GridFrame[itemData:GetQuality() or 1])
    -- icon
    itemData:GetIconLoader():Load(icon,itemData:GetIcon())
    -- line
    local width = (curLv - 1) * 226.5
    CSAPI.SetRectSize(line, width, 16)
end

function Anim_fillLv()
    if (barTime) then
        barTime = barTime + Time.deltaTime
        fill_imgLv.fillAmount = barTime / barLen * barValue
        if (barTime >= barLen) then
            barTime = nil
            fill_imgLv.fillAmount = barValue
        end
    end
end

---返回虚拟键公共接口  函数名一样，调用该页面的关闭接口
function OnClickVirtualkeysClose()
    view:Close()
end
