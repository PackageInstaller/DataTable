--阵型调整视图2D
local gridList = nil;--格子预制物列表，字典型[列-行]=GameObject，用于确定卡牌的位置
local cardList = nil;--卡牌列表，字典型[cid]=CardDragView
local eventMgr = nil;
local pivotList = nil;--中心点集合
local offsetList = nil;--偏移坐标集合
local currentDragData = nil;--当前拖拽的卡牌数据
local targetKey = nil;
local teamData=nil;
local dragList=nil;--卡牌位置变更的记录
local isMini=false;
local fID=nil;
local forceCall=nil;--限制位置移动成功的回调
local forceTab=nil;
local forceCaller=nil;
local canDragLeave=true;
local isDrop=false;
local yOffset=-35;--infoView的Y轴偏移值
local isLock=false;
local isDraging=false;
local addtiveState=false;
local joinModel=nil;
local infoNode=nil;--信息窗口挂载点
local isShowInfos=false;--是否显示hp/sp
function Awake()
	ResUtil:CreateUIGOAsync("Formation/CardDragView2D",MoveNode,function(go)
		joinModel=ComUtil.GetLuaTable(go);
		CSAPI.SetGOActive(go,false);
	end);
	gridList = {};
	local grids = ComUtil.GetComsInChildren(gridObj, "XLuaMono", false);
	for i = 0, grids.Length - 1 do
		gridList[grids[i].name] = ComUtil.GetLuaTable(grids[i].gameObject);
	end
end

-- function OnEnable()
-- 	InitListener();
-- end

-- function InitListener()
-- 	eventMgr = ViewEvent.New();
-- 	-- eventMgr:AddListener(EventType.Drop_Card_Item, OnDropCard);
-- 	eventMgr:AddListener(EventType.Drag_Card_Begin, OnDragBegin);
-- 	eventMgr:AddListener(EventType.Drag_Card_End, OnDragEnd);
-- 	eventMgr:AddListener(EventType.Drag_Card_Holding, OnDragCard);
-- 	eventMgr:AddListener(EventType.Team_FormationView_Select,OnClickFGrid);
-- 	eventMgr:AddListener(EventType.Team_Join_DragBegin,OnJoinDragBegin);
-- 	eventMgr:AddListener(EventType.Team_Join_DragEnd,OnJoinDragEnd);
-- 	eventMgr:AddListener(EventType.Team_FormationInfo_Click,OnClickInfoOption);
-- 	eventMgr:AddListener(EventType.Team_Join_Drag,OnJoinDrag);
-- 	eventMgr:AddListener(EventType.TeamView_AddtiveState_Change,SetAddtiveState);
-- end

function OnDisable()
	--eventMgr:ClearListener();
	CleanCache();
end

function ClearClickID()
	clickID=nil;
end

function CleanAll()
	formatTab=FormationTable.New(3, 3);
	ClearClickID()
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
	CleanCard();
end

function CleanCard()
	if clickID then
		ClearClickID()
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
	if infoView then
		CSAPI.RemoveGO(infoView.gameObject);
	end
	gridList = nil;
	cardList = nil;
	formatTab = nil;
	eventMgr = nil;
	pivotList = nil;
	currentDragData = nil;
	targetKey = nil;
	offsetList = nil;
	ReleaseCSComRefs();
end

function SetAddtiveState(state)
	addtiveState=state;
	SetHaloAttrState(addtiveState);
end

function SetHaloAttrState(isShow)
	if cardList then
		for k,v in ipairs(teamData.data) do
			if isShow then
				local gets=FormationUtil.CountHaloGet(teamData,v); --受到的光环加成
				cardList[v:GetID()].CreateHaloAtts(gets);
			else
				cardList[v:GetID()].HideHaloAtts();
			end
		end
	end
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

