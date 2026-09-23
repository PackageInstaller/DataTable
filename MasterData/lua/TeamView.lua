--编队界面
local teamData=nil;
local isFirst=true;
local is3D=true;
local addAttrs=nil;
local clickID=nil;
local recordTime=0;
local leaderGrid=nil;
local forceData=nil;--强制位移的数据
local closeFunc=nil;
local isRotate=true; --3D界面是否可以旋转
local isZoom=true;--3D界面是否可以缩放
----------------------队员列表所需参数
local itemGrids={};--队员格子
local layout=nil;
local layout2=nil;
local listType = RoleListType.Select
local canEmpty=true;--是否可以设置为空队伍
local canAssist=true;--是否可以上阵助战卡
local currIndex=1;--当前修改的队员下标
local isCost=false;--卡牌显示信息类型
local selectType=TeamSelectType.Normal;--选择队员的方式
local forceCfg=nil;--强制上阵数据
local excludIds=nil;--排除id
local dungeonID=nil;--当前的副本id
local forceID=nil;--强制上阵ID
local NPCList=nil;--可选的NPC支援列表
local canDragLeave=true;--是否可以拖拽下阵
local scroll=nil;
local isMember=true;
local isRefresh=false;
local cdTime=0;
local scroll2=nil
local assistMember=nil;--助战队员数据
local enableClick=true;--是否可以点击物体
local isDrag=false;--是否拖拽中
-- local isEdit=false;--是否编辑队伍中
local isList=false;
local teamList=nil;--主线队伍列表
local teamListItems={};--主线队伍列表子物体对象
local isAddtive=false; --是否显示光环加成
local rCanvasGroup=nil;
local lCanvasGroup=nil;
local isFight=false;
local input=nil;
local listScroll=nil;
local isListChange=false;--是否是编队变换
local svMoveTween=nil;
local indexMoveTween=nil;--下标位移动画
local svHeight=0;
local isAssistRefresh=false;
local isTeamDup=true;
local sortView=nil;
local sortID=2;

local BackteamPreset=nil;
local Top=nil;

local cond=nil;

local isShowInfos=false; --是否显示卡牌hp/sp信息
local refreshClick=nil--刷新点击按钮
local dungeonCfg=nil;
local sectionID=nil;
local battleStrength=0;
local platformType=nil;
local showFakeLevel = nil
function Awake()
	BackteamPreset=nil;
	ResUtil:LoadBigImg(mbg, "UIs/BGs/bg_13/bg", true, function()
		-- CSAPI.SetScale(mbg, 1, 1, 1)
		UIUtil:SetPerfectScale(mbg);
	end)
	input=ComUtil.GetCom(inp_teamName,"InputField");
    CSAPI.AddInputFieldCallBack(inp_teamName,OnTeamNameEdit);
	CSAPI.AddInputFieldChange(inp_teamName,OnTeamNameChange)
	rCanvasGroup=ComUtil.GetCom(rViewObj,"CanvasGroup");
	lCanvasGroup=ComUtil.GetCom(lViewObj,"CanvasGroup");
	scroll=ComUtil.GetCom(sr,"ScrollRect");
	scroll2=ComUtil.GetCom(sr2,"ScrollRect");
	listScroll=ComUtil.GetCom(teamListSV,"ScrollRect")
	svMoveTween=ComUtil.GetCom(listMoveTween,"ActionUIMoveTo")
	indexMoveTween=ComUtil.GetCom(moveIndex,"ActionUIMoveTo")
	refreshClick=ComUtil.GetCom(btn_refresh,"Image")
	local size=CSAPI.GetRealRTSize(teamListSV);
	svHeight=size[1];
    InitListener()
	UIUtil:AddQuestionItem("TeamView", gameObject, TopNode)
	if CSAPI.IsADV() then battleStrength=ShiryuSDK.GetbattleStrength() end
	local topWidth=CSAPI.UIFitoffsetTop();
	local bottomWidth=CSAPI.UIFoffsetBottom();
	local addWidth=topWidth>bottomWidth and  topWidth or bottomWidth
	local rtSize2=CSAPI.GetRTSize(roleListBg);
	CSAPI.SetRectSize(roleListBg,rtSize2[0]+math.abs(addWidth),rtSize2[1]);
	platformType=CSAPI.GetPlatform();
end

function InitSVObj()
	local itemPath=openSetting~=TeamOpenSetting.Tower and "UIs/RoleLittleCard/RoleLittleCard" or "UIs/RoleLittleCard/RoleLittleCardTower";
	local itemPath2=openSetting~=TeamOpenSetting.Tower and "UIs/RoleLittleCard/AssistCardGrid" or "UIs/RoleLittleCard/AssistCardGridTower";
	layout=ComUtil.GetCom(vsv,"UISV");
    layout:Init(itemPath,LayoutCallBack,true,1)
	layout2=ComUtil.GetCom(vsv2,"UISV");
    layout2:Init(itemPath2,LayoutCallBack2,true,1)
	layout2:AddOnValueChangeFunc(OnValueChange);
end

function OnEnable()
    recordTime=CSAPI.GetRealTime();
end

function InitListener()
	eventMgr = ViewEvent.New();
    eventMgr:AddListener(EventType.Team_Preset_Open, OnOpenPreset);
    eventMgr:AddListener(EventType.Team_FormationView_Select,OnFormatSelect);
	eventMgr:AddListener(EventType.Role_Card_Holder,OnHolderItem);
    eventMgr:AddListener(EventType.Team_FormationView_ForceMove,OnCharacterForceMove);
	eventMgr:AddListener(EventType.Team_Select_Leave,OnSelectLeave);
	eventMgr:AddListener(EventType.Card_Update,OnCardUpdate);
	eventMgr:AddListener(EventType.Team_Card_Join,OnCardJoin);
	eventMgr:AddListener(EventType.Team_FormationInfo_SetLeader,SetTeamLeader);
	eventMgr:AddListener(EventType.Team_FormationInfo_Click,OnClickInfoOption);
	eventMgr:AddListener(EventType.View_Lua_Closed,OnViewClosed);
	eventMgr:AddListener(EventType.Team_FormationInfo_SetRC,SetInfoViewPos);
	eventMgr:AddListener(EventType.Team_Formation3D_SetRAndZ, OnSetRAndZ);
	eventMgr:AddListener(EventType.Role_Card_PressDown, OnPressDownCard);
	eventMgr:AddListener(EventType.Team_FormationView_CharacterItemClickState, OnStateChange);
	eventMgr:AddListener(EventType.TeamView_Close, OnEventClose);
	eventMgr:AddListener(EventType.Team_AssistInfo_Init, OnAssistListInit);
	eventMgr:AddListener(EventType.TeamView_DragMask_Change, SetIsDrag);
	eventMgr:AddListener(EventType.Net_Connect_Fail, OnNetConnectFail);	
	eventMgr:AddListener(EventType.Relogin_Success,OnReLogin)
	eventMgr:AddListener(EventType.Team_Data_Change,OnDataChange)
	-- eventMgr:AddListener(EventType.TeamView_EditMode_Change,OnEditModeChange)
	eventMgr:AddListener(EventType.TeamView_Refresh_Formation,RefreshFormationView);
	eventMgr:AddListener(EventType.Team_EditIndex_Change,OnEditIndexChange)
	eventMgr:AddListener(EventType.Team_Item_Change,OnTeamItemChange);
	eventMgr:AddListener(EventType.TeamView_Show_TeamList,OnShowTeamList);
	eventMgr:AddListener(EventType.TeamView_Hide_TeamList,OnHideTeamList)
	eventMgr:AddListener(EventType.TeamView_ViewType_Change,OnViewTypChange)
	eventMgr:AddListener(EventType.TeamView_ChildNode_Change,OnChildNodeChange);
end

function OnCharacterForceMove(eventData)
    forceData=eventData;
	canDragLeave=eventData==nil;
    if(formationView)then
		formationView.SetDragLeave(canDragLeave);
        formationView.SetForceMove(eventData.forceData,eventData.forceCallBack,eventData.forceCaller);
    end
end

function OnDataChange()
	isChange=true;
	teamData=TeamMgr:GetEditTeam();
end

--切换至指定队伍队伍
function OnEditIndexChange(idx)
	if CheckLeader()~=true then
		return
	end
	clickID=nil;
	if TeamMgr.currentIndex ~= idx then
		isFirst=true;
		assistMember=nil;
		--播放数字变更动画
		PlayIndexTween(idx);
		if GetIsChange() then
			CheckTeam(function()
				TeamMgr:SaveEditTeam(function()
					isChange=false;
					TeamMgr:DelEditTeam();
					TeamMgr.currentIndex = idx;
					teamData=TeamMgr:GetEditTeam();
					-- RefreshFormationView();
					InitTeamItems();
					-- isList=false;
					-- isListChange=true;
					-- Refresh();
					DelayHideList();
				end)
			end);
		else
			isChange=false;
			TeamMgr:DelEditTeam();
			TeamMgr.currentIndex = idx;
			teamData=TeamMgr:GetEditTeam();
			-- RefreshFormationView();
			InitTeamItems();
			-- isList=false;
			-- isListChange=true;
			-- Refresh();
			DelayHideList();
		end
	else
		isList=false;
		isListChange=true;
		Refresh();
	end  
