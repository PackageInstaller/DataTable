local itemPath = "UIs/Grid/GridItem"
local curIndex = 0
curIndex1, curIndex2 = 1
local top=nil;
function Awake()	
	layout = ComUtil.GetCom(sv1, "UIInfinite")
	--layout:AddBarAnim(0.4, false)
	layout:Init(itemPath, LayoutCallBack, true)	
	animLua = UIInfiniteUtil:AddUIInfiniteAnim(layout, UIInfiniteAnimType.Diagonal)
end

function LayoutCallBack(index)	
	local lua = layout:GetItemLua(index)
	if(lua) then
		local _data = curDatas[index]
		lua.SetIndex(index)
		lua.SetClickCB(GridClickFunc.OpenInfoHandy)
		lua.Refresh(_data, {isClick = true})
		--lua.LoadFrame()
		lua.SetCount()
	end
end

-- function OnItemClickCB()
-- end
function OnInit()
	top=UIUtil:AddTop2("ArchiveGoodsListView", gameObject, function()
		view:Close()
	end, nil, "")
end

function OnOpen()
	CSAPI.PlayUISound("ui_popup_open")
	curIndex = 0
	SetTeamDatas()
	SetDatas()
	InitLeftPanel()
	RefreshPanel()
end

function SetTeamDatas()
	teamCfgs = Cfgs.CfgGoodsEnum:GetAll()
end

function SetDatas()
	datas = {}
	local cfgs = Cfgs.CfgArchiveGoods:GetAll()
	for i, v in pairs(cfgs) do
		if(v.bShowInAltas) then
			local goodsData = GoodsData({id = v.id, num = BagMgr:GetCount(v.id)});
			goodsData:InitCfg(v.id);
			table.insert(datas, goodsData)
		end
	end
	
	-- 排序
	table.sort(datas, function(a, b)
		local indexA = cfgs[a:GetID()]
		local indexB = cfgs[b:GetID()]
		if a:GetQuality() == b:GetQuality() then
			return indexA.index < indexB.index;
		else
			return a:GetQuality() > b:GetQuality()
		end
	end)	
end

function InitLeftPanel()
	if(not leftPanel) then
		local go = ResUtil:CreateUIGO("Common/LeftPanel", left.transform)
		leftPanel = ComUtil.GetLuaTable(go)
	end
	-- local ids = {29032, 24013, 29058, 29033}
	
	local leftDatas = {}
	for i = 0, #teamCfgs do
		local data = {}
		if i == 0 then
			data = {3025, "Archive2/icon2"}
		else
			data = {teamCfgs[i].languageID, "Archive2/" .. teamCfgs[i].icon}		
		end
		table.insert(leftDatas, data)
	end
	leftPanel.Init(this, leftDatas)
end

function RefreshPanel()
	SetLeft()
	SetRight()
end

function SetLeft()
	leftPanel.Anim()
end

function SetRight()
	curIndex =(curIndex1 - 1)
	curDatas = {}
	if(curIndex == 0) then
		curDatas = datas
	else
		for i, v in ipairs(datas) do
			local cfg = Cfgs.CfgArchiveGoods:GetByID(v:GetID())
			if(cfg.type == curIndex) then
				table.insert(curDatas, v)
			end
		end
	end
	AnimStart()
	animLua:AnimAgain()
	layout:IEShowList(#curDatas, AnimEnd)
end

function AnimStart()
	if not UIMask then
		UIMask = CSAPI.GetGlobalGO("UIClickMask")
	end
	CSAPI.SetGOActive(UIMask, true)
end

function AnimEnd()
	CSAPI.SetGOActive(UIMask, false)
end

function OnDestroy()	
	ReleaseCSComRefs();
end
---返回虚拟键公共接口  函数名一样，调用该页面的关闭接口
function OnClickVirtualkeysClose()
	---填写退出代码逻辑/接口
	if  top.OnClickBack then
		top.OnClickBack();
		if not UIMask then
			UIMask = CSAPI.GetGlobalGO("UIClickMask")
		end
		CSAPI.SetGOActive(UIMask, false)
	end
end
----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()	
	gameObject = nil;
	transform = nil;
	this = nil;
	left = nil;
	right = nil;
	sv1 = nil;
	view = nil;
end
----#End#----
