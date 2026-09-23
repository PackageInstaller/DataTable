local gridSize={1.88,1.88}
local points={--记录了1-1到3-3的在地板上的所有本地坐标位置
	{{-1.9,0,1.9},{0,0,1.9},{1.9,0,1.9}},
	{{-1.9,0,0},{0,0,0},{1.9,0,0}},
	{{-1.9,0,-1.9},{0,0,-1.9},{1.9,0,-1.9}},
}
local models={};--模型列表
local uiItems={};
local eventMgr=nil;
local dragObj=nil;
local dragForceList={{true,true,true},{true,true,true},{true,true,true}};--哪些区域可以拖拽
local wX,wY,wZ=0,0,0;
local currentDragData=nil;
local dragList=nil;--卡牌变更记录
local joinModel=nil;--上阵拖拽的模型对象
local loadList=nil;--加载模型的顺序
local isLock=false;--是否锁定，锁定时无法执行拖拽、上下阵、更改队长等操作
local formationEventMgr=nil;--编队事件管理脚本
local infoViewScale=1;
local isRotate=true;
local isZoom=true;
local isLoadOver=false;
local playTween=true;
local ahplaTween=nil;--格子的透明度动画
local fx=1;
local isFirst=false;
local last_angle=0;
local orginPos=nil;
local isDrag=false;
local addtiveState=false;--是否显示加成状态
local joinDragView=nil;--加入卡牌拖拽时的dragview对象
local infoNode=nil;--信息框节点
local isShowInfos=false;--是否显示hp/sp
local enableAlphaCamera=false
local alphaCameraTimer=0
local alphaCameraInterval=0.2
local showFakeLevel=nil;--低于指定等级显示特定等级

function Awake()
	-- local goRT = CSAPI.GetGlobalGO("CommonRT")
    -- CSAPI.SetRenderTexture(goRaw,goRT);
	-- CSAPI.SetCameraRenderTarget(modelRoot,goRT);
	formationEventMgr=ComUtil.GetCom(goRaw,"Formation3DEventMgr");
	formationEventMgr:AddZoomCall(OnZoom);
	eventMgr = ViewEvent.New();
	eventMgr:AddListener(EventType.Team_Join_DragBegin,OnJoinDragBegin);
	eventMgr:AddListener(EventType.Team_Join_DragEnd,OnJoinDragEnd);
	eventMgr:AddListener(EventType.Team_FormationInfo_Click,OnClickInfoOption);
	eventMgr:AddListener(EventType.Team_Model_LoadOver,OnModelLoadOver);
	eventMgr:AddListener(EventType.TeamView_AddtiveState_Change,SetAddtiveState);
	ahplaTween=ComUtil.GetCom(formationGrids,"ActionSRListAhpla");
	local screenArr=CSAPI.GetScreenSize();--设备屏幕大小
	local scaleA=screenArr[0]/screenArr[1];
	local z=0;
	if scaleA>1.55 then
		z=0;
	else
		z=(1.33/scaleA)*-5;
	end
	CSAPI.SetLocalPos(ScaleNode,0,0,z)
end

function OnModelLoadOver()
	if isLoadOver==false then
		CSAPI.SetGOActive(formationGrids,true);
		isLoadOver=true;		
	end
end

function OnEnable()
	if ViewModelMgr:GetCurrModelCreater()~= this then
		ViewModelMgr:SetModelCreater(this);
	end
	ShowAplhaCameraWithTime(1.5)
end

function SetScale(_scale)
	CSAPI.SetScale(ModelParent,_scale,_scale,_scale);
end

function SetUIItems(isShow)
	for k,v in pairs(uiItems) do
		CSAPI.SetGOActive(v.gameObject,isShow==true)
	end
end

function SetLocalPos(x,y)
	local _z=x/100;
	local _x=y*-1/100;
	CSAPI.SetLocalPos(ModelParent,_x,30,_z);
end

function CreateModelNode(modelId,func)   
	local go = CSAPI.CreateGO("ModelNode",0,0,0,modelNode);
    local lua = ComUtil.GetLuaTable(go);
	if func then
		func(lua);
	end
	-- lua.LoadModel(modelId);
    return lua;
end

--设置锁定
function SetLock(_isLock)
	isLock=_isLock;
end

--判断是否可以编辑队伍,无法操作时会弹出提示
function CanEditTeam()
	if isLock then
		Tips.ShowTips(LanguageMgr:GetTips(14001));
		return false;
	end
	return true;
end

--创建模型
function CreateModelByOrder()
	if loadList then
		CharacterMgr:LoadModelByOrder(loadList);
	end
end

function ShowModelState(state)
    CSAPI.SetGOActive(goModelRaw,state);
end

--使用启用旋转和缩放操作
function SetRotateAndZoom(_isRotate,_isZoom)
	isRotate=_isRotate;
	isZoom=_isZoom;
	formationEventMgr:SetZoomEnable(_isZoom);
end

--设置加成状态显示
function SetAddtiveState(state)
	addtiveState=state;
	SetHaloAttrState(addtiveState);