end

--播放移动索引动画
function PlayIndexTween(idx)
    if(idx>=65)then 
		idx = idx-64
	elseif(idx>=62)then  
		idx = idx-61
	end 
	local x,y=CSAPI.GetAnchor(txt_teamIndex);
	local tx,ty=CountIndexPos(idx);
	indexMoveTween:SetTargetPos(tx,ty);
	indexMoveTween:SetStartPos(x,y);
	indexMoveTween:Play();
end

--计算当前下标的位置
function CountIndexPos(idx)
	local x,y=0,7.2;
	local index=idx or TeamMgr.currentIndex;
	x=(index-1)*-133;
	return x,y;
end

--延迟关闭小队列表
function DelayHideList()
	CSAPI.SetGOActive(listMask,true)
	FuncUtil:Call(function()
		isList=false;
		isListChange=true;
		Refresh();
		CSAPI.SetGOActive(listMask,false)
	end,nil,100)
end

function OnDisable()
	-- TeamMgr:SetTeamViewOptions(isAddtive,isAddtive);
	TeamMgr:DelEditTeam();
    RecordMgr:Save(RecordMode.View,recordTime,"ui_id="..RecordViews.TeamEdit);
	--记录2D/3D选项
	TeamMgr:SaveViewerOption(is3D);
end

function OnDestroy()
	TeamMgr:SetDragFingerID();
	if CSAPI.IsADV() or CSAPI.IsDomestic() then
		if battleStrength~=ShiryuSDK.GetbattleStrength() then
			ShiryuSDK.OnRoleInfoUpdate();
		end
	end
	CSAPI.RemoveInputFieldCallBack(inp_teamName,OnTeamNameEdit);
	CSAPI.RemoveInputFieldChange(inp_teamName,OnTeamNameChange);
   eventMgr:ClearListener();
   ReleaseCSComRefs();
   -- 
   local arr = RoleMgr:GetDatas()
   for k, v in pairs(arr) do
	  	v.canDrag= true 
		v.disDrag_lanID=nil
   end
end

function OnViewClosed(viewKey)
	if viewKey=="RoleInfo" then
		if teamData then
			TeamMgr.currentIndex=teamData:GetIndex();
			RefreshTeamData();
		end
		Refresh();
	elseif viewKey=="HaloMain" then
		--重新创建3D界面,否则RT引用丢失
		if formationView and is3D then
			formationView.view:Close();
			formationView=nil;
			CreateFormationView(false);
		end
	end
end

function RefreshTeamData()
	teamData=TeamMgr:GetEditTeam();
	if assistMember and teamData and teamData:GetItem(assistMember.cid)==nil then
		teamData:AddCard(assistMember);
	end
end

--编辑模式变更
-- function OnEditModeChange(_isEdit)
-- 	isEdit=_isEdit;
-- 	Refresh(true);
-- end

function OnNetConnectFail()
	-- LogError("OnNetConnectFail----------------")
	OnAssistListInit();
end

function OnReLogin()
	-- LogError("OnReLogin----------------")
	OnAssistListInit();
end

function OnSetRAndZ(eventData)
	if eventData then
		Set3DRotateAndZoom(eventData.isRotate,eventData.isZoom)
	else
		Set3DRotateAndZoom()
	end
end

--设置3D界面是否可以旋转和缩放
function Set3DRotateAndZoom(_rotate,_zoom)
	isRotate=_rotate;
	isZoom=_zoom;
	if formationView and formationView.SetRotateAndZoom then
		formationView.isLRotate=isRotate;
		formationView.isLZoom=isZoom;
		formationView.SetRotateAndZoom(isRotate,isZoom);
	end
end

function SetIsDrag(_isDrag)
	isDrag=_isDrag;
	CSAPI.SetGOActive(dragMask,isDrag==true);
	if type(QuestionItem)=="table" and QuestionItem~=nil then
		QuestionItem.ActiveClick(not isDrag);
	end
end

--按钮是否可以点击
function IsDisClick()
	return isDrag;
end

function OnInit()
	Top=UIUtil:AddTop2("TeamView",gameObject, OnClickReturn,OnClickHomeFunc,{})
	-- OnCharacterForceMove(
	-- 	{
	-- 		forceData={{row=1,col=3,cfgId=71020}},
	-- 		forceCallBack=function()
	-- 			Log("ForceMove11111111111111");
	-- 		end,
	-- 		forceCaller=nil,
	-- 	}
	-- );
end

function OnClickHomeFunc()
	if IsDisClick() then
		return;
	end
	--data.currentIndex==eTeamType.RealPracticeAttack
	if(data and (TeamMgr:IsTeamType(eTeamType.PVP,data.currentIndex) or TeamMgr:IsTeamType(eTeamType.PVPFriend,data.currentIndex) or data.currentIndex==eTeamType.TeamBoss)) then 
		OnClickReturn()
	else 
		--按home键保存改动
		if CheckLeader()~=true then
			return
		end
		if GetIsChange() then
			CheckTeam(function ()
				TeamMgr:SaveEditTeam(function()
					UIUtil:ToHome();
				end);
			end);
		else
			UIUtil:ToHome()
		end
	end 	
end

function OnCardUpdate()
	Refresh();
end

function OnStateChange(eventData)
	enableClick=eventData;
	layout:UpdateList();
end

--data:{team 指定队伍数据,
--  currentIndex 指定队伍下标,
-- forceCfg 强制上阵配置信息,
--excludIds 角色列表中排除显示的id信息,
--canEmpty 队伍是否可以为空
--selectType 当前队员的选择类型，参考TeamSelectType
--is2D 阵型盘类型是否为2D，否则显示3D
--closeFun 关闭回调，返回支援卡牌数据
--}
function OnOpen()
	--SetSortID()
	InitSVObj();
	CSAPI.PlayUISound("ui_window_open_load");
	openSetting=openSetting or TeamOpenSetting.Normal;
	SetSortObj();
	-- isAddtive=TeamMgr:GetTeamViewOptions();
	isAddtive=false;
	FuncUtil:Call(function()
		CSAPI.SetGOActive(fullMask,false);
	end,nil,1000)--动画锁屏
    isFirst=true;
	is3D=TeamMgr:GetViewerOption();
    if data then
		if(data.teamList)then 
			teamList = data.teamList
		end 
        if data.team then
            teamData=data.team;
        elseif data.currentIndex then
            TeamMgr.currentIndex=data.currentIndex;
            teamData=TeamMgr:GetEditTeam();
        end
		cond=data.cond;
		assistMember=teamData:GetAssistData();
        forceCfg=data.forceCfg;
        excludIds=data.excludIds;
        canEmpty=data.canEmpty;
        selectType=data.selectType or TeamSelectType.Normal;
		canAssist=data.canAssist;
        closeFunc=data.closeFunc;
		dungeonCfg=data.dungeonCfg;
		showFakeLevel = data.showFakeLevel
		if data.NPCList then
			NPCList={};
			for k,v in ipairs(data.NPCList) do
				table.insert(NPCList,FormationUtil.FindNPC(v));
			end
		else
			NPCList=nil;
		end	
    else
		if teamList==nil then
			teamList={};
			for i = 1, g_TeamMaxNum, 1 do
				table.insert(teamList,i)
			end
		end
		-- teamList={22,1,2,3,4,5,6,7};
		TeamMgr.currentIndex=teamList[1];
        teamData=TeamMgr:GetEditTeam();
    end
	if openSetting==TeamOpenSetting.Tower then
		isShowInfos=true;
		sectionID=dungeonCfg and dungeonCfg.group or nil;
		if TowerMgr:GetLockAssistInfo(sectionID)~=nil then
			refreshClick.raycastTarget=false;
		else
			refreshClick.raycastTarget=true;
		end
	else
		isShowInfos=false;
		refreshClick.raycastTarget=true;
	end
	SetViewBtnState(is3D)
    SetViewLayout(openSetting);
    -- SetTabData()
	UIInfiniteUtil:AddUIInfiniteAnim(layout, UIInfiniteAnimType.Diagonal) --椭圆动画
    --layout:AddBarAnim(0.4,false);
    Refresh();
	CheckModelOpen();
	-- 
	PlayIndexTween(TeamMgr.currentIndex)
end

function CheckModelOpen()
	local isOpen,lockStr=MenuMgr:CheckModelOpen(OpenViewType.main, FormationUtil.SkillModuleKey)
	local isOpen2,lockStr=MenuMgr:CheckModelOpen(OpenViewType.special, FormationUtil.AIModuleKey)
	local color={146,146,150,255};
	local color2={255,255,255,255};
	local c1=isOpen and color2 or color;
	local c2=isOpen2 and color2 or color;
	if IsNil(skillImg)~=true then
		CSAPI.SetImgColor(skillImg,c1[1],c1[2],c1[3],c1[4],true);
		CSAPI.SetTextColor(skillImg,c1[1],c1[2],c1[3],c1[4],true);
	end
	if IsNil(aiImg)~=true then
		CSAPI.SetImgColor(aiImg,c2[1],c2[2],c2[3],c2[4],true);
		CSAPI.SetTextColor(aiImg,c2[1],c2[2],c2[3],c2[4],true);
	end
