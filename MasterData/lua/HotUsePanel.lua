local curCount = 1
local maxCount = 0

function Awake()	
	m_Slider = ComUtil.GetCom(numSlider, "Slider")
	CSAPI.AddSliderCallBack(numSlider, SliderCB)
	
	btnSure_cg = ComUtil.GetOrAddCom(btnUse, "CanvasGroup")
end

function OnOpen()
	itemInfo = data
	-- --name
	-- CSAPI.SetText(txtName, itemInfo:GetName())
	-- --desc
	-- CSAPI.SetText(txtDesc, itemInfo:GetDesc())
	CheckMax()
	-- SetCount()
	Refresh()
end

function Refresh()
	--grid
	if gridItem == nil then
		_, gridItem = ResUtil:CreateGridItem(gridNode.transform)
	end
	gridItem.Refresh(itemInfo, {isClick = false})
	--gridItem.SetCount()
	CSAPI.SetText(txt_name, itemInfo:GetName())
	CSAPI.SetText(txt_desc, itemInfo:GetDesc())
	--获取途径
	CreateGetInfo()
end

function CreateGetInfo()
	local infos = itemInfo.GetGetWayInfo and itemInfo:GetGetWayInfo() or nil;
	local combineInfo = itemInfo.GetCombineGetInfo and itemInfo:GetCombineGetInfo() or nil;
	local jOhterInfo = itemInfo.GetJOtherGetInfo and itemInfo:GetJOtherGetInfo() or nil;
	local tOhterInfo = itemInfo.GetTOtherGetInfo and itemInfo:GetTOtherGetInfo() or nil;
	if infos == nil and combineInfo == nil and jOhterInfo == nil and tOhterInfo == nil then
		hasGet = false;
	else
		hasGet = true;
		local cIsShow, bIsShow, oIsShow = false,false,false;
		HideItems(getItems);
		HideItems(buildItems);
		HideItems(otherItems);
		HideItems(otherItems2);
		if infos and #infos > 0 then
			cIsShow = true;
			CreateGetItem(infos, "GetWayItem/GoodsGetWayItemNew", getItems, chapterRoot, JumpCall);
		end
		if combineInfo and #combineInfo > 0 then
			bIsShow = true;
			-- local isCombineOpen=CSAPI.IsViewOpen("MatrixCompound");
			-- local isCombineDis=isDisable;
			-- if isCombineOpen and isDisable==true then
			-- 	isCombineDis=true;
			-- end
			CreateGetItem(combineInfo, "GetWayItem/GoodsGetWayItemNew", buildItems, buildRoot, JumpCall);
		end
		if jOhterInfo and #jOhterInfo > 0 then
			oIsShow = true;
			CreateGetItem(jOhterInfo, "GetWayItem/GoodsGetWayItemNew", otherItems, otherRoot, JumpCall);
		end
		if tOhterInfo and #tOhterInfo > 0 then
			oIsShow = true;
			CreateGetItem(tOhterInfo, "GetWayItem/GoodsGetWayItemText", otherItems2, otherRoot);
		end
		CSAPI.SetGOActive(chapterGet, cIsShow);
		CSAPI.SetGOActive(buildGet, bIsShow);
		CSAPI.SetGOActive(otherGet, oIsShow);
	end
end

function HideItems(itemList)
	for k, v in ipairs(itemList) do
		CSAPI.SetGOActive(v.gameObject, false);
	end
end


function CreateGetItem(arr, itemPath, itemList, parent, call)
	for k, v in ipairs(arr) do
		local isDisable = false;
		if data and data.key then
			isDisable = JumpMgr.IsDisableJump(data.key, v.jumpId);
		end
		if k > #itemList then
			ResUtil:CreateUIGOAsync(itemPath, parent, function(go)
				local lua = ComUtil.GetLuaTable(go);
				lua.Refresh(v, isDisable);
				lua.SetJumpCall(call);
				table.insert(itemList, lua);
			end)
		else
			CSAPI.SetGOActive(itemList[k].gameObject, true);
			itemList[k].Refresh(v, isDisable);
		end
	end
end

function JumpCall(d)
	local cfg = Cfgs.CfgJump:GetByID(d.jumpId);
	if cfg and cfg.sName then
		local cfg2 = Cfgs.view:GetByKey(cfg.sName);
		local isLast = CSAPI.IsLastOpenedView(cfg.sName) --是否是最后打开的全屏界面
		if cfg2 and cfg2.is_window ~= 1 then --跳转到窗口时不关闭所有界面
			if not isLast then
				CSAPI.CloseAllOpenned();
			else
				Close();
			end
		end
	end
end

function CheckMax()
	--需要的数量
	local cur = PlayerClient:Hot()
	local max1, max2 = PlayerClient:MaxHot()
	local value2 = data:GetCfg().dy_value2
	local needCount = math.floor((max2 - cur) / value2)
	--拥有的数量
	local hadCount = data:GetCount()
	maxCount = hadCount >= needCount and needCount or hadCount
	m_Slider.maxValue = maxCount == 0 and 1 or maxCount
	curCount = curCount > maxCount and maxCount or curCount
	
	btnSure_cg.alpha = maxCount <= 0 and 0.3 or 1
	
	CSAPI.SetText(txt_num, "" .. math.floor(curCount))
end

function SliderCB(_num)
	curCount = _num
	CSAPI.SetText(txt_num, "" .. math.floor(curCount))
end

function SetCount()
	m_Slider.value = curCount
end

function OnClickAdd()
	curCount = curCount + 1 > maxCount and maxCount or curCount + 1
	SetCount()
end

function OnClickRemove()
	curCount = curCount - 1 < 0 and 1 or curCount - 1
	SetCount()
end


function OnClickUse()
	if(maxCount <= 0) then
		return
	end
	local _cnt = curCount <= 0 and 1 or curCount
	local proto = {"PlayerProto:UseItem", {info = {id = data:GetID(), cnt = _cnt}}}
	NetMgr.net:Send(proto)
	view:Close()
end

function OnClickMask()
	view:Close()
end