--初始化阵型 生成卡牌放到对应位置上
function Init(data,_canDragLeave,_playTween,_clickID,_addtiveState,_infoNode,_isShowInfos)    
	SetParentSibling(0);
	CleanCache();
	CloseInfoView();
	dragList=nil;
	cardList = cardList or {};
	canDragLeave=_canDragLeave;
	addtiveState=_addtiveState;
	isMini=false;
	infoNode=_infoNode;
	isShowInfos=_isShowInfos;
	formatTab = FormationTable.New(3, 3);
	formatTab:SetForceTab(forceTab);
	if data ~= nil then
		--缓存一个数据
		teamData=data;
		--记录所有的占位信息
		for k, v in pairs(teamData.data) do
			formatTab:AddCardPosInfo(v);
		end
		for k, v in pairs(teamData.data) do           
			local key = v.row .. "-" .. v.col;
			local go = ResUtil:CreateUIGO("Formation/CardDragView2D", gridList[key].transform);
			cardList[v.cid] = ComUtil.GetLuaTable(go);
			local isLeader=teamData:IsLeader(v.cid);
			cardList[v.cid].SetTween(_playTween);
			cardList[v.cid].InitData(v,isLeader,isMini,isMirror,isShowInfos);
			-- local coord = FormationUtil.GetPlaceHolderInfo(v:GetGrids());
			-- cardList[v.cid].SetGridImg(v.row,v.col,coord);
			if not isMini then
				if addtiveState then
					local gets=FormationUtil.CountHaloGet(teamData,v); --受到的光环加成
					cardList[v:GetID()].CreateHaloAtts(gets);
				else
					cardList[v:GetID()].HideHaloAtts();
				end
			end
			local pos = GetOffset(v);
			CSAPI.SetLocalPos(go, pos.x, pos.y, pos.z);
			--设置拖拽子物体
			local posData=formatTab:GetCardRealCoord(v.cid);
			for key,val in ipairs(posData) do
				gridList[val.row.."-"..val.col].SetDragChild(cardList[v.cid]);
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
		end
		if _clickID then
			SetClickState(_clickID);
		else
			RefreshGrids();
		end
	end
end

--刷新格子颜色
function RefreshGrids()
	local list=GetGridsState();
	local tab={};
	for k,v in pairs(list) do
		table.insert(tab,v);
	end
	ApplyGridsColor(tab)
end

