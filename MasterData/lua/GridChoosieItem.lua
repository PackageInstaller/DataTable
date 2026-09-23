local func=nil;
local showBtn=false;
local elseData=nil;
--礼包详情ITEM data:{id,num,type,cfg}
function Refresh(_d,_elseData)
	--初始化格子
	isClick=false;
	this.data=_d;
	if this.data then
		local useNum=_d.num;
		if _elseData then
			isClick=_elseData.isSelect
			local baseNum=_elseData.useNum or 0;
			useNum=baseNum*_d.num;--被选中的格子自动计算当前数量
		end
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
	CSAPI.SetGOActive(stateObj,isClick==true);
end 

function SetClickCB(clickFunc)
	func=clickFunc;
end

function OnClickGrid(tab)
	if tab.data:GetClassType()=="CharacterCardsData" then
		-- local cardData = RoleMgr:GetMaxFakeData(tab.data:GetCfgID())
    	-- CSAPI.OpenView("RoleInfo", cardData)
		CSAPI.OpenView("RoleInfo", tab.data)
	-- elseif tab.data:GetClassType()=="EquipData" then
	-- 	-- GridClickFunc.EquipDetails(tab);
	-- 	CSAPI.OpenView("EquipDetails",tab);
	else
		local goods=BagMgr:GetFakeData(tab.data:GetCfgID());
		UIUtil:OpenGoodsInfo(goods, 4);
	end
	
end

--点击
function OnClickSelf(item)
	isClick=not isClick;
	CSAPI.SetGOActive(stateObj,isClick==true);
	if func then
		func(this);
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