--战场界面
local taskItems = nil;--星级物体
local isFull = false;--星级物体显示是否完全
local endTime = 0;--剩余时间
-- local commGrid=nil;--角色格子
local lastClickCharacter = nil;--最后查看信息的角色
local isLock = false;
local starClick = nil;
local currTeamNO = 1;--当前操作的队伍下标
local recordBeginTime = 0;
local dungeonData = nil;
local isLeftHide = true;
local sSlider = nil;--缩放的slider
local isPlayerLast = false
local isCanAIMove = false
local isAIMove = false
local panel = nil --首次入场动效
local canBlack = true
local top = nil
function Awake()
	AdaptiveConfiguration.SetLuaObjUIFit("Battle",gameObject)
	--添加问号 rui 211130 --因为不是通过openview打开的，所以要手动添加
	UIUtil:AddQuestionItem("Battle", gameObject, questionParent)
	--CSAPI.SetGOActive(right, false);
	currDungeonId = DungeonMgr:GetCurrId();
	recordBeginTime = CSAPI.GetRealTime();
	--EventMgr.Dispatch(EventType.Main_Menu_Show,false);
	gridList = {};
	for i = 1, 6 do
		local item = CreateTeamGrid(bottomGrid.transform);
		item.SetIndex(i);
		table.insert(gridList, item);		
	end
	taskItems = {};
	for i = 1, 3 do
		ResUtil:CreateUIGOAsync("FightTaskItem/FightTaskItem", starParent, function(go)
			local tab = ComUtil.GetLuaTable(go);
			tab.Init("", false, false);
			tab.SetIndex(i)
			table.insert(taskItems, tab);
		end);
	end
	starClick = ComUtil.GetCom(txt_star, "Text");
	sSlider = ComUtil.GetCom(scaleSlider, "Slider")
	--UpdateTeamInfo(BattleMgr:GetCtrlCharacter());
	CSAPI.SetGOActive(starParent, true);
	CSAPI.SetGOActive(enterAction, false)
	roundFade = ComUtil.GetCom(exit, "ActionFade")
	
	CSAPI.SetGOActive(bg, false)
	CSAPI.SetGOActive(node, false)
end

function OnInit()
	InitListener();
	
	top = UIUtil:AddTop2("BattleView", headNode, OnClickQuip, OnClickHome, {})
	CSAPI.SetGOActive(top.btn_home,false)
	CSAPI.SetGOActive(btn_quip,false)
			
	UpdateQuitState();
end

function UpdateQuitState()
	local isCanQuit = BattleMgr:IsCanQuit();
	if not PlayerClient:IsPassNewPlayerFight() then
		isCanQuit = false
	end
	CSAPI.SetGOActive(top.btn_exit, isCanQuit);
	CSAPI.SetGOActive(btn_auto, isCanQuit);
	CSAPI.SetGOActive(headNode, isCanQuit);
end

function InitListener()
	eventMgr = ViewEvent.New();
	eventMgr:AddListener(EventType.Battle_Character_Created, OnBattleCharacterCreated);
	eventMgr:AddListener(EventType.Battle_Character_Ctrl_Changed, OnBattleCharacterCtrlChanged);
	eventMgr:AddListener(EventType.Battle_Character_Update, OnBattleCharacterUpdate);
	eventMgr:AddListener(EventType.Battle_My_Character_Dead, OnBattleMyCharacterDead);
	
	eventMgr:AddListener(EventType.Battle_View_Show_Changed, OnViewShow);
	eventMgr:AddListener(EventType.Battle_Select_Ground_Info, ShowGridInfo);
	eventMgr:AddListener(EventType.Battle_BoxNum_Change, RefreshStarInfo);
	eventMgr:AddListener(EventType.Battle_Character_Move, OnBattleCharacterMove);
	eventMgr:AddListener(EventType.Battle_Lock_Click, LockClick);
	
	eventMgr:AddListener(EventType.Input_Scene_Battle_Grid_Click, OnClickGround);
	
	eventMgr:AddListener(EventType.Battle_Quit_State_Changed, UpdateQuitState);
	eventMgr:AddListener(EventType.Battle_Ground_Zoom, OnZoomChanged);
	
	--AIMove
	-- eventMgr:AddListener(EventType.Battle_AIMove_UI_Update, OnAIMoveState)
	--回合
	eventMgr:AddListener(EventType.Battle_Turn_Changed, OnBattleChangeRound);
	
	eventMgr:AddListener(EventType.Battle_UI_BlackShow, OnBlackClose);
	eventMgr:AddListener(EventType.AIPreset_Battle_SetRet,OnAISetRet)

	eventMgr:AddListener(EventType.Mission_List, OnRedPointRefresh)
end

--锁定点击
function LockClick()
	isLock = true;
	CSAPI.SetGOActive(mask, true);
	FuncUtil:Call(UnLockClick, nil, 5000);
end

function UnLockClick()
	isLock = false;
	CSAPI.SetGOActive(mask, false);
end