--返回格子的状态，row,col:当前拖拽物体的预览位置，不传默认为当前点击的物体的位置，为-1时返回默认格子状态
function GetGridsState(row,col)
	local posInfo={};
	local isOut=false;
	if row and col and (row<0 or col<0) then
		isOut=true;
	end
	for k,v in pairs(gridList) do
		strs = StringUtil:split(k, "-");
		local key=string.format("I%s_%s",strs[1],strs[2]);
		if strs and #strs>0 and formatTab then
			local item=formatTab:GetPosData(tonumber(strs[1]),tonumber(strs[2]));
			if item~=nil then
				local type=2;
				if clickID and item.cid~=clickID and this.enableHalo then
					type=4;
					-- Log( item.row .."\t"..item.col);
				elseif clickID and item.cid==clickID then
					type=7;
				elseif currentDragData~=nil and item.cid==currentDragData.cid then
					type=1;
				end
				
				posInfo[k]={key=key,realKey=k,type=type}
			else
				posInfo[k]={key=key,realKey=k,type=1}
			end
		else
			posInfo[k]={key=key,realKey=k,type=1}
		end
	end
	if not isOut then
		if row and col and formatTab and currentDragData then --判断是否能移动
			local canMove=false;
			if joinModel~=nil and joinModel.gameObject.activeSelf==true then
				currentDragData.row=row;
				currentDragData.col=col;
				-- local itemData=formatTab:GetPosData(row,col);
				-- if itemData then
				-- 	currentDragData.index=itemData.index
				-- else
				-- 	currentDragData.index=nil;
				-- end
				local isSuccess,isReplace=formatTab:PushCardByPos(currentDragData,true,true);
				local maxNum =g_TeamMemberMaxNum;
				if currentDragData.fuid~=nil or currentDragData.bIsNpc==true  then
					maxNum=g_TeamMemberMaxNum+1;
				end
				--获取当前相同的卡牌
				local eqItem=formatTab:GetPosDataByRoleTag(currentDragData:GetRoleTag());
				if isSuccess~=true or (isSuccess and teamData:GetRealCount()>=maxNum and isReplace==false) or ( eqItem and (eqItem.col~=col or eqItem.row~=row)) then
					canMove=false;
				else
					canMove=true;
				end
			else
				canMove=formatTab:CanMove(currentDragData.cid,row,col);
			end
			local coord=currentDragData:GetHolderInfo();
			for k,v in ipairs(coord) do
				local r = row + v[1] - 1;
				local c = col + v[2] - 1;
				if r<=formatTab.maxX and c<=formatTab.maxY then
					--未越界的位置,且不是当前位置，读取其中的卡牌信息
					local tempItem=formatTab:GetPosData(r,c);
					if tempItem and tempItem.cid~=clickID  then
						for _,v2 in ipairs(formatTab:GetCardRealCoord(tempItem.cid)) do
							-- posInfo[tempItem.cid]={id=tempItem.cid,type=3};
							local key=string.format("I%s_%s",v2.row,v2.col);
							local realKey=v2.row.."-"..v2.col;
							posInfo[realKey]={key=key,realKey=realKey,type=canMove==true and 5 or 6};
						end
					-- else
					-- 	local key=row.."-"..col;
					-- 	posInfo[key]={key=key,type=3};
					else
						local key=string.format("I%s_%s",r,c);
						local realKey=r.."-"..c;
						posInfo[realKey]={key=key,realKey=realKey,type=canMove==true and 5 or 6}
					end
				end
			end
		end
		-- Log("PosInfo1--------------------------------------"..tostring(row).."\t"..tostring(col))
		-- for k,v in pairs(posInfo) do
		-- 	Log("k:"..k.."\t"..v.key.."\t"..v.realKey.."\t"..v.type);
		-- end
		-- Log("PosInfo2--------------------------------------"..tostring(row).."\t"..tostring(col))
		if clickID and this.enableHalo then
			local posInfo2=	GetHaloRange(row,col);
			for k,v in pairs(posInfo2) do
				-- Log("k:"..k.."\t"..v.key.."\t"..v.realKey.."\t"..posInfo[k].type);
				if posInfo[k] and posInfo[k].type~=6 and posInfo[k].type~=5 then --不是禁止占用则被光环状态覆盖
					posInfo[k]=v;
				end
			end
		end
	end
	return posInfo;
	-- local posInfo={};
	-- for k,v in ipairs(teamData.data) do
	-- 	local type=2;
	-- 	if this.enableHalo and clickID and v.cid~=clickID then
	-- 		type=4
	-- 	end
	-- 	posInfo[v.cid]={id=v.cid,type=type};
	-- end
	-- if clickID and this.enableHalo then
	-- 	local posInfo2=	GetHaloRange(row,col);
	-- 	for k,v in pairs(posInfo2) do
	-- 		posInfo[k]=v;
	-- 	end
	-- end
	-- return posInfo;
end

function GetItem(clickID)
	local item=teamData:GetItem(clickID);
	if item then
		return item;
	elseif currentDragData and currentDragData:GetID()==clickID then
		return currentDragData;
	end
end

--返回当前光环的占位信息
function GetHaloRange(_row,_col)
	local posInfo={};
	if clickID and formatTab then
		local item=GetItem(clickID);
		if item==nil then
			return posInfo;
		end
		_row=_row or item.row;
		_col=_col or item.col;
		local haloCfg=item:GetHaloCfg();
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
					if tempItem then
						for k,v in ipairs(formatTab:GetCardRealCoord(tempItem.cid)) do
							-- posInfo[tempItem.cid]={id=tempItem.cid,type=3};
							local key=string.format("I%s_%s",v.row,v.col);
							local realKey=v.row.."-"..v.col;
							-- if tempItem.cid~=clickID  then
							-- 	posInfo[realKey]={key=key,realKey=realKey,type=3};
							-- end
							if tempItem.cid~=clickID  then
								posInfo[realKey]={key=key,realKey=realKey,type=3};
							elseif tempItem.cid==clickID then
								if currentDragData~=nil and currentDragData.cid~=tempItem.cid then
									posInfo[realKey]={key=key,realKey=realKey,type=3};
								elseif currentDragData~=nil and currentDragData.cid==tempItem.cid and row==v.row and col==v.col then
									posInfo[realKey]={key=key,realKey=realKey,type=3};
								elseif currentDragData==nil then
									posInfo[realKey]={key=key,realKey=realKey,type=2};
								end
							end
						end
					else
						local key=string.format("I%s_%s",row,col);
						local realKey=row.."-"..col
						posInfo[realKey]={key=key,realKey=realKey,type=3};
					end
				end
			end
		else
			-- Log( "该角色暂无光环");
		end
	end
	return posInfo;
