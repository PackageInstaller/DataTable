--阵型调整视图
local gridList = nil;--格子预制物列表，字典型[列-行]=GameObject，用于确定卡牌的位置
local cardList = nil;--卡牌列表，字典型[cid]=CardDragView
-- local formatTab = nil;--占位信息列表，记录了每个格子当前的占位情况，字典型，[列-行]=CardData;
local eventMgr = nil;
local pivotList = nil;--中心点集合
local offsetList = nil;--偏移坐标集合
local currentDragData = nil;--当前拖拽的卡牌数据
local targetKey = nil;
local teamData=nil;
local dragList=nil;--卡牌位置变更的记录
local fID=nil;
local forceCall=nil;--限制位置移动成功的回调
local forceCaller=nil;
local forceTab=nil;
local isDrop=false;
local canDragLeave=true;--是否可以拖拽下阵
local isLoadOver=false;
local isDrag=true;
function Awake()
	ResUtil:LoadBigImg(img2, "UIs/BGs/bg_9/bg", false, function()
		CSAPI.SetScale(img2, 1, 1, 1)
	end)
	local goRT = CSAPI.GetGlobalGO("CommonRT")
    CSAPI.SetRenderTexture(goModelRaw,goRT);
	CSAPI.SetCameraRenderTarget(modelRoot,goRT);
	gridList = {};
	local grids = ComUtil.GetComsInChildren(gridObj, "XLuaMono", false);
	for i = 0, grids.Length - 1 do
		gridList[grids[i].name] = ComUtil.GetLuaTable(grids[i].gameObject);
	end
end

function OnEnable()
	if ViewModelMgr:GetCurrModelCreater()~= this then
		ViewModelMgr:SetModelCreater(this);
	end
	InitListener();
end

function CreateModel(modelId,followTarget,delay)   
    local go = CSAPI.CreateGO("ModelNode",0,0,0,modelNode);
    local lua = ComUtil.GetLuaTable(go);
    lua.Set(followTarget,UIUtil:GetUICameraGO(),modelRoot);
	lua.LoadModel(modelId,delay);
	-- go.name=tostring(modelNode.transform.childCount);
    return lua;
end
function ShowModelState(state)
    CSAPI.SetGOActive(goModelRaw,state);
end

function InitListener()
	if eventMgr then
		eventMgr:ClearListener();
	else
		eventMgr = ViewEvent.New();
	end
	eventMgr:AddListener(EventType.Drop_Card_Item, OnDropCard);
	eventMgr:AddListener(EventType.Drag_Card_Begin, OnDragBegin);
	eventMgr:AddListener(EventType.Drag_Card_End, OnDragEnd);
	eventMgr:AddListener(EventType.Drag_Card_Holding, OnDragCard);
	eventMgr:AddListener(EventType.Team_FormationView_Select,OnClickFGrid);    
	
end

function OnDisable()
	eventMgr:ClearListener();
	ViewModelMgr:RemoveModelCreater(this);
	CleanCache();
end

function ClearClickID()
	clickID=nil;
end

function CleanAll()
	formatTab=FormationTable.New(3, 3);
	ClearClickID();
	RefreshGrids();
	if cardList then
		for _, v in pairs(cardList) do
			v.Close();
		end
		cardList = nil;
	end
	for _,v in pairs(gridList) do
		v.Clear();
	end
end

function CleanCache()
	targetKey = nil;
	-- currentDragData = nil;
	CleanCard();
end

function CleanCard()
	if clickID then
		ClearClickID();
		-- ShowHaloAdd(false);
		RefreshGrids();
	end
	if cardList then
		for _, v in pairs(cardList) do
			v.Close();
		end
		cardList = nil;
	end
	for _,v in pairs(gridList) do
		v.Clear();
	end
end

function OnDestroy()
	gridList = nil;
	cardList = nil;
	formatTab = nil;
	eventMgr = nil;
	pivotList = nil;
	currentDragData = nil;
	targetKey = nil;
	offsetList = nil;
end

function SetActive(isActive)
	CSAPI.SetGOActive(gameObject,isActive);
end

--设置是否显示光环
function SetHaloEnable(isEnable)
	this.enableHalo=isEnable or false;
end

