local layout = nil
local tabInfos = nil
local tabIndex = 1
local tabSelIndex = 0
local panels = {}
local currPanel = nil

function Awake()
    layout = ComUtil.GetCom(hsv, "UIInfinite")
    layout:Init("UIs/Rank/RankListItem", LayoutCallBack, true)
end

function LayoutCallBack(index)
    local lua = layout:GetItemLua(index)
    if (lua) then
        local _data = tabInfos[index]
        lua.SetIndex(index)
        lua.SetClickCB(OnItemClickCB)
        lua.Refresh(_data)
        lua.SetSelect(index == tabSelIndex)
    end
end

function OnItemClickCB(item)
    if item.index == tabSelIndex then
        return
    end
    local lua = layout:GetItemLua(tabSelIndex)
    if lua then
        lua.SetSelect(false)
    end
    item.SetSelect(true)
    tabSelIndex = item.index
    tabIndex = item.index

    RefreshPanel()
end

function OnInit()
    UIUtil:AddTop2("RankList", gameObject, OnClickReturn, nil, {});
end

--一个章节对应多个排行榜界面
function OnOpen()
    tabInfos = data
    tabIndex = openSetting or 1
    if tabInfos then
        InitTabPanel()
    end
end

function InitTabPanel()
    if not IsNil(layout) then
        layout:IEShowList(#tabInfos,OnItemLoadSuccess,tabIndex)
    end
end

function OnItemLoadSuccess()
    local lua = layout:GetItemLua(tabIndex)
    if lua then
        lua.OnClick()
    end
end

function RefreshPanel()
    if currPanel then
        UIUtil:SetObjFade(currPanel.gameObject,1,0,function ()
            CSAPI.SetGOActive(currPanel.gameObject,false)
            SetCenterPanel()
        end,200)
    else
        SetCenterPanel()
    end
end

function SetCenterPanel()
    if tabInfos[tabIndex] then
        local info = tabInfos[tabIndex]
        SetQuestion()
        if panels[info.id] then
            currPanel = panels[info.id]
            CSAPI.SetGOActive(currPanel.gameObject,true)
            panels[info.id].Refresh(info)
            UIUtil:SetObjFade(currPanel.gameObject,0,1,nil,200)
        else
            if info.path ~= "" then
                ResUtil:CreateUIGOAsync(info.path, panelParent, function(go)
                    local lua = ComUtil.GetLuaTable(go)
                    lua.Refresh(info)
                    currPanel = lua
                    UIUtil:SetObjFade(currPanel.gameObject,0,1,nil,200)
                    panels[info.id] = lua
                end)
            end
        end
    end
end

function SetQuestion()
    local rankType = tabInfos[tabIndex].rankType
    local cfg = rankType and Cfgs.CfgModuleInfo:GetByID(rankType.."") or nil
    CSAPI.SetGOActive(btnQuestion,cfg~=nil)
end

function OnClickQuestion()
    local rankType = tabInfos[tabIndex].rankType
    local cfg = rankType and Cfgs.CfgModuleInfo:GetByID(rankType.."") or nil
    if(cfg)then 
        CSAPI.OpenView("ModuleInfoView", cfg)
    end
end

function OnClickReturn()
    view:Close()
end