end

function SetHaloAttrState(isShow)
	if uiItems then
		for k,v in ipairs(teamData.data) do
			if isShow then
				local gets=FormationUtil.CountHaloGet(teamData,v); --受到的光环加成
				uiItems[v:GetID()].CreateHaloAtts(gets);
			else
				uiItems[v:GetID()].HideHaloAtts();
			end
		end
	end
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
	for _,v in pairs(models) do
		v.Remove();
	end
end

function OnDestroy()
	if infoView then
		CSAPI.RemoveGO(infoView.gameObject);
	end
	formatTab = nil;
	eventMgr = nil;
	pivotList = nil;
	currentDragData = nil;
	targetKey = nil;
	offsetList = nil;
	ReleaseCSComRefs();
end

function SetActive(isActive)
	CSAPI.SetGOActive(gameObject,isActive);
end

function SetForceMove(_forceTab,callBack,caller)
	forceTab=_forceTab;
	forceCall=callBack;
    forceCaller = caller;
	if formatTab then
		formatTab:SetForceTab(forceTab);
		if forceTab then
			dragForceList={{},{},{}};
			for k,v in ipairs(forceTab) do
				dragForceList[v.row][v.col]=true;
			end
		end
	end
end

function SetDragLeave(_canDragLeave)
	canDragLeave=_canDragLeave;
end

--判断指定区域的卡牌是否可以拖拽
function CanDrag(row,col)
	if row and col and row>0 and col>0 and dragForceList and dragForceList[row][col]== true then
		return true;
	else
		return false;
	end
end

function PlayEnter()
	CSAPI.SetAngle(rotateNode,-8,0,15);
	CSAPI.SetGOActive(enterTween,true);
end

function PlaySwitch(is3D)
	SetClickState(clickID);
	SetModelsShow(is3D);
	SetUIItems(is3D)
	CSAPI.SetGOActive(border,is3D);
	CSAPI.SetGOActive(FrmationScene_Shadows,is3D)
	CSAPI.SetGOActive(formationGrids,is3D)
	if not is3D then
		CSAPI.SetAngle(rotateNode,0,28.15,0);
		CSAPI.SetGOActive(switchOffTween,true);
		CSAPI.SetGOActive(switchOnTween,false);
	else
		CSAPI.SetAngle(rotateNode,0,-15,-52);
		CSAPI.SetGOActive(switchOnTween,true);
		CSAPI.SetGOActive(switchOffTween,false);
	end
	FuncUtil:Call(function()
		EventMgr.Dispatch(EventType.TeamView_ViewType_Change,{is3D=is3D})
	end,nil,180)
end

--初始化阵型 生成卡牌放到对应位置上,_canDragLeave:是否可以拖拽下阵,infoParent:信息框挂载点
function Init(data,_canDragLeave,_playTween,_clickID,_addtiveState,_infoNode,_isShowInfos,_showFakeLevel)    
	SetParentSibling(0);
	CloseInfoView();
	dragList=nil;
	canDragLeave=_canDragLeave;
	playTween=_playTween;
	addtiveState=_addtiveState;
	infoNode=_infoNode
	isShowInfos=_isShowInfos
	showFakeLevel = _showFakeLevel
	formatTab = FormationTable.New(3, 3);
	formatTab:SetForceTab(forceTab);
	-- CSAPI.SetGOActive(leaderObj,false)
	if data ~= nil then
		--缓存一个数据
		teamData=data;
		--记录所有的占位信息
		loadList=nil;
		local leaderModel=nil;
		local supportModel=nil;
		for k, v in ipairs(teamData.data) do
			formatTab:AddCardPosInfo(v);
            --创建模型
			CreateModelNode(v:GetModelID(),function(modelNode)
				local offset=GetOffset(v);
				modelNode.SetData(v,playTween);
				modelNode.SetPos(offset[1],offset[2],offset[3]);
				-- if v:IsLeader() then
				-- 	leaderModel=modelNode;
				-- end
				-- if v:IsAssist() then
				-- 	supportModel=modelNode;
				-- end
				--创建展示的UI信息
				CreateUIElment(function(go)
					local lua=ComUtil.GetLuaTable(go);
					lua.Refresh(v,isShowInfos,showFakeLevel);
					uiItems[v:GetID()]=lua;
					if addtiveState then
						local gets=FormationUtil.CountHaloGet(teamData,v); --受到的光环加成
						uiItems[v:GetID()].CreateHaloAtts(gets);
					else
						uiItems[v:GetID()].HideHaloAtts();
					end
					CSAPI.AddUISceneElement(lua.GetNode(),modelNode.gameObject,ModelCamera);
				end);
				models[v:GetID()]=modelNode;
				loadList=loadList or {};
				table.insert(loadList,modelNode.GetLoadData());
			end);
			--设置动画播放
			if _clickID==nil and playTween then
				for _,val in ipairs(formatTab:GetCardRealCoord(v:GetID())) do
					local key=val.row.."-"..val.col;
					CSAPI.SetScriptEnable(this[key],"ActionSRColor",true);
				end
			end
		end
		-- if leaderModel then
			-- CSAPI.SetGOActive(leaderObj,true)
			-- CSAPI.AddUISceneElement(leaderObj,leaderModel.gameObject,ModelCamera);
		-- end
		-- if supportModel then
		-- 	CSAPI.SetGOActive(supportObj,true)
		-- 	CSAPI.AddUISceneElement(supportObj,supportModel.gameObject,ModelCamera);
		-- else
		-- 	CSAPI.SetGOActive(supportObj,false)
		-- end
		CreateModelByOrder();
		if _clickID then
			SetClickState(_clickID);
		else
			RefreshGrids();
		end
	end