end

function ApplyGridsColor(tab)
	-- EventMgr.Dispatch(EventType.Team_Grid_RefreshColor,tab);
    if gridList then
        for k,v in ipairs(tab) do
            local grid=gridList[v.realKey];
			if grid then
                grid.SetColor(v.type);
            end
			if this[v.key] then
				local color=FormationUtil.GetHalo2DGridColor(v.type);
    			CSAPI.SetImgColor(this[v.key],color[1],color[2],color[3],color[4]);
			end
        end
    end
end

--拖拽完成
function OnDropCard(key)
	--获取当前拖拽的卡牌的LUAtable
	-- Log( "current:" .. tostring(currentDragData == nil));
	if CanEditTeam()~=true then
		return;
	end
	-- LogError(tostring(targetKey).."\t"..tostring(key))
	if targetKey ~= nil then
		key = targetKey;
	end
	-- Log( "key:"..tostring(key));
	local strs = StringUtil:split(key, "-");
	local row = tonumber(strs[1]);
	local col = tonumber(strs[2]);
	--获取当前放置到的grid的占位信息
	local canMove,tempTab=formatTab:CanMove(currentDragData.cid,row,col);
	if canMove==true then
		--同步ui
        for _, v in ipairs(tempTab:GetArray()) do
			cardList[v.cid].SetParent(gridList[v.row .. "-" .. v.col].gameObject, GetOffset(v))
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
				forceCall(forceCaller,row,col);
			end
		end
	else
		local item = cardList[currentDragData.cid];
        --复位
        item.SetParent(gridList[currentDragData.row .. "-" .. currentDragData.col].gameObject, GetOffset(currentDragData));
	end
	--更新队伍数据中的占位信息
	teamData:UpdateDataByArray(formatTab:GetArray());
	if cardList then
		for k, v in ipairs(teamData.data) do           
			if not isMini then
				if addtiveState then
					local gets=FormationUtil.CountHaloGet(teamData,v); --受到的光环加成
					cardList[v:GetID()].CreateHaloAtts(gets);
				else
					cardList[v:GetID()].HideHaloAtts();
				end
			end
			-- local coord = FormationUtil.GetPlaceHolderInfo(v:GetGrids());
			-- cardList[v.cid].SetGridImg(v.row,v.col,coord);
		end
	end
	EventMgr.Dispatch(EventType.Team_Item_Change);
end

--开始拖拽
function OnDragBegin(data)
	EventMgr.Dispatch(EventType.TeamView_DragMask_Change,true)
	isDrop=false;
	CloseInfoView();
	if data==nil or CanEditTeam()~=true then
		return;
	end
	isDraging=true;
	-- if currentDragData~=nil then --已经有在拖拽的物体时将该物体归还原位
	-- 	local item = cardList[currentDragData.cid];
	-- 	item.SetParent(data.oldParent, GetOffset(currentDragData));
	-- end
	currentDragData = formatTab:GetPosDataByCid(data.cid);
	EventMgr.Dispatch(EventType.Team_FormationView_Select,{cid=data.cid,isDrag=true})
	EventMgr.Dispatch(EventType.Team_Item_Change);
	clickID=data.cid;
	cardList[data.cid].SetTopMask(true);
	SetParentSibling(1);
	-- local item = cardList[currentDragData.cid];--防止从3-3拖出来时画面倒转
	-- local coord=FormationUtil.GetPlaceHolderInfo(currentDragData:GetGrids());
	-- item.SetGridImg(2,2,coord);
end