--限定某张卡牌只能挪到某个位置,成功后返回回调
function SetForceMove(_forceTab,callBack,caller)
	forceTab=_forceTab;
	forceCall=callBack;
    forceCaller = caller;
	if formatTab then
		formatTab:SetForceTab(forceTab);
        if(gridList)then
		    if forceTab then --除了forceTab指定的卡牌外其他卡牌无法移动
			    for k,v in pairs(gridList) do
				    v.SetClickActive(false);
			    end
			    for k,v in ipairs(forceTab) do
				    gridList[v.row.."-"..v.col].SetClickActive(true);
			    end
            else
		        for k,v in pairs(gridList) do
			        v.SetClickActive(true);
		        end
		    end        
        end
	end
end

function SetDragLeave(_canDragLeave)
	canDragLeave=_canDragLeave;
end

--初始化阵型 生成卡牌放到对应位置上,showDamageFunc:显示死亡信息的方法,_canDragLeave:是否可以拖拽下阵
function Init(data,_canDragLeave,showDamageFunc)    
	CleanCache();
	dragList=nil;
	canDragLeave=_canDragLeave;
	cardList = cardList or {};
	formatTab = FormationTable.New(3, 3);
	formatTab:SetForceTab(forceTab);
	if data ~= nil then
		--缓存一个数据
		teamData=data;
		--读取图片
		if TeamMgr:IsTeamType(DungeonFight,teamData:GetIndex()) then
			ResUtil.TeamIcon:Load(img,teamData:GetIndex().."",true);
			CSAPI.SetGOActive(img,true);
		else
			CSAPI.SetGOActive(img,false);
		end
		--记录所有的占位信息
		for k, v in pairs(teamData.data) do
			formatTab:AddCardPosInfo(v);
		end
		for k, v in pairs(teamData.data) do           
			local key = v.row .. "-" .. v.col;
			local go = ResUtil:CreateUIGO("Formation/CardDragView", gridList[key].transform);
			local fitState = formatTab:IsUnite(v);
			cardList[v.cid] = ComUtil.GetLuaTable(go);
			local isAssist=v.fuid~=nil;
			cardList[v.cid].InitData(v,isAssist,fitState,isMirror);
			if showDamageFunc then --显示死亡信息
				showDamageFunc(cardList[v.cid],v.cid);
			end
			-- if hideHot then--隐藏热值信息
			-- 	cardList[v.cid].SetOverHead(false);
			-- end
			local pos = GetOffset(v);
			CSAPI.SetLocalPos(go, pos.x, pos.y, pos.z);
			--设置拖拽子物体
			local posData=formatTab:GetCardRealCoord(v.cid);
			for key,val in ipairs(posData) do
				gridList[val.row.."-"..val.col].SetDragChild(cardList[v.cid]);
			end
		end
		if(gridList)then
		    if forceTab then --除了forceTab指定的卡牌外其他卡牌无法移动
			    for k,v in pairs(gridList) do
				    v.SetClickActive(false);
			    end
			    for k,v in ipairs(forceTab) do
				    gridList[v.row.."-"..v.col].SetClickActive(true);
			    end
            else
		        for k,v in pairs(gridList) do
			        v.SetClickActive(true);
		        end
		    end        
        end
		RefreshGrids();
	end
end

--刷新格子颜色
function RefreshGrids()
	local list=GetGridsState();
	local tab={};
	for k,v in pairs(list) do
		table.insert(tab,v);
	end
	SetNumObjColor(tab)
	DispatchRefresh(tab)
end

--返回格子的状态，row,col:当前拖拽物体的预览位置，不传默认为当前点击的物体的位置
function GetGridsState(row,col)
	local posInfo={};
	for k,v in pairs(gridList) do
		strs = StringUtil:split(k, "-");
		if strs and #strs>0 and formatTab then
			-- Log( item);
			local item=formatTab:GetPosData(tonumber(strs[1]),tonumber(strs[2]));
			if item~=nil then
				local type=2;
				if clickID and item.cid~=clickID and this.enableHalo then
					type=4;
				elseif clickID and item.cid==clickID then
					type=7;
				-- elseif currentDragData~=nil and item.cid==currentDragData.cid then
				-- 	type=1;
				end
				posInfo[k]={key=k,type=type}
			else
				posInfo[k]={key=k,type=1}
			end
		else
			posInfo[k]={key=k,type=1}
		end
	end
	if clickID and this.enableHalo then
		local posInfo2=	GetHaloRange(row,col);
		for k,v in pairs(posInfo2) do
			posInfo[k]=v;
		end
	end
	return posInfo;
