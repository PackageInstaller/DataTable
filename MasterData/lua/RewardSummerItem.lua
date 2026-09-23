local reward = nil
local item = nil

function Awake()
    CSAPI.SetGOActive(enterAction,false)
end

function SetIndex(idx)
    index = idx
end

function Refresh(_data)
    reward = _data
    if reward then
        local clickCB = nil;
        local goodsData = nil;
        if reward.c_id and reward.type == RandRewardType.EQUIP then
            goodsData = EquipMgr:GetEquip(reward.c_id);
            if goodsData:GetType() == EquipType.Material then
                clickCB = GetClickCB()
            else
                clickCB = GetClickCB(true)
            end
        else
            goodsData, clickCB = GridFakeData(reward)
            clickCB = GetClickCB()
        end
        if not item then
            item = ResUtil:CreateRewardByData(goodsData, itemParent.transform);
        else
            item.Refresh(goodsData)
        end
        item.SetCount(reward.num);
        item.SetClickCB(clickCB);
    end
end

function GetClickCB(isEquip)
    local func = function(tab)
        if tab.data ~= nil then
            CSAPI.OpenView("GoodsFullInfo", {
                data = tab.data,
                key = "RewardPanel"
            }, 2);
		end
    end
    if isEquip then
        func = function(tab)
            if tab.data ~= nil then
                if tab.data:GetType()==EquipType.Normal then
                    CSAPI.OpenView("EquipFullInfo", tab.data, 3);
                else
                    CSAPI.OpenView("GoodsFullInfo",{data=tab.data} , 3);
                end
            end
        end
    end
    return func
end

function ShowEnterAnim(delay)
    CSAPI.SetGOAlpha(anim,0)
    FuncUtil:Call(function ()
        CSAPI.SetGOActive(enterAction,false)
        CSAPI.SetGOActive(enterAction,true)    
    end,this,delay)
end