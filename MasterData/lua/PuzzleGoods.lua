--购买格子
local data=nil;
local getType=nil;
local costIdx=1;
local isSelect=false;

function Refresh(_d,_getType,_isSelect)
    data=_d;
    getType=_getType;
    isSelect=_isSelect;
    if data then
        local num="";
        if _getType==PuzzleEnum.GetWayType.Buy then
            SetCost(data:GetCosts(),not data:CanBuy());
            num=LanguageMgr:GetByID(74023,data:GetID());
        elseif _getType==PuzzleEnum.GetWayType.Draw then
            num=tostring(data.count);
            SetCost();
        end
        CSAPI.SetText(txtNum,num);
    end
    -- CSAPI.SetGOActive(border,isSelect==true);
end

--设置单种价格
function SetCost(costs,isOver)
    if costs==nil or isOver then
        CSAPI.SetGOActive(priceObj,false);
        CSAPI.SetGOActive(dPriceObj,false);
        do return end
    end
    if costs then
        if #costs==1 then
            if costs[1].num>0 then
                local tips="";
                ShopCommFunc.SetPriceIcon(moneyIcon,costs[1]);
                if costs[1].id==-1 then
                    tips=LanguageMgr:GetByID(18013);
                end
                CSAPI.SetText(txt_price,tips..tostring(costs[1].num));
                CSAPI.SetGOActive(priceObj,true);
                CSAPI.SetGOActive(dPriceObj,false);
            else
                CSAPI.SetGOActive(priceObj,false);
                CSAPI.SetGOActive(dPriceObj,false);
            end
        else
            CSAPI.SetGOActive(priceObj,false);
            CSAPI.SetGOActive(dPriceObj,true);
            CSAPI.SetGOActive(pnIcon1,costs[1].id==-1 )
            if costs[1].id~=-1 then
                ShopCommFunc.SetPriceIcon(dMIcon1,costs[1]);
            else
                CSAPI.SetText(pnIcon1,LanguageMgr:GetByID(18013));
            end
            CSAPI.SetGOActive(pnIcon2,costs[2].id==-1 )
            if costs[2].id~=-1 then
                ShopCommFunc.SetPriceIcon(dMIcon2,costs[2]);
            else
                CSAPI.SetText(pnIcon2,LanguageMgr:GetByID(18013));
            end
            CSAPI.SetText(txt_hPrice1,tostring(costs[1].num));
            CSAPI.SetText(txt_hPrice2,tostring(costs[2].num));
        end
    else
        CSAPI.SetGOActive(priceObj,false);
        CSAPI.SetGOActive(dPriceObj,false);
    end
end

function OnClick()
    if getType==PuzzleEnum.GetWayType.Buy then
        -- isSelect=not isSelect;
        EventMgr.Dispatch(EventType.Puzzle_Selected_Goods,{tab=this,isSelect=isSelect});
    elseif getType==PuzzleEnum.GetWayType.Draw and data then --显示物品详情
        CSAPI.OpenView("GoodsFullInfo",{data=data:GetGoods()});
    end
end

function GetData()
    return data;
end

function GetID()
    if data then
        return data:GetID()
    end
end

function GetCost()
    if data then
        return data:GetCosts()[costIdx]
    end
end

function GetGostIdx()
    return costIdx
end

--切换支付模式
function OnClickPrice()
    OnClick()
    -- if getType==PuzzleEnum.GetWayType.Buy then
    --     costIdx=costIdx==1 and 2 or 1;
    --     CSAPI.SetScale(priceBg,costIdx==1 and 1 or -1,1,1);
    -- end
end