end

--返回当前光环的占位信息
function GetHaloRange(_row,_col)
	local posInfo={};
	if clickID and formatTab then
		local item=teamData:GetItem(clickID);
		_row=_row or item.row;
		_col=_col or item.col;
		local haloCfg=Cfgs.cfgHalo:GetByID(item:GetCfgID());
		if haloCfg then
			local node=haloCfg.coordinate[1];
			for i=2,#haloCfg.coordinate do
				--取得受光环影响的相对位置
				local row=haloCfg.coordinate[i][1]-node[1]+_row;
				local col=haloCfg.coordinate[i][2]-node[2]+_col;
				--判断光环位置是否生效
				if row>0 and col>0 and row<=formatTab.maxX and col<=formatTab.maxY and (row~=_row or col~=_col) then
					--未越界的位置,且不是当前位置，读取其中的卡牌信息
					local tempItem=formatTab:GetPosData(row,col);
					if tempItem and tempItem.cid~=clickID  then
						for k,v in ipairs(formatTab:GetCardRealCoord(tempItem.cid)) do
							local key=v.row.."-"..v.col;
							posInfo[key]={key=key,type=3};
						end
					else
						local key=row.."-"..col;
						posInfo[key]={key=key,type=3};
					end
				end
			end
			-- Log( haloCfg.name.."的光环范围信息：");
			-- Log( posInfo);
		else
			-- Log( "该角色暂无光环");
		end
	end
	return posInfo;
end

function DispatchRefresh(tab)
	EventMgr.Dispatch(EventType.Team_Grid_RefreshColor,tab);
end

function SetNumObjColor(tab)
	if tab then
		for k,v in ipairs(tab) do
			local color=FormationUtil.GetHaloNumColor(v.type);
			CSAPI.SetImgColor(this["num"..v.key],color[1],color[2],color[3],color[4])
		end
	end
end

--拖拽完成
function OnDropCard(key)
	--获取当前拖拽的卡牌的LUAtable
	-- Log( "current:" .. tostring(currentDragData == nil));
	if targetKey ~= nil then
		key = targetKey;
	end
	local strs = StringUtil:split(key, "-");
	local row = tonumber(strs[1]);
	local col = tonumber(strs[2]);
	--获取当前放置到的grid的占位信息
	local canMove,tempTab=formatTab:CanMove(currentDragData.cid,row,col);
	if canMove==true then
		--同步ui
		for _, v in ipairs(tempTab:GetArray()) do
			cardList[v.cid].SetParent(gridList[v.row .. "-" .. v.col].gameObject, GetOffset(v))
			--设置合体物
			local fitState = tempTab:IsUnite(v);
			cardList[v.cid].SetFitObj(fitState);
		end
		--记录变更位置的卡牌信息
		isChange=true;
		dragList=dragList or {};
		for x=1,formatTab.maxX do
			for y=1,formatTab.maxY do
				local item1=formatTab:GetPosData(x,y);
				local item2=tempTab:GetPosData(x,y);
				if (item1 and item2==nil) or (item1 and item2 and item1.cid~=item2.cid and dragList[item1.cid]==nil) then
					dragList[item1.cid]=tempTab:GetPosDataByCid(item1.cid);
				end
				if item2==nil then--刷新拖拽物的子对象
					gridList[x.."-"..y].SetDragChild(nil);
				else
					gridList[x.."-"..y].SetDragChild(cardList[item2.cid]);
				end
			end
		end
		-- tempTab:Log();
		formatTab=tempTab;
		if forceTab and forceCall then 
			local hasForce=false;
			for k,v in ipairs(forceTab) do
				if v.cfgId==currentDragData:GetCfgID() then
					hasForce=true;
					break;
				end
			end
			if hasForce then
				forceCall(forceCaller);
			end
		end
	else
		local item = cardList[currentDragData.cid];
		--复位
		item.SetParent(gridList[currentDragData.row .. "-" .. currentDragData.col].gameObject, GetOffset(currentDragData));
	end
	--更新队伍数据中的占位信息
	teamData:UpdateDataByArray(formatTab:GetArray());
	EventMgr.Dispatch(EventType.Team_Item_Change);
