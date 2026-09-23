--公会战奖励界面
local itemPath = "GuildReward/GuildRewardItem"
local curIndex = 1
local datas

function Awake()
    tab = ComUtil.GetCom(tabObj,"CTab")
    tab:AddSelChangedCallBack(OnTabChanged) 

    layout = ComUtil.GetCom(sv,"UICircularScrollView")
    layout:Init(LayoutCallBack)
end

function LayoutCallBack(element)
    local _index = tonumber(element.name) + 1 
    local _data = datas[_index]
    ItemUtil.AddCircularItems(element, itemPath, _data, curIndex)
end

function OnOpen()
    tab.selIndex = curIndex
end

function OnTabChanged(_index)
    curIndex = _index

    local currGFData = GuildFightMgr:GetCurrGFData()
    
    
    if currGFData then 
        CSAPI.SetGOActive(txtTip,false)
        SetReWards(curIndex,currGFData:GetID())
       
        if datas then 
            layout:IEShowList(#datas)            
        end 
    else
        CSAPI.SetGOActive(txtTip,true)   
    end
    
end

--设置奖励内容
function SetReWards(_index,_id)
    local items = {}
      
    --决赛
    if _index == 3 then
        local cfg = Cfgs.CfgGuildFightRankReward:GetByID(_id)
        if cfg and cfg.infos then
            for i,v in ipairs (cfg.infos) do              
                local data = {starIx = v.sartIx, endIx = v.endIx, rewardId = v.rewardId}
                table.insert( items, data )                
            end
        end
    else
        local cfg = Cfgs.CfgGuildFightGroup:GetByID(_id) 
        if cfg and cfg.infos then   
            for i,v in ipairs(cfg.infos) do             
                --预赛
                if _index == 1 then                    
                    local data = {starIx = v.sartIx, endIx = v.endIx, rewardId = v.firstFightRewardId}
                    table.insert( items, data )
                --分组
                elseif _index == 2 then
                    local winData = {rankGroup = v.rankGroup, rewardId = v.winMailId, isWin = true}
                    table.insert( items, winData )
                    local loseData = {rankGroup = v.rankGroup, rewardId = v.lostMailId, isWin = false}
                    table.insert( items, loseData )
                end
            end
        end
    end
    datas = items
end

function OnClickClose()
    view:Close()
end
function OnDestroy()    
    ReleaseCSComRefs();
end

----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()     
gameObject=nil;
transform=nil;
this=nil;  
tabObj=nil;
txtGuild=nil;
txtPersonal=nil;
sv=nil;
txtTip=nil;
view=nil;
end
----#End#----