end


function CreateUIElment(func)
	ResUtil:CreateUIGOAsync("Formation/CardDragView",UINode,func);
end

--刷新格子颜色
function RefreshGrids()
	local list=GetGridsState();
	local tab={};
	for k,v in pairs(list) do
		table.insert(tab,v);
	end
	-- SetNumObjColor(tab)
	SetGridsStyle(tab)
end

--设置格子样式
function SetGridsStyle(tab)
	local enlist={};
	for k,v in pairs(tab) do
		local isPlayTween=true;
		if v.type==6 then --更换图片
			CSAPI.LoadSRInModule(this[v.key],"UIs/Formation/red.png");
		elseif v.type==5 or v.type==3 then
			CSAPI.LoadSRInModule(this[v.key],"UIs/Formation/btn_3_10.png");
		else
			CSAPI.LoadSRInModule(this[v.key],"UIs/Formation/btn_3_10.png");
			isPlayTween=false;
		end
		if isPlayTween then
			table.insert(enlist,this[v.key]);
		end
		local color=FormationUtil.GetHaloGridColor(v.type);
		CSAPI.SetSRColor(this[v.key],color[1],color[2],color[3],color[4]);
	end
	if ahplaTween then
		ahplaTween:SetList(enlist);
	end
end

--返回格子的状态，_row,_col:当前拖拽物体的预览位置，不传默认为当前点击的物体的位置，为-1时则返回默认格子状态
function GetGridsState(_row,_col)
	local posInfo={};
	local isOut=false;
	if _row and _col and (_row<0 or _col<0) then
		isOut=true;
	end
	if models then
		for i=1,9 do
			local row=math.ceil(i/3);
			local col=i%3==0 and 3 or i%3;
			local key=row.."-"..col;
			if formatTab then
				local item=formatTab:GetPosData(row,col);
				if item~=nil then
					local type=2;
					if clickID and item:GetID()~=clickID and this.enableHalo then
						type=4;
					elseif currentDragData~=nil and item:GetID()==currentDragData:GetID()  then --当前拖拽物以传入的值为准
						type=1;
					elseif clickID and item:GetID()==clickID then
						type=7;
					end
					posInfo[key]={key=key,type=type}
				else
					posInfo[key]={key=key,type=1}
				end
			else
				posInfo[key]={key=key,type=1}
			end
		end
	end
	if not isOut then
		if _row and _col and formatTab and currentDragData then --判断是否能移动
			local canMove=false;
			if dragObj~=nil then
				canMove=formatTab:CanMove(currentDragData.cid,_row,_col);
			elseif joinModel~=nil then
				currentDragData.row=_row;
				currentDragData.col=_col;
				-- local itemData=formatTab:GetPosData(_row,_col);
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
				-- Log(tostring(isSuccess).."\t"..tostring(isReplace).."\t"..tostring(eqItem==nil));
				if isSuccess~=true or (isSuccess and teamData:GetRealCount()>=maxNum and isReplace==false) or (eqItem and (eqItem.col~=_col or eqItem.row~=_row)) then--人满时不是替换则不能放置
					canMove=false;
				else
					canMove=true;
				end
			end
			local coord=currentDragData:GetHolderInfo();
			for k,v in ipairs(coord) do
				local r = _row + v[1] - 1;
				local c = _col + v[2] - 1;
				if r<=formatTab.maxX and c<=formatTab.maxY then
					local key=r.."-"..c;
					posInfo[key]={key=key,type=canMove==true and 5 or 6}
				end
			end
		end
		if clickID and this.enableHalo then
			local posInfo2=	GetHaloRange(_row,_col);
			for k,v in pairs(posInfo2) do
				if posInfo[k] and posInfo[k].type~=6 and posInfo[k].type~=5 then --不是禁止占用则被光环状态覆盖
					posInfo[k]=v;
				end
			end
		end
	end
	return posInfo;
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
	local nId=clickID;
	if clickID and formatTab then
		local item=GetItem(clickID);
		if item==nil then
			return posInfo;
		end
		_row=_row or item.row;
		_col=_col or item.col;
		local coordinate=item:GetCurCoordPos();
		if coordinate then
			local node=coordinate[1];
			for i=2,#coordinate do
				--取得受光环影响的相对位置
				local row=coordinate[i][1]-node[1]+_row;
				local col=coordinate[i][2]-node[2]+_col;
				--判断光环位置是否生效
				-- Log(row.."\t"..col)
				if row>0 and col>0 and row<=formatTab.maxX and col<=formatTab.maxY and (row~=_row or col~=_col) then
					--未越界的位置,且不是当前位置，读取其中的卡牌信息
					local tempItem=formatTab:GetPosData(row,col);
					if tempItem then
						for k,v in ipairs(formatTab:GetCardRealCoord(tempItem.cid)) do
							local key=v.row.."-"..v.col;
							if tempItem.cid~=clickID  then
								posInfo[key]={key=key,type=3};
							elseif tempItem.cid==clickID then
								if currentDragData~=nil and currentDragData.cid~=tempItem.cid then
									posInfo[key]={key=key,type=3};
								elseif currentDragData~=nil and currentDragData.cid==tempItem.cid and row==v.row and col==v.col then
									posInfo[key]={key=key,type=3};
								elseif currentDragData==nil then
									posInfo[key]={key=key,type=2};
								end
							end
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
function OnBeginDragXY(x,y,detalX,detalY)

	ShowAplhaCameraWithTime(1000)
	
	dragObj=nil;
	-- Log(x.."\t"..y.."\t"..z);
	-- local r,c=GetCurrKey(x,0,z)
	local r,c=GetCurrKey(wX,0,wZ)
	isFirst=true;
	if formationEventMgr then
		orginPos=formationEventMgr.modelCamera:WorldToScreenPoint(rotateNode.transform.position);
	end
	SetHaloAttrState(false)
	-- Log(tostring(r).."\t"..tostring(c));
	if r and c and CanDrag(r,c) and CanEditTeam() then
		SetIsDrag(true);
		EventMgr.Dispatch(EventType.TeamView_DragMask_Change,true)
		currentDragData=formatTab:GetPosData(r,c)
		if currentDragData then
			dragObj=models[currentDragData:GetID()];
			-- CSAPI.SetPos(dragObj,x,0,z);
			CSAPI.SetPos(dragObj.gameObject,wX,wY,wZ);
			if clickID~=currentDragData.cid then
				SetClickState(currentDragData.cid)
			end
			EventMgr.Dispatch(EventType.Team_FormationView_Select,{cid=currentDragData.cid,isDrag=true})
			-- CloseInfoView();
			ShowInfoView(currentDragData,true)
			SetParentSibling(1);
		end
		EventMgr.Dispatch(EventType.Drag_Card_Begin)
	end
