local slider = nil
local isGet = false
local isGet2 = false
local isFinish = false
local isFinish2 = false
local rItems = nil
local isBuy = true
local fundInfo =nil

function Awake()
    slider = ComUtil.GetCom(numSlider, "Slider")
end

function SetShopClickCB(_shopCb)
    shopCb = _shopCb
end

function SetClickCB(_cb)
    cb = _cb
end

function SetIndex(idx)
    index = idx
end

function Refresh(_data,_elseData)
    info = _data
    isBuy = _elseData and _elseData.isBuy
    if info then
        isGet = info:IsGet()
        isFinish = info:IsFinish()
        SetTitle()
        SetSlider()
        SetFund()
        SetReward()
        SetState()
    end
end

function SetTitle()
    CSAPI.SetText(txtTitle, info:GetName())
end

function SetSlider()
    CSAPI.SetText(txtNum, info:GetCnt() .. "/" .. info:GetMaxCnt())
    slider.value = info:GetCnt() / info:GetMaxCnt()
end

function SetFund()
    if info:GetFundId() then
        fundInfo =MissionMgr:GetData2(info:GetFundId())
        isGet2 = fundInfo:IsGet()
        isFinish2 = fundInfo:IsFinish()
    end
end

function SetReward()
    local gridDatas = GridUtil.GetGridObjectDatas(GetRewards())
    rItems = rItems or {}
    ItemUtil.AddItems("RegressionActivity4/RegressionFundReward", rItems, gridDatas, rewardParent, GridClickFunc.OpenInfoSmiple, 1,{isLock = not isBuy,isGet = isGet,isGet2 = (isGet2 and isBuy)})
end

function GetRewards()
   local rewards = info:GetJAwardId()
    if fundInfo then
        local _rewards = fundInfo:GetJAwardId()
        table.insert(rewards,_rewards[1])
    end
   return rewards
end

function SetState()
    CSAPI.SetGOActive(btnJump, not isGet and not isFinish)
    CSAPI.SetGOActive(btnGet, (isFinish and not isGet) or (isBuy and isFinish2 and not isGet2))
    CSAPI.SetGOActive(txtFinish, isGet and isBuy and isGet2)
    CSAPI.SetGOActive(btnShop,isGet and not isBuy)
    CSAPI.SetGOAlpha(node,(isGet and isBuy and isGet2) and 0.5 or 1)
end

function OnClickGet()
    if cb then
        cb() 
    end
end

function OnClickJump()
    if (info:GetJumpID()) then
        JumpMgr:Jump(info:GetJumpID())
    end
end

function OnClickShop()
    if shopCb then
        shopCb()
    end
end
