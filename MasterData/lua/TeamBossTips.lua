local curIndex = 0
function Awake()
	tab = ComUtil.GetCom(tabs, "CTab")
	tab:AddSelChangedCallBack(OnTabChanged)
end

function OnInit()
	eventMgr = ViewEvent.New()
	eventMgr:AddListener(EventType.TeamBoss_Over, function()
		view:Close()
	end)
end
function OnDestroy()
	eventMgr:ClearListener()
	ReleaseCSComRefs()
end

function OnOpen()
	tab.selIndex = 0
end

function OnTabChanged(_index)
	curIndex = _index
	RefreshPanel()
end

function RefreshPanel()
	CSAPI.SetGOActive(txtDesc, curIndex == 0)
	CSAPI.SetGOActive(sv, curIndex ~= 0)
	CSAPI.SetGOActive(sr1, curIndex == 1)
	CSAPI.SetGOActive(sr2, curIndex == 2)
	if(curIndex == 0) then
		SetPanel1()
	elseif(curIndex == 1) then
		SetPanel2()
	else
		SetPanel3()
	end
end

--规则
function SetPanel1()
	
	
end

--胜负奖励
function SetPanel2()
	if(datas2) then
		return
	end
	datas2 = {}
	local cfg = Cfgs.CfgTeamBoss:GetByID(1)
	for i, v in ipairs(cfg.infos) do
		table.insert(datas2, {isTitle = true, titleName = v.hard})
		table.insert(datas2, {isTitle = false, isWin = true, rewards = v.win_rewards})
		table.insert(datas2, {isTitle = false, isLost = true, rewards = v.lost_rewards})
	end
	InitItems(datas2, Content1)
end

--排名奖励
function SetPanel3()
	if(datas3) then
		return
	end
	datas3 = {}
	local cfg = Cfgs.CfgTeamBoss:GetByID(1)
	for i, v in ipairs(cfg.infos) do
		table.insert(datas3, {isTitle = true, titleName = v.hard})
		for k, m in ipairs(v.rankMailIds) do
			table.insert(datas3, {isTitle = false, index = k, rewards = v["rank_rewards" .. k]})
		end
	end
	InitItems(datas3, Content2)
end

function InitItems(datas, Content)
	for i, v in ipairs(datas) do
		local path = "TeamBoss/TeamBossTipsItem1"
		if(not v.isTitle) then
			path = "TeamBoss/TeamBossTipsItem2"
		end
		ResUtil:CreateUIGOAsync(path, Content, function(go)
			local lua = ComUtil.GetLuaTable(go)
			lua.Refresh(v)
		end)
	end
end

function OnClickMask()
	view:Close()
end
function OnClickClose()
	view:Close()
end 
----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()     
gameObject=nil;
transform=nil;
this=nil;  
tabs=nil;
item1=nil;
txtNormal1=nil;
txtSel1=nil;
item2=nil;
txtNormal2=nil;
txtSel2=nil;
item2=nil;
txtNormal2=nil;
txtSel2=nil;
txtDesc=nil;
sv=nil;
sr1=nil;
Content1=nil;
sr2=nil;
Content2=nil;
btnClose=nil;
view=nil;
end
----#End#----