local info = nil
local comm = nil
local priceItem = nil

function Awake()
    SetSelect(false)
end

function SetIndex(idx)
    index = idx
end

function SetClickCB(_cb)
    cb = _cb
end

function SetSelect(b)
    CSAPI.SetAngle(node,0,0,b and 8 or 0)
    CSAPI.SetGOActive(selImg,b)
end

--CfgBreakfastReward
function Refresh(_data)
    info = _data    
    if info then
        comm = ShopMgr:GetFixedCommodity(info.goodsId)
        SetIcon()
        SetDay()
        SetPrice()
        SetNum()
    end
end

function SetIcon()
    local iconName = comm:GetIcon()
    if iconName and iconName~= "" then
        ResUtil.IconGoods:Load(icon,iconName)
    end
end

function SetDay()
    LanguageMgr:SetText(txtDay,311001,info.index)
end

function SetPrice()
    ShopCommFunc.InitPriceItem(comm,priceNode,priceItem,"ShopComm/ShopPriceItem8")
end

function SetNum()
    CSAPI.SetText(txtNum,GetGoodsNumByComm(comm,ITEM_ID.DIAMOND) .. "")
end

function GetGoodsNumByComm(comm,id)
    local num = 0
    local rewardInfos = comm:GetCommodityList()
    if rewardInfos then
        for i, v in ipairs(rewardInfos) do
            if v.cid == id then
                num = num + v.num
            end
        end
    end
    return num
end

function GetRewards()
    return comm and comm:GetCommodityList()
end

function OnClick()
    if cb then
        cb(this)
    end
end