end


--拖拽中
function OnDragXY(x,y,detalX,detalY)
	-- Log(x.."\t"..y.."\t"..z);
	local r,c=GetCurrKey(wX,wY,wZ)
	if dragObj then
		-- CSAPI.SetPos(dragObj,x,0,z)
		SetModelFoucs(wX,wY,wZ);
		CSAPI.SetPos(dragObj.gameObject,wX,wY,wZ);
		--刷新格子状态
		local posTab=GetGridsState(r,c);
		SetGridsStyle(posTab);
	elseif formationEventMgr then
		if r and c and formatTab:GetPosData(r,c)~=nil then
		elseif isRotate==true then 
			local dis = {(x-orginPos.x),(y-orginPos.y)};
			local rotationAngle = UnityEngine.Mathf.Atan2(dis[2], dis[1])*180/3.1415;
			if isFirst then
				isFirst = false;
				last_angle = rotationAngle;
			end
			if last_angle < rotationAngle then
				fx = 1;
			elseif last_angle > rotationAngle then
				fx = -1;
			end
			-- Log(last_angle.."\t"..rotationAngle.."\t"..(rotationAngle-last_angle).."\t"..tostring(fx));
			-- formationEventMgr:Rotate(0,fx*4.5,0);
			formationEventMgr:Rotate(wX,wY,wZ);
			last_angle = rotationAngle;
		elseif infoView then
			SetClickState();
		end
	end
end

--停止拖拽
function OnEndDragXY(x,y,detalX,detalY)
	
	ShowAplhaCameraWithTime(0)	
	-- Log("End...........")
	EventMgr.Dispatch(EventType.TeamView_DragMask_Change,false)
	if dragObj then
		CSAPI.SetPos(dragObj.gameObject,wX,wY,wZ);
		local r,c=GetCurrKey(wX,0,wZ)
		-- Log("Down:"..tostring(r).."\t"..tostring(c));
		if r and c and r>0 and c>0 then
			--放置操作
			ApplyDragCardMove(r,c);
		else
			--设置回原位
			ResetModelOffset(currentDragData);
			if canDragLeave then
				--提示下阵
				EventMgr.Dispatch(EventType.Team_Select_Leave,currentDragData);
			end
		end
		CSAPI.PlayUISound("ui_cosmetic_adjustment");
	end
	dragObj=nil;
	currentDragData=nil;
	SetModelFoucs();
	SetHaloAttrState(addtiveState)
	SetIsDrag(false);
	SetClickState();
	RefreshGrids();
	SetParentSibling(0);
	EventMgr.Dispatch(EventType.Drag_Card_End)