--拖拽卡牌中
function OnDragCard(pos)
	--根据当前世界坐标计算离卡牌最近的格子坐标
	if currentDragData==nil or CanEditTeam()~=true  then
		return
	end
	if cardList and cardList[currentDragData:GetID()] then
		--刷新格子状态
		local dropObj=GetCurrDropObj(cardList[currentDragData:GetID()].transform.position);
		if dropObj then
			local strs=StringUtil:split(dropObj.gameObject.name, "-");
			local r = tonumber(strs[1]);
			local c = tonumber(strs[2]);
			local posTab=GetGridsState(r,c);
			if r and c then
				targetKey = r .. "-" .. c;
			end
			local tab={};
			for k,v in pairs(posTab) do
				table.insert(tab,v);
			end
			ApplyGridsColor(tab);
		else
			targetKey=nil;
			local posTab=GetGridsState(-1,-1);
			local tab={};
			for k,v in pairs(posTab) do
				table.insert(tab,v);
			end
			ApplyGridsColor(tab);
		end
	end
	
	--[[
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
	local strs=nil;
	--获取新的卡牌位置
	local posList=GetGridsState(list.row,list.col);
	if list.row and list.col then
		targetKey = list.row .. "-" .. list.col;
		--预览选择
		-- Log("targetKey:".. targetKey);
		--判断该位置可不可以用，不能用的话把占位格子的颜色设置为红色，可以用的话设置为暗绿色
		local canMove,tempTab=formatTab:CanMove(currentDragData.cid,list.row,list.col);
		local item2=tempTab:GetPosDataByCid(currentDragData.cid);
        local coord=FormationUtil.GetPlaceHolderInfo(grids);
        local type=2;
		if not canMove then
            type=6;
		end
		-- posList[currentDragData.cid]={id=currentDragData.cid,type=type}
		for k,v in ipairs(coord) do
			local r = list.row + v[1] - 1;
			local c = list.col + v[2] - 1;
			posList[r.."-"..c]={key=r.."-"..c,type=type}
			-- local temp=formatTab:GetPosData(r,c);
			-- if temp then
				-- posList[temp.cid]={id=temp.cid,type=type}
			-- end
		end
        local tab={};
        for k,v in pairs(posList) do
            table.insert(tab,v);
		end
        ApplyGridsColor(tab)
	else
		targetKey = nil;
	end]]
end

--拖拽完成
function OnDragEnd()
	EventMgr.Dispatch(EventType.TeamView_DragMask_Change,false)
	isDraging=false;
	if currentDragData==nil or CanEditTeam()~=true then
		return;
	end
	local cardData = currentDragData;
	local item = cardList[cardData.cid];
	cardList[cardData.cid].SetTopMask(false);
	--判断拖拽是否有效
	local currKey=currentDragData.row.."-"..currentDragData.col;
	local oldParent=gridList[currKey].gameObject;
	-- LogError("DragEnd:"..tostring(item.view.myParent.gameObject == gridObj))
	if isDrop or (targetKey==currKey) or (canDragLeave~=true and item.view.myParent.gameObject == gridObj) then
	 	--返回原位
	 	item.SetParent(oldParent, GetOffset(cardData));
	elseif targetKey~=nil then
		OnDropCard(targetKey);
	elseif item.view.myParent.gameObject == gridObj and canDragLeave==true then
        --返回原位
		item.SetParent(oldParent, GetOffset(cardData));
		-- item.SetGridImg(cardData.row,cardData.col);
		if targetKey==nil then
			EventMgr.Dispatch(EventType.Team_Select_Leave,cardData);
		end
	end
	CSAPI.PlayUISound("ui_cosmetic_adjustment");
	currentDragData=nil;
	oldKey=nil;
	SetClickState();
	RefreshGrids();
	SetParentSibling(0);
end

--放置
function OnDrop()
	isDrop=true;
	EventMgr.Dispatch(EventType.TeamView_DragMask_Change,false)
end

--设置父节点层级
function SetParentSibling(index)
	-- transform.parent:SetSiblingIndex(index);
	EventMgr.Dispatch(EventType.TeamView_ChildNode_Change,index);
end

--点击了阵型格子
function OnClickFGrid(eventData)
	if eventData and isDraging~=true then
		if eventData.cid~=clickID then
			local teamItemData=formatTab:GetPosDataByCid(eventData.cid);
			ShowInfoView(teamItemData);
		end
		SetClickState(eventData.cid);
	end
end

