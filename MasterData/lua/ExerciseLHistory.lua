local curDatas = {}
local isMax = false
local isFirst = true
function Awake()
    layout = ComUtil.GetCom(vsv, "UIInfinite")
    layout:Init("UIs/ExerciseL/ExerciseLItem", LayoutCallBack, true)
    UIInfiniteUtil:AddUIInfiniteAnim(layout, UIInfiniteAnimType.Normal)
end
function LayoutCallBack(index)
    local lua = layout:GetItemLua(index)
    if (lua) then
        local _data = curDatas[index]
        lua.Refresh(_data, true)
        -- 请求更多数据
        if (index ~= 100 and index == #curDatas) then
            GetRankData()
        end
    end
end

function GetRankData()
    if (not isMax) then
        CSAPI.SetGOActive(mask, true)
        ArmyProto:GetFightLogs(#curDatas + 1, 10, function(proto)
            if (not proto.logs or #proto.logs < 10) then
                isMax = true
            end
            if (proto.logs) then
                local len = #proto.logs
                for k = len, 1, -1 do
                    table.insert(curDatas, ExerciseMgr:GetHistoryData(proto.logs[k]))
                end
            end
            RefreshPanel()
            CSAPI.SetGOActive(mask, false)
        end)
    end
end

function OnOpen()
    GetRankData()
end

function RefreshPanel()
    if (isFirst) then
        isFirst = false
        layout:IEShowList(#curDatas)
    else
        layout:UpdateList()
    end

    CSAPI.SetGOActive(txtEmpty, #curDatas == 0)
end

function OnClickMask()
    view:Close()
end
