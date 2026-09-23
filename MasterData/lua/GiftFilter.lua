local curItemLua=nil;
local curItem=nil;
local layout=nil;
local curDatas={}
local eventMgr=nil;

function Awake()
	layout = ComUtil.GetCom(vsv, "UISV")
	layout:Init("UIs/Goods/GiftFilterGrid",LayoutCallBack,true)
    eventMgr = ViewEvent.New();
	eventMgr:AddListener(EventType.Goods_GiftFilter_GetRet, OnFilterGetRet);
end

function OnDestroy()
	eventMgr:ClearListener();
end

function OnOpen()
    Refresh();
end

function RefreshCurInfo()
    if curItem~=nil then
        CSAPI.SetText(txt_name, curItem:GetName());
        local cfg=curItem:GetCfg();
        if cfg then
			local loader=curItem:GetIconLoader();
			if loader then
				loader:Load(icon, curItem:GetIcon())
			end
			CSAPI.SetScale(icon,1,1,1);
			CSAPI.SetGOActive(btnDetails,false);
        end
        CSAPI.SetText(txtDesc, curItem:GetDesc());
        local quality=curItem:GetQuality();
		ResUtil:LoadBigImg(gridNode, string.format("UIs/Goods/img_06_0%s" ,quality or 1), true);
    end
end

function Refresh()
    if data and data.cfgId and data.needNum>0 then
        curDatas=BagMgr:GetPackagesByCfgID(data.cfgId)
        if curDatas==nil or (curDatas and #curDatas==0) then
            OnClickAnyWay();
            do return end
        end
        curItem=curItem or curDatas[1].goods
        local itemInfo=BagMgr:GetFakeData(data.cfgId);
        CSAPI.SetText(txt_title,LanguageMgr:GetByID(24047,itemInfo:GetName()));
        layout:IEShowList(#curDatas)
        RefreshCurInfo();
    end
end

function LayoutCallBack(index)
	local _data = curDatas[index]
	local _elseData={
        isClick = true, 
        isSelect = curItem and curItem:GetID()==_data.goods:GetID(),
        showNew=false
    };
	local grid=layout:GetItemLua(index);
    if curItemLua==nil and _elseData.isSelect then
        curItemLua=grid;
    end
	grid.Refresh(_data,_elseData);
	grid.SetClickCB(OnClickGrid);
end

function OnClickGrid(tab)
    if curItemLua~=tab then
        if curItemLua~=nil then
            curItemLua.SetChoosie(false);
        end
        curItemLua=tab
        curItem=tab.data.goods
        RefreshCurInfo();
        curItemLua.SetChoosie(true);
    end
end

--打开GiftInfo界面
function OnClickS()
    if curItem==nil then
        LogError("当前未选中任何礼包！");
        do return end
    end
    local cfg = curItem:GetCfg()
	if cfg == nil then
		LogError("获取配置表出错！")
		return
	end
	-- OnClickAnyWay();
	local rewardID = cfg.dy_value1
	local rewardCfg=Cfgs.RewardInfo:GetByID(rewardID);
	CSAPI.OpenView("GiftInfo",{info=curItem,rewardCfg=rewardCfg,showBtn=true,needNum=data.needNum,needCfgId=data.cfgId});
end

function OnClickAnyWay()
    view:Close();
end

function OnClickC()
    view:Close();
end

function OnClickDetails()
    if curItem==nil then
		return;
	end
	local cfg = curItem:GetCfg();
	if cfg and cfg.type==ITEM_TYPE.PANEL_IMG and cfg.dy_value1 then--多人插图,特殊处理
		CSAPI.OpenView("MulPictureView",{id=cfg.dy_value1,showMask=true});
	end
end

function OnFilterGetRet(needNum)
    if needNum==0 then
        OnClickC()
    else
        data.needNum=needNum;
        curItem=nil;
        Refresh();
    end
end