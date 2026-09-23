local cfg = nil
local mDatas = {}
local layout = nil
local isHad=false
local top = nil
local time = 0
local timer = 0

function Awake()
    layout = ComUtil.GetCom(vsv, "UIInfinite")
    layout:Init("UIs/Mission1/MissionActivityItem", LayoutCallBack, true)
    tlua = UIInfiniteUtil:AddUIInfiniteAnim(layout, UIInfiniteAnimType.Normal)

    eventMgr = ViewEvent.New();
    eventMgr:AddListener(EventType.Mission_List,function(_data)
        if not _data then
            RefreshPanel()
            return
        end

        local rewards = _data[2]
		RefreshPanel()
		if(#rewards > 0) then
			UIUtil:OpenReward({rewards})
		end
    end);

    eventMgr:AddListener(EventType.Mission_ReSet, function ()
        view:Close() --任务重置，关闭界面
    end)
end

function Update()
    if time > 0 and timer < Time.time then
        timer = Time.time + 1
        time = GlobalBossMgr:GetActiveTime()
        if time > 0 then
            local tab = TimeUtil:GetTimeTab(time)
            LanguageMgr:SetText(txtTime,70025,tab[1],tab[2],tab[3])
        else
            CSAPI.SetText(txtTime,LanguageMgr:GetTips(47001))
            CSAPI.SetTextColorByCode(txtTime,"ffffff")
        end
    end
end

function OnInit()
    top =UIUtil:AddTop2("MissionGlobalBoss", topObj, OnClickReturn);
end

function LayoutCallBack(index)
    local lua = layout:GetItemLua(index)
    if (lua) then
        local _data = mDatas[index]
        lua.SetIndex(index)
        lua.Refresh(_data,isBattle)
    end
end

function OnOpen()
    if data then
        SetTopBtn()
        SetTime()
        AnimStart()
        tlua:AnimAgain()
        RefreshPanel()
    end
end

function SetTopBtn()
    -- local ids = {}
    -- top.SetMoney(ids) -- 需要加跳转id todo 
end

function SetTime()
    timer = 0
    time = GlobalBossMgr:GetActiveTime()
    if time <= 0 then
        CSAPI.SetText(txtTime,LanguageMgr:GetTips(47001))
        CSAPI.SetTextColorByCode(txtTime,"ffffff")
    end
end


function RefreshPanel()
    SetDatas()
    if mDatas then
        SetBtn(mDatas)
        layout:IEShowList(#mDatas,AnimEnd)
    end
end

function SetDatas()
    mDatas = {}
    local _datas1 = MissionMgr:GetActivityDatas(eTaskType.GlobalBossDay, data.group)
    if _datas1 and #_datas1 > 0 then
        for i, v in ipairs(_datas1) do
            table.insert(mDatas,v)
        end
    end
    local _datas2 = MissionMgr:GetActivityDatas(eTaskType.GlobalBossMonth, data.group)
    if _datas2 and #_datas2 > 0 then
        for i, v in ipairs(_datas2) do
            table.insert(mDatas,v)
        end
    end
    if #mDatas > 0 then
        table.sort(mDatas, function(a, b)
            if (a:GetSortIndex() == b:GetSortIndex()) then
                return a:GetCfgID() < b:GetCfgID()
            else
                return a:GetSortIndex() > b:GetSortIndex()
            end
        end)
    end
end

function SetBtn(_datas)
	isHad = false
	for i, v in ipairs(_datas) do
		local get = v:IsGet()
		local finish = v:IsFinish()
		if(not get and finish) then
			isHad = true
			break
		end
	end

    if not canvasGroup then
        canvasGroup = ComUtil.GetCom(btnAllGet, "CanvasGroup")
    end
	canvasGroup.alpha = isHad and 1 or 0.3

    if not btnImg then
        btnImg = ComUtil.GetCom(btnAllGet, "Image")
    end
    btnImg.raycastTarget = isHad
end

function OnClickAllGet()
    if(isHad) then
        local ids = {}
        for k, v in ipairs(mDatas) do
            if v:IsFinish() and not v:IsGet() then
                table.insert(ids, v:GetID())
            end
        end
        if #ids > 0 then
            TaskProto:GetReward(nil, ids)
        end
	end
end

function OnClickReturn()
    Close()
end

function Close()
    view:Close()
end

function OnDestroy()
    eventMgr:ClearListener()
    CSAPI.SetGOActive(top.btn_home, true)
end

function AnimStart()
    CSAPI.SetGOActive(clickMask, true)
end

function AnimEnd()
    CSAPI.SetGOActive(clickMask, false)
end