function SetClickState(cID)
	if clickID~=nil and cardList[clickID] then
		local item=cardList[clickID];
		-- item.ShowArrow(false);
		item.SetSelectModel(false);
	end
	if clickID==cID then
		ClearClickID()
	else
		clickID=cID or nil;
	end
	if clickID then
		local item=cardList[clickID];
		-- item.ShowArrow(true);
		local teamItemData=formatTab:GetPosDataByCid(clickID);
		ShowInfoView(teamItemData);
	else
		EventMgr.Dispatch(EventType.Team_FormationView_Select)
		CloseInfoView();
	end
	RefreshGrids();
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
	local pos = UnityEngine.Vector3.zero;
	local grids=teamItemData:GetGrids();
	local formationType = FormationUtil.GetFormationType(grids);
	local list=CountOffset(grids,formationType);
	for _, val in ipairs(list) do
		if val.targetPos.row == teamItemData.row and val.targetPos.col == teamItemData.col then
			pos = val.pivot;
		end
	end
	return pos;
end 

--计算中心点并返回
function CountOffset(grids,formationType)
	offsetList = offsetList or {};
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
			pivot.x=pivot.x-2;
			pivot.y=pivot.y+4;
			local targetPos = {row = v[1], col = v[2]}
			-- Log( "中心点："..tostring(pivot).."\t 目标坐标:"..v[1]..","..v[2]);
			table.insert(tab, {pivot = pivot, targetPos = targetPos})
			offsetList[formationType]=tab;
		end
	end
	return offsetList[formationType]
end

--返回拖拽的队列数据
function GetDragList()
	return dragList;
end

function GetIsChange()
	return dragList~=nil;
end

function OnJoinDragBegin(eventData)
	--初始化一个2D拖拽物
	if eventData and eventData.card and CanEditTeam() then
		isDraging=true;
		if TeamMgr:IsFirstTeamLeader(eventData.card:GetID()) and TeamMgr:IsTeamType(eTeamType.DungeonFight,teamData:GetIndex()) then
			Tips.ShowTips(LanguageMgr:GetTips(14002))
			return
		end
		-- ResUtil:CreateUIGOAsync("Formation/CardDragView2D",gameObject,function(go)
		-- 	joinModel=ComUtil.GetLuaTable(go);
			local card=eventData.card;
			local teamItemData=TeamItemData.New();
			--是否是NPC
			local isNpc,s1,s2=FormationUtil.CheckNPCID(card:GetID());
			--是否是助战卡
			local fuid=nil;
			local index=nil;
			if FormationUtil.IsFirendCardID(card:GetID()) then
				local strs=StringUtil:split(card:GetID(),"_");
				fuid=tonumber(strs[1])
				index=6;
			elseif eventData.isAssist and isNpc then
				fuid=s1;
				index=6;
			end
			local tempData={
				cid=card:GetID(),
				fuid=fuid, --区别是否是助战卡
				bIsNpc=isNpc,
				index=index,
			}
			teamItemData:SetData(tempData);
			CSAPI.SetGOActive(joinModel.gameObject,true);
			joinModel.InitData(teamItemData,false,isShowInfos);
			currentDragData=teamItemData;
			local pos=UnityEngine.Vector3(eventData.x,eventData.y,transform.position.z);
			joinModel.Move(pos);
			clickID=card:GetID();
			joinModel.SetTopMask(true);
		-- end)
		SetClickState();
		CloseInfoView();
		SetParentSibling(1);
		-- local go = ResUtil:CreateUIGO("Formation/CardDragView2D", gameObject.transform);
		-- joinModel=ComUtil.GetLuaTable(go);
		-- local card=eventData.card;
		-- local teamItemData=TeamItemData.New();
		-- --是否是NPC
		-- local isNpc,s1,s2=FormationUtil.CheckNPCID(card:GetID());
		-- --是否是助战卡
		-- local fuid=nil;
		-- local index=nil;
		-- if FormationUtil.IsFirendCardID(card:GetID()) then
		-- 	local strs=StringUtil:split(card:GetID(),"_");
		-- 	fuid=tonumber(strs[1])
		-- 	index=6;
		-- elseif eventData.isAssist and isNpc then
		-- 	fuid=s1;
		-- 	index=6;
		-- end
		-- local tempData={
		-- 	cid=card:GetID(),
		-- 	fuid=fuid, --区别是否是助战卡
		-- 	bIsNpc=isNpc,
		-- 	index=index,
		-- }
		-- teamItemData:SetData(tempData);
		-- joinModel.InitData(teamItemData,false);
		-- currentDragData=teamItemData;
		-- local pos=UnityEngine.Vector3(eventData.x,eventData.y,transform.position.z);
		-- joinModel.Move(pos);
		-- SetClickState();
		-- clickID=card:GetID();
		-- joinModel.SetTopMask(true);
		-- CloseInfoView();
		-- SetParentSibling(1);
	end
