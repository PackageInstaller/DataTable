local currDatas = nil
local layout = nil
local intervalTime = 0 --刷新间隔
curIndex1, curIndex2 = 1, 1

function Awake()
    layout = ComUtil.GetCom(vsv, "UIInfinite")
    --layout:AddBarAnim(0.4, false)
    layout:Init("UIs/Rank/RankRItem", LayoutCallBack, true)
    tlua = UIInfiniteUtil:AddUIInfiniteAnim(layout, UIInfiniteAnimType.Normal)
end

function OnInit()
    UIUtil:AddTop2("BattleFieldRank", gameObject, OnClickReturn, nil, {});
end

function OnEnable()
    eventMgr = ViewEvent.New();
    eventMgr:AddListener(EventType.BattleField_BossRank_Info, UpdateCardsPanel)
end

-- 数据刷新回调
function UpdateCardsPanel()
    currDatas = BattleFieldMgr:GetRankInfos()
    layout:IEShowList(#currDatas, nil, 0)
    SetMyData()
end

function OnDisable()
    eventMgr:ClearListener();
end

function LayoutCallBack(index)
    local lua = layout:GetItemLua(index)
    if lua then
        local _data = currDatas[index]
        lua.Refresh(_data)
        -- 请求更多数据
        if (index ~= 100 and index == #currDatas and intervalTime < TimeUtil:GetTime()) then
            BattleFieldMgr:AddNextRankList()
			intervalTime = TimeUtil:GetTime() + 0.1
        end
    end
end

function InitLeftPanel()
    if (not leftPanel) then
        local go = ResUtil:CreateUIGO("Common/LeftPanel", leftParent.transform)
        leftPanel = ComUtil.GetLuaTable(go)
    end
    local leftDatas = {{39003, "Friend/Friend"}} -- 多语言id，需要配置英文
    leftPanel.Init(this, leftDatas)
end

function OnOpen()
    -- 定时清空旧缓存
    BattleFieldMgr:ClearRankData()

	InitLeftPanel()
    RefreshPanel()
    tlua:AnimAgain()
end

function RefreshPanel()
    leftPanel.Anim()

    ShowList()
end

function ShowList()
    currDatas = BattleFieldMgr:GetRankInfos()
    if #currDatas <= 0 then
        BattleFieldMgr:GetBossRank(1)
    else
        layout:IEShowList(#currDatas)
        --自己数据
	    SetMyData()
    end
end

function SetMyData()
	local info = BattleFieldMgr:GetMyRank()
    local rank = info:GetRank()
	
	CSAPI.SetGOActive(myObj, true)
	--name
	CSAPI.SetText(txtName, info:GetName())
	--等级
    local lvStr = LanguageMgr:GetByID(1033) or "LV."
	CSAPI.SetText(txtLv, lvStr.. info:GetLevel())
	--排名
	CSAPI.SetText(txtRank1,(rank < 4 and rank ~= 0) and rank .. "" or "")
	CSAPI.SetText(txtRank2, rank >= 4 and rank .. "" or "")
    CSAPI.SetText(txtRank2, rank > 100 and "100+" or "")
	--战斗力
	CSAPI.SetText(txtFighting, info:GetScore() .. "")
	--icon
	ResUtil.CRoleItem_BG:Load(iconBg, "btn_02_03")
	local _cfg = Cfgs.character:GetByID(info:GetModuleID())
	if(_cfg.icon) then
		ResUtil.RoleCard:Load(icon, _cfg.icon, true)
	end
end

function OnClickExplain()
    CSAPI.OpenView("BattleFieldExplain", 3)
end

function OnClickReturn()
    view:Close()
end
