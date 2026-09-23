--390  --1390
local isShowMore = false
local isCreate = false
function Init(_backCB, _viewName)
	isShowMore = false
	backCB = _backCB
	viewName = _viewName
	RefreshPanel()
end

function RefreshPanel()
	CSAPI.SetGOActive(mask, isShowMore)
	CSAPI.SetGOActive(jump, not isShowMore)
	CSAPI.SetGOActive(hide, isShowMore)
	CSAPI.SetGOActive(more, isShowMore)
	--CSAPI.SetRTSize(bg, isShowMore and 1390 or 226, 70)
	CSAPI.SetRTSize(bg, 226, 79)
	--scale
	--UIUtil:SetScaleByScene(bg)
	--item
	if(isShowMore) then
		if(not isCreate) then
			isCreate = true
			items = items or {}
			local datas = {{sViewName = "", cb = OnClickHome, sName1 = "首页"}}
			for i, v in ipairs(Cfgs.CfgMenuEnum:GetAll()) do
				table.insert(datas, v)
			end
			ItemUtil.AddItems("Top/HeadPanelItem", items, datas, more, nil, 1, viewName)
		end
	end
end

--首页（必定返回主场景）
function OnClickHome()
	local scene = SceneMgr:GetCurrScene()
	if(scene.key == "MajorCity") then
		CSAPI.CloseAllOpenned()
	else	
		SceneLoader:Load("MajorCity")
	end
end

--返回
function OnClickBack()
	if(backCB) then
		backCB()
	end
end


function OnClickJump()
	isShowMore = not isShowMore
	RefreshPanel()
end


function OnClickMask()
	isShowMore = false
	RefreshPanel()
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
mask=nil;
bg=nil;
jump=nil;
more=nil;
view=nil;
end
----#End#----