end

function OnJoinDrag(eventData)
	--设置拖拽物的位置
	if eventData and joinModel.gameObject.activeSelf then
		local pos=UnityEngine.Vector3(eventData.x,eventData.y,transform.position.z);
        joinModel.Move(pos);
		--刷新格子状态
		local dropObj=GetCurrDropObj(pos);
		if dropObj then
			local strs=StringUtil:split(dropObj.gameObject.name, "-");
			local r = tonumber(strs[1]);
			local c = tonumber(strs[2]);
			clickID=currentDragData.cid;
			local posTab=GetGridsState(r,c);
			local tab={};
			for k,v in pairs(posTab) do
				table.insert(tab,v);
			end
			ApplyGridsColor(tab);
		else
			local posTab=GetGridsState(-1,-1);
			local tab={};
			for k,v in pairs(posTab) do
				table.insert(tab,v);
			end
			ApplyGridsColor(tab);
		end
	end
end

function OnJoinDragEnd(eventData)
	--放置时
	if eventData and joinModel then
		local dropObj=GetCurrDropObj(joinModel.transform.position);
		if dropObj then --父物体
			local strs=StringUtil:split(dropObj.gameObject.name, "-");
			local r = tonumber(strs[1]);
			local c = tonumber(strs[2]);
			--加入队伍
			EventMgr.Dispatch(EventType.Team_Card_Join,{card=eventData.card,row=r,col=c});
	   	end
		-- SetModelFoucs();
		isDraging=false;
	end
	RemoveJoinModel();
	SetParentSibling(0);
end

function RemoveJoinModel()
	if joinModel then
		-- joinModel.Close();
		CSAPI.SetGOActive(joinModel.gameObject,false);
	end
	-- joinModel=nil;
	currentDragData=nil;
	RefreshGrids();
end

--返回当前能放置的物体对象，没有则返回空 pos:Vector3对象
function GetCurrDropObj(pos)
	-- local dropObj=nil;
	-- if pos then
	-- 	for k,v in pairs(gridList) do
	-- 		if v.IsPointInMatrix(pos) then
	-- 			dropObj=v;
	-- 			break;
	-- 		end
	-- 	end
	-- end
	-- return dropObj
	local dropObj=nil;
	if currentDragData then
		local grids=currentDragData:GetGrids();
		local formationType = FormationUtil.GetFormationType(grids);
		local points=CountOffset(grids,formationType);--得到所有中心点
		local size=FormationUtil.GetBgSize(grids);
		pos=gameObject.transform:InverseTransformPoint(pos);
		local minOffsetA={pos.x-size[1]/2,pos.y-size[2]/2};
		local maxOffsetA={pos.x+size[1]/2,pos.y+size[2]/2};
		-- FormationUtil.DrawMatix2D(minOffsetA,maxOffsetA,gameObject);
		local tempRange=0;
		for k,v in ipairs(points) do
			--计算目标范围的四个点
			local key=v.targetPos.row.."-"..v.targetPos.col;
			local p=gameObject.transform:InverseTransformPoint(gridList[key].GetPos())
			local realPos={v.pivot.x+p.x,v.pivot.y+p.y}
			local minOffsetB={realPos[1]-size[1]/2,realPos[2]-size[2]/2};
			local maxOffsetB={realPos[1]+size[1]/2,realPos[2]+size[2]/2};
			-- FormationUtil.DrawMatix2D(minOffsetB,maxOffsetB,gameObject);
			local width,height=FormationUtil.CountInterSize(minOffsetA,maxOffsetA,minOffsetB,maxOffsetB);
			-- Log("Key:"..key.."\t"..realPos[1].."\t"..realPos[2].."\t"..v.pivot.x.."\t"..v.pivot.y.."\t"..x.."\t"..y)
			local range=width*height;
			-- Log("Key:"..key.."\t"..tostring(range))
			if range>tempRange then
				tempRange=range;
				local oWidth=maxOffsetB[1]-minOffsetB[1];
				local oHeigth=maxOffsetB[2]-minOffsetB[2];
				-- Log("Key:"..key.."\t"..(width/oWidth).."\t"..(height/oHeigth));
				if width/oWidth>=0.3  and height/oHeigth>=0.3 then
					dropObj=gridList[key];
				end
			end
		end
	end
	return dropObj;
