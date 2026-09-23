--材料显示 
local lens = {296, 148, 0}
local ids = {11003, ITEM_ID.DIAMOND, ITEM_ID.GOLD}

function OnEnable()
	eventMgr = ViewEvent.New()
	eventMgr:AddListener(EventType.Bag_Update, function()
		RefreshPanel(curIDs)
	end)
end

function OnDisable()
	eventMgr:ClearListener()
end

function RefreshPanel(_ids)
	curIDs = _ids == nil and ids or _ids
	local len = #curIDs > 3 and 3 or #curIDs
	
	if maxObj ~= nil then
		SetBGLen(len)
		CSAPI.SetGOActive(maxObj, false)
	end
	for i = 1, 3 do
		if(i <= len) then
			SetTop(i, curIDs[i])
		end
		CSAPI.SetGOActive(this["btn" .. i], len >= i)
	end
end

function SetBGLen(len)
	local x = lens[len]
	CSAPI.SetAnchor(bg, x, 0, 0)
end

function SetTop(i, _id)
	local _icon = this["icon" .. i]
	local _txt = this["txtCount" .. i]
	if(_id) then
		local iconName = Cfgs.ItemInfo:GetByID(_id).icon
		--CSAPI.LoadImg(_icon, "UIs/Top/" .. iconName .. ".png", true, nil, true)
		ResUtil.IconGoods:Load(_icon, iconName, true)
		local num = BagMgr:GetCount(_id)
		CSAPI.SetText(_txt, num and num .. "" or "0")
		
		if(_id == ITEM_ID.GOLD and maxObj ~= nil) then
			CSAPI.SetGOActive(maxObj, true)
			CSAPI.SetText(txtMax, "MAX:" .. PlayerClient:GetGoldMax())
			CSAPI.SetParent(maxObj, this["btn" .. i])
			CSAPI.SetAnchor(maxObj, 33.6, 0, 0)
		end
	end
end


function OnClick1()
	Click(1)
end

function OnClick2()
	Click(2)
	
end

function OnClick3()
	Click(3)
end

function Click(index)
	if(index <= #curIDs) then
		if(curIDs[index] == 11003) then
			JumpMgr:Jump(140002)
		elseif(curIDs[index] == ITEM_ID.DIAMOND) then
			JumpMgr:Jump(140001)
		elseif(curIDs[index] == ITEM_ID.GOLD) then
			JumpMgr:Jump(140004)
		else
		end
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
bg=nil;
btn1=nil;
icon1=nil;
txtCount1=nil;
btn2=nil;
icon2=nil;
txtCount2=nil;
btn3=nil;
icon3=nil;
txtCount3=nil;
maxObj=nil;
txtMax=nil;
view=nil;
end
----#End#----