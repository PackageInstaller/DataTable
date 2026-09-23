local data=nil;
local eventMgr=nil;
local curHalo=nil;
local itemList={};
function Awake()
    eventMgr = ViewEvent.New();
end

function OnEnable()
    InitListener();
end

function InitListener()

end

function OnDisable()
    if eventMgr then
        eventMgr:ClearListener();
    end
end

-- _d:cardData
function Show(_d)
    data = _d;
    curHalo = data:GetHaloInfo();
    CleanCache();
    CSAPI.SetGOActive(gameObject,true);
    Refresh(true);
end

function Hide()
    CleanCache();
    CSAPI.SetGOActive(gameObject,false);
end

function CleanCache()

end

function Refresh()
    --统计每个等级可以得到的加成和解锁的特殊功能
    if curHalo then
        local cfg=curHalo:GetCfg();
        if cfg then
            local list={};
            for k, v in ipairs(cfg.infos) do
                local effect=v.haloEffect==nil and nil or Cfgs.cfgHaloEffect:GetByID(v.haloEffect)
                table.insert(list,{cfg=v,halo=curHalo,effect=effect,oldCfg=k>1 and cfg.infos[k-1] or nil});
            end
            ItemUtil.AddItems("Halo/HaloAttrInfoItem", itemList, list, Content)
        end
    end
end