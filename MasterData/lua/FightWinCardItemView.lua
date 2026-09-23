local cardData = nil;
local slider = nil;
local current = 0;
local max = 0;
local text_exp = nil;
local expBar = nil;

local isRun = false;
local currentMaxExp = 0;
local currentExp = 0;
local currentAddExp = 0;
local data=nil;
local grid=nil;
function Awake()
	slider = ComUtil.GetCom(goBar, "Slider");
	text_exp = ComUtil.GetCom(txt_expVal, "Text");
	expBar = ExpBar.New();
end

function SetByItem(teamItem)
	data=teamItem;
	cardData = teamItem:GetCard();
	CSAPI.SetGOActive(lvUpObj,false);
	CSAPI.SetGOActive(expObj,true);
	if grid==nil then
        local go=ResUtil:CreateUIGO("RoleCard/RoleLittleCard",childNode.transform);
        grid=ComUtil.GetLuaTable(go);
	end 
	if data.bIsNpc then --NPC
		grid.SetIcon(data:GetSmallImg())
		grid.SetBgIcon(data:GetQuality())
		grid.SetHeight(data:GetQuality());
		grid.SetStar(data:GetQuality())
		grid.SetLv(data:GetLv())  
		grid.SetEmpty(false);
	else
		grid.Refresh(data:GetCard());
	end
	grid.ActiveClick(false);
	-- grid.Refresh(data);
	-- SetIcon(teamItem:GetSmallImg());
	-- SetLv(teamItem:GetLv())
end

function SetIcon(img)
	ResUtil.RoleCard:Load(icon,img,false);
end

function SetLv(val)
	CSAPI.SetText(lv,tostring(val));
end

function SetExp(expAdd)
	if data==nil or (data and data.bIsNpc) or(data and data.fuid~=nil) then --NPC和助战不加经验
		return;
	end
	if cardData == nil then
		LogError("没有获取到卡牌数据！");
		return;
	end
	local maxLv = cardData:GetMaxLv();
	if maxLv == cardData:GetLv() then
		text_exp.text = "0";
		SetProgress(1);
	else
		local oldLv, oldExp = GetBeforCardInfo(expAdd);
		if oldLv<cardData:GetLv() then
			--升级
			CSAPI.SetGOActive(lvUpObj,true);
			CSAPI.SetGOActive(expObj,false);
		end
		text_exp.text=tostring(expAdd);
		expBar:Begin(oldLv, oldExp,cardData:GetLv() ,cardData:GetEXP(), expAdd, maxLv, SetProgress, GetUpLevelExp, RefreshLvText);
	end
end

function SetProgress(val)
	slider.value=val;
end

function GetUpLevelExp(lv)
	return cardData and RoleTool.GetExpByLv(lv) or 0 
end

function RefreshLvText(val)
	-- CSAPI.SetText(lv,tostring(val));
end

function Update()
	if expBar then
		expBar:Update();
	end
end

--返回升级前的卡牌等级和经验值
function GetBeforCardInfo(expAdd)
	local lv = cardData:GetLv();
	local exp = 0;
	local currentExp = cardData:GetEXP();
	if currentExp >= expAdd then
		exp = currentExp - expAdd;
	else
		expAdd = expAdd - currentExp;
		while(true) do
			lv = lv - 1;
			local maxExp = RoleTool.GetExpByLv(lv)
			if expAdd > maxExp then
				expAdd = expAdd - maxExp;
			else
				exp = maxExp - expAdd;
				break;
			end
		end
	end
	return lv, exp;
end 