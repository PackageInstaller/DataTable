--礼包信息界面
local item = nil;
local rewardCfg = nil;
local items=nil;
local selectID=nil;
local layout=nil;
local useNum=0;
local maxNum=0;
local minNum = 1;--最少使用数量
local needUseNum=0;--本次需求量
local needNum=0;
local needCfgId=nil;
local targetNum=0;--使用单个礼包时获取目标物品的数量
local curUseList={

}
-- local eventMgr=nil;

function Awake()
	layout = ComUtil.GetCom(vsv, "UISV");
	layout:Init("UIs/Goods/GiftSelectItem",LayoutCallBack,true)
	-- eventMgr = ViewEvent.New();
	-- eventMgr:AddListener(EventType.Bag_Update, OnBagChange);
end

-- function OnDestroy()
-- 	eventMgr:ClearListener();
-- end

function LayoutCallBack(index)
	local _data = curDatas[index]
	local grid=layout:GetItemLua(index);
	local elseData={isSelect=false,useNum=curUseList[_data.cfg.index] or 0,maxNum=maxNum-useNum,item=item};
	grid.Refresh(_data,elseData);
	grid.SetClickCB(OnChoosieNumChange);
end

function OnOpen()
	-- UIUtil:ShowAction(child,function()
		if data ~= nil then
			item = data.info;
			rewardCfg = data.rewardCfg;
			needCfgId=data.needCfgId;
			needNum=data.needNum;
			if needCfgId then
				targetNum=BagMgr:GetCount(needCfgId)+needNum;
			else
				targetNum=0;
			end
			SetData();
			CSAPI.SetText(txt_title,item:GetName());
			CSAPI.SetGOActive(btn_open,data.showBtn);
			Refresh();
		end
	-- end, UIUtil.active2);
end

function SetData()
	--初始化礼品礼包中的物品
	curDatas={};
	curUseList={}
	LoadCfgs(rewardCfg,1);
end

function LoadCfgs(cfg,count)
	if cfg then
		if cfg.type == RewardRandomType.FIXED then --只显示固定类型
			local list = cfg.item;
			if list then
				for k, v in ipairs(list) do
					if v.type == RewardRandomType.FIXED then
						local rCfg = Cfgs.RewardInfo:GetByID(v.id);
						LoadCfgs(rCfg,v.count);
					else
						if needCfgId and needNum>0 and v.id==needCfgId then
							needUseNum=math.floor(needNum/v.count+0.5);
							selectID=k;
						end
						table.insert(curDatas,{id=v.id,type=v.type,num=v.count,cfg=v});
					end
				end
			end
		elseif cfg.type==RewardRandomType.SINGLE_SELECT then --选择固定类型
			local list=cfg.item;
			if list then
				for k,v in ipairs(list) do
					if needCfgId and needNum>0 and v.id==needCfgId then
						needUseNum=math.floor(needNum/v.count+0.5);
						selectID=k;
					end
					table.insert(curDatas,{id=v.id,type=v.type,num=v.count,cfg=v});
				end
			end
		else	--随机，随机不做需求判定
			table.insert(curDatas,{id=cfg.id,type=cfg.type,num=count,cfg=cfg});
		end
	end
end

