local curDatas = nil
local sectionData = nil

function Awake()
    layout = ComUtil.GetCom(vsv, "UIInfinite")
    layout:Init("UIs/Exploration/TowerDeepRewardItem", LayoutCallBack)
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
    CSAPI.OpenView("TowerDeep",{id= data,itemId = item.data:GetID()})
    view:Close()
end

function OnOpen()
    if data then
        SetDatas()
        SetItems()
    end
end

function SetDatas()
    curDatas = DungeonMgr:GetDungeonGroupDatas(data)
    if #curDatas > 0 then
        table.sort(curDatas,function (a,b)
            local isGet1 = TowerMgr:IsDeepRewardGet(a:GetID())
            local isGet2 = TowerMgr:IsDeepRewardGet(b:GetID())
            if isGet1 == isGet2 then
                return a:GetID() < b:GetID()
            else
                return not isGet1
            end
        end)
    end
end

function SetItems()
    layout:IEShowList(#curDatas)
end


function OnClickClose()
    view:Close()
end