end

--开始拖拽
function OnDragBegin(data)
	isDrop=false
	isDrag=true;
	if data==nil then
		return;
	end
	-- if currentDragData~=nil then --已经有在拖拽的物体时将该物体归还原位
	-- 	local item = cardList[currentDragData.cid];
	-- 	item.SetParent(data.oldParent, GetOffset(currentDragData));
	-- end
	currentDragData = formatTab:GetPosDataByCid(data.cid);
	EventMgr.Dispatch(EventType.Team_FormationView_Select,{cid=data.cid,isDrag=true})
	EventMgr.Dispatch(EventType.Team_Item_Change);
	-- clickID=data.cid;
end

--拖拽卡牌中
function OnDragCard(pos)
	--根据当前世界坐标计算离卡牌最近的格子坐标
	if currentDragData==nil then
		return
	end
	local grids=currentDragData:GetGrids();
	local pivots = GetPivot(grids);
	local list = {dis=20};
	local distance = 0;
	for k, v in pairs(pivots) do
		distance = UnityEngine.Vector3.Distance(pos, v.pivot);
		if distance<=list.dis and distance<=20 then
			list.row=v.targetPos.row;
			list.col=v.targetPos.col;
			list.dis=distance;
			list.pos=v.pivot;
		end
	end
	-- local posList={};	
	local strs=nil;
	--获取新的卡牌位置
	local posList=GetGridsState(list.row,list.col);
	if list.row and list.col then
		targetKey = list.row .. "-" .. list.col;
		--预览选择
		-- Log( targetKey);
		--判断该位置可不可以用，不能用的话把占位格子的颜色设置为红色，可以用的话设置为暗绿色
		local canMove,tempTab=formatTab:CanMove(currentDragData.cid,list.row,list.col);
		local item2=tempTab:GetPosDataByCid(currentDragData.cid);
		local coord=FormationUtil.GetPlaceHolderInfo(grids);
		local type=2;
		if not canMove then
			type=6;
		end
		for k,v in ipairs(coord) do
			local r = list.row + v[1] - 1;
			local c = list.col + v[2] - 1;
			posList[r.."-"..c]={key=r.."-"..c,type=type}
		end
		-- ShowHaloAdd(true,list.row,list.col);
	else
		targetKey = nil;
		-- ShowHaloAdd(false);
	end
	local tab={};
	for k,v in pairs(posList) do
		table.insert(tab,v);
	end
	SetNumObjColor(tab)
	DispatchRefresh(tab)
end

--拖拽完成
function OnDragEnd(oldParent)
	isDrag=false;
	if currentDragData==nil then
		return;
	end
	local cardData = currentDragData;
	local item = cardList[cardData.cid];
	--判断拖拽是否有效
	if isDrop or (targetKey and targetKey==oldParent.name) or (canDragLeave~=true and item.view.myParent.gameObject == gridObj) then
		--返回原位
		item.SetParent(oldParent, GetOffset(cardData));
	elseif item.view.myParent.gameObject == gridObj and canDragLeave==true then
		--返回原位
		item.SetParent(oldParent, GetOffset(cardData));
		if targetKey==nil then
			--提示是否下阵
			EventMgr.Dispatch(EventType.Team_Select_Leave,cardData);
		end
	end
	currentDragData=nil;
	-- clickID=nil;
	RefreshGrids();
end

--放置
function OnDrop()
	isDrop=true;
	isDrag=false;
end

--点击了阵型格子
function OnClickFGrid(eventData)
	if isDrag then
		return;
	end
	if eventData then
		if fID and cardList[fID] then
			local item2=cardList[fID];
			item2.ShowArrow(false);
		end
		local item=cardList[eventData.cid];
		if item and (eventData.cid~=clickID or eventData.isDrag) then
			item.ShowArrow(true);
			fID=eventData.cid;
			clickID=eventData.cid;
		else
			clickID=nil;
			fID=nil;
		end
		RefreshGrids();
	end
end