end

--使拖拽生效的逻辑判断
function ApplyDragCardMove(row,col)
	if	currentDragData==nil or row==nil or col==nil or formatTab==nil then
		return;
	end
	--获取当前放置到的grid的占位信息
	local canMove,tempTab=formatTab:CanMove(currentDragData.cid,row,col);
	if canMove==true then
		--同步ui
		for _, v in ipairs(tempTab:GetArray()) do
			ResetModelOffset(v);
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
		--重置拖拽卡牌位置
		ResetModelOffset(currentDragData);
	end
	--更新队伍数据中的占位信息
	teamData:UpdateDataByArray(formatTab:GetArray());
	EventMgr.Dispatch(EventType.Team_Item_Change);
end

--重置模型位置
function ResetModelOffset(teamItemData)
	if teamItemData then
		local offset=GetOffset(teamItemData);
		models[teamItemData:GetID()].SetPos(offset[1],offset[2],offset[3]);
	end
end

--设置点击焦点
function SetClickState(cid)
	if cid==clickID then
		ClearClickID();
	else
		clickID=cid or nil;
	end
	-- if models then
	-- 	for k,v in pairs(models) do
	-- 		v.ShowArrow(v:GetData():GetID()==clickID);
	-- 	end
	-- end
	if not isDrag then
		if clickID then
			local teamItemData=formatTab:GetPosDataByCid(clickID);
			ShowInfoView(teamItemData);
		else
			EventMgr.Dispatch(EventType.Team_FormationView_Select)
			CloseInfoView();
		end
	end
	RefreshGrids();
end

function OnClickGround(x,y,z)
    --新手引导中
	if isDrag then
		return;
	end
    if(GuideMgr:IsGuiding())then
        return;
    end

	local r,c=GetCurrKey(x,0,z)
	if formatTab and r and c then
		local posData=formatTab:GetPosData(r,c);
		if posData then
			EventMgr.Dispatch(EventType.Team_FormationView_Select,{cid=posData.cid});
			ShowInfoView(posData);
			SetClickState(posData:GetID());
		end
	end
end

function SetRotateTo2D(is2D,func)
	if formationEventMgr then
		if is2D then
			--隐藏模型UI
			RefreshGrids();
			SetClickState(clickID);
			SetModelsShow(false);
			formationEventMgr:RotateTo(75,75,0,0.5,func);
		else
			formationEventMgr:RotateTo(0,0,0,0.5,function()
				RefreshGrids();
				SetModelsShow(true);
				if func then
					func();
				end
			end);
		end
	end
end

function SetModelsShow(isShow)
	if models then
		for k,v in pairs(models) do
			CSAPI.SetGOActive(v.gameObject,isShow==true);
		end
	end
end

function OnClickInfoOption(eventData)
	if isDrag then
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

--- func 显示选中界面
---@param teamItemData 队员信息
---@param isTop 是否只显示头顶的UI
---@param isJoin 是否是还未加入队伍的新卡牌
function ShowInfoView(teamItemData,isTop,isJoin)
	if teamItemData then
		--显示详细信息面板
		if infoView==nil then
			infoNode=infoNode or gameObject;
			ResUtil:CreateUIGOAsync("Formation/FormationInfoView",infoNode,function(go)
				infoView=ComUtil.GetLuaTable(go);
				infoView.Refresh(teamItemData,isTop);
				if isJoin then
					CSAPI.AddUISceneElement(go,joinModel.gameObject,ModelCamera);
				else
					CSAPI.AddUISceneElement(go,models[teamItemData:GetID()].gameObject,ModelCamera);
				end
				CSAPI.SetScale(go,infoViewScale,infoViewScale,infoViewScale);
				if not teamItemData:IsLeader() and not teamItemData:IsAssist() then
					infoView.SetLeaderEnable(true);
				else
					infoView.SetLeaderEnable(false);
				end
				-- CS.CSAPI.AddUIPosFolAddUISceneElementlow_C2C(go,models[teamItemData:GetID()].gameObject,UnityEngine.Vector2(0,0),ModelCamera,CSAPI.GetGlobalGO("UICamera"));
			end)
		else
			CSAPI.SetGOActive(infoView.gameObject,true);
			infoView.Refresh(teamItemData,isTop);
			if isJoin then
				CSAPI.AddUISceneElement(infoView.gameObject,joinModel.gameObject,ModelCamera);
			else
				CSAPI.AddUISceneElement(infoView.gameObject,models[teamItemData:GetID()].gameObject,ModelCamera);
			end
			CSAPI.SetScale(infoView.gameObject,infoViewScale,infoViewScale,infoViewScale);
			if not teamItemData:IsLeader() and not teamItemData:IsAssist() then
				infoView.SetLeaderEnable(true);
			else
				infoView.SetLeaderEnable(false);
			end
			-- CS.CSAPI.AddUIPosFollow_C2C(infoView.gameObject,models[teamItemData:GetID()].gameObject,UnityEngine.Vector2(0,0),ModelCamera,CSAPI.GetGlobalGO("UICamera"));
		end
		--锁定缩放和旋转
		SetRotateAndZoom(false,false);
	end
