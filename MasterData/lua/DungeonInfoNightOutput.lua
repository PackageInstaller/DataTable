local cfg = nil
local data = nil
local sectionData = nil
local outputGoodItems = {}
local rewardDatas = nil

function Awake()
    CSAPI.SetGOActive(empty, false)
end

function Refresh(tab)
    cfg = tab.cfg
    data = tab.data
    sectionData = tab.sectionData
    if cfg then
        ShowOutput()
    end
end

-- 显示掉落
function ShowOutput()
    rewardDatas = nil
    if cfg then
        rewardDatas = GetRewardDatas()
    end
    if (outputGoodItems and #outputGoodItems > 0) then
        for _, goodsItem in ipairs(outputGoodItems) do
            CSAPI.SetGOActive(goodsItem.gameObject, false);
        end
    end
    CSAPI.SetGOActive(empty, not rewardDatas or #rewardDatas < 1)
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
                -- goodsItem.SetFindImg(true)
                goodsItem.SetSpecial(true)
                table.insert(outputGoodItems, goodsItem)
            end)
        else
            local goodsItem = outputGoodItems[i];
            CSAPI.SetGOActive(goodsItem.gameObject, true);
            goodsItem.Refresh(goodsData, rewardDatas[i].elseData)
            -- goodsItem.SetFindImg(true)
            goodsItem.SetSpecial(true)
        end
    end
end

-- 获取掉落信息
function GetRewardDatas()
    local _datas = {}
    local dungeonData = DungeonMgr:GetDungeonData(cfg.id)
    local isTeaching = cfg.type == eDuplicateType.Teaching -- 教程关
    local specialRewards = RewardUtil.GetSpecialReward(cfg.group)
    if (specialRewards and #specialRewards > 0) then
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
    if (cfg.fisrtPassReward and ((not dungeonData or not dungeonData.data or not dungeonData.data.isPass) or isTeaching)) then
        for i, v in ipairs(cfg.fisrtPassReward) do
            local _isPass = false
            if (isTeaching and dungeonData and dungeonData.data) then
                _isPass = dungeonData.data.isPass
            end
            local _data = {
                id = GridUtil.GetGoodsID(v),
                elseData = {
                    tag = ITEM_TAG.FirstPass,
                    isPass = _isPass,
                }
            }
            table.insert(_datas, _data)
        end
    end
    if (cfg.fisrt3StarReward and ((not dungeonData or not dungeonData.data or dungeonData.data.star < 3) or isTeaching)) then
        for i, v in ipairs(cfg.fisrt3StarReward) do
            local _isPass = false
            if (isTeaching and dungeonData and dungeonData.data) then
                _isPass = dungeonData.data.star >= 3
            end
            local _data = {
                id = GridUtil.GetGoodsID(v),
                elseData = {
                    tag = ITEM_TAG.ThreeStar,
                    isPass = _isPass,
                }
            }
            table.insert(_datas, _data)
        end
    end
    if cfg.fixedReward then --固定
        for i, v in ipairs(cfg.fixedReward) do
            table.insert(_datas, {
                id = v,
            })
        end
    end
    if cfg.randomReward then --概率
        for i, v in ipairs(cfg.randomReward) do
            table.insert(_datas, {
                id = v,
                elseData = {
                    tag = ITEM_TAG.Chance,
                }
            })
        end
    end
    if cfg.littleReward then --小概率
        for i, v in ipairs(cfg.littleReward) do
            table.insert(_datas, {
                id = v,
                elseData = {
                    tag = ITEM_TAG.LittleChance,
                }
            })
        end
    end
    return _datas
end

function OnClickOutput()
    if (not rewardDatas or #rewardDatas < 1) then
        return
    end
    CSAPI.OpenView("DungeonDetail", {cfg, DungeonDetailsType.MainLineOutPut})
end