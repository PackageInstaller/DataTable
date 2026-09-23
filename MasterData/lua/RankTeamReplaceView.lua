
function Awake()
    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.Team_Data_Update,OnTeamUpdate)
end

function OnTeamUpdate()
    view:Close()
end

function OnDestroy()
    eventMgr:ClearListener()
end

function OnOpen()
    CSAPI.SetText(txt_desc,LanguageMgr:GetTips(24013))
    if data then
        SetItems()
    end
end

function SetItems()
    local teamItemInfos = data[1]
    local tacticas = data[2]
    if openSetting and openSetting.isHideTactics then
        tacticas = nil
    end
    local num = #teamItemInfos
    if tacticas then
        num = num + 1
    end

    if num> 0 then
        for i = 1, num do
            ResUtil:CreateUIGOAsync("Rank/RankTeamItem",grid,function (go)
                local lua = ComUtil.GetLuaTable(go)
                if tacticas and i == num then
                    lua.Refresh(tacticas,{isTactics = true, isHideLv = true})
                else
                    lua.Refresh(teamItemInfos[i],{isHideLv = true})
                end
            end)
        end
    end
end

function OnClickOK()
    if data and data[3] then
        data[3]()
    end
end

function OnClickClose()
    view:Close()
end

function OnClickCancel()
    view:Close()
end