function OnDestroy()
	eventMgr:ClearListener();
	
	if(battleGround) then
		battleGround.Remove();
	end
	
	local fightDungeonId = currDungeonId;
	if(fightDungeonId) then
		RecordMgr:Save(RecordMode.Dungeon, recordBeginTime, "duplicateID=" .. fightDungeonId);
	end

	CSAPI.SetGOActive(top.btn_home,true)
	CSAPI.SetGOActive(btn_quip,true)
	CSAPI.SetGOActive(top.btn_exit, true)
	ReleaseCSComRefs()
end
function OnBattleCharacterCreated(character)
	if(character == nil) then
		return;
	end
	
	if(battleGround == nil) then
		return;
	end
	
	if(character.GetType() == eDungeonCharType.Prop) then
		return;
	end
	
	local go = ResUtil:CreateUIGO("Battle/BattleGroundCharacterInfo", infos.transform);
	local goCamera = battleGround.GetCamera();
	CSAPI.AddUISceneElement(go, character.resParentGO, goCamera);
	local lua = ComUtil.GetLuaTable(go);
	lua.AddClickCallBack(function()
		if isAIMove then
			return
		end
		BattleMgr:TryOpenFightFormationView(character.currGridId);
	end)
	character.SetInfoView(lua);

	CSAPI.SetGOActive(top.btn_exit, true)
end

function OnBattleCharacterMove(eventData)
	--更新角色信息
	RefreshStarInfo(eventData);
	local allCharacters = BattleCharacterMgr:GetAll();
	if(allCharacters) then
		for _, tmpCharacter in pairs(allCharacters) do
			if tmpCharacter.GetType() == eDungeonCharType.MonsterGroup and tmpCharacter:IsDead() == false then
				tmpCharacter.UpdateMonsterInfo();
			end
		end
	end
end

function OnBattleCharacterUpdate(character)
	-- LogError(character.GetId().."\t"..tostring(BattleMgr:GetDefaultCtrlId()))
	if character.GetId() == BattleMgr:GetDefaultCtrlId() then
		UpdateTag(character);
		UpdateTeamInfo(character);
	end
end

function OnBattleCharacterCtrlChanged(character)
	UpdateTag(character);
	UpdateTeamInfo(character);
	UpdateUIAction()
	--更新当前操作人物所处的高度
	-- local currHeight=BattleMgr:GetMapGridHeight(character.currGridId);
	-- CSAPI.SetText(text_layer,tostring(currHeight));
	-- CSAPI.SetText(text_layerNum,tostring(currHeight));
end

