--特殊道具子物体
local idx = nil;
local clickFunc = nil;
local hasGoods = false;

function Awake()
	nameMove = ComUtil.GetCom(nameObj, "TextMove");
	tipMove = ComUtil.GetCom(tipObj, "TextMove");
end

function Init(index, cfgId, func)
	local goods = BagMgr:GetData(cfgId);
	idx = index;
	clickFunc = func;
	hasGoods = goods ~= nil;
	if goods == nil then
		goods = GoodsData();
		goods:InitCfg(cfgId);
	end
	local go, grid = ResUtil:CreateGridItem(gridNode.transform);
	grid.Refresh(goods);
	grid.SetCount(goods:GetCount());
	CSAPI.SetText(name, goods:GetName());
	CSAPI.SetText(tips, goods:GetDesc());
	--nameMove:SetMove();
	tipMove:SetMove();
	SetState(false);
	-- grid.SetIntensify();
end

function SetState(isChoosie)
	CSAPI.SetGOActive(state, isChoosie);
end

function GetIndex()
	return idx;
end

function OnClickSelf()
	if hasGoods == false then
		LanguageMgr:ShowTips(8006)
		return
	end
	if clickFunc then
		clickFunc(this);
	end
end