end

--设置页面布局
function SetViewLayout(openSetting)
	local hasPrefab=true;
    if openSetting==TeamOpenSetting.Normal then
		CSAPI.SetGOActive(btn_svType2,false);
        CSAPI.SetGOActive(viewType,true);
		CSAPI.SetGOActive(btn_list,selectType==TeamSelectType.Normal and true or false);
    elseif openSetting==TeamOpenSetting.PVP then
        CSAPI.SetGOActive(btn_svType2,false);
        CSAPI.SetGOActive(viewType,true);
		CSAPI.SetGOActive(btn_list,selectType==TeamSelectType.Normal and true or false);
		hasPrefab = false
    elseif openSetting==TeamOpenSetting.PVE or openSetting==TeamOpenSetting.Tower or openSetting==TeamOpenSetting.Rogue or openSetting==TeamOpenSetting.TotalBattle or openSetting==TeamOpenSetting.RogueS or openSetting==TeamOpenSetting.Colosseum or openSetting==TeamOpenSetting.RogueT or openSetting==TeamOpenSetting.MultBattle or openSetting==TeamOpenSetting.PVPMirror or openSetting==TeamOpenSetting.TowerDeep or openSetting==TeamOpenSetting.Trials2 or openSetting==TeamOpenSetting.SkinPass or
	openSetting==TeamOpenSetting.GlobalBoss or openSetting==TeamOpenSetting.PeriodicBoss or openSetting==TeamOpenSetting.VirCat then
		CSAPI.SetGOActive(btn_svType2,canAssist);
        CSAPI.SetGOActive(viewType,true);
		CSAPI.SetGOActive(btn_list,false);
    end
	if openSetting==TeamOpenSetting.Tower or openSetting==TeamOpenSetting.Rogue or openSetting==TeamOpenSetting.TotalBattle or openSetting==TeamOpenSetting.RogueS or openSetting==TeamOpenSetting.Colosseum or openSetting==TeamOpenSetting.RogueT or openSetting==TeamOpenSetting.MultBattle or openSetting==TeamOpenSetting.TowerDeep then
		hasPrefab=false;
	end
	CSAPI.SetGOActive(btn_prefab,hasPrefab);
	--AI和战术
	local isSkill = true
	local isAI = true
	if(TeamMgr.currentIndex ==eTeamType.Colosseum or TeamMgr.currentIndex ==(eTeamType.Colosseum + 1) or TeamMgr.currentIndex ==eTeamType.RogueT or openSetting==TeamOpenSetting.PVP) then 
		isSkill = false		
		isAI= false
	elseif openSetting==TeamOpenSetting.GlobalBoss then
		isSkill = false		
	elseif openSetting==TeamOpenSetting.RogueT then
		-- if(data.isSkill~=nil)then 
		-- 	isSkill = data.isSkill
		-- end 
		isSkill = false
	elseif openSetting==TeamOpenSetting.Tower then
		isSkill = dungeonCfg.type ~= eDuplicateType.EternalBattle
	end 
	CSAPI.SetGOActive(btn_ai,isAI)
	CSAPI.SetGOActive(btn_skill,isSkill)
	CSAPI.SetGOActive(btnLimit,openSetting==TeamOpenSetting.RogueT)
	CSAPI.SetGOActive(fightNumObj,openSetting ~= TeamOpenSetting.PeriodicBoss)
end

--刷新面板 isReset:是否重置卡牌列表，notLoadModel：是否不刷新阵盘
function Refresh(isReset,notLoadModel)
    -- teamData=TeamMgr:GetEditTeam();
	isMember=selectType~=TeamSelectType.Support;
	isFight=TeamMgr:GetTeamIsFight(teamData.index);
	if isList then--是否在列表视图中
		CSAPI.SetGOActive(roleListRoot,false);
		CSAPI.SetGOActive(teamListSV,true);
		CSAPI.SetGOActive(listSVTween,true);
		CSAPI.SetGOActive(listHideTween,false);
		InitTeamItems();
	else--编辑中，初始化卡牌列表
		if isListChange==true then
			CSAPI.SetGOActive(roleListRoot,true);
			CSAPI.SetGOActive(listSVTween,false);
			CSAPI.SetGOActive(listHideTween,true);
			FuncUtil:Call(EventMgr.Dispatch,nil,400,EventType.TeamView_Hide_TeamList);
		else
			CSAPI.SetGOActive(roleListRoot,true);
			CSAPI.SetGOActive(teamListSV,false);
		end
		SetSVList();
		SetCurrIndex();
		SetTabState(isMember)
		if isMember then --成员
			CSAPI.SetGOActive(btnTool,true);
			-- CSAPI.SetGOActive(btn_svType,true);
			CSAPI.SetGOActive(vsv2,false);
			CSAPI.SetGOActive(vsv,true);
		else --支援卡
			CSAPI.SetGOActive(btnTool,false);
			-- CSAPI.SetGOActive(btn_svType,false);
			CSAPI.SetGOActive(vsv2,true);
			CSAPI.SetGOActive(vsv,false);
		end
		RefreshCardList(isReset);
	end
	RefreshLeftInfo();
	SetSkillInfo();
	SetAddtiveState(offObj,not isAddtive)
	SetAddtiveState(onObj,isAddtive)
    --初始化阵型子物体
	if notLoadModel~=true then
		if formationView==nil then
			CreateFormationView();
		else
			formationView.CleanCard();
			Set3DRotateAndZoom(isRotate,isZoom);
			formationView.Init(teamData,canDragLeave,false,nil,isAddtive,infoNode,isShowInfos,showFakeLevel);
			if forceData then
				formationView.SetForceMove(forceData.forceData,forceData.forceCallBack,forceData.forceCaller);
			else
				formationView.SetForceMove(nil,nil,nil);
			end
			formationView.SetHaloEnable(true);
			formationView.SetLock(isFight);
		end
	end
    isFirst=false;
end

function RefreshLeftInfo()
	if teamData then
		if openSetting==TeamOpenSetting.Tower or openSetting==TeamOpenSetting.Rogue or openSetting==TeamOpenSetting.TotalBattle or openSetting==TeamOpenSetting.RogueS or openSetting==TeamOpenSetting.MultBattle or openSetting==TeamOpenSetting.TowerDeep or openSetting==TeamOpenSetting.Trials2 then
			input.interactable=false;
		else
			input.interactable=not TeamMgr:GetTeamIsFight(teamData:GetIndex())
		end
		if(openSetting==TeamOpenSetting.RogueS) then 
			input.text=LanguageMgr:GetByID(65021)
		elseif openSetting==TeamOpenSetting.TowerDeep then
			input.text=LanguageMgr:GetByID(130025)
		elseif openSetting == TeamOpenSetting.Trials2 then
			input.text=LanguageMgr:GetByID(37081)
		elseif openSetting == TeamOpenSetting.SkinPass then
			input.text=LanguageMgr:GetByID(320020)
		else 
			input.text=teamData:GetTeamName()==nil and "" or tostring(teamData:GetTeamName());
		end 
		local haloStrength=teamData:GetHaloStrength();
		CSAPI.SetText(txt_fightNum, tostring(teamData:GetTeamStrength()+haloStrength));
		CSAPI.SetText(txt_roleNum,string.format("<color=#ffc146>%s</color>/5",teamData:GetRealCount()));
		if openSetting==TeamOpenSetting.Normal then
			-- CSAPI.SetText(txt_teamIndex,tostring(teamData:GetIndex()))
			local x,y=CountIndexPos();
			CSAPI.SetAnchor(txt_teamIndex,x,y);
		end
	end
end

function OnClickList()
	if not isList then
		isList=true;
		if GetIsChange() then
			CheckTeam(function()
				TeamMgr:SaveEditTeam(function()
					isChange=false;
					TeamMgr:DelEditTeam();
					teamData=TeamMgr:GetEditTeam();
					CSAPI.SetGOActive(teamListSV,true);
					CSAPI.SetGOActive(listSVTween,true);
					CSAPI.SetGOActive(listHideTween,false);
					FuncUtil:Call(EventMgr.Dispatch,nil,400,EventType.TeamView_Show_TeamList);
					InitTeamItems();
				end)
			end);
		else
			CSAPI.SetGOActive(teamListSV,true);
			CSAPI.SetGOActive(listSVTween,true);
			CSAPI.SetGOActive(listHideTween,false);
			FuncUtil:Call(EventMgr.Dispatch,nil,400,EventType.TeamView_Show_TeamList);
			InitTeamItems();
		end
	end
end

function OnShowTeamList()
	CSAPI.SetGOActive(roleListRoot,false);
end

