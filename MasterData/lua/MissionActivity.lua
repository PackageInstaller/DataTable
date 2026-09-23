local cfg = nil
local mDatas = {}
local layout = nil
local type = nil
local resetTime = -1
local m_Slider =nil
local isHad=false
local isBattle = false
local top = nil

function Awake()
    layout = ComUtil.GetCom(vsv, "UIInfinite")
    layout:Init("UIs/Mission1/MissionActivityItem", LayoutCallBack, true)
    tlua = UIInfiniteUtil:AddUIInfiniteAnim(layout, UIInfiniteAnimType.Normal)

    m_Slider = ComUtil.GetCom(slider,"Slider")

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
    if type == eTaskType.DupTower and resetTime >= 0 then
        local timeTab = TimeUtil:GetDiffHMS(resetTime,TimeUtil:GetTime())
        local day = timeTab.day > 0 and timeTab.day .. LanguageMgr:GetByID(11010) or ""
        local hour = timeTab.hour > 0 and timeTab.hour .. LanguageMgr:GetByID(11009) or ""
        local min = timeTab.minute > 0 and timeTab.minute .. LanguageMgr:GetByID(11011) or ""
        LanguageMgr:SetText(txtTime, 36006, day .. hour .. min)
    end
end

function OnInit()
    top =UIUtil:AddTop2("MissionActivityView", topObj, OnClickReturn);
    isBattle = SceneMgr:IsBattleDungeon()
    CSAPI.SetGOActive(top.btn_home,not isBattle)
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
        type = data.type
        SetTopBtn()
        SetTitle(data.title)
    
        AnimStart()
        tlua:AnimAgain()

        RefreshPanel()
    end
end

function SetTopBtn()
    local ids = {}
    if type == eTaskType.DupTower or type == eTaskType.TmpDupTower then
        table.insert(ids,{10040})
    elseif type == eTaskType.Story then
        if data.group == 3001 then
            table.insert(ids,{10015})
        elseif data.group == 3003 then
            table.insert(ids,{10016})
            table.insert(ids,{12007,140014})
        elseif data.group == 3005 then
            table.insert(ids,{10103})
            table.insert(ids,{12010,140021})
        end
    elseif type == eTaskType.DupTaoFa then
        table.insert(ids,{10040})
    end
    top.SetMoney(ids) -- 需要加跳转id todo 
end

function RefreshPanel()
    mDatas = MissionMgr:GetActivityDatas(type, data.group)
    if mDatas then
        SetPrograss(type == eTaskType.DupTower)
        SetBtn(mDatas)
        layout:IEShowList(#mDatas,AnimEnd)
    end
end

-- 标题
function SetTitle(str)
    CSAPI.SetText(txtTitle,str or "")
end

-- 进度
function SetPrograss(b)
    CSAPI.SetGOActive(prograssObj, b)
    if b then
        ResUtil.IconGoods:Load(icon ,ITEM_ID.BIND_DIAMOND.."", true)
        CSAPI.SetScale(icon,0.6,0.6,1)
        local info = TowerMgr:GetTowerData()
        if (info) then
            CSAPI.SetText(txtCur, info.cur .. "")
            CSAPI.SetText(txtMax, info.max .. "")
            -- time
            resetTime = info.resetTime
            -- slider
            local prograss = info.cur / info.max
            m_Slider.value = prograss
        end
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
        if type == eTaskType.TmpDupTower then
            local ids = {}
            for k, v in ipairs(mDatas) do
                if v:IsFinish() and not v:IsGet() then
                    table.insert(ids, v:GetID())
                end
            end
            TaskProto:GetReward(nil, ids)
        else
            TaskProto:GetRewardByType(type, data.group)
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