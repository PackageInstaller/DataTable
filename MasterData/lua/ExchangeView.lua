local cfg = nil
local info = nil
local curDatas = {}
local page = nil
local data = nil

local time =0
local timer = 0

function Awake()
    layout = ComUtil.GetCom(vsv, "UIInfinite")
    layout:Init("UIs/Activity6/EXchangeItem", LayoutCallBack, true)
    tlua = UIInfiniteUtil:AddUIInfiniteAnim(layout, UIInfiniteAnimType.Normal)

    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.View_Lua_Opened,OnViewOpened)
    eventMgr:AddListener(EventType.View_Lua_Closed,OnViewClose)
    eventMgr:AddListener(EventType.SpecialDrops_Info_Update,OnInfoUpdate)
end

function LayoutCallBack(index)
    local lua = layout:GetItemLua(index)
    if (lua) then
        local _data = curDatas[index]
        lua.SetIndex(index)
        lua.SetClickCB(OnItemClickCB)
        lua.Refresh(_data)
    end
end

function OnItemClickCB(item)
    local _data = item.GetData()
    ShopCommFunc.OpenPayView(_data,OnSuccess)
end

function OnSuccess()
    SetData()
end

function OnViewOpened(viewKey)
    if (viewKey == "RewardPanel") then
        layout:IEShowList(0)
        ActivityMgr:CheckRedPointData(ActivityListType.Exchange)
    end
end

function OnViewClose(viewKey)
    if (viewKey == "RewardPanel") then
        CSAPI.SetGOActive(animMask, true)
        tlua:AnimAgain()
        layout:IEShowList(#curDatas, function ()
            CSAPI.SetGOActive(animMask, false)
        end)
    end
end

function OnInfoUpdate()
    SetNum()
end

function OnDestroy()
    eventMgr:ClearListener()
end

function Update()
    if time > 0 and Time.time > timer then
        timer = Time.time + 1
        time = GetTime()
        CSAPI.SetText(txtTime1,LanguageMgr:GetByID(22046) .. TimeUtil:GetTimeStr3(time))
    end
end

function Refresh(_data,_elseData)
    data = _data
    cfg = _elseData and _elseData.cfg or nil
    if cfg then
        info = cfg.info and cfg.info[1] or nil
        SetTime()
        SetNum()
        SetData()
        SetItems()
        SetSpecial()
        PlayAnim(600)
    end
end

function SetTime()
    time = GetTime()
    timer = 0
    CSAPI.SetText(txtTime2,"")
    CSAPI.SetText(txtTime3,"")
    CSAPI.SetText(txtTime4,"")
end

function GetTime()
    if data then
        local eTime = data:GetEndTime()
        if eTime > TimeUtil:GetTime() then
            return eTime - TimeUtil:GetTime()
        end
    end
    return 0
end

function SetNum()
    local str= "："
    if info and info.goodId then
        local cfg = Cfgs.ItemInfo:GetByID(info.goodId)
        if cfg and cfg.icon then
            ResUtil.IconGoods:Load(icon,cfg.icon)
        end
        local cur =PlayerMgr:GetSpecialDrop(info.goodId)
        local max = 0
        local cfgs = Cfgs.CfgDropItem:GetAll()
        if cfgs then
            for _, cfg in pairs(cfgs) do
                if cfg.DropItemID and cfg.DropItemID == info.goodId then
                    max = cfg.DropMax or 0
                    break
                end
            end
        end
        str = str ..cur.."/"..max
    end
    CSAPI.SetText(txtNum,str)
end

function SetData()
    if info and info.shopId  then
        page = ShopMgr:GetPageByID(info.shopId)
        if page then
            curDatas = page:GetCommodityInfos(true)
            if #curDatas > 0 then
                table.sort(curDatas,function (a,b)
                    if (a:IsOver() and b:IsOver()) or(not a:IsOver() and not b:IsOver()) then
                        return a:GetID() < b:GetID()
                    else
                        return not a:IsOver()
                    end
                end)
            end
        end
    end
end

function SetItems() 
    tlua:AnimAgain()
    layout:IEShowList(#curDatas)
end

function SetSpecial()
    CSAPI.SetGOActive(specObj,data and data:GetInfo() and data:GetInfo()[1] and data:GetInfo()[1].isSpecial ~= nil)
end

function PlayAnim(time)
    CSAPI.SetGOActive(animMask,true)
    FuncUtil:Call(function ()
        CSAPI.SetGOActive(animMask,false)
    end,this,time)
end

