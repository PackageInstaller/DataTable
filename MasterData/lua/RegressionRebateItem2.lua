local info = nil
local cfg = nil
local numSlider = nil
local rItems = {}
local isBuy = false
local buyInfo = nil
local isGet,isFinish = false,false

function Awake()
    numSlider = ComUtil.GetCom(sliderNum, "Slider")
end

function SetIndex(_index)
    index = _index
end

function Refresh(_data, _elseData)
    info = _data and _data.cfg
    isBuy = _elseData
    if isBuy then
        buyInfo = RegressionMgr:GetRebateInfo()
        isGet = _data.isGet
        isFinish = _data.isFinish
    end
    if info then
        SetTitle(info.name)
        SetPrograss(buyInfo and buyInfo.day or 0, info.param)
        SetGrids(info.reward)
        if isBuy then
            SetBtn(isGet, isFinish)
        end
    end
end

-- 设置标题
function SetTitle(str)
    CSAPI.SetText(txtTitle, str)
end

-- 设置进度
function SetPrograss(cur, max)
    cur = cur >= max and max or cur
    CSAPI.SetText(txtNum, cur .. "/" .. max)
    local prograss = cur / max
    numSlider.value = prograss
end

-- 设置物品
function SetGrids(list)
    local rewards = {}
    if list then
        for i, v in ipairs(list) do
            table.insert(rewards, {id = v[1], num = v[2],type = v[3] or RandRewardType.ITEM})
        end
    end
    local gridDatas = GridUtil.GetGridObjectDatas(rewards)
    rItems = rItems or {}
    ItemUtil.AddItems("Grid/GridItem", rItems, gridDatas, itemParent, GridClickFunc.OpenInfoSmiple, 1)
end

-- 设置按钮状态
function SetBtn(isGet, isFinsh)
    CSAPI.SetGOActive(txt_get, isGet)
    CSAPI.SetGOActive(btnJump, false)
    CSAPI.SetGOActive(btnGet, isFinsh and not isGet)
end

function OnClickReward()
    if isFinish and not isGet then
        RegressionProto:ActiveRewardsGain(info.idx)
    end
end
