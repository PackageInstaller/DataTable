local layout = nil
local tlua = nil
local curDatas = nil
local isHad = false
function Awake()
    layout = ComUtil.GetCom(vsv, "UIInfinite")
    layout:Init("UIs/Mission2/MissionRewardItem", LayoutCallBack, true)
    tlua = UIInfiniteUtil:AddUIInfiniteAnim(layout, UIInfiniteAnimType.Normal)

    eventMgr = ViewEvent.New();
    eventMgr:AddListener(EventType.Mission_List,OnMissionRefresh);

    CSAPI.SetGOActive(clickMask,false)
end

function LayoutCallBack(index)
    local lua = layout:GetItemLua(index)
    if (lua) then
        local _data = curDatas[index]
        lua.SetIndex(index)
        lua.SetClickCB(OnItemClickCB)
        lua.Refresh(_data,{title1 = data.title2,title2 = data.title3})
    end
end

function OnItemClickCB(item)
    local _data = item.GetData()
    if(_data) then
		if(not _data:IsGet() and _data:IsFinish()) then
			if(MissionMgr:CheckIsReset(_data)) then
				--LanguageMgr:ShowTips(xxx)
				LogError("任务已过期")
			else
				MissionMgr:GetReward(_data:GetID())
			end
		-- elseif(not _data:IsGet() and not _data:IsFinish()) then
		-- 	if(_data:GetJumpID()) then
		-- 		JumpMgr:Jump(_data:GetJumpID())
		-- 	end
		end
	end
end

function OnMissionRefresh(_data)
    if not _data then
        RefreshPanel()
        return
    end

    local rewards = _data[2]
    RefreshPanel()
    if(#rewards > 0) then
        UIUtil:OpenReward({rewards})
    end
end

function OnDestroy()
    eventMgr:ClearListener()
end

function OnOpen()
    if data then
        InitPanel()
    end
end

function InitPanel()
    SetTitle()
    SetDatas()

    AnimStart()
    tlua:AnimAgain()
    SetItems()
    SetButtonState()
end

function RefreshPanel()
    SetDatas()
    SetItems()
    SetButtonState()
end

function SetTitle()
    if data.title1 then
        CSAPI.SetText(txtTitle,data.title1)
    end
end

function SetDatas()
    curDatas = MissionMgr:GetActivityDatas(data.type, data.group)
end

function SetItems()
    if curDatas then
        layout:IEShowList(#curDatas,AnimEnd)
    end
end

function SetButtonState()
    isHad = false
	for i, v in ipairs(curDatas) do
		local get = v:IsGet()
		local finish = v:IsFinish()
		if(not get and finish) then
			isHad = true
			break
		end
	end

    CSAPI.SetGOAlpha(btnGet,isHad and 1 or 0.3)
end

function OnClickGet()
    if not isHad then
        return 
    end
    TaskProto:GetRewardByType(data.type, data.group)
end

function OnClickClose()
    view:Close()
end

function AnimStart()
    CSAPI.SetGOActive(clickMask, true)
end

function AnimEnd()
    CSAPI.SetGOActive(clickMask, false)
end