function OnBattleMyCharacterDead(character)
	OnClickChange();
	local ctrlList = GetPlayerTeam();
	CSAPI.SetGOActive(btnChange, #ctrlList > 1)
	isOne = not(#ctrlList > 1)
end

function OnBattleChangeRound(isPlayer)
	-- if isPlayerLast ~= isPlayer then
	local str = LanguageMgr:GetByID(isPlayer and 25047 or 25048) 
	--CSAPI.SetText(txtRound, str)
	CSAPI.SetText(txtRound,	StringUtil:SetByColor(str, isPlayer and "ffc146" or "fe5353"))
	-- CSAPI.SetGOActive(roundObj, true)
	-- roundFade:Play(1, 0, 600, 1150, function()
	-- 	CSAPI.SetGOActive(roundObj, false)
	-- end)
	-- end
end

function OnBlackClose()	
	canBlack = false
	CSAPI.SetGOActive(black, false)
end

function OnOpen()
	local currId = DungeonMgr:GetCurrId();
	dungeonData = DungeonMgr:GetDungeonData(currId);
	--LogError(currId);
	currTag = change1;
	if dungeonData == nil then
		dungeonData = DungeonData.New();
		dungeonData:SetData({id = currId})
	end
	-- InitAIMove()
	InitBattleGround();
	InitDungeon();
	--InitTeamChange()	
	InitUI()	

    InitCtrlType();
end


function OnViewShow(isShow)
	local maxNum = dungeonData:GetActionNum();
	CSAPI.SetText(text_actionNum1, BattleMgr:GetStepNum() .. "")
	CSAPI.SetText(text_actionNum2, "/" .. maxNum);
	ApplyTurnWarning(BattleMgr:GetStepNum(), maxNum);
	
	endTime = BattleMgr:GetEndTime();
	local ctrlList = GetPlayerTeam();
	CSAPI.SetGOActive(btnChange, #ctrlList > 1 and not isAIMove);
	InitDungeonInfo();
	local currChar = BattleMgr:GetCtrlCharacter();
	UpdateTeamInfo(currChar);
	if currChar ~= nil and isLeftHide == true then
		-- PlayMoveAction(right, {right.transform.localPosition.x - 400, right.transform.localPosition.y, 0}, function()
		-- 	isLeftHide = false;
		-- end);
	end	

	BattleMgr:UpdateMistViewDis();--更新迷雾视野距离
end

--初始化战场
function InitBattleGround()
	if(battleGround) then
		return;
	end
	
	local go = CSAPI.CreateGO("BattleGround");
	battleGround = ComUtil.GetLuaTable(go);
end
--初始化战斗场景
function InitDungeon()
	if(battleGround) then
		if(dungeonData) then
			battleGround.InitDungeon(dungeonData:GetID(), OnBattleGroundInited);	
		else
			LogError("初始化副本失败！副本数据错误");	
			LogError(dungeonData);	
		end
	end
end

--初始化队伍切换按钮
function InitTeamChange()
	-- local characters = BattleCharacterMgr:GetAll()
	-- for i, v in ipairs(characters) do
	-- 	local teamData = TeamMgr:GetFightTeamData(v.GetData().nTeamID);
	-- 	if(teamData and teamData.data) then
	-- 		local leader = teamData:GetLeader()
	-- 		local card = leader:GetCard();
	-- 		local icon = card:GetSmallImg()			
	-- ResUtil.Card:Load(this["Out" .. i], icon .. "", false)
	-- ResUtil.Card:Load(this["In" .. i], icon .. "", false)
	-- CSAPI.SetGrey(this["In" .. i], true)
	-- 	end		
	-- end
	local posX = currTeamNO == 1 and - 54 and 54
	CSAPI.SetAnchor(teamImg, posX, 0)
	StringUtil:SetColor(txtTeam1, currTeamNO == 1 and "black" or "white")
	StringUtil:SetColor(txtTeam2, currTeamNO == 2 and "black" or "white")
end

--初始化UI
function InitUI()
	local currId = DungeonMgr:GetCurrId();
	local cfg = Cfgs.MainLine:GetByID(currId)
	if cfg then
		CSAPI.SetText(txtTitle1, cfg.name)
		CSAPI.SetText(txtTitle2, "")				
		--CSAPI.SetText(txtCost, string.format("战斗消耗： %s行动值/次", cfg.costHot))
		CSAPI.SetGOActive(costObj,false)
		local str = StringUtil:SetByColor(cfg.enterCostHot,"ffc146")
		LanguageMgr:SetText(txtCost, 15046, str)
		--教程显示
		local isTeaching = cfg.type == eDuplicateType.Teaching
		CSAPI.SetGOActive(aiMoveObj, not isTeaching and DungeonMgr:AIMoveBtnShow())
		CSAPI.SetGOActive(timeObj, not isTeaching)	
	end
end

function OnBattleGroundInited()
	EventMgr.Dispatch(EventType.Battle_Ground_Inited, battleGround);	
end

function CanClickQuit()
	return not BattleMgr:GetCurrData();
end


--关闭界面
function OnClickClose()	
	if(not CanClickQuit()) then
		return;
	end
	
	DungeonMgr:Quit(true);
	--    view:Close();
	--    if(cfg)then
	--        CSAPI.OpenView("Dungeon",cfg.group);
	--    end
end

--退出副本
function OnClickQuip()		
	if(not CanClickQuit()) then
		return;
	end
	
	if(not DungeonMgr:CheckDungeonPass(1004)) then
		Tips.ShowTips("通关0-4后开启");
		return;
	end
	
	if(BattleMgr:GetAIMoveState()) then
		Tips.ShowTips("请先停止AI");
		return;
	end
	
	BattleMgr:SetInputState(false);
	CSAPI.OpenView("Dialog",
	{
		content = LanguageMgr:GetByID(15024),
		okCallBack = OnQuipOk,
		cancelCallBack = function()			
			BattleMgr:SetInputState(true);
		end
	});
end

function OnQuipOk()
	if CSAPI.IsADV()==false then
		BuryingPointMgr:TrackEvents("main_fight",{
			reason = "副本撤退",
			world_id = DungeonMgr:GetCurrSectionData():GetID(),
			card_id = DungeonMgr:GetCurrId() or 0
		})
	end
	DungeonMgr:SendToQuit();
	FriendMgr:ClearAssistData();
	TeamMgr:ClearFightTeamData();
	UIUtil:AddFightTeamState(2,"BattleView:OnQuipOk()")	
	-- BattleMgr:SetInputState(true);
end

--首页（必定返回主场景）
function OnClickHome()
	if(not CanClickQuit()) then
		return;
	end
	
	if(BattleMgr:GetAIMoveState()) then
		Tips.ShowTips("请先停止AI");
		return;
	end
	
	UIUtil:ToHome();
end

--回到主菜单
function OnClickBack()	
	if(not CanClickQuit()) then
		return;
	end
	
	if(BattleMgr:GetAIMoveState()) then
		Tips.ShowTips("请先停止AI");
		return;
	end
	
	if isSetting then
		CSAPI.SetGOActive(SettingObj, false)
		isSetting = false
	else
		EventMgr.Dispatch(EventType.Scene_Load, "MajorCity");
	end
end

function OnClickRotL()
	if(battleGround) then
		battleGround.cameraMgr:RotAdd(- 45);
	end
end
function OnClickRotR()
	if(battleGround) then
		battleGround.cameraMgr:RotAdd(45);
	end
end

function OnZoomChanged(progress)
	sSlider.value = progress or 0;
end

function CreateTeamGrid(parent)
	local go = ResUtil:CreateUIGO("Battle/BattleTeamItem", parent);
	local item = ComUtil.GetLuaTable(go);
	item.SetClickCB(OnClickGrid);
	return item;
end

function OnClickGrid(item)
	if item and item.teamItemData then
		FormationUtil.LookCard(item.teamItemData:GetID());
		-- if item.teamItemData.index == 6 then
		-- 	--助战格子
		-- 	-- Log( "点击了助战格子");
		-- 	local assist = FormationUtil.FindTeamCard(item.teamItemData.cid);
		-- 	if assist ~= nil then
		-- 		CSAPI.OpenView("RoleInfo", assist, RoleInfoOpenType.LookOther)
		-- 	end
		-- else
		-- 	local card = item.teamItemData:GetCard();
		-- 	if card ~= nil then
		-- 		CSAPI.OpenView("RoleInfo", card)
		-- 	end
		-- end	
	end
end

--开场动画，只执行一次
function UpdateUIAction()
	if not isFirst then
		local x, y = CSAPI.GetLocalPos(rightImg)
		if not rightMoveAction then
			rightMoveAction = ComUtil.GetCom(rightMove, "ActionMoveByCurve")
		end
		rightMoveAction.startPos = UnityEngine.Vector3(x, y + 730, 0)
		rightMoveAction.targetPos = UnityEngine.Vector3(x, y, 0)
		CSAPI.SetGOActive(bg, true)
		CSAPI.SetGOActive(node, true)
		CSAPI.SetGOActive(enterAction, true)
		if canBlack then
			CSAPI.SetGOActive(blackAction, true)
		end
		for k, v in ipairs(taskItems) do
			v.PlayTween()
		end
		isFirst = true
	end
end

--更新队伍信息
function UpdateTeamInfo(character)
	-- for k, v in ipairs(gridList) do
	-- 	CSAPI.SetGOActive(v.gameObject, false);
	-- end
	local currCharacter = BattleMgr:GetCtrlCharacter();
	if currCharacter == nil or currCharacter.GetType() ~= eDungeonCharType.MyCard or (character ~= nil and currCharacter ~= character) then
		return;
	end
	--CSAPI.SetGOActive(right, true);
	local ctrlData = currCharacter:GetData();
	if(ctrlData.nTeamID == nil) then
		LogError("缺少队伍id" .. table.tostring(ctrlData,true));
		return;
	end
	local teamData = TeamMgr:GetFightTeamData(ctrlData.nTeamID);
	-- DungeonMgr:SetFightTeamId(ctrlData.nTeamID)
	-- Log( "队伍数据");
	-- Log( teamData:GetData());
	if(teamData and teamData.data) then
		local index = 0;
		--读取队长的移动范围和跳跃范围
		local leader = teamData:GetLeader();
		local leaderCfg = leader:GetCfg();
		for k, v in ipairs(teamData.data) do
			local hp = 0;
			local totalHp = 0;
			local grid = gridList[k];
			-- if FriendMgr:IsAssist(v.cid) then
			-- 	hp = GetCardHPAndSP(v.cid, v.fuid, ctrlData);
			-- 	totalHp=v:GetCard():GetTotalProperty()["maxhp"] or 0;
			-- 	grid.SetHP(hp / totalHp);
			-- else
			-- 	index=index+1;
			-- 	hp = GetCardHPAndSP(v.cid, nil, ctrlData);
			-- 	if v.bIsNpc then
			-- 		grid.SetHP(hp / v:GetCfg().maxhp);
			-- 	else
			-- 		local card=v:GetCard();
			-- 		totalHp=card:GetTotalProperty()["maxhp"] or 0;
			-- 		grid.SetHP(hp / totalHp);
			-- 	end
			-- end			
			--CSAPI.SetGOActive(grid.gameObject, true);
			grid.Refresh(v);
			local hpPercent, spPercent = GetCardHPAndSP(v.cid, v.fuid, ctrlData);
			grid.SetHP(hpPercent);
			grid.SetSP(spPercent)
			grid.SetDeath(hpPercent <= 0);
			-- if v.bIsNpc == false and v.fuid == nil then
			local card = v:GetCard();
			grid.SetLv(card:GetLv())				
			-- local hot = card:GetCurDataByKey("hot");
			-- grid.SetHot(card:GetHot(), hot);
			-- end
			grid.SetClick(true);
			grid.SetFade()
		end
		if #teamData.data < #gridList then
			for i = #teamData.data + 1, #gridList do
				--CSAPI.SetGOActive(gridList[i].gameObject, true)
				gridList[i].Refresh()
				gridList[i].SetFade()
			end
		end
	elseif(teamData == nil and gridList ~= nil) then
		for k, v in pairs(gridList) do
			v.SetHP(0);
			v.SetSP(0);
		end
	end
end

--返回卡牌的HP
function GetCardHPAndSP(cid, fuid, fightTeamInfo)
	local hpPercent = 1
	local spPercent = 1
	local sp = 0
	if cid and fightTeamInfo then
		local strs = StringUtil:split(tostring(cid), "_");
		cid = strs[2] == nil and cid or tonumber(strs[2]);
		for k, v in ipairs(fightTeamInfo.team) do
			if v.cid == cid and v.fuid == fuid then
				hpPercent = v.hp_percent or 1;
				sp = v.sp or 0
			end
		end
	end
	spPercent = sp / g_SpMax
	return hpPercent, spPercent;
end

--点击了达成条件
function OnClickStar()
	isFull = not isFull;
	starClick.raycastTarget = false;
	if isFull then
		-- CSAPI.SetGOActive(targetDesc,false);
		CSAPI.SetGOActive(starParent, true);
		CSAPI.SetRTSize(img, 517, 388)
		-- PlayMoveAction(content, {content.transform.localPosition.x + 453, content.transform.localPosition.y, 0}, function()
		starClick.raycastTarget = true;
		-- end);
	else
		CSAPI.SetRTSize(img, 251, 114)		
		-- PlayMoveAction(content, {content.transform.localPosition.x - 453, content.transform.localPosition.y, 0}, function()
		CSAPI.SetGOActive(starParent, false);
		-- CSAPI.SetGOActive(targetDesc,true);
		starClick.raycastTarget = true;
		-- end);
	end
end


--刷新达成条件
function RefreshStarInfo(data)
	if data then
		--刷新达成条件
		InitStarInfo(dungeonData:GetID());
		if data.type == DungeonStarType.MoveNum then
			local maxNum = dungeonData:GetActionNum();
			CSAPI.SetText(text_actionNum1, data.num .. "")
			CSAPI.SetText(text_actionNum2, "/" .. maxNum);			
			
			ApplyTurnWarning(data.num, maxNum);
			
			if data.num > maxNum then
				BattleMgr:SetInputState(false);
			end

			BattleMgr:UpdateMistViewDis();
		end
	end
end

function ApplyTurnWarning(turn, turnMax)
	if(not turn or not turnMax) then
		return;
	end
	
	local leftTurn = turnMax - turn;
	local isWarning, enterWarning = FightClient:IsWarningTurn(leftTurn);			
	
	if(isWarning) then			
		CSAPI.OpenView("TurnWarning", leftTurn);		
	end
end

--初始化关卡信息
function InitDungeonInfo()
	OnRedPointRefresh()
	-- local dungeonCfg=dungeonData:GetCfg();
	--初始化特殊条件
	-- InitStarInfo();
end

--初始化达成条件
function InitStarInfo()
	local dungeonCfg = dungeonData:GetCfg();
	if dungeonCfg.nGroupID ~= nil and dungeonCfg.nGroupID ~= "" then--直接进入战斗副本
		
	else
		local completeInfo = nil;
		if dungeonData and dungeonData.data then
			completeInfo = dungeonData:GetNGrade()
		end
		local starInfos = DungeonUtil.GetStarInfo(dungeonCfg.id, completeInfo, true);
		for k, v in ipairs(taskItems) do
			v.Init(starInfos[k].tips, starInfos[k].isComplete);
		end
	end
end

function PlayUIAction(isShow)
	-- local list={}
	-- if isShow==true then
	-- 	list={
	-- 		{go=topNormal,pos={0,0,0}},
	-- 		{go=bottom,pos={0,-245.58,0}},
	-- 		{go=topRight,pos={0,0,0}},
	-- 	}
	-- else
	-- 	list={
	-- 		{go=topNormal,pos={- 300, 0, 0}},
	-- 		{go=topInfo,pos={- 300, 0, 0}},
	-- 		{go=StarObj,pos={680, 0, 0}},
	-- 		{go=topRight,pos={500,0,0}},
	-- 		{go=bottom,pos={0, -400, 0}}
	-- 	}
	-- end
	-- UIUtil:PlayMoveList(list);
end

function PlayMoveAction(go, pos, callBack)
	CSAPI.csMoveTo(go, "UI_Local_Move", pos[1], pos[2], pos[3], callBack, 0.2);
end

local battleCtrlType = "battle_ctrl_type";
function InitCtrlType()
    --local currType = PlayerPrefs.GetInt(battleCtrlType) or 0;
    local currType = 0;--固定默认移动
    SetCtrlType(currType);
end
function OnClickCtrlType()
    local currType = PlayerPrefs.GetInt(battleCtrlType) or 0;
    currType = currType == 1 and 0 or 1;

    Tips.ShowTips(LanguageMgr:GetByID(currType == 1 and 15114 or 15115));

    SetCtrlType(currType);
end

function SetCtrlType(ctrlType)
    PlayerPrefs.SetInt(battleCtrlType,ctrlType);
    --CSAPI.SetText(txtCtrl,ctrlType == 1 and "旋转" or "移动");
    CSAPI.SetGOActive(moveImg,ctrlType ~= 1);
    CSAPI.SetGOActive(rotImg,ctrlType == 1);
    --LogError(ctrlType);
    if(battleGround) then
        --LogError("========");
		battleGround.SetCtrlState(ctrlType);
	end
end

--切换多个队伍进行操作
function OnClickChange()
	SetCurrTag(currTeamNO == 1 and 2 or 1);
	ChangeCtrlCharacter();
	-- if not leftFade then
	-- 	leftFade = ComUtil.GetCom(lb, "ActionFade")
	-- end
	-- if not leftCG then
	-- 	leftCG = ComUtil.GetCom(lb, "CanvasGroup")
	-- end
	-- if not leftMove then
	-- 	leftMove = ComUtil.GetCom(lb, "ActionMoveByCurve")
	-- end
	-- leftFade:Play(1, 0, 100, 0, function()
	-- 	leftCG.alpha = 1
	-- 	leftMove.startPos = UnityEngine.Vector3(lb.transform.localPosition.x + 400, 0, 0)
	-- 	leftMove.targetPos = UnityEngine.Vector3(lb.transform.localPosition.x, 0, 0)
	-- 	leftMove:Play(function()
	-- 		SetCurrTag(currTeamNO == 1 and 2 or 1);
	-- 		ChangeCtrlCharacter();
	-- 	end)
	-- end)	
end

function UpdateTag(character)
	if(character) then
		local teamNO = character.GetTeamNO();
		SetCurrTag(teamNO or 1);
	end
end

function SetCurrTag(index)
	currTeamNO = index;
	CSAPI.SetAnchor(teamImg, index == 1 and - 59 or 59, 5)
	-- local color1 = index == 1 and 0 or 255
	-- local color2 = index == 2 and 0 or 255
	-- CSAPI.SetTextColor(txtTeam1, color1, color1, color1, 255)
	-- CSAPI.SetTextColor(txtTeam2, color2, color2, color2, 255)
	-- CSAPI.SetImgColor(change1, 0, 0, 0, isOne and 255 or 55);
	-- CSAPI.SetImgColor(change2, 0, 0, 0, isOne and 55 or 255);
	-- CSAPI.SetTextColor(light1, 255, 255, 255, isOne and 255 or 88);
	-- CSAPI.SetTextColor(light2, 255, 255, 255, isOne and 88 or 255);
end

--返回玩家队伍信息
function GetPlayerTeam()
	local allCharacters = BattleCharacterMgr:GetAll();
	local ctrlList = {};
	--获取当前我方队员信息
	if(allCharacters) then
		for _, tmpCharacter in pairs(allCharacters) do
			if(tmpCharacter.data.type == eDungeonCharType.MyCard and tmpCharacter:IsDead() == false) then				
				table.insert(ctrlList, tmpCharacter);
			end
		end
	end
	return ctrlList;
end

function ChangeCtrlCharacter()
	local ctrlList = GetPlayerTeam();
	-- Log( "当前队伍："..tostring(#ctrlList));
	-- Log( ctrlList);
	if ctrlList then
		local charID = nil;
		local currCharacter = BattleMgr:GetCtrlCharacter();
		if(currCharacter) then
			charID = currCharacter.GetId();
			for k, v in ipairs(ctrlList) do
				if v ~= currCharacter and v.IsDead() == false then
					charID = v.GetId();
					break;
				end
			end
			-- Log( "当前操作ID："..tostring(charID));
			BattleMgr:SetMoveCtrlTarget(charID);
		end
	end
end

--展示剩余时间
function Update()
	if endTime and endTime > 0 then
		UpdateTimeStr();
	end
end

function UpdateTimeStr()
	endTime = endTime - Time.deltaTime;
	endTime = endTime <= 0 and 0 or endTime;
	if endTime == 0 then
		--退出副本
		DungeonMgr:SetDungeonOver(nil);
		FightOverTool.OnBattleViewLost();
		FriendMgr:ClearAssistData();
		TeamMgr:ClearFightTeamData();
		UIUtil:AddFightTeamState(2,"BattleView:UpdateTimeStr()")
	end
	CSAPI.SetText(text_timeVal, TimeUtil:GetTimeStr3(endTime));
end

--点击地图格子
function OnClickGround(id)
	local allCharacters = BattleCharacterMgr:GetAll();
	local currCharacter = nil;
	--获取当前格子上的物体信息
	if(allCharacters) then
		for _, tmpCharacter in pairs(allCharacters) do
			local gridId = tmpCharacter.GetCurrGridId();
			if(gridId == id) then				
				currCharacter = tmpCharacter;
				break;
			end
		end
	end
	if currCharacter and currCharacter.data.type == eDungeonCharType.MyCard and currCharacter.GetTeamNO() ~= nil and currCharacter.GetTeamNO() ~= currTeamNO then--判断是否需要切换
		SetCurrTag(currCharacter.GetTeamNO());
		ChangeCtrlCharacter();
		currCharacter = nil;
		lastClickCharacter = nil;
	end
end

--长按地图格子显示格子的信息
function ShowGridInfo(id)
	-- Log( "显示格子内容");
	local allCharacters = BattleCharacterMgr:GetAll();
	local currCharacter = nil;
	--获取当前格子上的物体信息
	if(allCharacters) then
		for _, tmpCharacter in pairs(allCharacters) do
			local gridId = tmpCharacter.GetCurrGridId();
			if(gridId == id) then				
				currCharacter = tmpCharacter;
				break;
			end
		end
	end
	if lastClickCharacter then
		lastClickCharacter.SetSelectState(false);
	end
	if currCharacter and currCharacter.data.type ~= eDungeonCharType.MyCard then
		CSAPI.SetGOActive(teamObj, currCharacter.data.type ~= eDungeonCharType.Prop);
		CSAPI.SetGOActive(goodObj, currCharacter.data.type == eDungeonCharType.Prop);
		if currCharacter.data.type == eDungeonCharType.Prop then
			--道具/BUFF
		elseif currCharacter.data.type == eDungeonCharType.MyCard then --己方队伍切换
			--判断当前角色属于哪个队伍
			if currCharacter.data and currCharacter.GetTeamNO() ~= nil and currCharacter.GetTeamNO() ~= currTeamNO then
				SetCurrTag(currCharacter.GetTeamNO());
				ChangeCtrlCharacter();
			end
			currCharacter = nil;
			lastClickCharacter = nil;
		else --敌方队伍或者NPC
			currCharacter.SetSelectState(true);
			lastClickCharacter = currCharacter;
			--设置移动范围
			BattleMgr:ShowCharacterMoveRange(currCharacter);
		end
	else
		lastClickCharacter = nil;
		currCharacter = nil;
	end
	--设置移动范围
	if lastClickCharacter == nil then
		BattleMgr:ShowCharacterMoveRange(lastClickCharacter);
		OnClickHide();
	end
	if currCharacter ~= nil then
		if enemyPopup == nil then
			local go = ResUtil:CreateUIGO("Battle/BattleEnemyInfo", transform);
			enemyPopup = ComUtil.GetLuaTable(go);
			enemyPopup.AddCloseCB(OnClickHide);	
		else
			CSAPI.SetGOActive(enemyPopup.gameObject, true);
		end
		CSAPI.AddUISceneElement(enemyPopup.gameObject, currCharacter.gameObject, BattleMgr:GetCamera());
		enemyPopup.Init(currCharacter);
	elseif enemyPopup then
		CSAPI.SetGOActive(enemyPopup.gameObject, false);
	end
end

function OnClickScene()
	--BattleMgr:CheckClickGridTime();
end

function OnClickHide()
	if isLock == false then
		local currChar = BattleMgr:GetCtrlCharacter();
		if currChar and currChar.IsFighting() == false then
			BattleMgr:ShowCharacterMoveRange(currChar);
		end
		if lastClickCharacter then
			lastClickCharacter.SetSelectState(false);
		end
	end
end

--战斗设置
function OnClickSetting()
	if(not DungeonMgr:CheckDungeonPass(1003)) then
		Tips.ShowTips("通关0-3后开启");
		return;
	end
	
	isSetting = true
	local currCharacter = BattleMgr:GetCtrlCharacter();
	CSAPI.SetGOActive(SettingObj, true)
	if setItem ~= nil then
		setItem.Refresh(currCharacter);
	else
		ResUtil:CreateUIGOAsync("BattleAISetting/BattleAISetting", SetParent, function(go)
			local lua = ComUtil.GetLuaTable(go)
			lua.Refresh(currCharacter);
			setItem = lua
		end)
	end
end

function OnRedPointRefresh()
	if dungeonData then
		local cfg = dungeonData:GetCfg()
		local isRed = false
		if cfg.type == eDuplicateType.Tower then
			isRed = CheckRed(eTaskType.TmpDupTower,cfg.missionID)
		elseif cfg.type == eDuplicateType.TaoFa then
			isRed = CheckRed(eTaskType.DupTaoFa,cfg.group)
		end
		SetRed(isRed)
	end
end

function CheckRed(_type, _group)
	local datas = MissionMgr:GetActivityDatas(_type, _group)
	if datas and #datas > 0 then
		for i, v in ipairs(datas) do
			if v:IsFinish() and not v:IsGet() then
				return true
			end
		end
	end
	return false
end

function SetRed(b)
	UIUtil:SetRedPoint2("Common/Red2", redParent, b, 0,0, 0)
end

function OnClickMission()
	if dungeonData then
		local cfg = dungeonData:GetCfg()
		if cfg then
			local _type = eTaskType.TmpDupTower
			local _group = cfg.missionID
			if cfg.type == eDuplicateType.TaoFa then
				_type = eTaskType.DupTaoFa
				_group = cfg.group
			end
			CSAPI.OpenView("MissionActivity", {
				type = _type,
				title = LanguageMgr:GetByID(6018, cfg.name),
				group = _group
			})
		end
	end
end


-------------------------------------------寻路AIUI------------------------------
function OnAISetRet(proto)
	if proto and proto.ret==true then
		--更新战斗中的对应队伍数据
		local currCharacter = BattleCharacterMgr:GetCharacter(proto.oid);
		if currCharacter==nil then
			LogError("未找到对应角色(oid):"..tostring(proto.oid))
			return;
		end
		local ctrlData = currCharacter:GetData();
		--刷新战斗中队伍的缓存
		local fTeamData=TeamMgr:GetFightTeamData(ctrlData.nTeamID);
		if fTeamData then
			fTeamData:SetReserveNP(proto.nReserveNP);
			fTeamData:SetIsReserveSP(proto.bIsReserveSP);
			TeamMgr:AddFightTeamData(fTeamData);
		end
		--刷新队伍的缓存
		local teamData=TeamMgr:GetFightTeamData(ctrlData.nTeamID);
		if teamData then
			teamData:SetReserveNP(proto.nReserveNP);
			teamData:SetIsReserveSP(proto.bIsReserveSP);
			TeamMgr:SaveDataByIndex(ctrlData.nTeamID,teamData);
		end
	end
end

---返回虚拟键公共接口  函数名一样，调用该页面的关闭接口
function OnClickVirtualkeysClose()
	---填写退出代码逻辑/接口
	if  top.OnClickBack then
		top.OnClickBack();
	end
end


--[[
function InitAIMove()
	--自动寻路
	if dungeonData then
		local starNum = dungeonData:GetStar()
		if starNum >= 3 then
			isCanAIMove = true
			isAIMove = BattleMgr:GetAIMoveState()
		else
			isCanAIMove = false
			isAIMove = false
			BattleMgr:SetAIMoveState(false)
		end
		SetAIMoveBtnState(isAIMove)
	end
end

function OnAIMoveState(isOpen)
	if not isCanAIMove then
		return
	end
	isAIMove = not isOpen	
	OnClickAIMove()
end

function OnClickAIMove()
	if not isCanAIMove then
		LanguageMgr:ShowTips(8003)
		return
	end
	isAIMove = not isAIMove
	CSAPI.SetGOActive(aiMask, isAIMove)
	SetAIMoveBtnState(isAIMove)
	BattleMgr:SetAIMoveState(isAIMove)
	if dungeonData and isCanAIMove then
		SaveAIMoveSetting(dungeonData:GetID(), isAIMove)
	end	
end

function OnClickAIMask()
	if isAIMove then
		OnClickAIMove()
		LanguageMgr:ShowTips(8008)
	end
end

function SetAIMoveBtnState(b)
	local posX = b and 23 or - 23
	CSAPI.SetAnchor(aiImg, posX, 0)
	local color = b and {59, 46, 20} or {255, 255, 255}
	CSAPI.SetImgColor(aiImg.gameObject, color[1], color[2], color[3], 255)
	local iconName = b and "sel" or "nol"
	CSAPI.LoadImg(btnAI, "UIs/Battle/" .. iconName .. ".png", false, nil, true)
	
	CSAPI.SetGOActive(top.btn_exit, not b)
	CSAPI.SetGOActive(btn_auto, not b)
	
	local ctrlList = GetPlayerTeam();
	if #ctrlList > 1 then
		CSAPI.SetGOActive(btnChange, not b)
	end
end

function SaveAIMoveSetting(_id, _isOpen)
	local aiDatas = LoadAIMoveSetting()
	aiDatas[_id] = _isOpen
	FileUtil.SaveToFile("AIMoveState.txt", aiDatas)	
end

function LoadAIMoveSetting()
	local aiDatas = FileUtil.LoadByPath("AIMoveState.txt")
	return aiDatas and aiDatas or {}
end

--]]
----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()	
	gameObject = nil;
	transform = nil;
	this = nil;
	bg = nil;
	bgMask = nil;
	infos = nil;
	node = nil;
	StarObj = nil;
	txt_star = nil;
	starParent = nil;
	leftObj = nil;
	timeObj = nil;
	text_time = nil;
	text_timeVal = nil;
	btn_quip = nil;
	txt_quip = nil;
	btn_auto = nil;
	txt_auto = nil;
	aiMoveObj = nil;
	txt_aiMove = nil;
	btnAI = nil;
	aiImg = nil;
	headNode = nil;
	costObj = nil;
	txtCost = nil;
	tipsObj = nil;
	text_action = nil;
	text_actionNum1 = nil;
	text_actionNum2 = nil;
	questionParent = nil;
	titleObj = nil;
	txtTitle1 = nil;
	txtTitle2 = nil;
	txtRound = nil;
	right = nil;
	lb = nil;
	rightImg = nil;
	bottomGrid = nil;
	btnChange = nil;
	teamImg = nil;
	txtTeam1 = nil;
	txtTeam2 = nil;
	SettingObj = nil;
	SetParent = nil;
	scaleSlider = nil;
	roundObj = nil;
	rAnims = nil;
	rAnims = nil;
	enter = nil;
	exit = nil;
	buffObj = nil;
	mask = nil;
	black = nil;
	blackAction = nil;
	enterAction = nil;
	rightMove = nil;
	view = nil;
end
----#End#----
