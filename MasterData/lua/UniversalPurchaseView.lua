local cur,max = 0,0 --现有，最大
local reward = nil --物品
local cost = nil --购买价格
local currNum = 0 --当前购买
local costNum = 0 --消耗合计
local bagCount = 0 --需购买物品数量
local costCount = 0 --消耗物品数量

function Awake()
    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.Universal_Purchase_Refresh_Panel,OnPanelRefresh)
end

function OnPanelRefresh(_cur)
    currNum = cur < 1 and cur or 1
    RefreshPanel()
end

function OnDestroy()
    eventMgr:ClearListener()
end

function OnOpen()
    max = data.max or 0
    cur = data.count or 0 --可购买次数

    reward = data.reward[1]
    if reward == nil then
        LogError("缺少reward字段数据！")
        return
    end

    cost = data.cost[1]
    if cost == nil then
        LogError("缺少cost字段数据！")
        return
    end

    InitPanel()
    RefreshPanel()
end

function InitPanel()
    local titleStr = data.title or LanguageMgr:GetByID(15121)
    CSAPI.SetText(txt_title, titleStr)

    local id = cost[1]
    ResUtil.IconGoods:Load(moneyIcon, id .. "_1")
    ResUtil.IconGoods:Load(coinIcon, id .. "_1")

    currNum = cur < 1 and 0 or 1
end

function RefreshPanel()
    SetcostNum()
    SetNum()
end

function SetNum()
    local tipsStr = data.tips or LanguageMgr:GetByID(15122)
    tipsStr = tipsStr .. cur .. "/" ..max
    CSAPI.SetText(txt_tips, tipsStr)
    CSAPI.SetText(txt_num,currNum .. "")
    bagCount =BagMgr:GetCount(reward[1] or 0)
    CSAPI.SetText(txt_stage1,bagCount .. "")
    CSAPI.SetText(txt_stage2,(bagCount + currNum * reward[2])  .. "")
end

function SetcostNum()
    costCount = BagMgr:GetCount(cost[1] or 0)
    CSAPI.SetText(txt_hasNum, costCount .. "")
    costNum = currNum * (cost[2] or 0)
    CSAPI.SetText(txt_price2,costNum .. "")
end

function GetJumpID(cfgId)
    local cfg = Cfgs.ItemInfo:GetByID(cfgId)
    return cfg and cfg.j_moneyGet or 0
end

function OnClickPay()
    local dialogData = nil
    if cur <= 0 then
        dialogData = {}
        dialogData.content = LanguageMgr:GetTips(24009)
        dialogData.okCallBack = function()
            JumpMgr:Jump(GetJumpID(reward[1]))
            OnClickMask()
        end
    end
    if costNum > costCount then
        dialogData = {}
        dialogData.content = LanguageMgr:GetTips(10004)
        dialogData.okCallBack = function()
            JumpMgr:Jump(GetJumpID(cost[1]))
            OnClickMask()
        end
    end
    if dialogData~= nil then
        CSAPI.OpenView("Dialog",dialogData)
        return
    end

    if data.payFunc then
        data.payFunc(currNum)
    end
    OnClickMask()
end

function OnClickAdd()
    currNum = currNum + 1
    if currNum > cur then
        currNum = cur
    end
    RefreshPanel()
end

function OnClickRemove()
    currNum = currNum - 1
    if cur < 1 or currNum < 0 then
        currNum = 0
    end
    RefreshPanel()
end

function OnClickMax()
    currNum = cur 
    RefreshPanel()
end

function OnClickMin()
    currNum = 0
    RefreshPanel()
end

function OnClickMask()
    view:Close()
end