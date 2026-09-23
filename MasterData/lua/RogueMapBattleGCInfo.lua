
function Awake()
    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.RogueMap_Battle_Step_Refresh,OnStepShow)
    eventMgr:AddListener(EventType.RogueMap_Battle_FloatFont_Show, OnFloatFontShow)
end

function OnDisable()
	CSAPI.SetText(txtStep,"")
end

function OnStepShow(num)
    SetStepShow(num)
end

function SetStepShow(num)
    CSAPI.SetGOActive(node,num~=nil)
    if num then
        CSAPI.SetText(txtStep,num.."")
    end
end

function OnFloatFontShow(data)
    CreateFloatFont(data)
end

--创建角色飘字
function CreateFloatFont(data)
	--LogError(data);	
	local floatTrans = nil;
	if(IsNil(floatNode)) then		
		return;
	end
	floatTrans = floatNode.transform;
	local go = ResUtil:CreateUIGO("Common/FloatFontItem", floatTrans);
	if(not go) then
		LogError("create Common/FloatFontItem fail!");
		return;
	end
	local lua = ComUtil.GetLuaTable(go);
	lua.Set(data);
end

function OnDestroy()
    eventMgr:ClearListener()
end