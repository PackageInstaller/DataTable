local layout=nil;
local curDatas={}
local totalVal=0;

function Awake()
    layout = ComUtil.GetCom(vsv, "UISV")
    layout:Init("UIs/LuckyGacha/LuckyGachaPoolInfoItem", LayoutCallBack, true)
    CSAPI.SetGOActive(vsv,false)
    UIUtil:SetPerfectScale(Darken) -- 适配大小
end

function OnOpen()
    FuncUtil:Call(function()
        CSAPI.SetGOActive(vsv,true)
        if data then
            --初始化列表
            local list=data:GetInfos(data:GetRound(),false,true);
            probabilities={};
            --计算总权重值
            if list then
                totalVal=0;
                local list2={};
                for k,v in ipairs(list) do
                    totalVal=totalVal+v:GetWeight()*v:GetRewardNum();
                    local key=v:GetRewardLevel();
                    list2[key]=list2[key] or {};
                    list2[key].grade=key;
                    if list2[key].index==nil then
                        list2[key].index=v:GetIndex();
                    end
                    list2[key].list=list2[key].list or {}
                    list2[key].proba=list2[key].proba or 0;
                    list2[key].proba=list2[key].proba+v:GetWeight();
                    table.insert(list2[key].list,v);
                end
                --分组
                curDatas={};
                for k,v in pairs(list2) do
                    table.insert(curDatas,v);
                end
                table.sort(curDatas, function(a, b)
                    if a.grade == b.grade then
                        return a.index < b.index;
                    else
                        return a.grade < b.grade
                    end
                end)
            end
        end
        layout:IEShowList(#curDatas);
    end,nil,400)
end

function LayoutCallBack(index)
    local _data = curDatas[index]
    local item = layout:GetItemLua(index);
    item.Refresh(_data,totalVal);
end

function OnClickOK()
    view:Close();
end

function OnClickMask()
    view:Close();
end