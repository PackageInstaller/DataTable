--过场或暂停界面
local imgFill1 = nil
local imgFill2 = nil
local maskGo = nil
local lLineX = 0
local rLineX = 0
local isFightMenu = false
local isBattleStart = false

function Awake()
	imgFill1 = ComUtil.GetCom(eLine1, "ActionUIImgFilled")
	imgFill2 = ComUtil.GetCom(eLine3, "ActionUIImgFilled")
	
	lLineX = CSAPI.GetAnchor(line1_1)
	rLineX = CSAPI.GetAnchor(line3_1)
	
	maskGo = CSAPI.GetGlobalGO("UIClickMask")
end

--初始化
function Init(_titleStrs, _descStr, _isFightMenu, _isBattleStart)
	SetTitle(_titleStrs)
	SetDesc(_descStr)
	isFightMenu = _isFightMenu
	isBattleStart = _isBattleStart
	
	InitPanel()
	EnterTween()
end

--初始化面板
function InitPanel()
	CSAPI.SetGOActive(enterAction, false)
	CSAPI.SetGOActive(exitAction, false)
	
	CSAPI.SetAnchor(line1_1, lLineX, 0)
	CSAPI.SetAnchor(line1_2, lLineX, 10000)
	
	CSAPI.SetAnchor(line3_1, rLineX, 0)
	CSAPI.SetAnchor(line3_2, rLineX, 10000)
	
	CSAPI.SetGOActive(bgFade, isFightMenu)
	CSAPI.SetAnchor(c, 0, isFightMenu and 10000 or 0)
end

--设置大标题，从左到右
function SetTitle(strs)	
	for i = 1, 2 do
		local str = strs[i] or ""
		CSAPI.SetText(this["text" .. i].gameObject, str)
	end
	if strs then
		CSAPI.SetAnchor(text1, #strs > 1 and - 187 or 0, 2)
	end
end

--设置小标题
function SetDesc(str)
	CSAPI.SetText(text3, str or "")
end

--入场动画
function EnterTween()
	CSAPI.PlayUISound("ui_popup_open")
	CSAPI.SetGOActive(maskGo, true)
	CSAPI.SetGOActive(enterAction, true)
	imgFill1:Play(function()
		CSAPI.SetAnchor(line1_1, lLineX, 10000)
		CSAPI.SetAnchor(line1_2, lLineX, 0)
	end)
	imgFill2:Play(function()
		CSAPI.SetAnchor(line3_1, rLineX, 10000)
		CSAPI.SetAnchor(line3_2, rLineX, 0)
	end)
	FuncUtil:Call(function()
		CSAPI.SetGOActive(maskGo, false)
	end, this, 700)	
end

--退场动画
function ExitTween(_callBack)
	CSAPI.SetGOActive(maskGo, true)
	CSAPI.SetGOActive(exitAction, true)	
	FuncUtil:Call(function()
		CSAPI.SetGOActive(maskGo, false)
		if isFightMenu then
			CSAPI.PlayUISound("ui_generic_click_return")
		end
		if(_callBack) then
			_callBack()
		end
	end, this, 500)
end

function Close()

	view:Close()
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
text1=nil;
text2=nil;
text3=nil;
c=nil;
line1_1=nil;
line1_2=nil;
line3_1=nil;
line3_2=nil;
enterAction=nil;
bgFade=nil;
eLine1=nil;
eLine3=nil;
exitAction=nil;
view=nil;
end
----#End#----