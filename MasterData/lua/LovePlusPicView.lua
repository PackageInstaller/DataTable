local data = nil
local curDatas = {}
local layout = nil

function Awake()
    layout = ComUtil.GetCom(vsv, "UIInfinite")
    layout:Init("UIs/LovePlusPic/LovePlusPicItem", LayoutCallBack, true)
end

function LayoutCallBack(index)
    local lua = layout:GetItemLua(index)
    if (lua) then
        local _data = curDatas[index]
        lua.SetIndex(index)
        lua.SetClickCB(ItemClickCB)
        lua.Refresh(_data)
    end
end

function ItemClickCB(item)
    local cfg = item.GetCfg()
    if cfg then
        CSAPI.OpenView("LovePlusMulView",cfg.id)
    end

    --打点
	BuryingPointMgr:TrackEventsByDay("love_plus_picture",{
		time = TimeUtil:GetTimeStr2(TimeUtil:GetTime(),true),
		pictureId = tostring(cfg.id),
		sectionId = tostring(cfg.group),
		state = "1"
	})
end

function Refresh(_data)
    data = _data
    if data then
        SetTop()
        SetDatas()
        SetItems()
    end
end

function SetTop()
    -- CSAPI.SetText(txtTitle,data:GetTitle())
    -- CSAPI.SetText(txtName,data:GetName())
end

function SetDatas()
    if #curDatas < 1 then
        local cfgs = Cfgs.CfgDateCG:GetGroup(data:GetID())
        if cfgs then
            for _, cfg in pairs(cfgs) do
                table.insert(curDatas,cfg)
            end
        end
        if #curDatas > 0 then
            table.sort(curDatas,function (a,b)
                return a.id<b.id
            end)
        end
    end
end

function SetItems()
    layout:IEShowList(#curDatas)
end