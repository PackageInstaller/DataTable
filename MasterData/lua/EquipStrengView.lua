--装备强化面板
local disNewTween=false;
local childs={};
local leftPanel=nil
curIndex1, curIndex2 = 1, 1;
local curType=1;
local isAnim=false;
local eventMgr=nil;
local curChild=nil;
local top=nil;
local leftDatas=nil;

function Awake()
	UIUtil:AddQuestionItem("EquipStreng",gameObject, question)
	CSAPI.SetGOActive(question,false)
	eventMgr = ViewEvent.New();
	eventMgr:AddListener(EventType.Equip_StrengthTween_State,SetMask)
end

function OnInit()
	top=UIUtil:AddTop2("EquipStreng",gameObject, OnClickReturn,nil)
end

function OnDisable()
	RecordMgr:Save(RecordMode.View,recordTime,"ui_id=" .. RecordViews.Equip);	
	EventMgr.Dispatch(EventType.Equip_Update);
end

--openSetting:1-3
function OnOpen()
	InitLeftPanel();
	if openSetting and openSetting<=#leftDatas then
		curIndex1=openSetting or 1
	else
		curIndex1=1;
	end
	curType=curIndex1;
	FuncUtil:Call(function()
		SetMask(false);
		disNewTween=true;
	end,nil,640);
	if childs then
		for k, v in ipairs(childs) do
			CSAPI.SetGOActive(curChild.gameObject,false)
		end
	end
    Refresh();
end

function Refresh()
	if isAnim~=true then
		leftPanel.Anim();
	end
	--根据索引显示子物体
	curChild=CreateChild();
	if curChild then
		curChild.data=data;
		--刷新top的money
		top.SetMoney(curChild.GetMoneys());
		curChild.Refresh();
	end
end

--点击了左边面板
function RefreshPanel()
    --根据类型获取当前列表
    if isAnim then
        return
    end
    if curIndex1 and curIndex1 ~= curType then
        curType = curIndex1
		if curChild then
			CSAPI.SetGOActive(curChild.gameObject,false)
		end
        Refresh();
    end
end

function CreateChild()
	if childs and childs[curIndex1] then
		CSAPI.SetGOActive(childs[curIndex1].gameObject,true)
		return childs[curIndex1]
	end
	local go=nil;
	local path=nil
	if curIndex1==1 then
		path="EquipInfo/EquipStrength"
	elseif curIndex1==2 then
		path="EquipInfo/EquipRefining"
	elseif curIndex1==3 then
		path="EquipInfo/EquipSynthesis"
	end
	if path~=nil then
		go=ResUtil:CreateUIGO(path,root.transform);
		local lua=ComUtil.GetLuaTable(go);
		childs[curIndex1]=lua;
	end
	return childs[curIndex1];
end

function AnimStart()
    isAnim = true
    CSAPI.SetGOActive(clickMask, true)
end

-- 动画完成解除锁屏
function AnimEnd()
    isAnim = false
    CSAPI.SetGOActive(clickMask, false)
end

function InitLeftPanel()
	if (not leftPanel) then
        local go = ResUtil:CreateUIGO("Common/LeftPanel", root.transform)
        leftPanel = ComUtil.GetLuaTable(go)
    end
    leftDatas = {{75018, "EquipInfo/btn_02_01"}}
	if MenuMgr:CheckModelOpen(OpenViewType.special,"special18") then
		table.insert(leftDatas,{75002,"EquipInfo/btn_02_02"})
		CSAPI.SetGOActive(question,true)
		CheckFirstModuleInfo();
	end
	if MenuMgr:CheckModelOpen(OpenViewType.special,"special19") then
		table.insert(leftDatas,{75003,"EquipInfo/btn_02_03"})
	end
    leftPanel.Init(this, leftDatas)
end

--检测是否弹出过引导提示
function CheckFirstModuleInfo()
	local cfg=Cfgs.CfgModuleInfo:GetByID("EquipStreng");
	if cfg then
		local value=PlayerPrefs.GetInt("first_open_equipRefining");
		if value==nil or value==0 then
			CSAPI.OpenView("ModuleInfoView",cfg);
			PlayerPrefs.SetInt("first_open_equipRefining",1);
		end
	end
end

function OnClickReturn()
    view:Close();
end

function SetMask(isShow)
	CSAPI.SetGOActive(mask,isShow==true);
end

function OnDestroy()
	eventMgr:ClearListener();
    ReleaseCSComRefs();
end

----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()     
gameObject=nil;
transform=nil;
this=nil;  
root=nil;
leftPanel=nil;
end
----#End#----