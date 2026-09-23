--拼图排版界面
local items={};
local puzzleInfo=nil;
local list={};
local rewardBtns={};
local btnList={};
local overReward=nil;
local singGoods=nil;

function Init(_puzzleInfo)
    puzzleInfo=_puzzleInfo;
end

function Refresh(elseData)
    --设置背景图
    list={};
    local activeId=nil;
    if puzzleInfo then
        local bgName=puzzleInfo:GetBG();
        if bgName then
            CSAPI.LoadImg(node,string.format("UIs/PuzzleActivity/%s.png",bgName),true,nil,true);
        else
            LogError("未配置拼图背景图信息！"..table.tostring(puzzleInfo:GetCfg()));
        end
        list=puzzleInfo:GetFragments();
        btnList=puzzleInfo:GetRowRewards();
        activeId=puzzleInfo:GetID();
        --初始化奖励池信息
        SetOverRewardInfo();
        SetSingleRewardInfo();
    end
    -- LogError(btnList)
    --创建碎片
    ItemUtil.AddItems("PuzzleActivity/PuzzleItem", items, list, layout,OnClickFragment,1,{type=puzzleInfo:GetType(),ls=elseData})
    --创建行奖励按钮
    ItemUtil.AddItems("PuzzleActivity/PuzzleRewardBtn", rewardBtns, btnList, btnNode,nil,1,activeId)
end

--info: PuzzleRowRewardInfo
function SetOverRewardInfo()
    local infos=puzzleInfo:GetOverReward()
    if infos and #infos>0 then
        CSAPI.SetGOActive(allNode,true);  
        CSAPI.SetAnchor(singleNode,-102,-200);  
        overReward=infos[1];
        local goods=overReward:GetGoodsInfo(1);
        SetRewardGridState("a",goods,overReward:GetState());
    else
        CSAPI.SetGOActive(allNode,false);   
        CSAPI.SetAnchor(singleNode,0,-200);       
    end
end

function SetRewardGridState(key,goods,state)
    if key and goods and state then
        CSAPI.LoadImg(this[key.."Grid"],string.format("UIs/PuzzleActivity/%s.png",PuzzleEnum.QualityImg[goods:GetQuality()]),true,nil,true);
        goods:GetIconLoader():Load(this[key.."Icon"],goods:GetIcon(),true);
        CSAPI.SetGOActive(this[key.."LockObj"],state==1);
        CSAPI.SetGOActive(this[key.."StateImg"],state==3);
    end
end

function SetSingleRewardInfo()
    singGoods=puzzleInfo:GetSingleRewardGoods();
    if singGoods then
        SetRewardGridState("s",singGoods,2);
    end
end

function OnClickFragment(frag)
    if frag then
        local cost=frag:GetCost();
        local canUnlock=false;
        if cost then
            local full=true;
            for k,v in ipairs(cost) do
                if #v>=2 and BagMgr:GetCount(v[1])<v[2] then
                    full=false;
                    break;
                end
            end
            if full then
                canUnlock=true;
                local goodsInfo=BagMgr:GetFakeData(cost[1][1]);
                local dialogData= {}
                dialogData.content = LanguageMgr:GetByID(74014,goodsInfo:GetName(),cost[1][2])
                dialogData.okCallBack = function()
                    ActivePuzzleProto:UnlockGrid(puzzleInfo:GetID(),frag:GetIdx());
                end
                CSAPI.OpenView("Dialog",dialogData)
            end
        end
        if canUnlock~=true then
            --提示数量不够
            local goodsInfo=BagMgr:GetFakeData(cost[1][1]);
            Tips.ShowTips(LanguageMgr:GetByID(74013,goodsInfo:GetName()));
        end
    end
end

function OnClickSingle()
    if singGoods then
        GridClickFunc.OpenInfoSmiple({data=singGoods});
    end
end

function OnClickAll() --自动下发
    if overReward then
        GridClickFunc.OpenInfoSmiple({data=overReward:GetGoodsInfo(1)});
    end
end