--初始化礼包
function Refresh()
	maxNum=item:GetCount()<g_MaxUseItem and item:GetCount() or g_MaxUseItem;
	CSAPI.SetText(txt_currNum,tostring(item:GetCount()));
	if needNum and needNum>0 and needCfgId~=nil and needUseNum~=0 then
		CSAPI.SetGOActive(needObj,true);
		CSAPI.SetText(txtNeedNum,LanguageMgr:GetByID(24048,needUseNum));
		useNum=maxNum>=needUseNum and needUseNum or maxNum;
		curUseList[selectID]=useNum;--需要的数量
	else
		CSAPI.SetGOActive(needObj,false);
	end
	-- LogError(needUseNum.."\t"..tostring(needNum).."\t"..tostring(needCfgId).."\t"..tostring(useNum))
	CSAPI.SetText(txt_useNum, tostring(useNum).."/"..tostring(maxNum));
	if selectID then
		layout:IEShowList(#curDatas,nil,selectID);
	else
		layout:IEShowList(#curDatas)
	end
end

--礼包数量变更
function OnChoosieNumChange(lua)
	if lua then
		curUseList[lua.data.cfg.index]=lua.GetChoosieNum();
		useNum=0;
		for k, v in pairs(curUseList) do
			useNum=useNum+v;
		end
		CSAPI.SetText(txt_useNum, tostring(useNum).."/"..tostring(maxNum));
		layout:UpdateList();
	end
end

function OnClickAnyWay()
	Close();
end

function Close()
	UIUtil:HideAction(child, function()
		if  IsNil(gameObject)~=nil and IsNil(view)~=nil then
			view:Close();
		end
	end, UIUtil.active4);
end

--点击购买
function OnClickOpen()
	if next(curUseList)~=nil and useNum>0 then
		local index=nil;
		local id= item:GetID();
		local data=item:GetData();
		if data and data.get_infos and #data.get_infos>0 then
			index=data.get_infos[1].index;
			id=item:GetCfg().to_item_id;
		end
		local list={};
		for k, v in pairs(curUseList) do
			table.insert(list,{
				id=id,
				ix=index,
				cnt=v,
				arg1=k,
			});
		end
		--打开礼包
		PlayerProto:UseItemList(list, true,OnUseRet);
		if needUseNum>0 and needCfgId~=nil then
			do return end
		end
		Close();
	else
		Tips.ShowTips(LanguageMgr:GetByID(24028))
	end	
end

function OnDestroy()    
    ReleaseCSComRefs();
end

function SetBtnState(btn, img, enable)
	if btn then
		-- local color = enableColor;
		if enable then
			btn.enabled = enable;
		else
			btn.enabled = false;
			-- color = disableColor;
		end
		-- if img then
		-- 	CSAPI.SetImgColor(img.gameObject, color[1], color[2], color[3], color[4]);
		-- end
	end
end

function OnClickAdd()
	if useNum < maxNum then
		useNum = useNum + 1;
		CSAPI.SetText(txt_useNum, tostring(useNum));
		layout:UpdateList();
	else
		Tips.ShowTips(LanguageMgr:GetByID(24025));			
	end
	-- SetBtnState(removeBtn, removeImg, useNum > 1);
	-- SetBtnState(addBtn, addImg, useNum < maxNum);
end

function OnClickRemove()
	if useNum > minNum then
		useNum = useNum - minNum;
		CSAPI.SetText(txt_useNum, tostring(useNum));	
		layout:UpdateList();
	else
		Tips.ShowTips(LanguageMgr:GetByID(24026));	
	end
	-- SetBtnState(removeBtn, removeImg, useNum > 1);
	-- SetBtnState(addBtn, addImg, useNum < maxNum);
end

function OnClickMax()
	useNum = maxNum;
	-- SetBtnState(removeBtn, removeImg, useNum > 1);
	-- SetBtnState(addBtn, addImg, false);
	CSAPI.SetText(txt_useNum, tostring(useNum));	
	layout:UpdateList();
end 

function OnClickMin()
	useNum = minNum;
	-- SetBtnState(removeBtn, removeImg, useNum > 1);
	-- SetBtnState(addBtn, addImg, useNum < maxNum);
	CSAPI.SetText(txt_useNum, tostring(useNum));	
	layout:UpdateList();
end

function OnUseRet(proto)
	-- if proto and proto.gets and needCfgId and needCfgId==proto.id then
	-- 	for k, v in ipairs(proto.gets) do
	-- 		if needCfgId==v.id then
	-- 			needNum=needNum-v.num;
	-- 		end
	-- 	end
	-- 	needNum=needNum<=0 and 0 or needNum;
	if proto and proto.infos and needCfgId then
		-- needUseNum=needUseNum-proto.info.cnt;
		-- needUseNum=needUseNum>0 and needUseNum or 0;
		local count=BagMgr:GetCount(needCfgId);
		needNum=count>=targetNum and 0 or targetNum-count; 
		item=BagMgr:GetFakeData(item:GetID());
		EventMgr.Dispatch(EventType.Goods_GiftFilter_GetRet,needNum)
		if item:GetCount()<=0 or needNum<=0 then
			Close();
			do return end;
		end
	end
	SetData();
	Refresh();
end

function OnClickQuestion()
	Tips.ShowTips(LanguageMgr:GetTips(16012));
end

----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()     
gameObject=nil;
transform=nil;
this=nil;  
child=nil;
name=nil;
gridNode=nil;
Content=nil;
text_open=nil;
text_tips=nil;
view=nil;
end
----#End#----