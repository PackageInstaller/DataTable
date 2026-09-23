--剧情图鉴
local itemPathT = "UIs/Archive2/ArchiveBoardItemT"
local itemPathTH = "UIs/Archive2/ArchiveBoardItemTH"

local curType = 1  --当前类型
local curDatas = {}

local curID = nil    --当前id
local curInfos = {}

local teamDatas = {}
local top=nil;
curIndex1, curIndex2 = 1,1

function Awake()
	layout_r1 = ComUtil.GetCom(sv1, "UIInfinite")
	layout_r1:Init(itemPathT, LayoutCallBack_r1, true)
	animLua1 = UIInfiniteUtil:AddUIInfiniteAnim(layout_r1, UIInfiniteAnimType.Diagonal)
	
	layout_r2 = ComUtil.GetCom(sv2, "UIInfinite")
	--layout_r2:AddBarAnim(0.4, false)
	layout_r2:Init(itemPathTH, LayoutCallBack_r2, true)
	animLua2 = UIInfiniteUtil:AddUIInfiniteAnim(layout_r2, UIInfiniteAnimType.Diagonal)
end

function LayoutCallBack_r1(index)
	local lua = layout_r1:GetItemLua(index)
	if(lua) then
		local _data = curDatas[index]
		lua.SetIndex(index)
		lua.SetClickCB(TItemCB)
		lua.Refresh(_data)
	end
end

function TItemCB(id)
	curID = id
	RefreshPanel()
end

function LayoutCallBack_r2(index)
	local lua = layout_r2:GetItemLua(index)
	if(lua) then
		local _data = curInfos[index]
		lua.SetIndex(index)
		--lua.SetClickCB(TItemCB)
		lua.Refresh(_data)
	end
end

function OnInit()
	top=UIUtil:AddTop2("ArchiveBoardView", gameObject, function()
		if(curID) then
			--显示大列表
			curID = nil
			CSAPI.SetGOActive(sv1, curID == nil)
			CSAPI.SetGOActive(sv2, curID ~= nil)
			layout_r1:IEShowList(#curDatas)
		else
			view:Close()
		end
	end, nil, "")
end

function OnOpen()
	CSAPI.PlayUISound("ui_popup_open")
	curID = nil
	InitTeamDatas()
	InitLeftPanel()
	RefreshPanel()
end

function InitTeamDatas()
	local cfgs = Cfgs.CfgArchiveIllustration:GetAll()
	for i, v in pairs(cfgs) do
		if CheckIsShow(v) then
			table.insert(teamDatas, v)
		end
	end
end

function CheckIsShow(cfg)
	if cfg and cfg.infos then
		for i, info in ipairs(cfg.infos) do
			if CheckItemShow(info) then
				return true
			end
		end
	end
	return false
end

function CheckItemShow(info)
	if info.shopId then
		-- local recordInfo = ShopMgr:GetRecordInfos(info.shopId)
		-- if recordInfo and recordInfo.last_buy_time > 0 then --有记录
		-- 	return true
		-- end
		local cfgBoard = Cfgs.CfgArchiveMultiPicture:GetByID(info.board_id)
		if cfgBoard and cfgBoard.itemId then 
			if BagMgr:GetCount(cfgBoard.itemId) > 0 then --查询背包
				return true
			end
		end
		if ShopMgr:HasBuyRecord(info.shopId) then --当期已购买
			return true
		else
			local commodity =ShopMgr:GetFixedCommodity(info.shopId)
			if commodity and commodity:GetNowTimeCanBuy() then --当前商品是否在销售
				return true
			end
		end
	else
		return true
	end
	return false
end

function InitLeftPanel()
	if(not leftPanel) then
		local go = ResUtil:CreateUIGO("Common/LeftPanel", left.transform)
		leftPanel = ComUtil.GetLuaTable(go)
	end
	leftPanel.Init(this, {{29060 ,"Archive2/icon_02_03"}})
end

function RefreshPanel()
	SetLeft()
	SetRight()
end

function SetLeft()
	leftPanel.Anim()
end

function SetRight()
	if curID ~= nil and curType ~= curIndex1 then
		curID = nil
	end
	CSAPI.SetGOActive(sv1, curID == nil)
	CSAPI.SetGOActive(sv2, curID ~= nil)
	if(curID) then
		local cfg = Cfgs.CfgArchiveIllustration:GetByID(curID)
		--筛选出已看的
		curInfos = {}
		for k, m in ipairs(cfg.infos) do
			-- if(PlotMgr:IsPlayed(m.story_id)) then
				if CheckItemShow(m) then
					table.insert(curInfos, m)
				end
			-- end
		end
		animLua2:AnimAgain()
		layout_r2:IEShowList(#curInfos)
	else
		curType = curIndex1
		curDatas = teamDatas

		if(#curDatas > 0) then
			table.sort(curDatas, function(a, b)
				return a.id < b.id
			end)
		end
		AnimStart()
		animLua1:AnimAgain()
		layout_r1:IEShowList(#curDatas, AnimEnd)
	end
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
	sv2 = nil;
	view = nil;
end
----#End#----
