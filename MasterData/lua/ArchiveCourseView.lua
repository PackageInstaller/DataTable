local itemPathT = "UIs/Archive2/ArchiveCourseItemT"

local curType = 1  --当前类型
local curDatas = {}
local teamDatas = {}

local top=nil;
curIndex1, curIndex2 = 1,1


function Awake()
	layout = ComUtil.GetCom(sv1, "UIInfinite")
	--layout:AddBarAnim(0.4, false)
	layout:Init(itemPathT, LayoutCallBack, true)
	animLua = UIInfiniteUtil:AddUIInfiniteAnim(layout, UIInfiniteAnimType.Diagonal)
end

function LayoutCallBack(index)	
	local lua = layout:GetItemLua(index)
	if(lua) then
		local _data = curDatas[index]
		lua.SetIndex(index)
		lua.SetClickCB(TItemCB)
		lua.Refresh(_data)
	end
end

function TItemCB(item)
	CSAPI.OpenView("ModuleInfoView", item.GetCfg())
end

function OnInit()
	top=UIUtil:AddTop2("ArchiveCourseView", gameObject, function()
		view:Close()		
	end, nil, "")
end

function OnOpen()
	CSAPI.PlayUISound("ui_popup_open")
	InitDatas()
	InitTeamDatas()
	InitLeftPanel()
	RefreshPanel()
end

function InitDatas()
	local cfgs = Cfgs.CfgArchiveCourse:GetAll()
	for i, v in pairs(cfgs) do
		teamDatas[v.type] = teamDatas[v.type] or {}
		table.insert(teamDatas[v.type], v)
	end
end

function InitTeamDatas()
	teamCfgs = Cfgs.CfgArchiveCourseGroup:GetAll()	
	local cfgDatas = {}
	for i, v in ipairs(teamCfgs) do --剔除组内没有角色的选项
		if teamDatas[v.id] and #teamDatas[v.id] > 0 then
			table.insert(cfgDatas, v)
		end
	end
	teamCfgs = cfgDatas
end

function InitLeftPanel()
	if(not leftPanel) then
		local go = ResUtil:CreateUIGO("Common/LeftPanel", left.transform)
		leftPanel = ComUtil.GetLuaTable(go)
	end
	-- local ids = {20000, 29030, 2007, 29031, 2003, 2006, 29057}
	
	local leftDatas = {}
	for i = 1, #teamCfgs do
		local data = {}
		data = {teamCfgs[i].languageID, "Archive2/" .. teamCfgs[i].icon}		
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
	if curType ~= curIndex1 then
		curType = curIndex1
	end
	curDatas = teamDatas[teamCfgs[curType].id]
	-- local cfgs = Cfgs.CfgArchiveCourse:GetAll()
	-- for i, v in pairs(cfgs) do
	-- 	if(v.type == curType) then
	-- 		table.insert(curDatas, v)
	-- 	end
	-- end
	if curDatas then
		if(#curDatas > 0) then
			table.sort(curDatas, function(a, b)
				return a.id < b.id
			end)
		end
		AnimStart()
		animLua:AnimAgain()
		layout:IEShowList(#curDatas, AnimEnd)
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
gameObject=nil;
transform=nil;
this=nil;  
left=nil;
right=nil;
sv1=nil;
view=nil;
end
----#End#----