--初始化主线队伍列表
function InitTeamItems()
	if teamList==nil or (teamList and next(teamList)==nil) then
		do return end
	end
	ItemUtil.AddItems("Team/TeamSelectItem", teamListItems, teamList, teamSelectNode,nil,nil,{canEmpty=canEmpty},function()
		--计算当前content总长度
		local len = 1
        if openSetting==TeamOpenSetting.PVP then
			len = 3
		else 
			len = g_TeamMaxNum
		end 
		local height=(len-1)*(249)+262; 
		local currHeight=(TeamMgr.currentIndex-1)*249-5-7;
		-- CSAPI.SetAnchor(teamSelectNode,0,currHeight);
		local x,y=CSAPI.GetAnchor(teamSelectNode);
		currHeight=height-currHeight>=svHeight and currHeight or height-svHeight;
		local index=1;
		for k, v in ipairs(teamListItems) do
			local h=(k-1)*(249)+262;
			if currHeight<h then
				v.SetEnterDelay(index);
				index=index+1;
			end
			v.PlayEnter();
		end
		svMoveTween:SetStartPos(0,y);
		svMoveTween:SetTargetPos(0,currHeight);
		svMoveTween:Play();
	end);
end

function CreateFormationView(isTween)
    local path=is3D and "Formation/FormationView3D" or "Formation/FormationView2D";
    ResUtil:CreateUIGOAsync(path,childNode,function(go)
        formationView=ComUtil.GetLuaTable(go);
        if is3D then
            formationView.SetScale(1);
            formationView.SetLocalPos(-60,-60);
			formationView.PlayEnter();
        else
            CSAPI.SetLocalPos(formationView.gameObject,-400,-20);
        end
        if forceData then
            formationView.SetForceMove(forceData.forceData,forceData.forceCallBack,forceData.forceCaller);
        else
            formationView.SetForceMove(nil,nil,nil);
        end
		Set3DRotateAndZoom(isRotate,isZoom);
		formationView.SetHaloEnable(true);
		isTween=isTween==nil and true or isTween;
        formationView.Init(teamData,canDragLeave,isTween,clickID,isAddtive,infoNode,isShowInfos,showFakeLevel);
		formationView.SetLock(TeamMgr:GetTeamIsFight(teamData.index));
        -- if clickID then
		-- 	formationView.SetClickState(clickID);
        -- end
    end);
end

function OnHideTeamList()
	CSAPI.SetGOActive(teamListSV,false);
end

function OnClickReturn()
	if IsDisClick() then
		return;
	end
	if CheckLeader()~=true then
		return
	end
    local assitData = teamData:GetAssistData();
	if currIndex == 6 and assitData~=nil then --如果删除了助战卡
		--清除助战索引
		TeamMgr:RemoveAssistTeamIndex(assitData.cid);
	end
    if GetIsChange() then --有改动
        CheckTeam(Exit);
    else
        -- TeamMgr:DelEditTeam(TeamMgr.currentIndex);
        if closeFunc then
            closeFunc(teamData:GetAssistData());
            closeFunc=nil;
        end
        view:Close();
    end
end

function OnEditExit()
	if openSetting and openSetting==TeamOpenSetting.Normal then
		isChange=false;
		EventMgr.Dispatch(EventType.TeamView_EditMode_Change)
		-- TeamMgr:DelEditTeam(TeamMgr.currentIndex);
    	teamData=TeamMgr:GetEditTeam();
	else
		Exit()
	end
end

function OnHolderItem(tab)
	-- LookCard(tab.cardData:GetID())
	if not isMovement then
		LookCard(tab.cardData:GetID());
	end
	isMovement=false;
end

function OnTeamItemChange()
	if assistMember then
		assistMember=teamData:GetAssistData();
	end
	RefreshLeftInfo();
end

function OnClickInfoOption(eventData)
	if IsDisClick() then
		return;
	end
	if eventData and eventData.type then
		if eventData.type==2 then
			local id=clickID~=nil and clickID or eventData.cid
			LookCard(id)
			clickID=nil;
		end
	end
end

function OnApplicationPause(isPause)
	if isPause~=true then
		EventMgr.Dispatch(EventType.TeamView_DragJoin_Lost)
	end
end

function OnApplicationFocus(hasFocus)
	if hasFocus==true then
		EventMgr.Dispatch(EventType.TeamView_DragJoin_Lost)
	end
end

--检察队伍是否必须要有队长
function CheckLeader()
	if (teamData:HasLeader() == false and teamData.index == 1) or (teamData:HasLeader() == false and canEmpty ~= true) or (teamData:GetCount()>0 and teamData:HasLeader() == false ) then
		Tips.ShowTips(LanguageMgr:GetTips(14021));
		return false
	end
	return true
end

--检察队伍改动的冲突 func 处理完冲突的回调，func2取消解决冲突的回调
function CheckTeam(func,func2)
	if ((selectType == TeamSelectType.Normal or selectType==TeamSelectType.Force) and (TeamMgr:IsTeamType(eTeamType.DungeonFight) or TeamMgr:IsTeamType(eTeamType.ForceFight) or TeamMgr:IsTeamType(eTeamType.RogueS) or TeamMgr:IsTeamType(eTeamType.TowerDeep))) then --副本队伍检查是否有冲突
		local state = 1;--卡牌状态，1表示当前卡牌没有队伍冲突，2表示在其它队伍中上阵，但是可以下阵，3表示在其它队伍中强制上阵
		for k, v in ipairs(teamData.data) do
			local card = RoleMgr:GetData(v.cid);
			if card then
				local teamIndex = -1;
				if(openSetting == TeamOpenSetting.RogueS) then  
					teamIndex =TeamMgr:GetCardTeamIndex(card:GetID(),eTeamType.RogueS,true);
					if(teamIndex ~= - 1 and teamIndex>=11 and teamIndex<=19 and  teamIndex ~= teamData.index) then --该卡牌存在于其他队伍中
						LanguageMgr:ShowTips(14028)
						return
					end
				else
					if selectType==TeamSelectType.Force then --强制上阵
						teamIndex =TeamMgr:GetCardForceIndex(dungeonID,card:GetID());
					else
						teamIndex =TeamMgr:GetCardTeamIndex(card:GetID());
					end
					if(teamIndex ~= - 1 and teamIndex ~= teamData.index) then --该卡牌存在于其他队伍中
						state=2;
						break;
					end 
				end 
			end
		end
		if state==3 then
			--弹出提示
			CSAPI.OpenView("Dialog", {
				content = LanguageMgr:GetTips(14028),
				okCallBack = func,
				cancelCallBack=func2,
			});
		else
			func();
		end
	else
		func();
	end
end

function Exit()
    local assist=teamData:GetAssistData();
	RoleAudioPlayMgr:StopSound();
    TeamMgr:SaveEditTeam(function()
		if closeFunc then
			closeFunc(assist);
			closeFunc=nil;
		end
		EventMgr.Dispatch(EventType.TeamView_Close)
	end);
end

function OnEventClose()
	if view and view.Close then
		view:Close()
	end
end

--是否有改动
function GetIsChange()
	if (formationView and formationView.GetIsChange()==true) or isChange then
		return true;
	end
	return false;
end

--显示阵型盘光环加成
function OnClickAddtive()
	isAddtive=not isAddtive;
	SetAddtiveState(offObj,not isAddtive)
	SetAddtiveState(onObj,isAddtive)
	EventMgr.Dispatch(EventType.TeamView_AddtiveState_Change,isAddtive);
	if not isList then
		RefreshCardList();
	end
end

function SetAddtiveState(go,isOn)
	CSAPI.SetGOActive(go,isOn);
end

--展开预设
function OnOpenPreset(data)
    local teamName=teamData.teamName;
    TeamMgr:DelEditTeam(TeamMgr.currentIndex);
    teamData=TeamMgr:GetEditTeam();
    if teamData.teamName~=teamName then
        teamData.teamName=teamName;
    end
    clickID=nil;
	Refresh();
	--播放队长出击语音
	local member=teamData:GetLeader();
	if member then
		RoleAudioPlayMgr:PlayByType(member:GetModelID(), RoleAudioType.enterLevel)
	end
end

--编成预设
function OnClickPrefab()
	if IsDisClick() then
		return;
	end
    -- SaveLocal();
	if selectType==TeamSelectType.Force or forceCfg~=nil then
		Tips.ShowTips(LanguageMgr:GetTips(14022));
		do return end
	end
    if teamPreset == nil then
        ResUtil:CreateUIGOAsync("FormatPreset/TeamPreset", gameObject,function(go)
			teamPreset = ComUtil.GetLuaTable(go);
			BackteamPreset=teamPreset;
			print("查找到并赋值")
        end);
	else
		CSAPI.SetGOActive(teamPreset.gameObject, true);
	end
end

function OnClickCloseList()
	isList=false;
	isListChange=true;
	Refresh();
end