end

function CloseInfoView()
	if infoView then
		CSAPI.SetGOActive(infoView.gameObject,false);
	end
	if this.isLRotate~=nil or this.isLZoom~=nil then
		SetRotateAndZoom(this.isLRotate,this.isLZoom);
	else
		SetRotateAndZoom(true,true);
	end
end

--设置父节点层级
function SetParentSibling(index)
	-- transform.parent:SetSiblingIndex(index);
	EventMgr.Dispatch(EventType.TeamView_ChildNode_Change,index);
end

function SetIsDrag(_isDrag)
	isDrag=_isDrag;
	if isDrag then
		SetRotateAndZoom(false,false);
	else
		if this.isLRotate~=nil or this.isLZoom~=nil then
			SetRotateAndZoom(this.isLRotate,this.isLZoom);
		else
			SetRotateAndZoom(true,true);
		end
	end
end

--拖拽卡牌加入队伍
function OnJoinDragBegin(eventData)
	
	ShowAplhaCameraWithTime(1000)
	--创建对应角色的模型，并设置为formationView的DragObj
	local card=eventData and eventData.card or nil;
	if card and CanEditTeam() then
		SetIsDrag(true);
		--第一队队长不能加入其它队伍
		if TeamMgr:IsFirstTeamLeader(card:GetID()) and TeamMgr:IsTeamType(eTeamType.DungeonFight,teamData:GetIndex()) then
			Tips.ShowTips(LanguageMgr:GetTips(14002))
			return
		end
		loadList=nil;
		if formationEventMgr then
			formationEventMgr:SetRayEnable(true);
		end
		CreateModelNode(card:GetSkinID(),function(modelNode)
			joinModel=modelNode;
			local teamItemData=TeamItemData.New();
			--是否是NPC
			local isNpc,s1,s2=FormationUtil.CheckNPCID(card:GetID());
			--是否是助战卡
			local fuid=nil;
			local index=nil;
			if FormationUtil.IsFirendCardID(card:GetID()) then
				local strs=StringUtil:split(card:GetID(),"_");
				fuid=tonumber(strs[1])
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
			modelNode.SetData(teamItemData,playTween);
			CreateUIElment(function(go) --创建2dui
				local lua=ComUtil.GetLuaTable(go);
				lua.Refresh(teamItemData,isShowInfos,showFakeLevel);
				-- uiItems[teamItemData:GetID()]=lua;
				joinDragView=lua;
				CSAPI.AddUISceneElement(lua.GetNode(),modelNode.gameObject,ModelCamera);
			end);
			ShowInfoView(teamItemData,true,true);
			loadList=loadList or {};
			table.insert(loadList,modelNode.GetLoadData());
			CreateModelByOrder();
			currentDragData=teamItemData;
			SetClickState()
			-- CloseInfoView();
			SetParentSibling(1);
			clickID=card:GetID();
			-- models[card:GetID()]=modelNode;
		end);
		SetHaloAttrState(false)
	end
end

function OnJoinDragEnd(eventData)
	ShowAplhaCameraWithTime(0)
	SetIsDrag(false);
	local card=eventData and eventData.card or nil;
	if	joinModel and card then
		local r,c=GetCurrKey(wX,0,wZ)
		-- Log("Down:"..tostring(r).."\t"..tostring(c));
		if r and c and (r~=-1 or c~=-1) then
			--加入队伍
			EventMgr.Dispatch(EventType.Team_Card_Join,{card=card,row=r,col=c});
		end
	end
	if joinDragView then
		joinDragView.Close();
		joinDragView=nil;
	end
	SetHaloAttrState(addtiveState);
	RemoveJoinModel();
	SetParentSibling(0);
	CloseInfoView();
end

-- function OnMouseUp()
-- 	EventMgr.Dispatch(EventType.TeamView_DragMask_Change,false)
-- 	RemoveJoinModel();
-- 	if joinDragView then
-- 		joinDragView.Close();
-- 		joinDragView=nil;
-- 	end
-- 	SetParentSibling(0);
-- 	local isClose=false;
-- 	if clickID then
-- 		isClose=teamData:GetItem(clickID)==nil;
-- 	end
-- 	if isClose then
-- 		CloseInfoView();
-- 	end
-- end

--移除拖拽的模型
function RemoveJoinModel()
	if joinModel then
		joinModel.Remove();
		joinModel=nil;
		SetModelFoucs();
	end
	currentDragData=nil;
	if formationEventMgr then
		formationEventMgr:SetRayEnable(false);
	end
	RefreshGrids();
end

