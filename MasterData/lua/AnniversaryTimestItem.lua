local data = nil
local goodsData = nil
local isFinish = false
local isGet = false

function Refresh(_data)
    data = _data
    if data then
        isFinish = data:IsFinish()
        isGet = data:IsGet()
        CSAPI.SetGOActive(getImg,isGet)
        CSAPI.SetGOActive(selImg,isFinish and not isGet)
        CSAPI.SetGOAlpha(iconParent,isGet and 0.8 or 1)
        local reward = data:GetJAwardId() and data:GetJAwardId()[1]
        if reward then
            goodsData = GridFakeData(reward)
        end
        SetIcon()
        SetNum()
        SetRed()
    end
end

function SetIcon()
    if goodsData and goodsData:GetIcon() then
        ResUtil.IconGoods:Load(icon, goodsData:GetIcon())
    end
end

function SetNum()
    CSAPI.SetText(txtNum,(goodsData and goodsData:GetCount()) .. "")
end

function SetRed()
    UIUtil:SetRedPoint(redParent, isFinish and not isGet)
end

function OnClick()
    if isFinish and not isGet then
        if(MissionMgr:CheckIsReset(data)) then
            --LanguageMgr:ShowTips(xxx)
            LogError("任务已过期")
        else
            MissionMgr:GetReward(data:GetID())
        end
    else
        UIUtil:OpenGoodsInfo(goodsData, 3)
    end
end
