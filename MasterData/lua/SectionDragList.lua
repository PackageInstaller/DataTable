--章节拖拽面板
local items = {} --当前显示的item列表
local displayItems={} --当前隐藏的item列表
local topItem = nil
local downItem = nil
local downSpeed = 30       --惯性阻尼

local clickTarget=nil;--点击响应

local discPress = false
local addX = 0
local datas={};
local selectedItem=nil;--选中的物体
local onItemInit=nil;--初始化格子的方法
local onClickItem=nil;--点击子物体的回调
local distance=0;
local moveTime=0.5;--移动时间
local nowTime=0;
function Awake()
	clickTarget=ComUtil.GetCom(gameObject,"Image");
end

--data：list:数据数组,selectIndex:当前选中下标,onItemInit:格子初始化方法
function SetData(data)
	Clear();
	if items~=nil and #items>0 then
		for k,v in ipairs(items) do
			v.SetSelectState(false);
			table.insert(displayItems,v);
            CSAPI.SetGOActive(v.gameObject,false);
		end
		items={};
    end
    if data then
        datas=data.list;
		onItemInit=data.onItemInit;
		onClickItem=data.onClickItem;
        CreateChild(data.selectIndex or 1);
    end
end

function Clear()
    discPress=false;
    addX=0;
    topItem = nil;
    downItem = nil;
    selectedItem=nil;
    onItemInit=nil;
    datas={};
end

function Update()
	if(not discPress and addX ~= 0) then
		if(math.abs(addX) < 2) then
			addX = 0
			RunEnd()
		else
			addX = addX > 0 and addX - Time.deltaTime * downSpeed or addX + Time.deltaTime * downSpeed
			Run(addX)
		end
	end
	if addX==0 and distance~=0 then
		if nowTime>=moveTime then
			nowTime=moveTime;
			MoveEnd();
			distance=0;
			nowTime=0;
		else
			nowTime=nowTime+Time.deltaTime;
			Move();
		end		
	end
end

--==============================--
--desc:创建子物体
--time:2019-11-22 03:54:48
--@showIndex: 设置当前选中的是第几个
--@return 
--==============================--
function CreateChild(showIndex)
	showIndex=showIndex or 1;
	local mIndex = #datas - showIndex + 1
	
	--由上往下加
	for i = #datas, 1, - 1 do
		local rIndex = 0
		if(i >= mIndex) then
			rIndex = i - mIndex
		else
			rIndex = mIndex - i
		end
		if displayItems[1]==nil then
			local gItem = ResUtil:CreateUIGO("Section/SectionItem", content.transform)
			item = ComUtil.GetLuaTable(gItem)
		else
			item=displayItems[1];
			table.remove(displayItems,1);--从隐藏列表中删除
			CSAPI.SetGOActive(item.gameObject,true);
		end
		item.SetIndex(i);
		if onItemInit then
            onItemInit(item,datas[#datas-i+1]);
		end
		item.SetAnchor(mIndex, rIndex)
		item.SetClickCallBack(OnClickItem);
		item.SetDragCallBack(BeginDrag, Drag, EndDrag);
		table.insert(items, item)	
		if item.GetX()==0 then
			selectedItem=item;
			-- item.SetOffset(-70,0,0);
			-- item.SetScale(0.6);
			-- item.SetSelectState(true);
		end
	end
	topItem = items[1]
	downItem = items[#items]
end

function OnClickItem(item)
	if onClickItem and discPress==false then
		onClickItem(item);
	end
end

--==============================--
--@showIndex: 选中指定的节点
--@return 
--==============================--
function MoveToItem(item,callBack)
	discPress=true;
	moveCallBack=callBack;
	if item~=nil and  items~=nil and #items>0 then
		minX=item.GetX();
		if(minX ~= 0) then
			if selectedItem then
				selectedItem.SetSelectState(false);
			end
			distance=-minX;
		end
    end
end

--点击对齐的移动
function Move()
	local minX=Lerp(0,distance,nowTime/moveTime);
	for i, v in ipairs(items) do
		local x=v.GetX()+minX;
		v.SetNowPos(x);
	end
end

--点击移动
function MoveEnd()
	for i, v in ipairs(items) do
		local x=v.GetX()+distance;
		v.SetNowPos(x);
		v.x=x;--更新v的x值
		if(x == 0) then
            selectedItem=v;
		end
	end
	if selectedItem then
		selectedItem.SetSelectState(true);
	end
	if moveCallBack then
		moveCallBack();
	end
	discPress=false;
end

function Lerp(min,max,time)
	return min+(max-min)*time;
end

--滑动
function Run(_addX)
	local X = _addX
	if(X > 0) then
		local downX = CSAPI.GetAnchor(downItem.gameObject)
		if(downX > 0) then
			X = 0
			addX = 0.1 
			return
		elseif((downX + X) > 0) then
			X = - downX + 1
		end
	else
		local topX = CSAPI.GetAnchor(topItem.gameObject)
		if(topX < 0) then
			X = 0
			addX = 0.1 
			return
		elseif((topX + X) < 0) then
			X = - topX - 1
		end
	end
	for i, v in ipairs(items) do
		v.SetMove(X)
	end
	if onRunning then
		onRunning();
	end
end


--最靠近的居中
function RunEnd()
    local minX = 0
    selectedItem=nil;
	for i, v in ipairs(items) do
		local x = math.abs(v.GetX())
		if(minX == 0) then
            minX = x
            selectedItem=v;
		elseif(minX > x) then
            minX = x
            selectedItem=v;
		end
	end
	minX=selectedItem.GetX();
	if(minX ~= 0) then
		for i, v in ipairs(items) do
			v.SetNowPos(v.GetX()-minX);
		end
	end
	if selectedItem then--显示细节
		selectedItem.SetSelectState(true);
	end
	if onRunEnd then
		onRunEnd();
	end
end


function BeginDrag()
	discPress = true
	--隐藏细节
	if selectedItem then
        selectedItem.SetSelectState(false);
    end
end

function Drag(_addY)
	addX = _addY
	Run(addX)
end

function EndDrag()
	discPress = false
end


function OnBeginDragXY(x,y)
    BeginDrag();
    perY = 0;
end

function OnDragXY(x,y)
	if(perY == 0) then
		perY = y
		addX=1;
	elseif(perY ~= y) then
		Drag(y - perY)
		perY = y
	end
end

function OnEndDragXY(x,y)
    EndDrag()
end

function OnClickBg()
	CSAPI.SetGOActive(gameObject, false)
end

--返回当前选中的对象
function GetSelectedItem()
    return selectedItem;
end

--添加移动中的回调方法
function AddRunCall(running,runEnd)
	onRunning=running;
	onRunEnd=runEnd;
end