--根据世界坐标返回row和col的值,不在棋盘内则返回-1
function GetCurrKey(x,y,z)
	--将世界坐标转为本地坐标
	local r=-1;
	local c=-1;
	local localPos=FormationGrid.transform:InverseTransformPoint(UnityEngine.Vector3(x,y,z));
	if currentDragData then--有拖拽物体时，先做面积判定
		local grids=currentDragData:GetGrids();
		local pList=CountOffset(grids);
		local size=FormationUtil.GetGridSize(grids,true);
		-- local minA={x-size[1]/2,y,z-size[2]/2};
		-- local maxA={x+size[1]/2,y,z+size[2]/2};
		-- local minOffsetA={x-size[1]/2,z-size[2]/2};
		-- local maxOffsetA={x+size[1]/2,z+size[2]/2};
		local minOffsetA={localPos.x-size[1]/2,localPos.z-size[2]/2};
		local maxOffsetA={localPos.x+size[1]/2,localPos.z+size[2]/2};
		local tempRange=0;
		for k,v in ipairs(pList) do
			--计算目标范围的四个点
			local key=v.targetPos.row.."-"..v.targetPos.col;
			-- local p=FormationGrid.transform:TransformPoint(UnityEngine.Vector3(v.pivot[1],v.pivot[2],v.pivot[3]));
			local realPos={v.pivot[1],v.pivot[3]}
			-- local realPos={p.x+v.pivot[1],p.z+v.pivot[3]}
			-- local realPos={p.x,p.z}
			local minOffsetB={realPos[1]-size[1]/2,realPos[2]-size[2]/2};
			local maxOffsetB={realPos[1]+size[1]/2,realPos[2]+size[2]/2};
			local width,height=FormationUtil.CountInterSize(minOffsetA,maxOffsetA,minOffsetB,maxOffsetB);
			-- Log("Key:"..key.."\t"..tostring(p.x).."\t"..tostring(p.y).."\t"..tostring(p.z))
			local range=width*height;
			-- Log("Key:"..key.."\t"..tostring(range))
			if range>tempRange then
				tempRange=range;
				local oWidth=maxOffsetB[1]-minOffsetB[1];
				local oHeigth=maxOffsetB[2]-minOffsetB[2];
				-- Log("Key:"..key.."\t"..(width/oWidth).."\t"..(height/oHeigth));
				if width/oWidth>=0.6  and height/oHeigth>=0.6 then
					r=v.targetPos.row;
					c=v.targetPos.col;
				end
			end
		end
		if r==-1 or c==-1 then
			for x=1,3 do
				for y=1,3 do
					local isIn=IsPointInMatrix({x=localPos.x,y=localPos.z},points[x][y]);
					if isIn then
						r=x;
						c=y;
						break;
					end
				end
			end
		end
	else
		for x=1,3 do
			for y=1,3 do
				local isIn=IsPointInMatrix({x=localPos.x,y=localPos.z},points[x][y]);
				if isIn then
					r=x;
					c=y;
					break;
				end
			end
		end
	end
	return r,c;
end

function OnZoom(delta)
	ShowAplhaCameraWithTime(2)	
	infoViewScale=infoViewScale+delta*0.08;
	if infoView then
		CSAPI.SetScale(infoView.gameObject,infoViewScale,infoViewScale,infoViewScale);
	end
	if uiItems then
		for k,v in pairs(uiItems) do
			CSAPI.SetScale(v.GetNode(),infoViewScale,infoViewScale,infoViewScale);
		end
	end
	-- CSAPI.SetScale(leaderObj,infoViewScale,infoViewScale,infoViewScale);
end

function SetModelFoucs(x,y,z)
	for k,v in pairs(models) do 
		v.SetMatAlpha();
	end
	if models then
		local r=0;
		local c=0;
		if x and y and z then
		  	r,c=GetCurrKey(x,y,z);
		end
		--将受影响的模型透明度都设置成0.4，否则为1
		local coord=nil;
		local cid=nil;
		if dragObj then
			coord=dragObj.GetData():GetHolderInfo();
			cid=dragObj.GetData().cid;
		elseif joinModel then
			coord=joinModel.GetData():GetHolderInfo();
			cid=joinModel.GetData().cid;
		end
		if coord and r and c then
			for k1,v1 in ipairs(coord) do
				local row = r + v1[1] - 1;
				local col = c + v1[2] - 1;
				local fData=formatTab:GetPosData(row,col);
				for k,v in pairs(models) do 
					local m=v.GetData();
					local mData=formatTab:GetPosDataByCid(m.cid);
					if mData and ((mData.row==row and mData.col==col) or (fData and fData:GetID()==mData:GetID())) and mData.cid~=cid then
						v.SetMatAlpha(0.4);
					end
				end
			end
		end
	end
end

--射线碰撞的点
function OnRayCall(x,y,z)
	wX=x;
	wY=y;
	wZ=z;
	if joinModel~=nil then
		SetModelFoucs(wX,wY,wZ);
		CSAPI.SetPos(joinModel.gameObject,wX,wY,wZ);
		--刷新格子状态
		local r,c=GetCurrKey(wX,wY,wZ)
		local posTab=GetGridsState(r,c);
		SetGridsStyle(posTab);
	end
end

