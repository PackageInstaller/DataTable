local cfg = nil
local data = nil
local sectionData = nil

function Refresh(tab)
    cfg = tab.cfg
    data = tab.data
    sectionData = tab.sectionData
    if cfg then
        isStoryFirst = (not data) or (not data:IsPass())
    end
end

function SetStoryCB(_cb)
    cb = _cb
end

function OnClickStory()
    OnStoryClick()
end

function OnStoryClick()
    if cfg and cfg.storyID and cfg.sub_type == DungeonFlagType.Story then
        PlotMgr:TryPlay(cfg.storyID, OnStoryPlayComplete, this, true);
    end
end

function OnStoryPlayComplete()
    PlotMgr:Save() -- 播放完毕后保存剧情id
    FightProto:QuitDuplicate({
        index = 1,
        nDuplicateID = cfg.id
    });
    local data = {};
    data.id = cfg.id;
    data.star = 1;
    data.isPass = true;
    DungeonMgr:AddDungeonData(data);
    MenuMgr:UpdateDatas() --刷新关卡解锁状态
    EventMgr.Dispatch(EventType.Dungeon_PlotPlay_Over);
    EventMgr.Dispatch(EventType.Activity_Open_State);
    if cb then
        cb(isStoryFirst)
    end
end