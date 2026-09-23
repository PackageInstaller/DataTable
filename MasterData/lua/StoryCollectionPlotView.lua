local groupData = nil
local cfgDungeon = nil
local sectionData = nil
local rewardItems = nil

function Awake()
    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.Mission_List, OnMissionListRefresh)
end

function OnMissionListRefresh()
    SetNum()
    SetRed()
end

function OnDestroy()
    eventMgr:ClearListener()
end

function OnInit()
    UIUtil:AddTop2("StoryCollectionPlot", topParent, OnClickBack)
end

function OnOpen()
    if data and data.id then
        groupData = DungeonMgr:GetDungeonGroupData(data.id)
        if groupData then
            cfgDungeon = groupData:GetFirstDungeonCfg()
            sectionData = DungeonMgr:GetSectionData(groupData:GetGroup())
            SetBG()
            RefreshPanel()
        end
    end
end

function SetBG()
    ResUtil.StoryCollectionImg:Load(bg,groupData:GetGroup() .. "/bg",nil,false)
    CSAPI.SetGOAlpha(bg,1)
end

function RefreshPanel()
    SetNum()
    SetTitle()
    SetDesc()
    SetRed()
    SetRewards()
end

function SetNum()
    local curDatas = DungeonMgr:GetDungeonGroupDatas(groupData:GetGroup())
    local cur,max = 0,#curDatas
    if #curDatas > 0 then
        for i, v in ipairs(curDatas) do
            if v:IsPass() then
                cur = cur + 1
            end
        end
    end
    CSAPI.SetText(txtNum1,cur .. "")
    CSAPI.SetText(txtNum2,"/" .. max)
end

function SetTitle()
    CSAPI.SetText(txtTitle,cfgDungeon and cfgDungeon.name or "")
end

function SetDesc()
    CSAPI.SetText(txtDesc,cfgDungeon and cfgDungeon.introduction or "")
end

function SetRed()
    if sectionData then
        CSAPI.SetGOActive(redParent,MissionMgr:CheckRed2(sectionData:GetTaskType(),sectionData:GetID()))
    else
        CSAPI.SetGOActive(redParent,false)
    end
end

function SetRewards()
    local dungeonData = DungeonMgr:GetDungeonData(cfgDungeon.id)
    if dungeonData and dungeonData:IsPass() then
        CSAPI.SetGOActive(rewardObj,false)
        return 
    end
    local rewardDatas = nil
    if cfgDungeon then
        rewardDatas = GetRewardDatas()
    end
    if (rewardItems and #rewardItems > 0) then
        for _, goodsItem in ipairs(rewardItems) do
            CSAPI.SetGOActive(goodsItem.gameObject, false);
        end
    end
    if (not rewardDatas or #rewardDatas < 1) then
        CSAPI.SetGOActive(rewardObj,false)
        return
    end
    for i = 1, 4 do
        local goodsData = GoodsData();
        if (not rewardDatas[i]) then
            break
        end
        local id = rewardDatas[i].id
        goodsData:InitCfg(id);
        if rewardItems == nil or i > #rewardItems then
            ResUtil:CreateUIGOAsync("DungeonDetail/DungeonGoodsItem", itemParent, function(go)
                rewardItems = rewardItems or {}
                local goodsItem = ComUtil.GetLuaTable(go);
                goodsItem.Refresh(goodsData, rewardDatas[i].elseData)
                table.insert(rewardItems, goodsItem)
            end)
        else
            local goodsItem = rewardItems[i];
            CSAPI.SetGOActive(goodsItem.gameObject, true);
            goodsItem.Refresh(goodsData, rewardDatas[i].elseData)
        end
    end
end

-- 获取掉落信息
function GetRewardDatas()
    local _datas = {}
    local dungeonData = DungeonMgr:GetDungeonData(cfgDungeon.id)
    local isPlot = cfgDungeon.sub_type ~= nil    
    local specialRewards = RewardUtil.GetSpecialReward(cfgDungeon.group)
    if not isPlot and (specialRewards and #specialRewards > 0) then
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
    if (cfgDungeon.fisrtPassReward) then
        for i, v in ipairs(cfgDungeon.fisrtPassReward) do
            local _isPass = false
            if (dungeonData and dungeonData.data) then
                _isPass = dungeonData.data.isPass
            end
            local _data = {
                id = GridUtil.GetGoodsID(v),
                num = v[2],
                elseData = {
                    tag = ITEM_TAG.FirstPass,
                    isPass = _isPass
                }
            }
            table.insert(_datas, _data)
        end
    end
    if (cfgDungeon.fisrt3StarReward) then
        for i, v in ipairs(cfgDungeon.fisrt3StarReward) do
            local _isPass = false
            if (dungeonData and dungeonData.data) then
                _isPass = dungeonData.data.star >= 3
            end
            local _data = {
                id =GridUtil.GetGoodsID(v),
                num = v[2],
                elseData = {
                    tag = ITEM_TAG.ThreeStar,
                    isPass = _isPass
                }
            }
            table.insert(_datas, _data)
        end
    end
    if cfgDungeon.fixedReward then --固定
        for i, v in ipairs(cfgDungeon.fixedReward) do
            table.insert(_datas, {
                id = v
            })
        end
    end
    if cfgDungeon.randomReward then --概率
        for i, v in ipairs(cfgDungeon.randomReward) do
            table.insert(_datas, {
                id = v,
                elseData = {
                    tag = ITEM_TAG.Chance
                }
            })
        end
    end
    if cfgDungeon.littleReward then --小概率
        for i, v in ipairs(cfgDungeon.littleReward) do
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

function OnClickEnter()
    if cfgDungeon and cfgDungeon.storyID and cfgDungeon.sub_type == DungeonFlagType.Story then
        PlotMgr:TryPlay(cfgDungeon.storyID, OnStoryPlayComplete, this, true);
    end
end

function OnStoryPlayComplete()
    PlotMgr:Save() -- 播放完毕后保存剧情id
    FightProto:QuitDuplicate({
        index = 1,
        nDuplicateID = cfgDungeon.id
    });
    local data = {};
    data.id = cfgDungeon.id;
    data.star = 1;
    data.isPass = true;
    DungeonMgr:AddDungeonData(data);
    MenuMgr:UpdateDatas() --刷新关卡解锁状态
    EventMgr.Dispatch(EventType.Dungeon_PlotPlay_Over);
    EventMgr.Dispatch(EventType.Activity_Open_State);
    SetNum()
    SetRed()
    SetRewards()
end

function OnClickMission()
    if sectionData then
        CSAPI.OpenView("MissionActivity",{
            type = sectionData:GetTaskType(),
            group = sectionData:GetID()
        })
    end
end

function OnClickBack()
    view:Close()
end