-----------------------------------------列表相关----------------------------------
function SetSVList()
	svList = {}
	-- local teamData=TeamMgr:GetEditTeam();
	local teamIndex=nil;
	if teamData then
		teamIndex=teamData:GetIndex()
	end
	local teamType=TeamMgr:GetTeamType(teamIndex);
	isTeamDup=teamType==eTeamType.DungeonFight;
	if selectType == nil or selectType == TeamSelectType.Normal then
		local arr = {}
		arr = RoleMgr:GetArr();
		-- svList = RoleSortUtil:SortByCondition(listType, arr,teamIndex,isTeamDup)
		if openSetting==TeamOpenSetting.Tower then
			for i=1,#arr do
				arr[i].canDrag=CheckCardCanPass(arr[i]);
			end
			--svList=SortMgr:Sort2(sortID,arr,{isTower=openSetting==TeamOpenSetting.Tower})
		elseif openSetting==TeamOpenSetting.TotalBattle then
			for i=1,#arr do
				arr[i].canDrag=TotalBattleMgr:IsShowCard(arr[i]:GetID());
			end
			--svList=SortMgr:Sort2(sortID,arr,{isTotalBattle=openSetting==TeamOpenSetting.TotalBattle})
		elseif openSetting==TeamOpenSetting.Colosseum then
			if(TeamMgr.currentIndex ==(eTeamType.Colosseum + 1)) then 
				arr = ColosseumMgr:GetEditTeamArr() --改用选择的卡牌
			end 
			--svList=SortMgr:Sort(sortID,arr)
		elseif openSetting==TeamOpenSetting.RogueT then
			local _newArr = {}
			for i=1,#arr do
				arr[i].canDrag,arr[i].disDrag_lanID=CheckCardCanPass(arr[i]);
				table.insert(_newArr,arr[i])
			end
			--推荐的
			local starRoles = RogueTMgr:GetStarRoles()
            for k, v in pairs(starRoles) do
				v.canDrag=CheckCardCanPass(v);
				table.insert(_newArr,v)
			end
			arr = _newArr
			--svList=SortMgr:Sort2(sortID,arr,{isRogueT=openSetting==TeamOpenSetting.RogueT})
		elseif openSetting==TeamOpenSetting.MultBattle then
			for i=1,#arr do
				local canDrag,lanID=MultTeamBattleMgr:CardCanUse(arr[i]:GetID());
				arr[i].canDrag=canDrag
				arr[i].disDrag_lanID=lanID
			end
		elseif openSetting==TeamOpenSetting.PVP then
			for i=1,#arr do
				local canDrag,lanID= true,nil
				if(teamType==eTeamType.PVP)then 
					canDrag,lanID=ExerciseRMgr:CardCanUse(arr[i]:GetCfgID())
				end 
				arr[i].canDrag=canDrag
				arr[i].disDrag_lanID=lanID
			end
		elseif openSetting==TeamOpenSetting.Trials2 then
			for i=1,#arr do
				arr[i].canDrag = TrialsMgr:IsShowCard(arr[i]:GetRoleTag())
			end
		elseif openSetting==TeamOpenSetting.VirCat then
			for i=1,#arr do
				arr[i].canDrag = VirCatMgr:IsCardShow(arr[i]:GetID())
			end
		end
		-- else
		-- 	svList=SortMgr:Sort(sortID,arr)

		svList=SortMgr:Sort(sortID,arr)
	elseif selectType == TeamSelectType.Force then
		local arr = {}
		--强制上阵时剔除同队强制上阵的roleTag类型卡牌，剔除已强制上阵的别队卡牌	
		if forceID then --强制位置
			local cfg = Cfgs.CardData:GetByID(forceID);
			arr = RoleMgr:GetCardsByRoleTag(cfg.role_tag)
		else --普通位置
			local forceIDs = {};
			if forceCfg then
				for k, v in ipairs(forceCfg) do
					local nForceID = FormationUtil.GetNForceID(v);
					table.insert(forceIDs, nForceID);
				end
			end
			local list = RoleMgr:GetCardsByExcludeIds(forceIDs)--剔除同队强制上阵的相同roleTag类型的卡牌
			if excludIds then
				for k, v in ipairs(list) do
					local hasId = false;
					for key, val in ipairs(excludIds) do
						if val == v:GetID() then
							hasId = true;
							break;
						end
					end
					if hasId == false then
						table.insert(arr, v);
					end
				end
			else
				arr = list;
			end
		end
		-- svList = RoleSortUtil:SortByCondition(listType, arr,teamIndex,isTeamDup)
		svList=SortMgr:Sort(sortID,arr);
	elseif selectType == TeamSelectType.Support then
		-- svList=FriendMgr:GetAssisCardByType();
		if FriendMgr:IsRefreshAssist() then
			-- SetAssistList();
			isAssistRefresh=true;
			FriendMgr:SetDontCleanAssist(TeamMgr:GetAssistCids());
			FriendMgr:InitAssistData();--刷新
		else
			isAssistRefresh=false;
			SetAssistList();
		end
	end
end

function OnAssistListInit()
	if selectType ~= TeamSelectType.Support then
		do return end
	end
	SetAssistList();
	RefreshCardList(true);
end

function SetAssistList()
	local num=NPCList~=nil and #NPCList or 0;
	local assistID=teamData and teamData:GetAssistID() or nil;
	local lockAssistID=FriendMgr:GetLockAssistID(sectionID);
	if openSetting==TeamOpenSetting.Tower then
		assistID=lockAssistID;
	end
	-- Log(tostring(isRefresh).."\t"..tostring(FriendMgr.tLIndex))
	svList=FriendMgr:GetAssistList(g_AssitShowMaxCnt-num,isRefresh,assistID,openSetting==TeamOpenSetting.Tower,sectionID);
	if svList then
		if openSetting==TeamOpenSetting.Tower then
			table.sort(svList,function(a,b)
				local n1=a:GetID()==lockAssistID and 1 or 0;
				local n2=b:GetID()==lockAssistID and 1 or 0
				if n1~=n2 then
					return n1>n2;
				else
					return AssistSortUtil.Sort2(a,b)
				end
			end)
		elseif openSetting==TeamOpenSetting.TotalBattle then
			table.sort(svList,function(a,b)
				local n1=TotalBattleMgr:IsShowCard(a:GetID()) and 1 or 0;
				local n2=TotalBattleMgr:IsShowCard(b:GetID()) and 1 or 0
				if n1~=n2 then
					return n1>n2;
				else
					return AssistSortUtil.Sort2(a,b)
				end
			end)
		end
	end
	if NPCList~=nil then
		svList=svList or {};
		for k,v in ipairs(NPCList) do
			table.insert(svList,1,NPCList[k]);
		end
	end
	if next(svList) then
		CSAPI.SetGOActive(txt_noneAssist,false)
	else
		CSAPI.SetText(txt_noneAssist,LanguageMgr:GetTips(14038));
		CSAPI.SetGOActive(txt_noneAssist,true)
	end
end

