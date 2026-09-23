--装备信息界面（获得前）
local enableColor = {225, 116, 0, 255};
local disableColor = {77, 77, 77, 255};
local hasGet=false;
local getItems={};
local buildItems={};
local otherItems={};
local otherItems2={};
local itemInfo=nil;
local eventMgr=nil;
local grid=nil;
-- local defaultSize={0,0};
-- local slider=nil;
function Awake()
	CSAPI.PlayUISound("ui_popup_open")
	-- defaultSize=CSAPI.GetRTSize(svc);
end

function OnEnable()
	eventMgr = ViewEvent.New();
	eventMgr:AddListener(EventType.View_Lua_Closed, this.OnViewClose);
end

function OnDisable()
	eventMgr:ClearListener();
end

function OnViewClose(event)
	if data and data.key==event then
		Close();
	end
end

function OnOpen()
	if data then
		itemInfo=data.data;
	end
	Refresh();
end

function Refresh()
	if itemInfo then
		--初始化物品信息
		if grid == nil then
			_, grid = ResUtil:CreateEquipItem(gridNode.transform);
		end
		grid.Refresh(itemInfo, {isClick = false});
		local cfg = itemInfo:GetCfg();
		local quality=itemInfo:GetQuality();
		ResUtil:LoadBigImg(gridNode, string.format("UIs/Goods/img_06_0%s" ,quality or 1), true);
		CSAPI.SetText(txt_name, itemInfo:GetName());
		CSAPI.SetText(txt_desc, itemInfo:GetDesc());
		if cfg then
			local showGets=true;
			if showGets then
				--显示获取途径
				CreateGetInfo();
			else
				CSAPI.SetGOActive(chapterGet,false);
				CSAPI.SetGOActive(buildGet,false);
				CSAPI.SetGOActive(otherGet,false);
			end
		end
	end
end

function CreateGetInfo()
	local infos=itemInfo.GetGetWayInfo and itemInfo:GetGetWayInfo() or nil;
	local combineInfo=itemInfo.GetCombineGetInfo and itemInfo:GetCombineGetInfo() or nil;
	local jOhterInfo=itemInfo.GetJOtherGetInfo and itemInfo:GetJOtherGetInfo() or nil;
	local tOhterInfo=itemInfo.GetTOtherGetInfo and itemInfo:GetTOtherGetInfo() or nil;
	if infos==nil and combineInfo==nil and jOhterInfo==nil and tOhterInfo==nil then
		hasGet=false;
	else
		hasGet=true;
		local cIsShow,bIsShow,oIsShow=false,false,false;
		HideItems(getItems);
		HideItems(buildItems);
		HideItems(otherItems);
		HideItems(otherItems2);
		if infos and #infos>0 then
			cIsShow=true;
			CreateGetItem(infos,"GetWayItem/GoodsGetWayItemNew",getItems,chapterRoot,JumpCall);
		end
		if combineInfo and #combineInfo>0 then
			bIsShow=true;
			-- local isCombineOpen=CSAPI.IsViewOpen("MatrixCompound");
			-- local isCombineDis=isDisable;
			-- if isCombineOpen and isDisable==true then
			-- 	isCombineDis=true;
			-- end
			CreateGetItem(combineInfo,"GetWayItem/GoodsGetWayItemNew",buildItems,buildRoot,JumpCall);
		end
		if jOhterInfo and #jOhterInfo>0 then
			oIsShow=true;
			CreateGetItem(jOhterInfo,"GetWayItem/GoodsGetWayItemNew",otherItems,otherRoot,JumpCall);
		end
		if tOhterInfo and #tOhterInfo>0 then
			oIsShow=true;
			CreateGetItem(tOhterInfo,"GetWayItem/GoodsGetWayItemText",otherItems2,otherRoot);
		end
		CSAPI.SetGOActive(chapterGet,cIsShow);
		CSAPI.SetGOActive(buildGet,bIsShow);
		CSAPI.SetGOActive(otherGet,oIsShow);
	end
end

function HideItems(itemList)
	for k,v in ipairs(itemList) do
		CSAPI.SetGOActive(v.gameObject,false);
	end
end

function CreateGetItem(arr,itemPath,itemList,parent,call)
	for k,v in ipairs(arr) do
		local isDisable=false;
		if data and data.key then
			isDisable=JumpMgr.IsDisableJump(data.key,v.jumpId);
		end
		if k>#itemList then
			ResUtil:CreateUIGOAsync(itemPath,parent,function(go)
				local lua=ComUtil.GetLuaTable(go);
				lua.Refresh(v,isDisable);
				lua.SetJumpCall(call);
				table.insert(itemList,lua);
			end)
		else
			CSAPI.SetGOActive(itemList[k].gameObject,true);
			itemList[k].Refresh(v,isDisable);
		end
	end
end

function JumpCall(d)
	local cfg=Cfgs.CfgJump:GetByID(d.jumpId);
    if cfg and cfg.sName then
        local cfg2=Cfgs.view:GetByKey(cfg.sName);
		local isLast=CSAPI.IsLastOpenedView(cfg.sName) --是否是最后打开的全屏界面
		if cfg2 and cfg2.is_window~=1 then --跳转到窗口时不关闭所有界面
			if not isLast then
            	CSAPI.CloseAllOpenned();
			else
				Close();
			end
        end
    end
end

function OnClickReturn()
	Close();
end

function Close()
	CSAPI.SetGOActive(tweenObj2,true);
	FuncUtil:Call(function()
		view:Close();
	end,nil,180);
end

function OnClickBack()
	CSAPI.SetGOActive(root, true);
end
----#End#----