--返回中心点集合 世界坐标
function GetPivot(grids)
	pivotList = pivotList or {};
	local formationType = FormationUtil.GetFormationType(grids);
	if pivotList[formationType] == nil then
		local tab = {};
		--获取初始坐标
		local coord=FormationUtil.GetPlaceHolderInfo(grids);
		--遍历所有可以放置的点
		for _, v in ipairs(FormationUtil.GetCardCanMovePos(formationType)) do
			local count = UnityEngine.Vector3.zero;
			for index, val in ipairs(coord) do
				local row = v[1] + val[1] - 1;
				local col = v[2] + val[2] - 1;	
				local key = row .. "-" .. col;
				if gridList[key] ~= nil then
					if index == 1 then
						origin = gridList[key].transform.position;
					end
					count = count + gridList[key].transform.position;
				end
			end
			local pivot = count / #coord;
			local targetPos = {row = v[1], col = v[2]}
			-- Log( "中心点："..tostring(pivot).."\t 目标坐标:"..v[1]..","..v[2]);
			table.insert(tab, {pivot = pivot, targetPos = targetPos})
		end
		pivotList[formationType] = tab;
	end
	return pivotList[formationType];
end

--根据横列获取卡牌的偏移值，相对右上角格子的坐标
function GetOffset(teamItemData)
	offsetList = offsetList or {};
	local pos = UnityEngine.Vector3.zero;
	local grids=teamItemData:GetGrids();
	local formationType = FormationUtil.GetFormationType(grids);
	if offsetList[formationType] == nil then
		local tab = {};
		--获取初始坐标
		local coord = FormationUtil.GetPlaceHolderInfo(grids);
		--遍历所有可以放置的点
		for _, v in ipairs(FormationUtil.GetCardCanMovePos(formationType)) do
			local count = UnityEngine.Vector3.zero;
			local origin = nil;
			for index, val in ipairs(coord) do
				local row = v[1] + val[1] - 1;
				local col = v[2] + val[2] - 1;	
				local key = row .. "-" .. col;
				if gridList[key] ~= nil then
					if index == 1 then
						origin = gridList[key].transform;
					end
					count = count + gridList[key].transform.position;
					-- Log( key.."\t :".. tostring(gridList[key].transform.position));
				end
			end
			local pivot = origin:InverseTransformPoint(count / #coord);
			local targetPos = {row = v[1], col = v[2]}
			-- Log( "中心点："..tostring(pivot).."\t 目标坐标:"..v[1]..","..v[2]);
			table.insert(tab, {pivot = pivot, targetPos = targetPos})
			if v[1] == teamItemData.row and v[2] == teamItemData.col then
				pos = pivot;
			end
		end
		offsetList[formationType] = tab;
	else
		for _, val in ipairs(offsetList[formationType]) do
			if val.targetPos.row == teamItemData.row and val.targetPos.col == teamItemData.col then
				pos = val.pivot;
			end
		end
	end
	return pos;
end 

--返回拖拽的队列数据
function GetDragList()
	return dragList;
end

function GetIsChange()
	return dragList~=nil;
end

--设置显示大小
function SetScale(_scale)
	CSAPI.SetScale(gridRoot,_scale,_scale,_scale);
	-- CSAPI.SetScale(gridObj,_scale,_scale,_scale);
	-- CSAPI.SetLocalPos(numObj,_scale,_scale,_scale);
	CSAPI.SetScale(modelNode,_scale,_scale,_scale);
end

--设置位置
function SetLocalPos(x,y)
	local _x=x/100;
	local _y=y/100;
	CSAPI.SetLocalPos(gridRoot,x,y,0);
	CSAPI.SetLocalPos(modelNode,_x,_y,10);
	-- CSAPI.SetLocalPos(gridObj,x,y,0);
	-- CSAPI.SetLocalPos(numObj,x,y,0);
	CSAPI.SetLocalPos(haloObj,x,y-145,0);
	CSAPI.SetLocalPos(img,x+-313.66,y+150.74,0);
end

-----------------------演习-------------------------------------------------
function SetMirror()
    local newGridList = {}
	for k,v in pairs(gridList) do
		--禁用拖拽检测
		local _drop = ComUtil.GetCom(v, "DropCallLua")
		_drop.enabled = false
		--格子翻转
		local klist = StringUtil:split(k,"-")
		local n =-tonumber(klist[2])+4
		newGridList[n.."-"..klist[1]] = v  
	end
	gridList = newGridList
   
	--禁用拖拽
	eventMgr:ClearListener();

	--模型翻转
	isMirror = true
end
