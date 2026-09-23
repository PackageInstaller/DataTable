ActivePuzzleProto = {}

--获取拼图数据
function ActivePuzzleProto:GetPuzzleData(id)
    local proto = {"ActivePuzzleProto:GetPuzzleData", {id=id}}
	NetMgr.net:Send(proto);
end

function ActivePuzzleProto:GetPuzzleDataRet(proto)
    PuzzleMgr:SetData(proto);
    EventMgr.Dispatch(EventType.Puzzle_Data_Ret);
end

--请求获取抽奖配置
function ActivePuzzleProto:DrawPuzzle(id)
    local proto = {"ActivePuzzleProto:DrawPuzzle", {id=id}}
	NetMgr.net:Send(proto);
end

function ActivePuzzleProto:DrawPuzzleRet(proto)
    LogError(proto)
end

--请求解锁拼图格子
function ActivePuzzleProto:UnlockGrid(id,gridIdxs)
    local proto = {"ActivePuzzleProto:UnlockGrid", {id=id,gridIdx=gridIdxs}}
	NetMgr.net:Send(proto);
end

function ActivePuzzleProto:UnlockGridRet(proto)
    --比较新增的ID
    PuzzleMgr:UpdateGridsInfo(proto); 
    -- local ids=nil
    -- if proto then
    --     local info=PuzzleMgr:GetData(proto.id);
    --     if info and proto.unlockGrid then
    --         local ls=info:GetData().unlockGrids;
    --         if ls then
    --             for k,v in ipairs(proto.unlockGrid) do
    --                 local has=false;
    --                 for _, val in ipairs(ls) do
    --                     if v==val then
    --                         has=true
    --                         break
    --                     end
    --                 end
    --                 if has~=true then
    --                     ids=ids or {}
    --                     table.insert(ids,v);
    --                 end
    --             end
    --         end
    --     end
    -- end
    if proto then
        local info=PuzzleMgr:GetData(proto.id);
        if info then
            if info:GetType()==ePuzzleType.Type2 then
                EventMgr.Dispatch(EventType.Puzzle_Unlock_Ret,proto)
            else
                EventMgr.Dispatch(EventType.Puzzle_Item_TweenBegin,proto)
            end     
        end
    end
end

function ActivePuzzleProto:GetReward(id,rwdId)
    local proto = {"ActivePuzzleProto:GetReward", {id=id,rwdId=rwdId}}
	NetMgr.net:Send(proto);
end

function ActivePuzzleProto:GetRewardRet(proto)
    PuzzleMgr:UpdateRwdIds(proto);
    EventMgr.Dispatch(EventType.Puzzle_GetReward_Ret)
end

--请求购买碎片
function ActivePuzzleProto:BuyPuzzle(id,idx,costType)
    local proto = {"ActivePuzzleProto:BuyPuzzle", {id=id,idx=idx,costType=costType}}
	NetMgr.net:Send(proto);
end

function ActivePuzzleProto:BuyPuzzleRet(proto)
    if proto and proto.unlockGrids then
        PuzzleMgr:UpdateGridsInfo(proto); 
    end
    EventMgr.Dispatch(EventType.Puzzle_Buy_Ret);
end