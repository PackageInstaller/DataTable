local cfg = nil
local goGoals = {}

function Refresh(_data)
    cfg = _data and _data:GetCfg()
    if cfg then
        ShowStarInfo()
        ShowOutput(cfg)
        SetTitle()
    end
end

-- 显示条件信息
function ShowStarInfo()
    if #goGoals > 0 then
        for i, v in ipairs(goGoals) do
            CSAPI.SetGOActive(v.gameObject,false)
        end
    end
    if cfg.teamLimted then
        local condition = TeamCondition.New()
        condition:Init(cfg.teamLimted)
        local list = condition:GetDesc()
        if cfg.tacticsSwitch then
            table.insert(list,LanguageMgr:GetByID(49028))
        end
        if list and #list> 0 then
            for i = 1, #list do
                if #goGoals >= i then
                    CSAPI.SetGOActive(goGoals[i].gameObject, true)
                    goGoals[i].Init(list[i]);
                else
                    ResUtil:CreateUIGOAsync("FightTaskItem/FightBigTaskItem", goalTitle, function(go)
                        goGoals = goGoals or {};
                        local item = ComUtil.GetLuaTable(go);
                        CSAPI.SetGOActive(item.gameObject, true)
                        item.Init(list[i]);
                        table.insert(goGoals, item);
                    end);
                end
            end
        end
    end
end

-- 显示掉落
function ShowOutput(cfg)
    local rewardDatas = nil
    if cfg then
        rewardDatas = GetRewardDatas(cfg)
    end
    if (outputGoodItems and #outputGoodItems > 0) then
        for _, goodsItem in ipairs(outputGoodItems) do
            CSAPI.SetGOActive(goodsItem.gameObject, false);
        end
    end
    if (not rewardDatas or #rewardDatas < 1) then
        return
    end
    for i = 1, 4 do
        local goodsData = GoodsData();
        if (not rewardDatas[i]) then
            break
        end
        local id = rewardDatas[i].id
        goodsData:InitCfg(id);
        if outputGoodItems == nil or i > #outputGoodItems then
            ResUtil:CreateUIGOAsync("DungeonDetail/DungeonGoodsItem", goodsNode, function(go)
                outputGoodItems = outputGoodItems or {}
                local goodsItem = ComUtil.GetLuaTable(go);
                goodsItem.Refresh(goodsData, rewardDatas[i].elseData)
                goodsItem.SetFindImg(true)
                table.insert(outputGoodItems, goodsItem)
            end)
        else
            local goodsItem = outputGoodItems[i];
            CSAPI.SetGOActive(goodsItem.gameObject, true);
            goodsItem.Refresh(goodsData, rewardDatas[i].elseData)
            goodsItem.SetFindImg(true)
        end
    end
end

-- 获取掉落信息
function GetRewardDatas(cfg)
    local _datas = {}
    local dungeonData = DungeonMgr:GetDungeonData(cfg.id)
    local specialRewards = RewardUtil.GetSpecialReward(cfg.group)
    if (specialRewards) then
        for i, v in ipairs(specialRewards) do
            local _data = {
                id = GridUtil.GetGoodsID(v),
                elseData = {
                    tag = ITEM_TAG.TimeLimit,
                }
            }
            table.insert(_datas, _data)
        end
    end
    if (cfg.fisrtPassReward) then
        for i, v in ipairs(cfg.fisrtPassReward) do
            local _isPass = false
            if (isTeaching and dungeonData and dungeonData.data) then
                _isPass = dungeonData.data.isPass
            end
            local _data = {
                id = GridUtil.GetGoodsID(v),
                elseData = {
                    tag = ITEM_TAG.FirstPass,
                    isPass = _isPass
                }
            }
            table.insert(_datas, _data)
        end
    end
    if (cfg.fisrt3StarReward) then
        for i, v in ipairs(cfg.fisrt3StarReward) do
            local _isPass = false
            if (isTeaching and dungeonData and dungeonData.data) then
                _isPass = dungeonData.data.star >= 3
            end
            local _data = {
                id = GridUtil.GetGoodsID(v),
                elseData = {
                    tag = ITEM_TAG.ThreeStar,
                    isPass = _isPass
                }
            }
            table.insert(_datas, _data)
        end
    end
    if cfg.fixedReward then --固定
        for i, v in ipairs(cfg.fixedReward) do
            table.insert(_datas, {
                id = v
            })
        end
    end
    if cfg.randomReward then --概率
        for i, v in ipairs(cfg.randomReward) do
            table.insert(_datas, {
                id = v,
                elseData = {
                    tag = ITEM_TAG.Chance
                }
            })
        end
    end
    if cfg.littleReward then --小概率
        for i, v in ipairs(cfg.littleReward) do
            table.insert(_datas, {
                id = v,
                elseData = {
                    tag = ITEM_TAG.LittleChance
                }
            })
        end
    end
    return _datas
end

function OnClickOutput()
    CSAPI.OpenView("DungeonDetail", {cfg, DungeonDetailsType.MainLineOutPut})
end

function SetTitle()
    if not IsNil(txtName) then
        CSAPI.SetText(txtName,cfg.name)
    end
end