--判断一个点是否在矩形中
function IsPointInMatrix(p,matrixPos)
	local p1,p2,p3,p4;
	--根据matrixPos计算矩形的上下左右四个点
	p1={x=gridSize[1]/2+matrixPos[1],y=gridSize[2]/2+matrixPos[3]}
	p2={x=gridSize[1]/2+matrixPos[1],y=(gridSize[2]/2*-1+matrixPos[3])}
	p3={x=(gridSize[1]/2*-1+matrixPos[1]),y=gridSize[2]/2+matrixPos[3]}
	p4={x=(gridSize[1]/2*-1+matrixPos[1]),y=(gridSize[2]/2*-1+matrixPos[3])}
	local isPointIn =false;
	if  p.x>=p3.x and p.x<=p1.x and p.y>=p4.y and p.y<=p1.y then
		isPointIn=true;
	end
	return isPointIn;
end

--返回偏移点
function GetOffset(teamItemData)
	local pos = UnityEngine.Vector3.zero;
	local list=CountOffset(teamItemData:GetGrids());
	for _, val in ipairs(list) do
		if val.targetPos.row == teamItemData.row and val.targetPos.col == teamItemData.col then
			pos = val.pivot;
		end
	end
	return pos;
end

--计算各种格子类型的偏移中心点
function CountOffset(grids)
	offsetList = offsetList or {};
	local formationType = FormationUtil.GetFormationType(grids);
	if offsetList[formationType] == nil then--记录该类型所有的偏移坐标
		local tab = {};
		--获取初始坐标
		local coord = FormationUtil.GetPlaceHolderInfo(grids);
		--遍历所有可以放置的点
		for _, v in ipairs(FormationUtil.GetCardCanMovePos(formationType)) do
			local count = {0,0,0};
			for index, val in ipairs(coord) do
				local row = v[1] + val[1] - 1;
				local col = v[2] + val[2] - 1;
				if points[row][col] ~= nil then
					count ={count[1] + points[row][col][1],count[2]+points[row][col][2],count[3]+points[row][col][3]};
				end
			end
			local pivot ={count[1]/#coord,count[2]/#coord,count[3]/#coord};
			local targetPos = {row = v[1], col = v[2]}
			-- Log( "中心点："..tostring(pivot).."\t 目标坐标:"..v[1]..","..v[2]);
			table.insert(tab, {pivot = pivot, targetPos = targetPos})
		end
		offsetList[formationType] = tab;
	end
	return offsetList[formationType];
end

function Update()
	if isZoom~=true and infoView and this.isLZoom~=false then
		local mouseScrollValue = UnityEngine.Input.GetAxis("Mouse ScrollWheel");
		if mouseScrollValue ~= 0 then
			SetClickState();
		end
	end

	-- 	if alphaCameraTimer ~= -1 then
	-- 		if alphaCameraTimer > 0 then
	-- 			alphaCameraTimer = alphaCameraTimer - Time.deltaTime;
	-- 		else
	-- 			alphaCameraTimer = -1
	-- 			CSAPI.SetGOActive(AplhaCamera.gameObject,false)
	-- 		end
	-- 	end
	
	-- alphaCameraTimer = alphaCameraTimer + Time.deltaTime;
	-- if alphaCameraTimer / alphaCameraInterval > 1 then
	-- 	local cacheState = AplhaCamera.gameObject.activeSelf
	-- 	if cacheState == true then
	-- 		CSAPI.SetGOActive(AplhaCamera.gameObject,false)
	-- 		alphaCameraTimer = 0
	-- 	else
	-- 		CSAPI.SetGOActive(AplhaCamera.gameObject,true)
	-- 		alphaCameraTimer = alphaCameraInterval - 0.01
	-- 	end
	-- end
end

function ShowAplhaCameraWithTime(timeCache)
	if timeCache ~= 0 then CSAPI.SetGOActive(AplhaCamera.gameObject,true) end
	alphaCameraTimer = -timeCache
	-- CSAPI.SetGOActive(AplhaCamera.gameObject,true)
	-- alphaCameraTimer = timeCache
end

function CleanCache()
	targetKey = nil;
	CleanCard();
end

function CleanCard()
	if clickID then
		ClearClickID();
		RefreshGrids();
	end
	for _,v in pairs(models) do
		v.Remove();
	end
	for _,v in pairs(uiItems) do
		v.Close();
	end
end

--返回拖拽的队列数据
function GetDragList()
	return dragList;
end

function GetIsChange()
	return dragList~=nil;
end

--设置是否显示光环
function SetHaloEnable(isEnable)
	this.enableHalo=isEnable or false;
end

----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()     
gameObject=nil;
transform=nil;
modelRoot=nil;
SideNode=nil;
ModelCamera=nil;
BGCamera=nil;
BFCamera=nil;
BHUDCamera=nil;
AplhaCamera=nil;
ModelParent=nil;
rotateNode=nil;
FormationGrid=nil;
formationGrids=nil;
modelNode=nil;
for r=1,3 do
	for c=1,3 do
		this[r.."-"..c]=nil;
	end
end
goRaw=nil;
UINode=nil;
view=nil;
this=nil; 
end
----#End#----