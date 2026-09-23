--角色碎片兑换UI
local layout=nil;
local grid1=nil;
local grid2=nil;
local stuffInfo1=nil;
local stuffInfo2=nil;
local exChangeList={};
function Awake()
    layout = ComUtil.GetCom(vsv, "UISV")
	layout:Init("UIs/Grid/GridItem",LayoutCallBack,true,0.7)
end

function OnOpen()
    if openSetting==nil or openSetting==1 then
        stuffInfo1={id=10033,num=0}
        stuffInfo2={id=10034,num=0}
    end
    Refresh();
end

function Refresh()
    local preNum1=0;
    local preNum2=0
    exChangeList={};
    curDatas=data or {};
    local idx="";
    if openSetting and openSetting==2 then
       idx="1"; 
    end
    local key="costs"
    local key2=string.format("gets%s",idx)
    for k,v in ipairs(curDatas) do
        local c=v:GetCfg();
        if c and c.dy_value2 then --通过动态值2获取兑换表数据
            local cfg=Cfgs.CfgItemExchange:GetByID(c.dy_value2);
            if cfg and cfg.type==ExchangeItemType.CardCoreItem and cfg[key2] and cfg[key] then
                --统计能兑换的次数
                local num=0;
                if cfg[key][1] then
                    local val=cfg[key][1][1];
                    local cost=cfg[key][1][2]==nil and 0 or cfg[key][1][2]
                    local goods=BagMgr:GetCardCore(val,true); --获取消耗的素材
                    if goods and goods:GetType()==ITEM_TYPE.CARD_CORE_ELEM then
                        num=math.floor(goods:GetCount()/cost);
                    elseif goods and good:GetType()~=ITEM_TYPE.CARD_CORE_ELEM then
                        LogError("兑换消耗的素材不是角色碎片类型！");
                    end
                end
                for _,val in ipairs(cfg[key2]) do
                    if (stuffInfo1 and stuffInfo1.id==val[1]) or stuffInfo1==nil then
                        stuffInfo1=stuffInfo1 or {}
                        stuffInfo1.id=val[1]
                        stuffInfo1.num=stuffInfo1.num==nil and val[2]*num or stuffInfo1.num+val[2]*num
                    elseif (stuffInfo2 and stuffInfo2.id==val[1])or stuffInfo2==nil then
                        stuffInfo2=stuffInfo2 or {}
                        stuffInfo2.id=val[1]
                        stuffInfo2.num=stuffInfo2.num==nil and val[2]*num or stuffInfo2.num+val[2]*num
                    end
                end
                if num>0 then
                    table.insert(exChangeList,{id=c.dy_value2,num=num});
                end
            end
        end
    end
    if stuffInfo1 then
        CSAPI.SetGOActive(stuff1,true);
        local goods=BagMgr:GetFakeData(stuffInfo1.id);
        -- if goods==nil then
        --     goods = GoodsData({id = stuffInfo1.id, num = 0});
        -- end
        CreateStuffGrid(grid1,stuffGrid1,goods)
        RefrehStuffInfo(goods,stuffInfo1.num,txt_stuff1,txt_curr1,txt_pre1)
    else
        CSAPI.SetGOActive(stuff1,false);
    end
    if stuffInfo2 then
        CSAPI.SetGOActive(stuff2,true);
        local goods2=BagMgr:GetFakeData(stuffInfo2.id);
        -- local goods2=BagMgr:GetDataByCfgID(stuffInfo2.id);
        -- if goods2==nil then
        --     goods2 = GoodsData({id = stuffInfo2.id, num = 0});
        -- end
        CreateStuffGrid(grid2,stuffGrid2,goods2)
        RefrehStuffInfo(goods2,stuffInfo2.num,txt_stuff2,txt_curr2,txt_pre2)
    else
        CSAPI.SetGOActive(stuff2,false);
    end
    layout:IEShowList(#curDatas);
end

function CreateStuffGrid(grid,gridParent,goods)
    if grid==nil and gridParent then
        ResUtil:CreateUIGOAsync("Grid/GridItem",gridParent,function(go)
            local lua=ComUtil.GetLuaTable(go);
            lua.Refresh(goods);
            lua.SetClickCB(GridClickFunc.OpenInfo);
        end)
    end
end

function RefrehStuffInfo(goods,preNum,nameObj,currObj,preObj)
    if goods and preNum and nameObj and currObj and preObj then
        CSAPI.SetText(nameObj,goods:GetName());
        CSAPI.SetText(currObj,tostring(goods:GetCount()));
        CSAPI.SetText(preObj,tostring(goods:GetCount()+preNum));
    end
end

function LayoutCallBack(index)
    local _data = curDatas[index]
	local grid=layout:GetItemLua(index);
	grid.SetIndex(index);
	grid.Refresh(_data);
	grid.SetClickCB(GridClickFunc.OpenInfo);
end

--兑换
function OnClickPay()
    if #exChangeList>0 then
        ClientProto:ExchangeItem(exChangeList, function(proto)
            UIUtil:OpenReward({proto.rewards})
            view:Close();
        end,nil,openSetting);
    else
        LanguageMgr:ShowTips(15104);
    end
end

function OnClickAnyWay()
    view:Close();
end