--刷新卡牌视图 isReset:重置位置
function RefreshCardList(isReset)
    -- curDatas = {}
	-- if(orderType == RoleListOrderType.Up) then ---旧版排序
	-- 	local len = #svList
	-- 	local oList={};
	-- 	for k = len, 1, - 1 do
	-- 		local tIndex=TeamMgr:GetCardTeamIndex(svList[k]:GetID());
	-- 		if tIndex  and tIndex~=-1 and tIndex~=teamData:GetIndex() then
	-- 			table.insert(oList,svList[k]);
	-- 		else
	-- 			table.insert(curDatas, svList[k])
	-- 		end
	-- 	end
	-- 	for k,v in ipairs(oList) do
	-- 		table.insert( curDatas,v )
	-- 	end
	-- else
		curDatas = svList
	-- end
	if curDatas and teamData then --剔除已上阵的卡牌
		local list={};
		local hasItem=false;
		for k,v in ipairs(curDatas) do
			hasItem=false;
			for _,val in ipairs(teamData.data) do
				if v:GetID()==val:GetID() and not val:IsAssist() then
					hasItem=true;
					break;
				end
			end
			if hasItem~=true then
				table.insert(list,v);
			end
		end 
		curDatas=list;
	end
	CSAPI.SetGOActive(SortNone,#curDatas<=0);
	if isList~=true then
		if isMember then
			layout:IEShowList(#curDatas, nil,isReset and 1 or 0)
		else
			layout2:IEShowList(#curDatas, nil,isReset and 1 or 0)
		end
	end
end

function LayoutCallBack(index)
    local _data = curDatas[index]
	local roleItem=teamData:GetItemByRoleTag(_data:GetRoleTag());
	local assistTag=teamData:GetAssistData()~=nil and teamData:GetAssistData():GetRoleTag() or nil;
	local isEqual=false;
	if (selectType ~= TeamSelectType.Support  and _data:GetRoleTag()==assistTag) or (roleItem and  _data:GetRoleTag()==roleItem:GetRoleTag() and roleItem:GetIndex()~=6 and selectType==TeamSelectType.Support) then
		isEqual=true;
	end
	local disDrag,_disDrag_lanID=false,nil;
	local key="TeamFormation"
	if openSetting==TeamOpenSetting.Tower then
		disDrag=not _data.canDrag;
	elseif openSetting==TeamOpenSetting.TotalBattle then
		key="TotalBattle";
		disDrag=TotalBattleMgr:IsShowCard(_data:GetID())~=true
		isEqual=disDrag;
	elseif openSetting==TeamOpenSetting.RogueT or openSetting==TeamOpenSetting.PVP then
		disDrag=not _data.canDrag;
		_disDrag_lanID = _data.disDrag_lanID;
		isEqual=disDrag;
	elseif openSetting==TeamOpenSetting.MultBattle then
		disDrag=not _data.canDrag;
		_disDrag_lanID = _data.disDrag_lanID;
		isEqual=disDrag;
	elseif openSetting==TeamOpenSetting.Trials2 then
		disDrag=not _data.canDrag;
		isEqual=disDrag;
	-- elseif openSetting==TeamOpenSetting.TowerDeep then
	-- 	disDrag=not _data.canDrag;
	-- 	isEqual=disDrag;
	elseif openSetting==TeamOpenSetting.VirCat then
		disDrag=not _data.canDrag;
		isEqual=disDrag;
	end
	local isNpc,s1,s2=FormationUtil.CheckNPCID(_data:GetID());
	local showNpc=false;
	if isNpc and s1=="npc" then
		showNpc=true;
	end
	if(openSetting==TeamOpenSetting.Colosseum)then 
		showNpc = false
	end 
	local _elseData={
        isSelect=teamData:GetItem(_data:GetID())~=nil,
		isCost=isCost,
		listType=listType,
		isFormation= TeamMgr:GetCardTeamIndex(_data:GetID(),TeamMgr:GetTeamType(teamData:GetIndex()),true)~=teamData:GetIndex(),--当前队伍的卡牌不显示队伍信息
		showTips=isEqual,
		showNPC=showNpc,
		showAttr=isAddtive,
		sr=scroll,
		key=key,
		canClick=enableClick,
		sortId=sortID,
		disDrag=disDrag,
		disDrag_lanID = _disDrag_lanID,
		showFakeLevel = showFakeLevel,
		teamType = TeamMgr:GetTeamType(teamData:GetIndex())
    };
	local grid=layout:GetItemLua(index);
	grid.SetIndex(index);
	grid.Refresh(_data,_elseData);
	grid.SetClickCB(OnClickCard);
end

--支援卡牌列表
function LayoutCallBack2(index)
    local _data = curDatas[index]
	local roleItem=teamData:GetItemByRoleTag(_data:GetRoleTag());
	local assistTag=teamData:GetAssistData()~=nil and teamData:GetAssistData():GetRoleTag() or nil;
	local isEqual=false;
	if (selectType ~= TeamSelectType.Support  and _data:GetRoleTag()==assistTag) or (roleItem and  _data:GetRoleTag()==roleItem:GetRoleTag() and roleItem:GetIndex()~=6 and selectType==TeamSelectType.Support) then
		isEqual=true;
	end
	local canDrag,disDrag_lanID=true,nil;
	if openSetting==TeamOpenSetting.Tower then--还需要判断是否是今日锁定的助战卡牌
		canDrag=FriendMgr:IsLockAssist(_data:GetID(),sectionID);
		local canPass=CheckCardCanPass(_data);
		if canDrag and canPass~=true then
			canDrag=false;
		elseif canDrag~=true and FriendMgr:GetLockAssistID(sectionID)==nil then
			canDrag=canPass;
		end
	elseif openSetting==TeamOpenSetting.TotalBattle then
		canDrag = TotalBattleMgr:IsShowCard(_data:GetID());
	elseif openSetting==TeamOpenSetting.Trials2 then
		if not TrialsMgr:IsShowCard(_data:GetRoleTag()) then
			canDrag = false
			TeamMgr:RemoveAssistTeamIndex(_data:GetID())
		end
	end
	local isNpc,s1,s2=FormationUtil.CheckNPCID(_data:GetID());
	local showNpc=false;
	if isNpc and s1=="npc" then
		showNpc=true;
	end
	local _elseData={
        isSelect=teamData:GetItem(_data:GetID())~=nil,
		showTips=isEqual,
		showNPC=isNpc,
		showAttr=isAddtive,
		checkTeam=true,
		sr=scroll2,
		disDrag=not canDrag,
		disDrag_lanID = disDrag_lanID,
    };
	local grid=layout2:GetItemLua(index);
	grid.SetIndex(index);
	grid.Refresh(_data,_elseData);
	grid.SetClickCB(OnClickCard);
end

function OnClickRefresh()
	isRefresh=true
	if openSetting == TeamOpenSetting.Trials2 and NPCList then
		NPCList = nil
	end
	SetSVList();
	-- SetAssistList();
	-- RefreshCardList(true)
	if not isAssistRefresh then
		RefreshCardList(true)
	end
	isRefresh=false;
	--开启CD
	SetCD();
end

function SetCD()
	CSAPI.SetGOActive(btn_refresh,false);
	CSAPI.SetGOActive(refreshObj,true);
	cdTime=Time.unscaledTime+g_AssitCD;
end

function Update()
	if cdTime~=0 and Time.unscaledTime<cdTime then
		local timeStr=cdTime-Time.unscaledTime;
		CSAPI.SetText(txt_refreshTime,TimeUtil:GetTimeStr(math.floor(timeStr+0.5)));
	elseif cdTime~=0 and Time.unscaledTime>cdTime then
		CSAPI.SetGOActive(btn_refresh,true);
		CSAPI.SetGOActive(refreshObj,false);
		cdTime=0
	end
	if platformType==7 and isDrag==true and CSAPI.GetCurrUIEventObj()==nil then
		EventMgr.Dispatch(EventType.TeamView_DragJoin_Lost)
		isDrag=false;
	end
end

function OnValueChange()
	if scroll2.normalizedPosition.y<=0 then
		CSAPI.SetScriptEnable(vsv2Mask,"SoftMask",false);
		CSAPI.SetScriptEnable(vsv2Mask,"Image",true);
		CSAPI.SetScriptEnable(vsv2Mask,"Mask",true);
	else
		CSAPI.SetScriptEnable(vsv2Mask,"Image",false);
		CSAPI.SetScriptEnable(vsv2Mask,"Mask",false);
		CSAPI.SetScriptEnable(vsv2Mask,"SoftMask",true);
	end
end

--点击卡牌
function OnClickCard(tab)
	if IsDisClick() then
		return;
	end
	if not isMovement then
		LookCard(tab.cardData:GetID());
	end
	isMovement=false;
end

--移动时取消点击事件
function OnPressDownCard(tab)
	if scroll.velocity.x>0 or scroll.velocity.y>0 then
		isMovement=true;
		scroll:StopMovement();
	end
end

function LookCard(cid)
	if cid==nil then
		LogError("查看卡牌时卡牌ID不能为NIL")
		return
	end
	if GetIsChange() then
		CheckTeam(function ()
			TeamMgr:SaveEditTeam(function()
				isChange=false;
				RefreshTeamData();
				FormationUtil.LookCard(cid);
			end);
		end);
	else
		FormationUtil.LookCard(cid);
	end
end

--下阵
function OnSelectLeave(eventData)
	if eventData then
		if (teamData and (teamData:GetIndex()==1 or canEmpty~=true)  and teamData:GetRealCount()<=1 and teamData:GetAssistID()~=eventData:GetID())  then--第一队最后一个队员无法下阵 或队伍不能为空时
			Tips.ShowTips(LanguageMgr:GetTips(14023));
			return;
		end
		local dialogdata = {};
		local content = LanguageMgr:GetTips(14024);
		dialogdata.content = content;
		dialogdata.okCallBack = function()
			Leave(eventData:GetID());
			RefreshFormationView()
		end
		CSAPI.OpenView("Dialog",dialogdata);
	end
end

function SetTabState(_isMember)
	CSAPI.SetGOActive(svOnTween2,_isMember);
	CSAPI.SetGOActive(svOffTween2,not _isMember);
end

--切换队员和支援
function OnClickSVType2()
	isMember=not isMember
	if isMember then
		OnClickMember();
	else
		OnClickAssist();
	end
end

--队员页
function OnClickMember()
    -- local item=teamData:GetItemByIndex(teamData:GetNextIndex());
    if forceCfg~=nil then --读取强制数据
        selectType=TeamSelectType.Force;
    else--显示普通列表
        selectType=TeamSelectType.Normal;
    end
	SetSortObj();
    -- SetTabData()
    Refresh(true);
end

--支援页
function OnClickAssist()
    selectType=TeamSelectType.Support;
    -- SetTabData()
    Refresh(true);
end

function SetInfoViewPos(eventData)
	if eventData and  eventData.row and eventData.col and formationView then
		local posData=formationView.formatTab:GetPosData(eventData.row,eventData.col);
		if posData then
			formationView.SetClickState(posData:GetID());
		end
	end
end

function SetCurrIndex()
	if selectType==TeamSelectType.Support then
		currIndex=6;
	else
		currIndex=teamData:GetNextIndex();
	end
end

function RefreshFormationView()
	if formationView then
		formationView.CleanCard();
		formationView.Init(teamData,canDragLeave,false,nil,isAddtive,infoNode,isShowInfos,showFakeLevel);
		formationView.SetHaloEnable(true);
	end
end

--有卡牌加入队伍时
function OnCardJoin(eventData) 
	if eventData then
		local row=eventData.row;
		local col=eventData.col;
		local card=eventData.card;
		--判断当前队伍是否有相同的卡牌，有的话要判断当前放置位置是否是那张卡，相同的卡牌只能替换上阵，否则视为无效操作，如果当前队伍中没有相同的卡，那可以替换掉位置够用的卡牌。如果当前位置为空且队伍中没有重复的卡，那么只要位置可以放置且队伍人数未超过上限即可放置。
		if row and col then
			-- Log("上阵："..tostring(row).."\t"..tostring(col));
			local roleItem = teamData:GetItemByRoleTag(card:GetRoleTag());--当前队伍是否存在相同的卡牌
			local posItem=formationView.formatTab:GetPosData(row,col);--当前位置放置的卡牌
			local isForce = false;
			if forceCfg and posItem then --判断当前位置的卡牌是否是强制上阵的卡牌
				for k, v in ipairs(forceCfg) do
					local nForceID = FormationUtil.GetNForceID(v);
					if  nForceID == posItem:GetCardCfgID() then
						isForce = true;
						break;
					end
				end
			end
			if selectType == TeamSelectType.Support and canAssist~=true then --无法上阵助战卡
				LanguageMgr:ShowTips(14036);
				return
			elseif selectType == TeamSelectType.Support and posItem and posItem.index~=6  then
				-- Tips.ShowTips(LanguageMgr:GetTips(14035));
				return
			elseif selectType~=TeamSelectType.Support and posItem and posItem.index==6 then
				return
			elseif roleItem and roleItem.row==row and roleItem.col==col then
				JoinCard(card,row,col,roleItem.index,true);
			elseif roleItem==nil and posItem~=nil and isForce~=true then --当前位置已有卡牌且当前队伍中没有相同卡牌
				JoinCard(card,row,col,posItem.index,true);
			elseif roleItem==nil and posItem==nil then
				local teamCount = teamData:GetRealCount();
				local maxNum = selectType == TeamSelectType.Support and g_TeamMemberMaxNum + 1 or g_TeamMemberMaxNum;
				if teamCount >= maxNum then --超过队伍人数上限
					Tips.ShowTips(LanguageMgr:GetTips(14025));
				else
					JoinCard(card,row,col,currIndex,false);
				end
			elseif roleItem~=nil then
				Tips.ShowTips(LanguageMgr:GetTips(14026));
			end
		end
	end
end

--检查卡牌是否符合限制条件
function CheckCardCanPass(card)
	-- LogError(cond)
	if card==nil then
		return false;
	end
	if(openSetting==TeamOpenSetting.Tower)then 
		local info=nil;
		local assistData=card:GetAssistData();
		if assistData~=nil then
			info=FormationUtil.GetTowerCardInfo(card:GetData().old_cid, assistData.uid,TeamMgr.currentIndex);
		else
			info=FormationUtil.GetTowerCardInfo(card:GetID(),nil,TeamMgr.currentIndex);
		end
		if info and info.tower_hp<=0  then --HP为0，无法上阵
			return false;
		end
	end 
	if cond then
		local result,lanID=cond:CheckCard(teamData,card);
		-- LogError(tostring(card:GetID()).."检测限制--------------->"..tostring(result))
		return result,lanID;
	end
	return true;
end

function JoinCard(card,row,col,index,isReplace)
	if card==nil or row==nil or col==nil then
		LogError("上阵数据为空！");
		return;
	end
	local teamItem=TeamItemData.New();
	local tempData = {
		cid = card:GetID(),
		row = row,
		col = col,
	}
	local isNpc=FormationUtil.CheckNPCID(card:GetID());
	if selectType == TeamSelectType.Support then
		tempData.index = 6;
		local assistData = FormationUtil.FindTeamCard(card:GetID());
		local assData=assistData:GetAssistData();
		if assData then
			tempData.fuid = assData.uid;
		end
		tempData.bIsNpc=isNpc;
	else
		tempData.index = index;
		tempData.isForce = IsForcePos();
		tempData.bIsNpc=isNpc;
	end
	teamItem:SetData(tempData);
	if formationView.formatTab:PushCardByPos(teamItem,isReplace) then
		if teamItem:IsAssist() then
			local cAssistID = teamData:GetAssistID();
			if cAssistID~=nil then
				TeamMgr:RemoveAssistTeamIndex(cAssistID);
			end
			TeamMgr:AddAssistTeamIndex(card:GetID(), teamData:GetIndex());
			assistMember=teamItem;
		end
		if index then
			local tempItem=teamData:GetItemByIndex(index);
			if tempItem then
				teamData:RemoveCard(tempItem:GetID(),true);
			end
		end
		teamData:AddCard(teamItem);
		SetCurrIndex();
		if forceData and forceData.forceCallBack then 
			local hasForce=false;
			for k,v in ipairs(forceData.forceData) do
				if v.cfgId==teamItem:GetCfgID() then
					hasForce=true;
					break;
				end
			end
			if hasForce then
				forceData.forceCallBack(forceData.forceCaller,teamItem.row,teamItem.col);
			end
		end
		CSAPI.PlayUISound("ui_cosmetic_adjustment");
		clickID=nil;
		SetSVList();
		RefreshLeftInfo();
		RefreshCardList();
		RefreshFormationView()
		isChange=true;
		--播放出击语音
		RoleAudioPlayMgr:PlayByType(card:GetModelCfg().id, RoleAudioType.enterLevel)
		-- CheckCardCanPass(card);
	else
		Log("位置不足！");
	end
end

--下阵角色
function Leave(_cid)
	if _cid and canDragLeave then
		local teamItem = teamData:GetItem(_cid);
		--判断当前队伍是否是强制上阵队伍,强制上阵的卡牌不可替换
		local isForceTeam=TeamMgr.currentIndex >= eTeamType.ForceFight
		if(isForceTeam) then
			local isForce = false;
			if forceCfg then
				for k, v in ipairs(forceCfg) do
					local nForceID = FormationUtil.GetNForceID(v);
					if teamItem and nForceID == teamItem:GetCardCfgID() then
						isForce = true;
						break;
					end
				end
			end
			if isForce or (teamItem:IsNPC() and not teamItem:IsAssist()) then --非强制上阵ID可以下阵
				teamItem = nil;
			end
		end
		if teamItem then
			teamData:RemoveCard(teamItem.cid);
			--移除占位信息
			formationView.formatTab:RemoveCard(teamItem);
			if teamItem:IsAssist() then
				--清除助战索引
				TeamMgr:RemoveAssistTeamIndex(teamItem.cid);
				assistMember=nil;
			end
			if not isForceTeam then--非强制队伍刷新队员下标
				for k,v in ipairs(teamData.data) do
					if v:IsAssist() then
						v.index=6;
					else
						v.index=k;
					end
				end
			end
			SetCurrIndex()
            isChange=true;
			CSAPI.PlayUISound("ui_cosmetic_adjustment");
		end
		-- if not isEdit then
		-- 	InitTeamItems();
		-- end
		RefreshLeftInfo();
		-- SortCB(conditionData,true);--刷新列表
		SetSVList();
		RefreshCardList(true);
	end
end

--当前索引是否是强制上阵的位置
function IsForcePos()
	if currIndex and forceCfg and forceCfg[currIndex] ~= nil and forceCfg[currIndex].nForceID then
		return true;
	end
	return false;
end

----光环
function OnFormatSelect(eventData)
	if IsDisClick() then
		return;
	end
	if formationView then
		if eventData==nil or eventData.cid==nil or eventData.cid==clickID then
			clickID=nil;
		elseif eventData and eventData.isDrag then
			clickID=nil;
		elseif eventData then
			clickID=eventData.cid
		end
	end
end

function SetViewBtnState(_is3D)
	rCanvasGroup.alpha=_is3D and 1 or 0.5;
	lCanvasGroup.alpha=_is3D and 0.5 or 1;
	CSAPI.SetGOActive(line2D,not _is3D)
	CSAPI.SetGOActive(line3D,_is3D)
end

--切换视图
function OnClickViewType()
	if IsDisClick() then
		return;
	end
	TeamMgr:SetDragFingerID();
    is3D=not is3D;
	CSAPI.PlayUISound("ui_generic_tab_2")
	SetViewBtnState(is3D)
	CSAPI.SetGOActive(fullMask,true);
	FuncUtil:Call(function()
		CSAPI.SetGOActive(fullMask,false);
	end,nil,400)
    --切换显示的阵型图
	if is3D then --转换到3D
		if formationView then
			formationView:CleanCard();
			formationView.view:Close();
			formationView=nil;
		end
		CreateFormationView();
		-- formationView.PlaySwitch(is3D,function()
		-- 	if formationView then
		-- 		formationView:CleanCard();
		-- 		formationView.view:Close();
		-- 		formationView=nil;
		-- 	end
		-- end)
		formationView.PlaySwitch(is3D);
	else--转换到2D
		if formationView then
			-- formationView.PlaySwitch(is3D,function()
			-- 	formationView:CleanCard();
			-- 	formationView.view:Close();
			-- 	formationView=nil;
			-- 	CreateFormationView();
			-- end)
			formationView.PlaySwitch(is3D);
			-- formationView.SetRotateTo2D(true,function()
			-- 	formationView:CleanCard();
			-- 	formationView.view:Close();
			-- 	formationView=nil;
			-- 	CreateFormationView();
			-- end);
		else
			CreateFormationView();
		end
	end
end

function OnViewTypChange(eventData)
	if eventData then
		if formationView and not eventData.is3D then
			formationView:CleanCard();
			formationView.view:Close();
			formationView=nil;
		end
		if not eventData.is3D then
			CreateFormationView(false);
		end
	end
end

function SetTeamLeader(cid)
	teamData:SetLeader(cid);
    isChange=true
	--设置队长播放对应角色出击音效
	local member=teamData:GetItem(cid);
	if member then
		RoleAudioPlayMgr:PlayByType(member:GetModelID(), RoleAudioType.enterLevel)
	end
    Refresh();
end

function OnClicklMask()
    UIUtil:DoLocalMove(sbg, {0,0,0},function()
        CSAPI.SetGOActive(selectLeaderObj,false);
    end);
end

function OnClickTest()
	if formationView then
		CSAPI.SetGOActive(formationView.gameObject,false);
	end
    ResUtil:CreateUIGOAsync("Formation/FormationView3D" ,childNode,function(go)
        local lua=ComUtil.GetLuaTable(go);
        lua.Init(teamData);
    end);
end

--点击了清空
function OnClickClean()
	if IsDisClick() then
		return
	end
    if teamData and isFight then
		Tips.ShowTips(LanguageMgr:GetTips(14001));
		return;
	end
    local removeCid={};
	for i=1,#teamData.data do
		local item=teamData.data[i];
		if teamData:GetTeamType()==eTeamType.Colosseum or teamData:GetTeamType()==eTeamType.RogueT or teamData:GetTeamType()==eTeamType.ChainFront then
			table.insert(removeCid,item.cid);
		else
			if (teamData:GetIndex()==1 or canEmpty~=true) and item:IsLeader()==false then--不能为空的队伍或者编队1会留下队长卡
				table.insert(removeCid,item.cid);
			elseif teamData:GetIndex()~=1 and canEmpty and item:IsForce()~=true and item:IsNPC()~=true then --不清空助战队员和强制上阵卡牌
				table.insert(removeCid,item.cid);
			end
		end
	end
	local assistData=teamData:GetAssistData();
	for k,v in ipairs(removeCid) do
		if assistData and assistData.cid==v then
			TeamMgr:RemoveAssistTeamIndex(v);
		end
		teamData:RemoveCard(v);
	end
    Refresh(teamData:GetIndex(),elseData);
    OnDataChange();
    EventMgr.Dispatch(EventType.TeamView_Refresh_Formation)
end

--点击了AI
function OnClickAI()
    --打开设置AI界面
    -- EventMgr.Dispatch(EventType.Team_Edit_Change)
	if IsDisClick() then
		return
	end
	local isOpen,lockStr=MenuMgr:CheckModelOpen(OpenViewType.special, FormationUtil.AIModuleKey)
	if isOpen~=true then
		Tips.ShowTips(lockStr);
		return
	end
    if isFight then
        Tips.ShowTips(LanguageMgr:GetTips(14001));
        return
    end
    if teamData==nil or (teamData and teamData:GetRealCount()==0) then
        Tips.ShowTips(LanguageMgr:GetByID(31009));
        return
    end
	if GetIsChange() then
		CheckTeam(function ()
			TeamMgr:SaveEditTeam(function()
				isChange=false;
				RefreshTeamData();
				CSAPI.OpenView("AIPrefabSetting",{teamData=teamData});
			end);
		end);
	else
		CSAPI.OpenView("AIPrefabSetting",{teamData=teamData});
	end
end

--点击了技能
function OnClickSkill()
    --显示战术选择面板
	if IsDisClick() then
		return;
	end
	local isOpen,lockStr=MenuMgr:CheckModelOpen(OpenViewType.main, FormationUtil.SkillModuleKey)
	if isOpen~=true then
		Tips.ShowTips(lockStr);
		return
	end
    if isFight then
        Tips.ShowTips(LanguageMgr:GetTips(14001));
        return
    end
	CSAPI.OpenView("TacticsView",{teamData=teamData,closeFunc=OnSkillChange});
end

function OnChildNodeChange(index)
	if index==0 then
		CSAPI.SetParent(childNode,layerObj,false);
	else
		CSAPI.SetParent(childNode,layerObj2,false);
	end
end

function OnTeamNameChange(str)
	local text=StringUtil:FilterChar(str);
	input.text=text;
end

function OnTeamNameEdit(str)
    if teamData then
		if (input.text==nil or input.text=="")  then
			input.text=teamData:GetTeamName();
		end
        if (not MsgParser:CheckContain(input.text))  then
            teamData:SetTeamName(input.text);
            OnDataChange();
        else
            Tips.ShowTips(LanguageMgr:GetTips(9003))
            input.text=teamData:GetTeamName();
        end
	end
end

--战术变更
function OnSkillChange(cfgId)
    local isChange=teamData:GetSkillGroupID()~=cfgId;
    if not isChange then
        return;
    end
    cfgId=cfgId or 0;
	if TeamMgr:GetTeamData():GetCount()>0 then
		AbilityProto:SkillGroupUse(cfgId,TeamMgr.currentIndex,function(proto)
			if teamData then
				teamData:SetSkillGroupID(cfgId);
				OnDataChange();
			end
            SetSkillInfo();
		end);
	else
		teamData:SetSkillGroupID(cfgId);
        OnDataChange();
        SetSkillInfo();
	end
end

function SetSkillInfo()
    --设置战术名称等级
    local tactice=TacticsMgr:GetDataByID(teamData:GetSkillGroupID());
    if tactice then
        CSAPI.SetText(txt_skillName,tactice:GetName());
		ResUtil.Ability:Load(skillIcon, tactice:GetIcon(),false);
    else
        CSAPI.SetText(txt_skillName,LanguageMgr:GetByID(26038));
		CSAPI.LoadImg(skillIcon,"UIs/Team/btn_02_03.png",true,nil,true);
    end
end

function SetSortObj()
	--判断筛选ID
	local tempID=0;
	if openSetting== TeamOpenSetting.Normal then--不能为空的队伍或者编队1会留下队长卡
		tempID=2;
	elseif openSetting== TeamOpenSetting.PVE then
		tempID=3;
	elseif(openSetting==TeamOpenSetting.Tower or openSetting==TeamOpenSetting.TotalBattle)then 	
		tempID = 25
	elseif(openSetting==TeamOpenSetting.RogueT)then 
		tempID = 26
	else
		tempID=4;
	end
	--
	local isChange=tempID~=sortID
	sortID=tempID;
	if sortView==nil and isLoadSortView~=true then
		isLoadSortView=true
		ResUtil:CreateUIGOAsync("Sort/SortTop",btnTool,function(go)
			CSAPI.SetScale(go,1,1,1);
			sortView=ComUtil.GetLuaTable(go);
			sortView.Init(sortID,function()
				SetSVList()
				RefreshCardList(true);
			end);
			CSAPI.SetAnchor(go,-55,15);
		end);
	elseif sortView~=nil and isChange then
		sortView.Init(sortID,function()
			SetSVList()
			RefreshCardList(true);
		end);
	end
end

--能力测验编队限制
function OnClickLimit()
	CSAPI.OpenView("TeamLimitPanel",data.dungeonId)
end

-------------------------------筛选
---返回虚拟键公共接口  函数名一样，调用该页面的关闭接口
function OnClickVirtualkeysClose()
	if BackteamPreset then
		---填写退出代码逻辑/接口
		if BackteamPreset.OnOpenPreset and BackteamPreset.gameObject.activeInHierarchy then
			BackteamPreset.OnOpenPreset();
		else
			if  Top.OnClickBack then
				Top.OnClickBack();
				BackteamPreset=nil;
			end
		end
	else
		if  Top.OnClickBack then
			Top.OnClickBack();
		end
	end
end

----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()     
gameObject=nil;
transform=nil;
this=nil;  
mbg=nil;
childNode=nil;
roleListRoot=nil;
vsv=nil;
sr=nil;
svOnObj=nil;
svOffObj=nil;
txt_level=nil;
txt_cost=nil;
btn_svType2=nil;
svOffObj2=nil;
svOnObj2=nil;
txt_member=nil;
txt_assist=nil;
svOnTween2=nil;
svOffTween2=nil;
btnTool=nil;
txtFiltrate=nil;
btnUD=nil;
objSort=nil;
txtSort=nil;
top=nil;
btn_preset=nil;
txt_preset=nil;
btn_clean=nil;
txt_clean=nil;
infos=nil;
viewType=nil;
onObj=nil;
offObj=nil;
txt_3d=nil;
txt_2d=nil;
viewOnTween=nil;
viewOffTween=nil;
fightMask=nil;
btnNext=nil;
btnUp=nil;
fullMask=nil;
view=nil;
scroll=nil;
scroll2=nil;
txt_noneAssist=nil;
layout=nil;
skillImg=nil;
aiImg=nil;
end
----#End#----