end

function OnClickInfoOption(eventData)
	if isDraging then
		return;
	end
	if eventData and eventData.type then
		if CanEditTeam() then
			if eventData.type==1 then --设为队长
				EventMgr.Dispatch(EventType.Team_FormationInfo_SetLeader,clickID);
				SetClickState(clickID);
			-- elseif eventData.type==2 then --查看信息
			-- 	FormationUtil.LookCard(clickID);
				-- SetClickState(clickID);
			elseif eventData.type==3 then --退出队伍
				if canDragLeave then
					local teamItem=teamData:GetItem(clickID);
					EventMgr.Dispatch(EventType.Team_Select_Leave,teamItem);
				else
					Tips.ShowTips(LanguageMgr:GetTips(14003))
				end
				SetClickState(clickID);
			end
		end
	end
end

function ShowInfoView(teamItemData)
	if teamItemData then
		--显示详细信息面板
		if infoView==nil then
			infoNode=infoNode or gameObject;
			ResUtil:CreateUIGOAsync("Formation/FormationInfoView2D",infoNode,function(go)
				infoView=ComUtil.GetLuaTable(go);
				infoView.Refresh(teamItemData);
				SetInfoViewPos(teamItemData);
				if not teamItemData:IsLeader() and not teamItemData:IsAssist() then
					infoView.SetLeaderEnable(true);
				else
					infoView.SetLeaderEnable(false);
				end
			end)
		else
			CSAPI.SetGOActive(infoView.gameObject,true);
			infoView.Refresh(teamItemData);
			SetInfoViewPos(teamItemData);
			if not teamItemData:IsLeader() and not teamItemData:IsAssist() then
				infoView.SetLeaderEnable(true);
			else
				infoView.SetLeaderEnable(false);
			end
		end
	end
end
--offset:110
function SetInfoViewPos(teamItemData)
	for k,v in pairs(cardList) do
		v.InitData(v.data,false,isMini,isMirror,isShowInfos);
	end
	if teamItemData then
		local item=cardList[teamItemData:GetID()];
		local x,y,z=item.GetPos();
		item.SetSelectModel(true);
		-- local pos=transform:InverseTransformPoint(CS.UnityEngine.Vector3(x,y,z));
		local pos=infoNode.transform:InverseTransformPoint(CS.UnityEngine.Vector3(x,y,z));
		local fType=teamItemData:GetFormationType();
		if fType==FormationType.Single or fType==FormationType.VDouble or fType==FormationType.VThree then
			pos.y=pos.y;
		elseif fType==FormationType.HThree or fType==FormationType.Nine  then
			pos.y=pos.y+yOffset*3;
		end
		CSAPI.SetLocalPos(infoView.gameObject,pos.x,pos.y,0);
	end
end

--设置锁定
function SetLock(_isLock)
	isLock=_isLock;
	if gridList then
		local tips=_isLock==true and LanguageMgr:GetTips(14001) or nil
		for k,v in pairs(gridList) do
			v.SetDragActive(not _isLock,tips);
		end
	end
end

--判断是否可以编辑队伍,无法操作时会弹出提示
function CanEditTeam()
	if isLock then
		Tips.ShowTips(LanguageMgr:GetTips(14001));
		return false;
	end
	return true;
end

function CloseInfoView()
	if infoView then
		CSAPI.SetGOActive(infoView.gameObject,false);
	end
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

function SetTrims(isShow)
	CSAPI.SetGOActive(trims,isShow)
end

----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()     
gameObject=nil;
transform=nil;
this=nil;  
bg=nil;
gridObj=nil;
view=nil;
end
----#End#----