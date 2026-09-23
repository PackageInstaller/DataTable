local func=nil;
local showBtn=false;
local elseData=nil;
local choosieNum=0;
local maxNum=0;
local func2=nil;--数量变更事件
local elseData=nil;

--礼包详情ITEM data:{id,num,type,cfg}
function Refresh(_d,_elseData)
	--初始化格子
	isClick=false;
	this.data=_d;
	elseData=_elseData;
	if this.data then
		local useNum=0;
		if _elseData then
			local baseNum=_elseData.useNum or 0;
			useNum=baseNum*_d.num;--被选中的格子自动计算当前数量
			maxNum=_elseData.maxNum or 0;
			choosieNum=baseNum;
		end
		SetCurNum(choosieNum or 0)
		local d={id=_d.id,num=useNum,type=_d.type};
		local goodsData, clickCB = GridFakeData(d,true)
		if goodsData ~= nil then
			if this.grid==nil then
				this.grid = ResUtil:CreateRewardByData(goodsData, gridNode.transform);
			else
				this.grid.Refresh(goodsData);
			end
			this.grid.SetClickCB(OnClickGrid);
		end
	end
end 

function SetClickCB(clickFunc2)
	func2=clickFunc2;
end

function OnClickGrid(tab)
	if tab.data:GetClassType()=="CharacterCardsData" then
		CSAPI.OpenView("RoleInfo", tab.data)
	else
		local goods=BagMgr:GetFakeData(tab.data:GetCfgID());
		UIUtil:OpenGoodsInfo(goods, 4);
	end
	
end

--点击
function OnClickSelf(item)
	if func then
		func(this);
	end
end

function SetCurNum(num)
	if num then
		choosieNum=num;
		CSAPI.SetText(txtNum,tostring(choosieNum));
		CSAPI.SetGOAlpha(btnAdd,maxNum<=0 and 0.5 or 1);
		CSAPI.SetGOAlpha(btnRemove,choosieNum<=0 and 0.5 or 1);
	end
end

function OnClickAdd()
	if maxNum>0 then
		SetCurNum(choosieNum+1);
	end
	if func2 then
		func2(this);
	end
end

function GetChoosieNum()
	return choosieNum or 0;
end

function OnClickRemove()
	if choosieNum-1>=0 then
		SetCurNum(choosieNum-1);
	end
	if func2 then
		func2(this);
	end
end

function OnClickNum()
	CSAPI.OpenView("NumSelectView",{maxNum=choosieNum+maxNum,curNum=choosieNum,item=elseData.item,cb=OnCloseNumSelect});
end

function OnCloseNumSelect(num)
	SetCurNum(num);
	if func2 then
		func2(this);
	end
end

function OnDestroy()    
    ReleaseCSComRefs();
end

----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()     
gameObject=nil;
transform=nil;
this=nil;  
gridNode=nil;
btnClick=nil;
view=nil;
end
----#End#----