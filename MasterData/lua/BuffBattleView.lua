local groupData = nil
local sectionData = nil
local cfgDungeon = nil
--left
local layout =nil
local curDatas = nil
local curSels = {}
--right
local items = nil
local totalNum = 0
local accNum = 0

function Awake()
    layout = ComUtil.GetCom(vsv,"UIInfinite")
    layout:Init("UIs/BuffBattle/BuffBattleItem1", LayoutCallBack, true)

    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.RedPoint_Refresh, OnRedPointRefresh)

    CSAPI.SetGOAlpha(node,0)
end

function LayoutCallBack(index)
    local lua = layout:GetItemLua(index)
    if (lua) then
        local _data = curDatas[index]
        lua.SetIndex(index)
        lua.SetClickCB(OnItemClickCB)
        lua.Refresh(_data)
        lua.SetSelect(curSels[_data.id] ~= nil)
    end
end

function OnItemClickCB(item)
    local isSel = curSels[item.cfg.id] ~= nil
    curSels[item.cfg.id] = not isSel and 1 or nil
    local isPass,lockStr = GCalHelp:CheckBuffBattle(GetSelIds(),cfgDungeon.id)
    if not isSel and not isPass then
        curSels[item.cfg.id] = nil
        return 
    end
    item.SetSelect(not isSel)
    SetSelScore()
    SetRItems()
end

function OnRedPointRefresh()
    SetRed()    
end

function OnDestroy()
    BuffBattleMgr:SetIDs(curSels)
    eventMgr:ClearListener()
end

function OnInit()
    UIUtil:AddTop2("BuffBattle", topParent, OnClickBack,OnClickHome);
end

function OnOpen()
    groupData = DungeonMgr:GetDungeonGroupData(data and data.id or 0)
    if groupData then
        sectionData = DungeonMgr:GetSectionData(groupData:GetGroup())
        cfgDungeon = groupData:GetFirstDungeonCfg()
        if cfgDungeon == nil then
            LogError("关卡组表未填写对应关卡id")
            return
        end
        PlayerProto:GetBuffBattleInfo(groupData:GetGroup(),OnInfoCallBack)
    end
end

function OnInfoCallBack(proto)
    if proto then
        totalNum = proto.score or 0
        accNum = proto.total_score or 0
    end
    SetSelIds()
    RefreshPanel()
    UIUtil:SetObjFade(node,0,1,nil,300)
end

function SetSelIds()
    local ids = BuffBattleMgr:GetIDs()
    if ids and #ids > 0 then
        for i, v in ipairs(ids) do
            curSels[v] = 1
        end
    end
end

function RefreshPanel()
    SetLeft()
    SetRight()
end

---------------------------------------------左侧---------------------------------------------
function SetLeft()
    SetLDatas()
    SetLItems()
    SetSelScore()
end

function SetLDatas()
    if curDatas == nil then
        curDatas = groupData:GetBuffs()
    end
end

function SetLItems()
    layout:IEShowList(#curDatas)
end

function SetSelScore()
    CSAPI.SetText(txtScore,GCalHelp:GetCheckBuffBattlePoint(GetSelIds(),cfgDungeon.id) .. "")
end

function GetSelIds()
    local datas = {}
    for k, v in pairs(curSels) do
        if v ~= nil then
            table.insert(datas,k)
        end
    end
    return datas
end
---------------------------------------------右侧---------------------------------------------
function SetRight()
    SetTotal()
    SetAcc()
    SetRItems()
    SetRed()
end

function SetTotal()
    CSAPI.SetText(txtTotal,totalNum .. "")
end

function SetAcc()
    CSAPI.SetText(txtAcc,accNum .. "")
end

function SetRItems()
    local ids = GetSelIds()
    local datas = {}
    if #ids > 0 then
        local cfg = nil
        for _, cfgId in ipairs(ids) do
            cfg = Cfgs.CfgBuffBattle:GetByID(cfgId)
            if cfg then
                table.insert(datas,cfg)
            end
        end
    end
    items= items or {}
    ItemUtil.AddItems("BuffBattle/BuffBattleItem2",items,datas,itemParent)
end

function SetRed()
    local isRed = MissionMgr:CheckRed2(eTaskType.PointsBattle,sectionData:GetID())
    UIUtil:SetRedPoint2("Common/Red2", btnMission, isRed, 110, 12, 0)
end

function OnClickClear()
    curSels = {}
    if #curDatas > 0 then
        local lua = nil
        for i, v in ipairs(curDatas) do
            lua = layout:GetItemLua(i)
            if lua then
                lua.SetSelect(false)
            end
        end
    end
    SetRItems()
    SetSelScore()
end

function OnClickEnter()
    CSAPI.OpenView("TeamConfirm", { -- 正常上阵
    dungeonId = cfgDungeon.id,
    teamNum = cfgDungeon.teamNum,
    buffs = GetSelIds()
    }, TeamConfirmOpenType.BuffBattle)
end

function OnClickBack()
    view:Close()
end

function OnClickHome()
    UIUtil:ToHome()
end

function OnClickMission()
    if sectionData then
        UIUtil:ShowMissionReward(sectionData:GetTaskType(),sectionData:GetID())
    end
end